-- 담당 : 이인상

create table reservation(
reserve_date date  not null,
checkin_date date  not null,
checkout_date date not null,
price int(10)  not null,
id varchar(20) not null,
code int(10) not null,
foreign key (id) references users (id),
foreign key (code) references item (code),
review smallint(1),
reserve_code int(10) primary key
);