# collectd-notify
[Collectd](https://collectd.org/) plugin for sending notifications to [Notify](https://mashlol.github.io/notify/) Android app.

Implemented as a bash script

## Requirements
* bash
* curl
* [GNU bc](https://www.gnu.org/software/bc/) or some other POSIX-compatible version of bc.

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

The [threshold](https://collectd.org/wiki/index.php/Plugin:threshold) plugin must also be loaded and configured in order to generate notifications.
More information can be found on [collectd-threshold(5)](https://collectd.org/documentation/manpages/collectd-threshold.5.shtml) man page.

The following configuration example configures a warning notification to be sent if the load (midterm) gets above 3, and a failure notification is sent if the load gets above 5.
```
LoadPlugin threshold
<Plugin threshold>
  <Type load>
    DataSource midterm
    WarningMax 3
    FailureMax 5
  </Type>
</Plugin>
```
