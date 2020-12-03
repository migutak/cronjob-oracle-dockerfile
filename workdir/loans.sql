drop table tqall;
drop table tcards;
create table tqall as select * from qall;
create table tcards as select * from qcards where primary = 'P';
commit;