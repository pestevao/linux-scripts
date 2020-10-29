# LINUX-SCRIPTS
Some free linux scripts (for systems manly)



# disk-space-watcher.sh

You can customize it as needed regarding:

  - it is built to work on CentOS and Red Hat based systems some changes may be needed to work on some other OS
  - must have rwx permissions on the user that will run it
  - ADMIN_CC can host multiple email addresses space between them
  - line 13 - EXCLUDE_LIST - pipe any directory more that you want to exclude for being scanned (ex. some CIFS mounts or /tmp folder)
  - line 33 - you can remove the "| head -n 25" to return the full listing;
  - line 33 - the "| numfmt --to=iec" formats the output to human readable units
  - line 38 - sender@example.com must be changed to your domain

Call this script via crontab for example every 10 minutes:

  */10 * * * * /fullpath_to_your/disk-space-watcher.sh



# service-watcher.sh

You can customize it as needed regarding:

  - it is built to work on CentOS and Red Hat based systems some changes may be needed to work on some other OS
  - must have rwx permissions on the user that will run it
  - ADMIN_CC can host multiple email addresses space between them
  - line 26 and 36 - sender@example.com must be changed to your domain

Call this script via crontab for example every 1 minute:

  */1 * * * * /fullpath_to_your/service-watcher.sh



