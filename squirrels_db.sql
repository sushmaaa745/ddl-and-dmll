create database squirrels_db;

use squirrels_db;

create table squirrels
(
    squirrel_id int(3) primary key,
    name varchar(50) not null,
    age int(2) not null,
    weight float(5,2),
    habitat_id int(3),
    foreign key(habitat_id) references habitats(habitat_id)
);

create table habitats
(
    habitat_id int(3) primary key,
    location varchar(100) not null,
    type varchar(30) check(type in ('Forest', 'Urban', 'Park'))
);

create table sightings
(
    sighting_id int(3) primary key,
    squirrel_id int(3),
    date date not null,
    time time not null,
    location varchar(100) not null,
    foreign key(squirrel_id) references squirrels(squirrel_id)
);
drop table squirrels;

drop database squirrels_db;

alter table habitats
add area_size float(5,2);

alter table habitats
drop column area_size;


ALTER TABLE sightings
CHANGE COLUMN time sighting_time TIME NOT NULL;


ALTER TABLE squirrels
MODIFY COLUMN weight DECIMAL(5,2);

ALTER TABLE habitats
MODIFY COLUMN type VARCHAR(30),
ADD CONSTRAINT chk_type CHECK (type IN ('Forest', 'Urban', 'Park', 'Garden'));
truncate table squirrels;
alter table squirrels
modify column age int(2) not null;
alter table squirrels
add unique(name);
alter table sightings
modify column location varchar(100) default 'Unknown';
insert into habitats values(1,'Central Park', 'Park');
insert into habitats values(2,'Greenwood Forest', 'Forest');
insert into habitats values(3,'Downtown', 'Urban');
insert into squirrels (squirrel_id, name, age, weight, habitat_id) values
(101,'Nutty',2,1.5,1),
(102,'Chippy',3,1.8,2),
(103,'Squeaky',1,1.2,3),
(104,'Furry',4,2.1,1),
(105,'Jumpy',2,1.7,2);
insert into sightings values(1001,101,'2024-06-01','08:30:00','Central Park');
insert into sightings values(1002,102,'2024-06-02','09:15:00','Greenwood Forest');
insert into sightings values(1003,103,'2024-06-03','07:45:00','Downtown');
insert into sightings values(1004,104,'2024-06-04','10:00:00','Central Park');
update squirrels
set weight = 1.9
where name = 'Nutty';
delete from squirrels
where name = 'Furry';


INSERT INTO researchers (id, name, field, salary)
VALUES (1, 'Dr. Jane Goodall', 'Zoology', 120000);
UPDATE researchers
SET salary = 130000
WHERE id = 1;
DELETE FROM researchers
WHERE id = 1;
CREATE TABLE observations (
  observation_id INT PRIMARY KEY,
  squirrel_id INT,
  date DATE NOT NULL,
  notes TEXT,
  method_id INT,
  FOREIGN KEY(squirrel_id) REFERENCES squirrels(squirrel_id)
);
CREATE TABLE methods (
  method_id INT PRIMARY KEY,
  method_name VARCHAR(100) NOT NULL
);
ALTER TABLE observations
ADD CONSTRAINT fk_method
FOREIGN KEY (method_id)
REFERENCES methods (method_id)
ON DELETE CASCADE;
INSERT INTO observations (observation_id, squirrel_id, date, notes, method_id)
VALUES (1, 101, '2024-06-01', 'Observed climbing a tree', 1);
INSERT INTO observations (observation_id, squirrel_id, date, notes, method_id)
VALUES (1, 102, '2024-06-02', 'Foraging for food', 2);
INSERT INTO observations (observation_id, squirrel_id, notes, method_id)
VALUES (3, 103, 'Playing with other squirrels', 3);
SELECT * 
FROM squirrels 
WHERE weight > 1.5 AND age < 3;
UPDATE squirrels
SET weight = 2.0, last_updated = NOW()
WHERE squirrel_id = 101;
DELETE FROM sightings 
WHERE location = 'Downtown';

#operators
SELECT SUM(nuts_collected) AS total_nuts_collected
FROM squirrel_stats;
SELECT *
FROM squirrel_stats
WHERE nuts_collected % 2 = 0;
SELECT squirrel_id, nuts_collected,
       (nuts_collected - (SELECT AVG(nuts_collected) FROM squirrel_stats)) AS nut_difference
FROM squirrel_stats;
SELECT *
FROM squirrel_stats
WHERE acorns_stored > 100;
SELECT *
FROM squirrel_info
WHERE age != 1;
SELECT *
FROM squirrel_stats
WHERE pinecones_buried <= 5;
SELECT (acorns_stored & pinecones_buried) AS result
FROM squirrel_stats;
SELECT (nuts_buried | acorns_stored) AS result
FROM squirrel_stats;
SELECT (nuts_collected ^ pinecones_buried) AS result
FROM squirrel_stats;
SELECT *
FROM squirrel_info
WHERE location = 'Oak Tree' AND acorns_stored > 20;
SELECT *
FROM squirrel_info
WHERE location = 'Pine Forest'
   OR (SELECT SUM(nuts_collected) FROM squirrel_stats WHERE squirrel_id = squirrel_info.squirrel_id) > 50;
SELECT *
FROM squirrel_health
WHERE last_seen_season != 'Winter' AND health_status = 'Excellent';
