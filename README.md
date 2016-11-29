# collectd-notify
[Collectd](https://collectd.org/) plugin for sending notifications to [Notify](https://mashlol.github.io/notify/) Android app.

Implemented as a bash script

## Requirements
* bash
* curl

## Installation
Install the script in any location

## Configuration
The [exec](https://collectd.org/documentation/manpages/collectd-exec.5.shtml) plugin must be loaded in *collectd.conf*.
The exec plugin is configured with a username (to run the script), path to the script and identifier from the Notify [app](https://play.google.com/store/apps/details?id=com.kevinbedi.notify).

```
LoadPlugin exec
<Plugin exec>
        NotificationExec username "/usr/local/bin/collectd-notify.sh" "myKey"
</Plugin>
```

