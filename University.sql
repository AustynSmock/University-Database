use University_as1050128;

show tables;
-- create department table
CREATE TABLE department (
	dept_name	varchar(20),
    building	varchar(15),
    budget		numeric(12,2),
    constraint budget_check check(budget>0),
    primary key (dept_name)
);
-- create instructor table
CREATE TABLE instructor (
	id			varchar(5),
    name 		varchar(20) not null,
    dept_name	varchar(20),
    salary		numeric(8,2),
    primary key (id),
    foreign key (dept_name) references department(dept_name) on delete set null
);
-- create teaches table 
CREATE TABLE teaches (
	id 			varchar(5),
    course_id	varchar(8),
    sec_id		varchar(8),
    semester	varchar(6),
    year		numeric(4,0),
    primary key (id, course_id, sec_id, semester, year),
    foreign key (id) references instructor(id) on delete cascade
);
-- create course table
CREATE TABLE course (
	course_id	varchar(8),
    title		varchar(50),
    dept_name	varchar(20),
    credits		numeric(2,0),
    constraint credit_check check(credits>0),
    primary key (course_id),
    foreign key (dept_name) references department(dept_name) on delete set null
);
-- create section table
CREATE TABLE section (
	course_id 		varchar(8),
    sec_id			varchar(8),
    semester 		varchar(6),
    year			numeric(4,0),
    building		varchar(15),
    room_number 	varchar(7), 
    time_slot_id	varchar(4),
    primary key (course_id, sec_id, semester, year),
    foreign key (course_id) references course(course_id) on delete cascade
);
-- update the teaches table with an additional 
-- referential integrity constraint
ALTER TABLE teaches ADD (
  foreign key (course_id, sec_id, semester, year) references section(course_id, sec_id, semester, year) on delete cascade
);
-- create classroom table
CREATE TABLE classroom (
	building 	varchar(15),
    room_number varchar(7),
    capacity 	numeric(4,0),
    primary key (building, room_number)
);
-- update the section table with an additional 
-- referential integrity constraint
ALTER TABLE section ADD (
  foreign key (building, room_number) references classroom(building, room_number) on delete set null
);
-- create student table
CREATE TABLE student (
	id			varchar(5),
    name		varchar(20) not null,
    dept_name 	varchar(20),
    tot_cred	numeric(3,0),
    primary key (id),
    foreign key (dept_name) references department(dept_name) on delete set null
);
-- create takes table
CREATE TABLE takes (
	id			varchar(5),
    course_id	varchar(8),
    sec_id		varchar(8),
    semester	varchar(6),
    year		numeric(4,0),
	grade		varchar(2),
    primary key (id, course_id, sec_id, semester, year),
    foreign key (id) references student(id) on delete cascade,
    foreign key (course_id, sec_id, semester, year) references section(course_id, sec_id, semester, year) on delete cascade
);
-- create advisor table
CREATE TABLE advisor (
	s_id	varchar(5),
    i_id	varchar(5),
    primary key (s_id),
    foreign key (s_id) references student(id) on delete cascade,
    foreign key (i_id) references instructor(id) on delete set null
);
-- create prereq table
CREATE TABLE prereq (
	course_id	varchar(8),
    prereq_id	varchar(8),
    primary key (course_id, prereq_id),
    foreign key (course_id) references course(course_id),
    foreign key (prereq_id) references course(course_id)
);
-- create timeSlot table
CREATE TABLE timeSlot (
	time_slot_id	varchar(4),
    day				varchar(1),
    start_hour		int,
    start_min		int,
    end_hour		int,
    end_min			int,
    primary key (time_slot_id, day, start_hour, start_min)
);

-- populate department table
INSERT INTO department VALUES
	('Biology','Watson',90000.00);
INSERT INTO department VALUES
	('Comp. Sci.','Taylor',100000.00);
INSERT INTO department VALUES
	('Elec. Eng.','Taylor',85000.00);
INSERT INTO department VALUES
	('Finance','Painter',120000.00);
INSERT INTO department VALUES
	('History','Painter',50000.00);
INSERT INTO department VALUES
	('Music','Packard',80000.00);
INSERT INTO department VALUES
	('Physics','Watson',70000.00);
    
-- populate instructor table
INSERT INTO instructor VALUES
	('10101','Srinivasan','Comp. Sci.',65000.00);
INSERT INTO instructor VALUES
	('12121','Wu','Finance',90000.00);
INSERT INTO instructor VALUES
	('15151','Mozart','Music',40000.00);
INSERT INTO instructor VALUES
	('22222','Einstein','Physics',95000.00);
INSERT INTO instructor VALUES
	('32343','El Said','History',60000.00);
INSERT INTO instructor VALUES
	('33456','Gold','Physics',87000.00);
INSERT INTO instructor VALUES
	('45565','Katz','Comp. Sci.',75000.00);
INSERT INTO instructor VALUES
	('58583','Califieri','History',62000.00);
INSERT INTO instructor VALUES
	('76543','Singh','Finance',80000.00);
INSERT INTO instructor VALUES
	('76766','Crick','Biology',72000.00);
INSERT INTO instructor VALUES
	('83821','Brandt','Comp. Sci.',92000.00);
INSERT INTO instructor VALUES
	('98345','Kim','Elec. Eng.',80000.00);
    
-- populate classroom table
INSERT INTO classroom VALUES
	('Packard','101',500);
INSERT INTO classroom VALUES
	('Painter','514',10);
INSERT INTO classroom VALUES
	('Taylor','3128',70);
INSERT INTO classroom VALUES
	('Watson','100',30);
INSERT INTO classroom VALUES
	('Watson','120',50);
    
-- popualte course table
INSERT INTO course VALUES
	('BIO-101','Intro. to Biology','Biology',4);
INSERT INTO course VALUES
	('BIO-301','Genetics','Biology',4);
INSERT INTO course VALUES
	('BIO-399','Computational Biology','Biology',3);
INSERT INTO course VALUES
	('CS-101','Intro. to Computer Science','Comp. Sci.',4);
INSERT INTO course VALUES
	('CS-190','Game Design','Comp. Sci.',4);
INSERT INTO course VALUES
	('CS-315','Robotics','Comp. Sci.',3);
INSERT INTO course VALUES
	('CS-319','Image Processing','Comp. Sci.',3);
INSERT INTO course VALUES
	('CS-347','Database System Concepts','Comp. Sci.',3);
INSERT INTO course VALUES
	('EE-181','Intro. to Digital Systems','Elec. Eng.',3);
INSERT INTO course VALUES
	('FIN-201','Investment Banking','Finance',3);
INSERT INTO course VALUES
	('HIS-351','World History','History',3);
INSERT INTO course VALUES
	('MU-199','Music Video Production','Music',3);
INSERT INTO course VALUES
	('PHY-101','Physical Principles','Physics',4);
    
-- populate section table 
INSERT INTO section VALUES
	('BIO-101','1','Summer',2009,'Painter','514','B');
INSERT INTO section VALUES
	('BIO-301','1','Summer',2010,'Painter','514','A');
INSERT INTO section VALUES
	('CS-101','1','Fall',2009,'Packard','101','H');
INSERT INTO section VALUES
	('CS-101','1','Spring',2010,'Packard','101','F');
INSERT INTO section VALUES
	('CS-190','1','Spring',2009,'Taylor','3128','E');
INSERT INTO section VALUES
	('CS-190','2','Spring',2009,'Taylor','3128','A');
INSERT INTO section VALUES
	('CS-315','1','Spring',2010,'Watson','120','D');
INSERT INTO section VALUES
	('CS-319','1','Spring',2010,'Watson','100','B');
INSERT INTO section VALUES
	('CS-319','2','Spring',2010,'Taylor','3128','C');
INSERT INTO section VALUES
	('CS-347','1','Fall',2009,'Taylor','3128','A');
INSERT INTO section VALUES
	('EE-181','1','Spring',2009,'Taylor','3128','C');
INSERT INTO section VALUES
	('FIN-201','1','Spring',2010,'Packard','101','B');
INSERT INTO section VALUES
	('HIS-351','1','Spring',2010,'Painter','514','C');
INSERT INTO section VALUES
	('MU-199','1','Spring',2010,'Packard','101','D');
INSERT INTO section VALUES
	('PHY-101','1','Fall',2009,'Watson','100','A');
    
-- populate student table
INSERT INTO student VALUES
	('00128','Zhang','Comp. Sci.',102);
INSERT INTO student VALUES
	('12345','Shankar','Comp. Sci.',32);
INSERT INTO student VALUES
	('19991','Brandt','History',80);
INSERT INTO student VALUES
	('23121','Chavez','Finance',110);
INSERT INTO student VALUES
	('44553','Peltier','Physics',56);
INSERT INTO student VALUES
	('45678','Levy','Physics',46);
INSERT INTO student VALUES
	('54321','Williams','Comp. Sci.',54);
INSERT INTO student VALUES
	('55739','Sanchez','Music',38);
INSERT INTO student VALUES
	('70557','Snow','Physics',0);
INSERT INTO student VALUES
	('76543','Brown','Comp. Sci.',58);
INSERT INTO student VALUES
	('76653','Aoi','Elec. Eng.',60);
INSERT INTO student VALUES
	('98765','Bourikas','Elec. Eng.',98);
INSERT INTO student VALUES
	('98988','Tanaka','Biology',120);
    
-- populate teaches table
INSERT INTO teaches VALUES
	('76766','BIO-101','1','Summer',2009);
INSERT INTO teaches VALUES
	('76766','BIO-301','1','Summer',2010);
INSERT INTO teaches VALUES
	('10101','CS-101','1','Fall',2009);
INSERT INTO teaches VALUES
	('45565','CS-101','1','Spring',2010);
INSERT INTO teaches VALUES
	('83821','CS-190','1','Spring',2009);
INSERT INTO teaches VALUES
	('83821','CS-190','2','Spring',2009);
INSERT INTO teaches VALUES
	('10101','CS-315','1','Spring',2010);
INSERT INTO teaches VALUES
	('45565','CS-319','1','Spring',2010);
INSERT INTO teaches VALUES
	('83821','CS-319','2','Spring',2010);
INSERT INTO teaches VALUES
	('10101','CS-347','1','Fall',2009);
INSERT INTO teaches VALUES
	('98345','EE-181','1','Spring',2009);
INSERT INTO teaches VALUES
	('12121','FIN-201','1','Spring',2010);
INSERT INTO teaches VALUES
	('32343','HIS-351','1','Spring',2010);
INSERT INTO teaches VALUES
	('15151','MU-199','1','Spring',2010);
INSERT INTO teaches VALUES
	('22222','PHY-101','1','Fall',2009);
    
-- populate takes table
INSERT INTO takes VALUES
	('00128','CS-101','1','Fall',2009,'A');
INSERT INTO takes VALUES
	('00128','CS-347','1','Fall',2009,'A-');
INSERT INTO takes VALUES
	('12345','CS-101','1','Fall',2009,'C');
INSERT INTO takes VALUES
	('12345','CS-190','2','Spring',2009,'A');
INSERT INTO takes VALUES
	('12345','CS-315','1','Spring',2010,'A');
INSERT INTO takes VALUES
	('12345','CS-347','1','Fall',2009,'A');
INSERT INTO takes VALUES
	('19991','HIS-351','1','Spring',2010,'B');
INSERT INTO takes VALUES
	('23121','FIN-201','1','Spring',2010,'C+');
INSERT INTO takes VALUES
	('44553','PHY-101','1','Fall',2009,'B-');
INSERT INTO takes VALUES
	('45678','CS-101','1','Fall',2009,'F');
INSERT INTO takes VALUES
	('45678','CS-101','1','Spring',2010,'B+');
INSERT INTO takes VALUES
	('45678','CS-319','1','Spring',2010,'B');
INSERT INTO takes VALUES
	('54321','CS-101','1','Fall',2009,'A-');
INSERT INTO takes VALUES
	('54321','CS-190','2','Spring',2009,'B+');
INSERT INTO takes VALUES
	('55739','MU-199','1','Spring',2010,'A-');
INSERT INTO takes VALUES
	('76543','CS-101','1','Fall',2009,'A');
INSERT INTO takes VALUES
	('76543','CS-319','2','Spring',2010,'A');
INSERT INTO takes VALUES
	('76653','EE-181','1','Spring',2009,'C');
INSERT INTO takes VALUES
	('98765','CS-101','1','Fall',2009,'C-');
INSERT INTO takes VALUES
	('98765','CS-315','1','Spring',2010,'B');
INSERT INTO takes VALUES
	('98988','BIO-101',1,'Summer',2009,'A');
INSERT INTO takes VALUES
	('98988','BIO-301',1,'Summer',2010,'A');

-- populate advisor table
INSERT INTO advisor VALUES
	('12345','10101');
INSERT INTO advisor VALUES
	('44553','22222');
INSERT INTO advisor VALUES
	('45678','22222');
INSERT INTO advisor VALUES
	('00128','45565');
INSERT INTO advisor VALUES
	('76543','45565');
INSERT INTO advisor VALUES
	('23121','76543');
INSERT INTO advisor VALUES
	('98988','76766');
INSERT INTO advisor VALUES
	('76653','98345');
INSERT INTO advisor VALUES
	('98765','98345');
    
-- populate prereq table
INSERT INTO prereq VALUES
	('BIO-301','BIO-101');
INSERT INTO prereq VALUES
	('BIO-399','BIO-101');
INSERT INTO prereq VALUES
	('CS-190','CS-101');
INSERT INTO prereq VALUES
	('CS-315','CS-101');
INSERT INTO prereq VALUES
	('CS-319','CS-101');
INSERT INTO prereq VALUES
	('CS-347','CS-101');
INSERT INTO prereq VALUES
	('EE-181','PHY-101');

-- populate timeSlot table
INSERT INTO timeSlot VALUES
	('A','F',8,0,8,50);
INSERT INTO timeSlot VALUES
	('A','M',8,0,8,50);
INSERT INTO timeSlot VALUES
	('A','W',8,0,8,50);
INSERT INTO timeSlot VALUES
	('B','F',9,0,9,50);
INSERT INTO timeSlot VALUES
	('B','M',9,0,9,50);
INSERT INTO timeSlot VALUES
	('B','W',9,0,9,50);
INSERT INTO timeSlot VALUES
	('C','F',11,0,11,50);
INSERT INTO timeSlot VALUES
	('C','M',11,0,11,50);
INSERT INTO timeSlot VALUES
	('C','W',11,0,11,50);
INSERT INTO timeSlot VALUES
	('D','F',13,0,13,50);
INSERT INTO timeSlot VALUES
	('D','M',13,0,13,50);
INSERT INTO timeSlot VALUES
	('D','W',13,0,13,50);
INSERT INTO timeSlot VALUES
	('E','R',10,30,11,45);
INSERT INTO timeSlot VALUES
	('E','T',10,30,11,45);
INSERT INTO timeSlot VALUES
	('F','R',14,30,15,45);
INSERT INTO timeSlot VALUES
	('F','T',14,30,15,45);
INSERT INTO timeSlot VALUES
	('G','F',16,0,16,50);
INSERT INTO timeSlot VALUES
	('G','M',16,0,16,50);
INSERT INTO timeSlot VALUES
	('G','W',16,0,16,50);
INSERT INTO timeSlot VALUES
	('H','W',10,0,12,30);
    
-- test whether my database has been populated as required
Select * from classroom;
Select * from department;
Select * from course;
Select * from instructor;
Select * from section;
Select * from teaches;
Select * from student;
Select * from takes;
Select * from advisor;
Select * from prereq;
Select * from timeSlot;
