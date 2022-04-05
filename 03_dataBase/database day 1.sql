create database mywork;
create database if not exists mywork;
drop database if exists mywork;

-- mywork database 생성
use mywork;
create table highschool_students (
  student_no varchar(20) not null primary key,
  student_name varchar(100) not null,
  grade tinyint,
  class varchar(20),
  gender varchar(20),
  age smallint,
  enter_date date
);

desc highschool_students;
drop table highschool_students;

create table highschool_students (
  student_no varchar(20) not null,
  student_name varchar(100) not null,
  grade tinyint,
  class varchar(20),
  gender varchar(20),
  age smallint,
  enter_date date,
  constraint primary key (student_no)
);
desc highschool_students;

alter table highschool_students
drop primary key;

desc highschool_students;

alter table highschool_students
add primary key (student_no);
desc highschool_students;

drop database mywork;

select * from box_office;
select count(*) from box_office;

use world;

desc city;

select id, name
  from city;
  
select count(*) from city;

select * from city;

select district, countrycode, name, id
  from city;

select *
  from country;

select *
  from world.country;  
  
select *
  from mywork.box_office;
  
select *
  from city
 where countrycode = 'KOR';
 
select *
  from city
 where countrycode = 'KOR'
   and district LIKE 'K%';
   
select *
  from city
 where countrycode = 'KOR'
   and district LIKE '%K';
   
select *
  from city
 where countrycode = 'KOR'
   and district LIKE '%ong%';   
   
select *
  from city
 where countrycode = 'KOR'
   or 2>3;      
   
select *
  from city
 where countrycode = 'KOR'
  and district in('seoul', 'kyonggi');
  
select *
  from city
 where countrycode = 'KOR'
  and (district = 'seoul'
    or district = 'kyonggi');
    
select *   
  from country  
 where population >= 45000000 and population <= 55000000;
 
 select *   
  from country  
 where population between 45000000 and 55000000;
 
 select *
  from city
 where population between 9980000 and 1000000000;
 
 use mywork;
 desc box_office;

-- box_office table : 2004~2019년까지 개봉된 영화 정보

-- seq_no : 일련번호, 기본키
-- years : 제작연도
-- ranks : 순위
-- movie_name : 영화명
-- release_date : 개봉일
-- sale_amt : 매출액
-- share_rate : 점유율(매출액 기준)
-- audience_num : 관객수
-- screen_num : 스크린수
-- showing_count : 상영횟수
-- rep_country : 대표국적
-- countries : 국적
-- distributor : 배급사
-- movie_type : 유형(장편, 단편, ...)
-- genre : 장르(스릴러, 액션..)
-- director : 감독