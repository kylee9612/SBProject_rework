-- 담당 : 이인상

create table users(
id varchar (20) primary key,
pw varchar (20) not null,
name varchar (20) not null,
age int (2) not null,
mobile varchar(20) not null,
email varchar(30) not null,
point int(10),
authority smallint(1),
foreign key (authority) references authority(code)
);