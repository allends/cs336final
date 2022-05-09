drop table if exists bids;
drop table if exists comments;
drop table if exists alerts;
drop table if exists trucks;
drop table if exists cars;
drop table if exists bikes;
drop table if exists items;
drop table if exists accountInfo;

create table accountInfo(
  accountId int not null,
  accountType varchar(15) default 'customer',
  username varchar(30) not null,
  password varchar(30),
  PRIMARY KEY (username)
);

create table items(
itemId int,
itemName varchar(30),
sellerUsername varchar(30),
itemType varchar(30),
make varchar(30),
model varchar(30),
year int,
numSeats int,
minPrice float,
closeDate date,
closeTime time,
currentBid float,
currentBidder varchar(30),
bidIncrement float,
isOpen boolean,
fulltext(itemName, itemType),
primary key (itemId),
foreign key (sellerUsername) references accountInfo(username) ON UPDATE CASCADE ON DELETE CASCADE,
foreign key (currentBidder) references accountInfo(username) ON UPDATE CASCADE ON DELETE CASCADE);

create table bids(
bidId int,
itemId int,
bidder varchar(30),
amountBid float,
primary key(bidId),
foreign key (itemId) references items(itemId) ON DELETE CASCADE,
foreign key (bidder) references accountInfo(username) ON UPDATE CASCADE ON DELETE CASCADE);

create table comments(
commentId int,
itemId int,
repliedTo int default null,
username varchar(30),
content text,
datePosted date,
timePosted time,
fulltext(content),
primary key(commentId),
foreign key (itemId) references items(itemId) ON DELETE CASCADE,
foreign key (username) references accountInfo(username) ON UPDATE CASCADE ON DELETE CASCADE); 

create table alerts(
alertId int,
itemId int,
username varchar(30),
content varchar(100),
datePosted date,
timePosted time,
primary key(alertId),
foreign key (itemId) references items(itemId) ON DELETE CASCADE,
foreign key (username) references accountInfo(username) ON UPDATE CASCADE ON DELETE CASCADE);

create table trucks(
itemId int,
hasTruckBed varchar(5),
towingPower float,
mpg float,
horsepower float,
primary key(itemId),
foreign key (itemId) references items(itemId) ON DELETE CASCADE);

create table bikes(
itemId int,
isMountainBike varchar(5),
hasLights varchar(5),
numGears int,
bikeIntendedAge varchar(8),
primary key(itemId),
foreign key (itemId) references items(itemId) ON DELETE CASCADE);

create table cars(
itemId int,
mpg float,
isConvertible varchar(5),
horsepower float,
hasNavigation varchar(5),
primary key(itemId),
foreign key (itemId) references items(itemId) ON DELETE CASCADE);
