create user amandaarnoni@localhost IDENTIFIED by '1234567';

create database uvv;
-- owner = amandaarnoni 
-- template = template0 
-- encoding = 'UTF8' 
-- lc_collate = 'pt_BR.UTF-8' 
-- lc_ctype = 'pt_BR.UTF-8'
-- allow_connections = true;

create schema elmasri;

grant all privileges on uvv.* to amandaarnoni@localhost;

flush privileges;

exit;

mysql -u amandaarnoni -p



