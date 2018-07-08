# Auto-status for Slack on Mac OS X

Overview
--------

The native Slack application has the capability to manually adjust a user's
status, but does nothing automatically. The manual nature of switching your
status based on where or what you're doing is tedious. This app attempts
to ease that pain point by automatically adjusting status based on factors
it can discern.

This status bar automatically (or manually) updates a user's Slack status
based on information from the user's calendars and Wireless SSID in use. It
only works on Mac OS X and is only effective for users that use Mac's default
calendar application and wireless for networking.

Currently the app can detect 4 types of statuses

- Vacationing - scans the vacation calendar for events for the current time
- In a Meeting -  scans the work calendar for events for the current time
- Working Remotely - compares the SSID currently in use with the given work SSID
- Away - detects the lock state of the screen and sets away if locked
