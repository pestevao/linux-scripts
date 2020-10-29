#!/bin/bash
# Shell script to monitor or watch the status of a crucial service.
# It will send an email to $ADMIN and $ADMIN_CC, if the service state fails and try to restart it asap.
# -------------------------------------------------------------------------
###edit the following
# Set the service
SERVICE=service_name
# Set admin email
ADMIN="admin1@example.com"
ADMIN_CC="admin2@example.com admin3@example.com"
###stop editing

HOST=`hostname -f`

if /usr/sbin/service $SERVICE status | grep -e 'active (running)' > /dev/null
	then
		echo "$service is running" && exit;
	else
		/usr/sbin/service $SERVICE start
		/bin/sleep 60
		STATUS=$(/usr/sbin/service $SERVICE status)
		/bin/sleep 9
		if echo $STATUS | grep -e 'active (running)' > /dev/null
			then
				SUBJECT="STATUS - $HOST - $SERVICE started ($(date +%Y-%m-%d) $(date +%H:%M))"
				echo "The $SERVICE at $HOST wasn't running and has been started." | mail -r "sender@example.com" -s "$SUBJECT" -c "$ADMIN_CC" $ADMIN && exit;
			else
				SUBJECT="STATUS - $HOST - $SERVICE start failed ($(date +%Y-%m-%d) $(date +%H:%M))"
				echo "The $SERVICE at $HOST is stopped and cannot be started!
				
				=======================
				
				$STATUS
				
				=======================
				" | mail -r "sender@example.com" -s "$SUBJECT" -c "$ADMIN_CC" $ADMIN && exit;
		fi
fi
