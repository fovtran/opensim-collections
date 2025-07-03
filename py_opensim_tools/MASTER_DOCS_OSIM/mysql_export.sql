mysql> SELECT * FROM passwd INTO OUTFILE '/tmp/tutorials.txt'
    -> FIELDS TERMINATED BY ',' ENCLOSED BY '"'
    -> LINES TERMINATED BY '\r\n';

# Timestamped Backups

# Linux
mv /home/Johnny/OpenSimBackups/OpensimBackup.sql /home/Johnny/OpenSimBackups/OpensimBackup_$(date +%Y-%m-%d-%H.%M.%S).sql

# Automatic Daily Backups
# Linux
# Add something like this to crontab for a weekly/daily/hourly run. 
# (crontab -e to edit)

mysqldump -uuser -ppass dbname | gzip > /tmp/mydb_`date +%Y%m%d_%H%M%S`.sql.gz

# To verify the backup gunzip it and look inside the .sql-file, it should contain a DB-dump. For example by executing:
zcat /tmp/mydb_YYYYMMDD_HHmmSS.sql.gz | more

# To restore a given db:
cat /tmp/mydb_YYYYMMDD_HHmmSS.sql.gz | gunzip | mysql -uuser -ppass dbname 