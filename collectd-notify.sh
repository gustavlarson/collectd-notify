#!/usr/bin/env bash
#
# Collectd plugin for sending notifications to Notify Android app (https://mashlol.github.io/notify/).
#
# Author: Gustav Larson
# URL: https://github.com/gustavlarson/collectd-notify

IDENTIFIER=${1}
NOTIFICATION=$(cat)

# Extract a value from the notification data with the key provided.
# https://collectd.org/documentation/manpages/collectd-exec.5.shtml#notification_data_format
data () {
  echo "$NOTIFICATION" | grep "${1}: " | sed "s/^${1}: \(.*\)$/\1/"
}

SEVERITY=$(data Severity)
HOST=$(data Host)
PLUGIN=$(data Plugin)
TYPE=$(data Type)
TYPEINSTANCE=$(data TypeInstance)
DATASOURCE=$(data DataSource)
VALUE=$(data CurrentValue)
VALUE=$(printf "%.f" ${VALUE})

TITLE="${SEVERITY}: ${HOST} ${PLUGIN}"

case $PLUGIN in
  entropy)
    TEXT="entropy has reached ${VALUE}."
    ;;
  memory)
    # Convert bytes to Mb
    VALUE="$(echo "${VALUE}/(1024*1024)" | bc)"
    TEXT="$(data TypeInstance) memory has reached ${VALUE} Mb."
    ;;
  load)
    VALUE=$(printf "%.2f" ${VALUE})
    TEXT="${DATASOURCE} load has reached ${VALUE}."
    ;;
  *)
    TEXT="${TYPE} ${TYPEINSTANCE} ${DATASOURCE} has reached ${VALUE}."
    ;;
esac


#
# Send notification
#
curl -X GET --get \
  --data-urlencode "to=${IDENTIFIER}" \
  --data-urlencode "title=${TITLE}" \
  --data-urlencode "text=${TEXT}" \
  https://appnotify.herokuapp.com/notify
