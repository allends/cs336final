insert into `cs336project`.`accountinfo` (`accountId`, `accountType`, `username`, `password`) values ('24', 'customer', 'allends', 'epic'), ('2', 'customer', 'eoin', 'potato'), ('3', 'customer', 'sidhu', 'fish'), ('69', 'administrator', 'admin', 'admin');

insert into `cs336project`.`alerts` (`alertId`, `itemId`, `username`, `content`, `datePosted`, `timePosted`) values ('1', '1234', 'allends', 'You have been outbid', '2021-01-01', '12:00:00');

insert into `cs336project`.`items` (`itemId`, `itemName`, `sellerUsername`, `itemType`, `make`, `model`, `year`, `numSeats`, `minPrice`, `closeDate`, `closeTime`, `currentBid`, `bidIncrement`, `isOpen`) 
values ('1234', 'Massive Truck', 'eoin', 'truck', 'ford', 'f150', '1883', '5', '300', '2021-05-12', '12:00:00', '0', '100', 'true'),
('1235', 'Bike', 'eoin', 'bike', 'mongoose', 'trailb', '12', '1', '100', '2021-05-12', '12:00:00', '0', '50', 'true');

insert into `cs336project`.`comments` (`commentId`, `itemId`, `username`, `content`, `datePosted`, `timePosted`) values ('345', '1234', 'allends', 'Wow, this really is a massive truck', '2022-05-05', '12:00:00');

insert into `cs336project`.`bids` (`bidId`, `itemId`, `bidder`, `amountBid`) values ('987', '1234', 'sidhu', '400');
 