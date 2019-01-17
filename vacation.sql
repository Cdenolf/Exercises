-- create a table named hotel
create table hotel(
hotelno varchar(10),
hotelname varchar(20),
city varchar(20),
primary key (hotelno)
);
 
-- insert some sample data
insert into hotel values('fb01', 'The Tower Hotel', 'London');
insert into hotel values('fb02', 'Watergate', 'Paris');
insert into hotel values('ch01', 'Omni Shoreham', 'London');
insert into hotel values('ch02', 'Phoenix Park', 'London');
insert into hotel values('dc01', 'Latham', 'Berlin');

create table room(
roomno numeric(5),
hotelno varchar(10),
type varchar(10),
price decimal(5,2),
primary key (roomno, hotelno),
foreign key (hotelno) REFERENCES hotel(hotelno)
);
 
insert into room values(501, 'fb01', 'single', 19);
insert into room values(601, 'fb01', 'double', 29);
insert into room values(701, 'fb01', 'family', 39);
insert into room values(1001, 'fb02', 'single', 58);
insert into room values(1101, 'fb02', 'double', 86);
insert into room values(1001, 'ch01', 'single', 29.99);
insert into room values(1101, 'ch01', 'family', 59.99);
insert into room values(701, 'ch02', 'single', 10);
insert into room values(801, 'ch02', 'double', 15);
insert into room values(901, 'dc01', 'single', 18);
insert into room values(1001, 'dc01', 'double', 30);
insert into room values(1101, 'dc01', 'family', 35);

create table guest(
guestno numeric(5),
guestname varchar(20),
guestaddress varchar(50),
primary key (guestno)
);
 
insert into guest values(10001, 'John Kay', '56 High St, London');
insert into guest values(10002, 'Mike Ritchie', '18 Tain St, London');
insert into guest values(10003, 'Mary Tregear', '5 Tarbot Rd, Aberdeen');
insert into guest values(10004, 'Joe Keogh', '2 Fergus Dr, Aberdeen');
insert into guest values(10005, 'Carol Farrel', '6 Achray St, Glasgow');
insert into guest values(10006, 'Tina Murphy', '63 Well St, Glasgow');
insert into guest values(10007, 'Tony Shaw', '12 Park Pl, Glasgow');

create table booking(
hotelno varchar(10),
guestno numeric(5),
datefrom date,
dateto date,
roomno numeric(5),
primary key (hotelno, guestno, datefrom),
foreign key (roomno, hotelno) REFERENCES room(roomno, hotelno),
foreign key (guestno) REFERENCES guest(guestno)
);
 
insert into booking values('fb01', 10001, '19-04-01', '19-04-08', 501);
insert into booking values('fb01', 10004, '19-04-15', '19-05-15', 601);
insert into booking values('fb01', 10005, '19-05-02', '19-05-07', 501);
insert into booking values('fb01', 10002, '19-01-04', '19-01-29', 601);
insert into booking values('fb01', 10001, '19-05-01', null, 701);
insert into booking values('fb02', 10003, '19-04-05', '20-04-04', 1001);
insert into booking values('fb02', 10005, '19-05-12', '30-05-04', 1101);
insert into booking values('ch01', 10006, '19-04-21', null, 1101);
insert into booking values('ch02', 10002, '19-04-25', '19-05-06', 801);
insert into booking values('dc01', 10007, '19-05-13', '19-05-15', 1001);
insert into booking values('dc01', 10003, '19-05-20', null, 1001);

 