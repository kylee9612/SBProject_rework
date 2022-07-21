-- 담당 : 이인상

create table question(
no int(20) primary key,
id varchar (20),
title varchar (20),
contents varchar(1000),
written Date not null,
foreign key (id) references users(id)
)
