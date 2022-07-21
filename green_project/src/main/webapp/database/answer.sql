-- 담당 : 이인상

create table answer(
no int(20) primary key,
id varchar (20) not null, 
title varchar (20) not null,
contents varchar(1000) not null,
code int (20) not null,
written Date not null,
foreign key (id) references users(id),
foreign key (code) references question(no)
);
