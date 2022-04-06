-- (실습) world 데이터베이스에 접속해 country 테이블에서 인구가 4,500만 명에서 5,000만 명 사이에 있는 국가를 조회
-- 이 때 해당 국가명(name)과 대륙명(continent)을 연결해서 "국가명 (대륙명)" 형태로 조회하기 (예: South Korea (Asia))
use world;
select code, name, continent, concat(name, ' (', continent, ')') as name_continent
  from country
   where Population between 45000000 and 50000000;

-- (실습) mywork 데이터베이스에 접속해 box_office 테이블에서 2019년 개봉한 한국 영화 중 관객수가 500만 명 이상인 영화를 조회
-- 이 때 매출액은 1억으로 나눈 후 소수점 없이 반올림 한 결과를 표시하기
use mywork;
select years, ranks, movie_name, release_date, audience_num, round(sale_amt/100000000) as sales
  from box_office
  where year(release_date) = 2019
    and rep_country = "한국"
    and audience_num >= 5000000;


-- (실습) 연인과 처음으로 만난 날이 2021년 5월 12일인데, 100일, 500일, 1000일이 되는 날을 조회
select adddate("20210512", 100) as 100일,
       adddate("20210512", 500) as 500일,
       adddate("20210512", 1000) as 1000일;

-- (실습) mywork 데이터베이스에 접속해 box_office 테이블에서 2019년 12월에 개봉한 영화의 제목과 개봉일을 조회
select movie_name, release_date
  from box_office
  where extract(year_month from release_date) = "201912";
  
-- (실습) 현재 box_office 테이블에 영화감독(director)이 두 명 이상이면 ','로 연결되어 있음
-- 감독이 1명이면 그대로 두고, 두명 이상이면 ',' 대신 '/'값으로 대체해 조회
select movie_name, replace(director, ',', '/')
  from box_office
  where instr(director, ',');
  

-- (실습) mywork 데이터베이스에 접속해 box_office 테이블에서 2019년에 개봉된 영화 중, 영화 제목에 ':'이 들어간 영화 조회
use mywork;
select movie_name, release_date
  from box_office
    where year(release_date) = 2019
      and instr(movie_name, ':') > 0;
      
-- 기타 함수들

select cast(10 as char),
	cast("10.21315" as double),
	cast("2022-04-06" as datetime);

select convert(10, char),
	convert("10.21315", double),
	convert("2022-04-06", datetime);
    
    
-- select if(참, 참일경우실행, 거짓일경우실행);
select if(2<1, 1, 0);

select ifnull(null, "null입니다"),
	   ifnull(1, "null입니다");
       
select nullif(1, 1), 
       nullif(1, 2);  
       
select case 1  when 0 then 'a'
			   when 1 then 'b'
	   end case1,
       
       case 3  when 0 then 'a'
			   when 1 then 'b'
               else "none"
	   end case2,
       
       case when 25 between 1 and 19  then '10대'
			when 25 between 20 and 30  then '20대'
            else "30대 이상"
	   end case3;       

-- (실습) mywork 데이터베이스의 box_office 테이블에서 2019년 개봉한 영화 중 순위(ranks) 기준 상위 10위까지 영화
-- 이 때 개봉일이 무슨 요일인지와 개봉일이 어떤 분기(상반기, 하반기)에 속해있는지도 조회하기 
-- (예: quarter(release_date) 가 1 또는 2이면 상반기, 3 또는 4이면 하반기)
use mywork;
select ranks, movie_name, release_date, dayname(release_date), 
       case when quarter(release_date) in (1, 2) then "상반기"
            else "하반기"
	   end 분기	, sale_amt
  from box_office
  where year(release_date) = 2019
    and ranks <= 10
  order by ranks;

-- 매출액 기준 상위 10  
select movie_name, release_date,
      case quarter(release_date) 
				 when 1 then '상반기' 
                 when 2 then '상반기' 
				 when 3 then '하반기'
                 when 4 then '하반기' 
	   end as 분기 
from mywork.box_office 
where year(release_date) = 2019 
order by sale_amt 
desc limit 10;


-- (실습) world 데이터베이스에 있는 country 테이블에는 indepyear라는 컬럼에는 해당 국가의 독립연도가 저장되어 있음
-- 이 때 각 국가명과 독립연도를 조회해 독립연도의 값이 없으면 '없음', 있으면 해당 독립연도를 조회하는 쿼리 작성하기
-- (힌트 : ifnull 함수 이용하기)
use world;
select name, indepyear, ifnull(indepyear, "없음")
  from country
  where name = "south korea";

-- (실습) mywork 데이터베이스의 box_office 테이블에서 2019년 개봉한 영화 중 
-- 순위(ranks)가 1~10위인 경우 "상위10" 그 외(11위 이상)는 "나머지" 라고 표시하기
-- (힌트 : case when 활용)\
-- option 1 
use mywork;
select movie_name, ranks, 
  case when ranks between 1 and 10 then "상위 10"
       else "나머지"
  end 순위
  from box_office
   where year(release_date) = 2019;

-- option 2
/*case when then 사용*/
use mywork;
select movie_name,release_date,ranks,
case when ranks<=10 then '상위10'
     else '나머지'
end 랭킹
from box_office
where release_date like '2019%'
order by ranks;
/*if문 사용*/
select movie_name,release_date,ranks,if(ranks<=10,'상위10','나머지')
from box_office
where release_date like '2019%'
order by ranks;



/* 데이터 집계하기 */
use world;
-- 1. 그룹화 하기
select continent
  from country
  group by continent
  order by continent;

select continent
  from country
  group by 1
  order by 1;
  
select continent, region
  from country
  group by continent, region
  order by continent, region;
  
select name, district, substring(district, 1, 3) as dist
  from city
   where countrycode = "KOR"
   group by substring(district, 1, 3);
 
select name, district, substring(district, 1, 3) as dist
  from city
   where countrycode = "KOR"
   group by dist;
  
select name, district, substring(district, 1, 3) as dist
  from city
   where countrycode = "KOR"
   group by 3;
   
-- group by 한 대상이 select 뒤에 나와야 의미가 있습니다. 아래는 안되는 경우
select continent
  from country
  group by region;


select distinct continent
 from country;


-- 2. 집계함수
select *
  from country;
  
select count(*), count(continent)
  from country;
  
select count(*), count(continent)
  from country;  

desc country;

select count(*), count(distinct name)  -- record(행) 수
  from country
  where continent = "europe";

select max(population), min(population), avg(population)
  from country
  where continent = "europe";
  
-- (참고)
-- 1단계
 select min(population)
  from country
  where continent = "europe";
  
  -- 2단계
  select name, population
    from country
    where continent= "europe" and population = 1000;

-- sub query 방식으로
select a.name, a.population, b.max_population
 from (
    select max(population) as max_population
      from country
      where continent = "europe"
 )b, country a
 where a.population = b.max_population;
 
    
-- 3. 그룹화 + 집계함수 -> 집계쿼리 완성











