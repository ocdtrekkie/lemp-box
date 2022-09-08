## LEMP Box

This Sandstorm app is sort of a crime, it does not work out of the box! It is designed to let you import old PHP apps into a Sandstorm sandbox without actually packaging them properly as apps.

### How to use LEMP Box

* Create a grain and download the backup.
* Copy the directory of the web application to the /data/www folder inside the zip file.
* Copy the database backup as import.sql in the /data/sql folder inside the zip file. (Database name "app", user "root", password "root")
* Restore the grain backup to your server and rename the grain title to be explanatory.
