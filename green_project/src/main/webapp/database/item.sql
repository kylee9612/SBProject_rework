-- 담당 : 이인상

create table item(
id varchar (20) not null,
name varchar (20) not null,
address varchar(100) not null,
code int(10) primary key,
view_count int(10) default 0,
like_count int(10) default 0,
category varchar (20) not null,
price int(10) not null,
thumbnail varchar (100),
content varchar (1000),
rate float(3) default 0,
max_people smallint(2) not null,
reserve_code int (10) primary key,
foreign key (id) references users(id),
foreign key (category) references item_category (category);
);