/* 내부 조인 */
-- (실습) world 데이터베이스에서 country와 city 테이블을 내부 조인해 국가명과 해당 국가에 속한도시 개수를 구하고,
-- 마지막에는 전체도시 수를 구하는 쿼리 작성하기 (힌트 : with rollup)

-- 1:m 의 내부 조인 결과는 m개의 집합체가 나옴
use world;

select count(*)
from country; -- 239

select count(*)
from city; -- 4079

select a.name, b.name
  from country a
    join city b
      on a.code = b.countrycode; -- 총 4079의 행이 나옴

select if(grouping(a.name), "전체도시수", a.name) 도시,  count(*) 도시수
  from country a
    join city b
      on a.code = b.countrycode
  group by a.name with rollup; -- 총계 4079
      

/* 외부 조인 */
select continent
  from country
  group by continent;

-- country와 city 내부 조인  
select a.continent, count(*)
  from country a
  join city b
    on a.code = b.countrycode
  group by a.continent;
  
  select *
    from country
    where continent = "Antarctica";

desc city;
   select *
    from city
    where countrycode = 'ATA';
    
-- 외부조인
select a.continent, a.code, b.CountryCode, b.name
  from country a
  left outer join city b
    on a.code = b.countrycode;

  
select a.continent, count(*), count(b.name) 도시수
  from country a
  left outer join city b
    on a.code = b.countrycode
  group by a.continent;
  
  -- right 조인으로 바로 위의 left 조인 결과와 동일하게 맞추려면
  select a.continent, count(*), count(b.name) 도시수
  from city b
  right outer join country a
    on a.code = b.countrycode
  group by a.continent;
  
  -- (실습) 아프리카(Africa)대륙에 속한 국가 중 사용 언어가 없는 국가가 있음
  -- country 테이블과 countrylanguage 테이블을 외부조인해서 이 국가의 이름이 무엇인지 찾는 쿼리 작성하기
  desc country;
  desc countrylanguage;
  
  -- option 1
  select a.name, b.language
    from country a
    left join countrylanguage b
      on a.code = b.countrycode
	where a.continent = "africa"
       and b.language is null;
 
 -- option 2
  select a.name, b.language, count(b.language)
    from country a
    left join countrylanguage b
      on a.code = b.countrycode
	where a.continent = "africa"
    group by a.name
    having count(b.language) = 0;

	       
/* Union */
  
use mywork;

create table tbl1 (col1 int, col2 varchar(20));
create table tbl2 (col1 int, col2 varchar(20));

insert into tbl1 values (1, "가"), (2, "나"), (3, "다");
select *
  from tbl1;
  
insert into tbl2 values (1, "A"), (2, "B");
select *
  from tbl2;  

-- 한컬럼 연결  
select col1
   from tbl1
 union   -- distinct 한 값만 가져옴(default) 모두 가져오고 싶으면 union all
select col1
   from tbl2;

-- 두컬럼 연결  
select col1, col2
  from tbl1
 union -- distinct 한지의 기준 : 두컬럼의 조합으로 판단
 select col1, col2
  from tbl2; 

-- order by, limit 함께 사용 가능, ()로 묶어줘야 함
(select col1, col2
  from tbl1
  order by col1 desc limit 3)
union  
 select col1, col2
  from tbl2;   
  
-- (실습) tbl1과 tbl2 테이블에서 tbl1은 전체, tbl2 테이블은 col1 값이 1인 건만 조회하는 쿼리 작성하기
select * from tbl1
union all
select * from tbl2
  where col1 = 1;


/* 사원 기존 정보를 이용한 테이블 조인 실습 */

-- (실습 1) 사원의 사번, 이름, 부서명 조회하기
-- 각 테이블의 레코드 수 확인
select count(*)
  from departments; -- 10


select count(*)
  from dept_emp; -- 33188
  
select count(*)
  from employees;  -- 30023
  
select count(*) 
  from employees a
    join dept_emp b;  -- 30023 * 33188
    
desc employees;
desc dept_emp;
desc departments;

select count(*) 
  from employees a
    join dept_emp b
      on a.emp_no = b.emp_no; -- 33188
      
select a.emp_no, b.dept_no , count(distinct b.dept_no) 
  from employees a
    join dept_emp b
      on a.emp_no = b.emp_no;      
      
-- employees, dept_emp 두 테이블 내부 조인 
-- employees 보다 dept_emp 행의수가 더 많음
-- 즉 1:m의 관계로 한 직원이 타부서 매니저도 겸함을 알 수 있음
-- dep_emp 행의 개수의 집합체가 만들어짐
  
select count(*)  
  from employees a
    join dept_emp b
      on a.emp_no = b.emp_no
	join departments c
      on b.dept_no = c.dept_no; -- 33188

select a.emp_no, b.dept_no, c.dept_name 
  from employees a
    join dept_emp b
      on a.emp_no = b.emp_no
	join departments c
      on b.dept_no = c.dept_no;

select a.emp_no, concat(a.first_name, ' ', a.last_name) emp_name, c.dept_name
  from employees a
    join dept_emp b
      on a.emp_no = b.emp_no
	join departments c
      on b.dept_no = c.dept_no;

select a.emp_no, concat(a.first_name, ' ', a.last_name) emp_name, c.dept_name -- , count(*)
  from employees a
    join dept_emp b join departments c
      on a.emp_no = b.emp_no and b.dept_no = c.dept_no;
      

-- (실습 2) Marketing과 Finance 부서의 현재 관리자 (직원)정보 조회하기
select count(*)
  from dept_manager;
select count(*)
  from departments; 
 -- 한 부서에 여러 매니저가 있음을 알 수 있음 1:m 관계
 
 
select count(*)
  from dept_manager a
    join departments b
      on a.dept_no = b.dept_no; -- 24

    
 select a.emp_no, b.dept_name
  from dept_manager a
    join departments b
      on a.dept_no = b.dept_no; 
      
-- 직원 정보 얻기 위해 한번 더 join
 select count(*) 
  from dept_manager a
    join departments b
      on a.dept_no = b.dept_no
    join employees c
      on a.emp_no = c.emp_no; -- 24

 select a.emp_no, b.dept_name, concat(c.first_name, ' ', c.last_name) emp_name
  from dept_manager a
    join departments b
      on a.dept_no = b.dept_no
    join employees c
      on a.emp_no = c.emp_no
    where b.dept_name in ('Marketing','Finance')
       and sysdate() between a.from_date and a.to_date;
       
      
-- (실습 3) 모든 부서의 이름과 현재 관리자의 사번 조회하기
select a.dept_name, b.emp_no, b.from_date, b.to_date 
  from departments a
  left join dept_manager b
    on a.dept_no = b.dept_no
  where sysdate() between b.from_date and b.to_date
        or b.from_date is null;

-- (실습 3-1) "모든 부서"의 이름과 현재 관리자의 사번 조회하기 + 관리자 이름까지
select a.dept_name, b.emp_no, b.from_date, b.to_date, concat(c.first_name, ' ', c.last_name) name
  from departments a
  left join dept_manager b
    on a.dept_no = b.dept_no
  left join employees c
    on c.emp_no = b.emp_no
  where sysdate() between b.from_date and b.to_date
        or b.from_date is null;

   
        
-- (실습 4) 1) 부서별 사원 수와 --2) 전체 부서의 총 사원 수 구하기
-- option 1
select if(grouping(a.dept_name), "All", a.dept_name) department, count(*)
  from departments a
  join dept_emp b
    on a.dept_no = b.dept_no
   where sysdate() between b.from_date and b.to_date
  group by a.dept_name with rollup;

-- option 2
select a.dept_name, count(*)
  from departments a
  join dept_emp b
    on a.dept_no = b.dept_no
   where sysdate() between b.from_date and b.to_date
  group by a.dept_name
union   
select "All", count(*)
  from dept_emp
  where sysdate() between from_date and to_date;


/* 서브쿼리 */
select col
  from tbl
  where cond;
  
-- 1. 스칼라 서브쿼리
select col, (서브쿼리)
  from tbl
  where cond;

-- 2. 파생 테이블
select col
  from tbl, (서브쿼리)
  where cond;

-- 3. Where 절의 서브쿼리
select col
  from tbl
  where val >= (서브쿼리);
  
  
-- 랭킹 1위인 영화들 조회
select *
  from box_office
  where ranks = 1;

-- 랭킹 1위인 영화들의 연도별, 영화별 매출액 구하기
select year(release_date), movie_name, sale_amt
  from box_office
  where ranks = 1  
  group by 1, 2
  order by 1;

-- 1위인 영화들의 평균 매출액 구하기: 영화한편 또는 두편에 대한 평균이 나옴
select year(release_date), movie_name, sale_amt, avg(sale_amt)
  from box_office
  where ranks = 1
   group by 1, 2
   order by 1;

-- 1위인 영화들의 평균을 알고 싶을 때
 select avg(sale_amt)
   from box_office
   where ranks = 1;

-- 랭킹 1위인 영화를 대상으로 각 영화(1위인 영화들) 매출액이 전체 평균 매출액보다 큰 영화만 조회하기

