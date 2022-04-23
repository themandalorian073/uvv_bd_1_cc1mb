mysql -u root -p

create user 'amandaarnoni'@'localhost';

create database `uvv`;

exit;

create user 'amandaarnoni'@'localhost';

grant all privileges on uvv.* to amandaarnoni;

mysql -u amandaarnoni