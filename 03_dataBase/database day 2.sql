use mywork;
/* (테이블) box_office table : 2004~2019년까지 개봉된 영화 정보
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
*/

-- (실습) 2018년 개봉한 한국 영화 조회하기
select *
  from box_office
 where release_date >= '2018-01-01'
  and release_date <= '2018-12-31'
  and rep_country = '한국';
  
-- (실습) 2019년 개봉영화 중 관객수가 500만 명 이상인 영화 조회하기
select *
  from box_office
where release_date between '2019-01-01' and '2019-12-31'
  and audience_num >= 5000000;
  

-- (실습) 2019년 개봉영화 중 관객수가 500만명 이상이거나 매출액이 400억원 이상인 영화 조회하기
select years, ranks, movie_name, release_date, audience_num, sale_amt / 100000000  as sales
  from box_office
where release_date between '2019-01-01' and '2019-12-31'
  and (audience_num >= 5000000 or sale_amt >= 40000000000);
  
-- (실습) 2012년에 제작되었지만, 2019년에 개봉된 영화 조회하기
select * from box_office
 where years = 2012
  and release_date between '2019-01-01' and '2019-12-31';

/* 데이터 정렬하기 */
use world;

desc country;

select code, name, continent, region, population
  from country
 where population > 100000000
  order by population desc;

----
  
select name, continent, region
  from country
  where population > 50000000
   order by continent, region desc;
   
select code, name, continent, region, population
  from country
  where population > 50000000
   order by 5 desc;   

desc country;

select *
  from country
  where population > 50000000
   order by 5 desc;   

desc city;
-- (실습) city table을 참조해서 우리나라에 속한 도시에 대해, 도시명은 오름차순, 인구는 내림차순으로 조회하기
select * from city
 where countrycode = 'KOR'
 order by name, population desc;
 
 use mywork;
 
 select * from box_office
   limit 10;
   
select * from box_office
  where release_date between '2019-01-01' and '2019-12-31'
    and audience_num >= 5000000
  order by sale_amt desc
  limit 5;

desc countrylanguage;
-- (실습) world database의 countrylanguage table에 국가별 사용 언어가 있고,
-- 이 테이블 percentage 컬럼에는 해당 언어가 사용되는 비율값이 들어 있음
-- 이 비율이 99% 이상인 것을 국가코드 순으로 조회하기
select * from countrylanguage
  where percentage >= 99
  order by countrycode;

-- (실습) world database에 접속된 상태에서 mywork database에 있는 box_office 테이블에서
-- 2019년 제작된 영화중 순위(ranks)가 1위에서 10위까지인 영화를 순위(ranks)별로 조회하기
select * from mywork.box_office
  where years = 2019 and ranks between 1 and 10
  order by ranks;

-- (실습) mywork database로 이동해 box_office 테이블에서
-- 2019년 제작된 영화중 영화유형(movie_type)이 장편이 아닌 영화를 순위(ranks)대로 조회하기
use mywork;
select * from box_office
  where years = 2019 and movie_type != '장편'
  order by ranks;

-- (실습) box_office 테이블에서 2019년 제작된 영화 중 스크린수 기준 상위 10개 영화 조회하기
select * from box_office
  where years = 2019
  order by screen_num desc
  limit 10;

/* SQL 함수 사용하기 */
-- 숫자형 함수

select abs(1), abs(-1);

select length('mysql');

select 7 % 2,  7 mod 2, 7 / 2, 7 div 2;

select ceil(4.5), floor(4.5);

select log(10, 100), log10(100), ln(100), log(100);

select mod(5, 4), 5 mod 4, 5 % 4;

select power(4, 3), sqrt(25), sign(5), sign(-5);

select round(1153.456, 1), round(1153.456, 2), round(1153.4563, 3);

select round(1153.456, -1), round(1153.456, -2), round(1153.456, -3);

select truncate(2.4536, 2), truncate(1153.4536, -2);

select rand(), rand(3);

-- (퀴즈) 
select round(rand());

-- 문자형 함수
select char_length('sql'), length('sql');

select char_length('홍길동'), length('홍길동');

select concat("this", "is", "mysql");
select concat("this", NULL , "mysql");
select concat_ws("**", "this", "is", "mysql");

select format(123456789.123456, 3);

select instr("thisissql", "sql") as instr,
       locate("sql", "thisissqlandsql", 10) as locate,
       position("sql" in "thisissql") as pos;
       
select lower("AbCd"), lcase("AbCd");
select upper("AbCd"), ucase("AbCd");

select lpad("sql", 7, "#"),
       rpad("sql", 7, "#");
       
select ltrim('    sql    '),
       rtrim('    sql    ');       
       
select left("thisismysql", 4),
       right("thisismysql", 3);
       
select repeat("sql", 3);

select replace("생일 축하해 철수야", "철수", "영희") as rep;    

select reverse("sql");

select substr("this is mysql", 6, 2);
select substr("this is mysql", 6);

select substring("this is mysql", 6, 2);
select substring("this is mysql", 6);

select substring("this is mysql", -5, 2);
select substring("this is mysql", -5);

select mid("this is mysql", 6, 2);
select mid("this is mysql", 6);

select mid("this is mysql", -5, 2);
select mid("this is mysql", -5);

select trim("  mysql  ");
select trim(leading "*" from "***mysql***"),
       trim(trailing "*" from "***mysql***"),
       trim(both "*" from "***mysql***");
       
select strcmp("mysql", "mysql") as same,
       strcmp("mysql1", "mysql2") as small,
       strcmp("asia", "africa") as large;
       
-- (실습) "산토끼 토끼야" 문자열에서 토끼를 거북이로 바꾸세요    

select replace("산토끼 토끼야", "토끼", "거북이");

-- 날짜형 함수
select curdate(), current_date(), current_date;

select curtime(), current_time(), current_time;

select now(), current_timestamp(), current_timestamp;

select dayname("2022-04-05");
select dayofmonth("2022-04-05");
select dayofweek("2022-04-05");
select dayofyear("2022-04-05");


select last_day("2022-04-05");
select year("2022-04-05");
select month("2022-04-05");
select quarter("2022-04-05");
select weekofyear("2022-04-05");

-- INTERVAL expr unit
-- https://dev.mysql.com/doc/refman/8.0/en/expressions.html#temporal-intervals
select date_add("2022-04-05", interval 5 day),
	  adddate("2022-04-05", interval 5 day),
      adddate("2022-04-05", 5);
      
select date_add("2022-04-05", interval '1 2' year_month);
select date_add("2022-04-05", interval '1 2' day_hour);


select date_sub("2022-04-05", interval 5 day),
	  subdate("2022-04-05", interval 5 day),
      subdate("2022-04-05", 5);
      
select date_sub("2022-04-05", interval '1 2' year_month);
select date_sub("2022-04-05", interval '1 2' day_hour);

select extract(year_month from "2022-04-03 22:00:00");
select extract(day_hour from "2022-04-03 22:00:00");
select extract(minute_second from "2022-04-03 22:00:00");

select datediff("2022-04-05", "2022-04-04");
select datediff("2022-04-04", "2022-04-05");
select datediff("2022-04-05 00:00:00", "2022-04-04 23:59:59");

-- DATE_FORMAT 함수에서 사용하는 주요 식별자       
-- https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date-format
select date_format("2022-04-04 23:59:59", "%d-%b-%Y");

select str_to_date("5, 04, 2022", "%d, %m, %Y"); 

select makedate(2022, 100);
select makedate(2022, 365);

select sysdate(), sleep(2), sysdate();

select now(), sleep(2), now();

-- WEEK 함수에서 사용할 수 있는 mode 값
-- https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_week
select week("2022-01-03");

select yearweek("2022-01-03");

-- (실습) 현재 날짜를 기준으로 현재일이 속한 월의 마지막 날짜에 해당하는 요일 구하기
select dayname(last_day(curdate()));

select makedate(2022, 365);

-- (실습) world 데이터베이스에 접속해 country 테이블에서 인구가 4,500만 명에서 5,000만 명 사이에 있는 국가를 조회
-- 이 때 해당 국가명(name)과 대륙명(continent)을 연결해서 "국가명 (대륙명)" 형태로 조회하기 (예: South Korea (Asia))
use world;
select code, name, continent, concat(name, ' (', continent, ')') as name_continent
  from country
   where Population between 45000000 and 50000000;

-- (실습) mywork 데이터베이스에 접속해 box_office 테이블에서 2019년 개봉한 영화 중 관객수가 500만 명 이상인 영화를 조회
-- 이 때 매출액은 1억으로 나눈 후 소수점 없이 반올림 한 결과를 표시하기



-- (실습) 연인과 처음으로 만난 날이 2021년 5월 12일인데, 100일, 500일, 1000일이 되는 날을 조회

-- (실습) mywork 데이터베이스에 접속해 box_office 테이블에서 2019년 12월에 개봉한 영화의 제목과 개봉일을 조회

-- (실습) 현재 box_office 테이블에 영화감독(director)이 두 명 이상이면 ','로 연결되어 있음
-- 감독이 1명이면 그대로 두고, 두명 이상이면 ',' 대신 '/'값으로 대체해 조회

-- (실습) mywork 데이터베이스에 접속해 box_office 테이블에서 2019년에 개봉된 영화 중, 영화 제목에 ':'이 들어간 영화 조회
use mywork;
select movie_name, release_date
  from box_office
    where year(release_date) = 2019
      and instr(movie_name, ':') > 0;
    










