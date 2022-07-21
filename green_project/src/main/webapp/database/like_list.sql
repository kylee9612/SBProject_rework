-- 담당 : 이인상

create table like_list(
id varchar(20) not null,
code int(10) not null,
foreign key (id) references users (id),
foreign key (code) references item (code)
);