# linux-scripts
Some free linux scripts (for systems manly)



*** disk-space-watcher.sh

You can customize it as needed regarding:

  - line 13 - EXCLUDE_LIST - pipe any directory more that you want to exclude for beeing scaned (ex. some CIFS mounts or /tmp folder)
  - line 33 - you can remove the "| head -n 25" to return the full listing;
  - line 33 - the "| numfmt --to=iec" formats the output to human readable units

Call this script via crontab for example:

  */10 * * * * /fullpath_to_your/disk-space-watcher.sh



*** 

