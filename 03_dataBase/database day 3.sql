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

-- city 테이블에서 "국가 코드별"로 "도시 수"를 구하는 집계 쿼리 작성하기
desc city;

select *
  from city;

select countrycode, count(*)
  from city
  group by countrycode;
  
-- (실습) 2019년 개봉 영화의 유형별 최대, 최소 매출액과 전체 매출액 집계하기 
select movie_type, max(sale_amt), min(sale_amt), sum(sale_amt), count(*)
  from box_office
  where year(release_date) = 2019
  group by movie_type;


-- (실습) 2019년 개봉 영화 중 매출액이 1억 원 이상인 영화의 분기별, 배급사별 개봉 영화 수와 매출액 집계하기
desc box_office;

select quarter(release_date), distributor, count(*), round(sum(sale_amt) / 100000000) as 매출액
  from box_office
  where year(release_date) = 2019
    and sale_amt >= 100000000
  group by quarter(release_date), distributor
  order by 1;

-- (실습) world 데이터베이스의 country 테이블에서 대륙별 면적(surfacearea)이 가장 크고 인구가 가장 많은 대륙 순으로 정렬하는 쿼리
use world;
select continent, sum(surfacearea), sum(population), count(*)
  from country
  group by continent
  order by 2 desc, 3 desc;


-- (실습) mywork 데이터베이스의 box_office 테이블에서 2019년 개봉 영화 중 1~10위 영화와 나머지 영화의 매출액 합계를 구하는 쿼리
use mywork;

select case when ranks between 1 and 10 then "상위 10"
		    else "나머지"
       end 순위, sum(sale_amt), count(*)
  from box_office
  where year(release_date) = 2019
  group by 1;
    


 /* 총계 산출과 Having 절 */
 -- 1. with rollup
 --  world 데이터베이스의 country 테이블에서 대륙(continent)별로 몇 개 국가가 있는지와 전체 국가 수의 합계까지 조회하기
use world;
select continent, count(*)
  from country
  group by continent with rollup; -- 239
  
select count(*)
 from country;  -- 239
 
 -- 2019년 개봉 영화 중 매출액이 천만원 이상인 것을 골라 "영화 유형별"로 매출액 소계를 구하는 쿼리
use mywork;

select movie_type, sum(sale_amt)
  from box_office
  where year(release_date) = 2019
     and sale_amt >= 10000000
  group by movie_type with rollup; -- 1870105386118

-- 매출 총합 확인
select sum(sale_amt)
  from box_office
  where year(release_date) = 2019
     and sale_amt >= 10000000;  -- 1870105386118
 
 -- 2019년 1분기 개봉 영화중 매출액이 천만원 이상인 "영화의 월별", "영화 유형별" 매출액 소계 구하기
 select month(release_date), extract(year_month from release_date) as 개봉년월, movie_type, sum(sale_amt), count(*)
   from box_office
   where year(release_date) = 2019
     and quarter(release_date) = 1
     and sale_amt >= 10000000
   group by month(release_date), movie_type with rollup -- 총합 : 448682208765
   order by 1; 
 
 select sum(sale_amt)
   from box_office
    where year(release_date) = 2019
     and quarter(release_date) = 1
     and sale_amt >= 10000000;  -- 총합 : 448682208765

 -- 2. grouping 함수
 -- 2019년 개봉 영화의 영화 유형별 매출액의 소계 구하기
select movie_type, sum(sale_amt), grouping(movie_type)
  from box_office
   where year(release_date) = 2019
  group by movie_type with rollup;
  
select if(grouping(movie_type) = 1, "전체합계", movie_type) 영화유형, sum(sale_amt)
  from box_office
   where year(release_date) = 2019
  group by movie_type with rollup;  

 
 -- 3. Having 절
 -- "개봉월별"로 순위가 1~10위에 있는 영화 편수 구하기
 -- 이 때 영화가 2편이상 개봉한 연월만 골라 조회하기
select extract(year_month from release_date) as 개봉년월, count(*) 개봉편수
  from box_office
    where ranks between 1 and 10	
    group by extract(year_month from release_date)
    having count(*) > 2;
    
 
-- (실습) 개봉월별로 순위가 1~10위에 있는 영화 편수 구하기
-- 이 때 "개봉월별 매출액이 1500억 이상인 경우"만 조회하기
select extract(year_month from release_date) as 개봉년월, round(sum(sale_amt)/100000000) 금액_억원
  from box_office
    where ranks between 1 and 10	
    group by extract(year_month from release_date)
    having round(sum(sale_amt)/100000000) > 1500
    order by 2 desc;
    

-- (실습) 2019년 개봉 영화 중 매출액이 천만원 이상인 것을 골라 "영화 유형별"로 매출액 소계를 구하기
-- 이 때 Having 절 이용하여 영화유형 컬럼을 기준으로 소계나 총계로 나온 결과 로우만 걸러내기
select movie_type, sum(sale_amt)
  from box_office
  where year(release_date) = 2019
    and sale_amt > 10000000
  group by movie_type with rollup
  having grouping(movie_type) = 1;
  
  
-- (실습) box_office 테이블에서 2019년 개봉영화 중 "국가별" 관객수가 50만명 이상인 건을 조회하는데, 
-- 이 때 국가별 총계 구하는 쿼리
select rep_country, sum(audience_num)
  from box_office
    where year(release_date) = 2019
    group by rep_country with rollup
    having sum(audience_num) >= 500000;
	

-- (실습) box_office 테이블에서 2015년 이후 개봉한 영화 중 
-- 연도별로 2번 이상 관객수가 100만을 넘긴 영화의 감독과 관객수를 "연도별", "감독별"로 구하는 쿼리
select year(release_date), director, sum(audience_num), count(*) 개봉편수
  from box_office
    where year(release_date) > 2015   
      and audience_num > 1000000
    group by year(release_date), director
    having count(*) >= 2;
      

/* 내부 조인 */
use world;

desc city;
desc country;
select a.id, a.name, a.countrycode, b.code, b.continent, a.population
  from city a
 inner join country b
  on a.countrycode = b.code;

desc countrylanguage;

select b.name, a.language, a.percentage
  from countrylanguage a
 join country b
   on a.countrycode = b.code;
   
select b.name, a.language, a.percentage
  from countrylanguage a
 join country b
   on a.countrycode = b.code
 where a.countrycode = "KOR";
   
select a.code, a.name, b.language, c.name, c.population
  from country a
 join countrylanguage b
   on a.code = b.countrycode
 join city c
   on a.code = c.countrycode
 where a.code= "kor";

-- (실습) world 데이터베이스에서 country와 city 테이블을 내부 조인해 국가명과 해당 국가에 속한 도시 개수를 구하고, 
-- 마지막에는 전체 도시 수를 구하는 쿼리 작성하기 

select a.name, b.name, count(*) 도시수
  from country a
  join city b
    on a.code = b.countrycode
  group by a.name;



/* 외부 조인 */




