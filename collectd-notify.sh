#!/usr/bin/env bash
IDENTIFIER=${1}
NOTIFICATION=$(cat)

# Extract a value from the notification data with the key provided.
# https://collectd.org/documentation/manpages/collectd-exec.5.shtml#notification_data_format
data () {
  echo "$NOTIFICATION" | grep "${1}: " | sed "s/^${1}: \(.*\)$/\1/"
}

TITLE="$(data Severity): $(data Host)"
TEXT="$(data Type) $(data TypeInstance) has reached $(data CurrentValue)"

curl -X GET --get \
  --data-urlencode "to=${IDENTIFIER}" \
  --data-urlencode "title=${TITLE}" \
  --data-urlencode "text=${TEXT}" \
  https://appnotify.herokuapp.com/notify
