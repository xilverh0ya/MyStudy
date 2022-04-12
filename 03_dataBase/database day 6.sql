
-- 테이블 생성
CREATE TABLE emp_hierarchy (
       employee_id   INT, 
       emp_name      VARCHAR(80),
       manager_id    INT,
       salary        INT,
       dept_name     VARCHAR(80)
);

-- 데이터 입력

INSERT INTO emp_hierarchy VALUES 
(200,'Jennifer Whalen',101,4400,'Administration'),
(203,'Susan Mavris',101,6500,'Human Resources'),
(103,'Alexander Hunold',102,9000,'IT'),
(104,'Bruce Ernst',103,6000,'IT'),
(105,'David Austin',103,4800,'IT'),
(107,'Diana Lorentz',103,4200,'IT'),
(106,'Valli Pataballa',103,4800,'IT'),
(204,'Hermann Baer',101,10000,'Public Relations'),
(100,'Steven King',null,24000,'Executive'),
(101,'Neena Kochhar',100,17000,'Executive'),
(102,'Lex De Haan',100,17000,'Executive'),
(113,'Luis Popp',108,6900,'Finance'),
(112,'Jose Manuel Urman',108,7800,'Finance'),
(111,'Ismael Sciarra',108,7700,'Finance'),
(110,'John Chen',108,8200,'Finance'),
(108,'Nancy Greenberg',101,12008,'Finance'),
(109,'Daniel Faviet',108,9000,'Finance'),
(205,'Shelley Higgins',101,12008,'Accounting'),
(206,'William Gietz',205,8300,'Accounting');

select * from emp_hierarchy 
order by 1;

select employee_id, emp_name, dept_name, salary 
  from emp_hierarchy 
order by 3, 4 desc;

-- 부서별 salary 합계 구하기 : sum() over~
select employee_id, emp_name, dept_name, salary,
  sum(salary) over (partition by dept_name) sum_salary
  from emp_hierarchy 
order by 3, 4 desc;

-- row_number()
select employee_id, emp_name, dept_name, salary,
  sum(salary) over (partition by dept_name) sum_salary,
  row_number() over (partition by dept_name) sequence
  from emp_hierarchy 
order by 3, 4 desc;

-- rank() : 순위
-- dense_rank() : 누적순위 
-- percent_rank() : (rank() - 1)/(rows - 1)  "상위 몇 % ~"
--                : 103 번, (1 - 1) / (5 - 1) = 0   104번, (2 -1) / (5 - 1) = 0.25

select employee_id, emp_name, dept_name, salary,
  rank() over (partition by dept_name order by salary desc) ranks,
  dense_rank() over (partition by dept_name order by salary desc) dense_ranks,
  percent_rank() over (partition by dept_name order by salary desc) percent_ranks
  from emp_hierarchy 
order by 3, 4 desc;

-- lag(__) : 현재 로우를 기준으로 바로 앞 로우의 __값 가져오기  /* lag(__, 1, null) */
-- lead(__) : 현재 로우를 기준으로 바로 뒤 로우의 __값 가져오기 /* lead(__,1, null) *
select employee_id, emp_name, dept_name, salary,
  lag(salary) over (partition by dept_name order by salary desc) lag_previous,
  lead(salary) over (partition by dept_name order by salary desc) lead_next
  from emp_hierarchy 
order by 3, 4 desc;


-- lag(__, n, 0) : 현재 로우를 기준으로 n번째 앞 로우의 __값 가져오기, 없을 경우 0을 가져옴 
-- lead(__,n, 0) : 현재 로우를 기준으로 n번째 뒤 로우의 __값 가져오기, 없을 경우 0을 가져옴
select employee_id, emp_name, dept_name, salary,
  lag(salary, 1, 0) over (partition by dept_name order by salary desc) lag_previous,
  lead(salary, 1, 0) over (partition by dept_name order by salary desc) lead_next
  from emp_hierarchy 
order by 3, 4 desc;

select employee_id, emp_name, dept_name, salary,
  lag(salary, 2, 0) over (partition by dept_name order by salary desc) lag_previous,
  lead(salary, 2, 0) over (partition by dept_name order by salary desc) lead_next
  from emp_hierarchy 
order by 3, 4 desc;

-- (실습) 
-- box_office 테이블에서 해마다 1위였던 영화들의 연도와 매출 구하고,
select year(release_date) years, sale_amt
  from box_office
  where ranks = 1;
-- 매출 증감율을 알기 위해서 전년 매출 필요하므로, ranks로 파티션 나누고(생략 가능),
-- lag() 함수를 이용해서 전년도 매출 구하기
select year(release_date) years, ranks, sale_amt,
  lag(sale_amt) over (order by year(release_date)) lastyear_sale_amt
  from box_office
   where ranks = 1;
-- 최종적으로 매출 증감율 구하기
with tmp as
(
select year(release_date) years, ranks, sale_amt,
  lag(sale_amt) over (order by year(release_date)) lastyear_sale_amt
  from box_office
   where ranks = 1
)  
select years, ranks, sale_amt, lastyear_sale_amt,
		round((sale_amt - lastyear_sale_amt)/lastyear_sale_amt * 100, 2) rates -- 매출 증감율을 위한 컬럼 추가
from tmp
order by 1 desc;
-- 2019년도 1위였던 영화의 매출액(1396억)과 2018년도 1위였던 영화의 매출액(1026억) 확인
-- 전년도 대비 매출액이 약 36% 증가했음을 알 수 있음

-- cume_dist() : 누적분포
select employee_id, emp_name, dept_name, salary,
  cume_dist() over (partition by dept_name order by salary desc) rates
  from emp_hierarchy
order by 3, 4 desc;

-- (실습) 
-- box_office 테이블에서 2019년 개봉한 상위 10편의 영화 순위와 제목, 매출액 구한뒤,
select ranks, movie_name,sale_amt
  from box_office
  where year(release_date) = 2019
    and ranks <= 10;
    
-- 연도별 총매출액을 구하기
select ranks, year(release_date), movie_name, sale_amt, 
  sum(sale_amt) over (partition by year(release_date)) sum_amt
  from box_office
  where year(release_date) = 2019
    and ranks <= 10;
-- 어차피 2019년도로 필터링이 되어 있어서 파티션 하지 않아도 됨
select ranks, year(release_date), movie_name, sale_amt, 
  sum(sale_amt) over () sum_amt
  from box_office
  where year(release_date) = 2019
    and ranks <= 10;    

-- 마지막으로 매출액이 많은 순서대로 누적 분포 값을 구하는 쿼리 작성하기
select ranks, year(release_date), movie_name, sale_amt, 
  sum(sale_amt) over () sum_amt,
  cume_dist() over (order by sale_amt desc) cume_dist_amt -- 누적 분포 컬럼
  from box_office
  where year(release_date) = 2019
    and ranks <= 10;   


-- ntile(n) : n개의 버킷(양동이)으로 나눈뒤,해당 로우가 몇번 째 양동이에 담길지를 반환
select employee_id, emp_name, dept_name, salary,
  ntile(3) over (partition by dept_name order by salary desc) ntiles
  from emp_hierarchy
order by 3, 4 desc;


-- 프레임절을 지정하지 않았을 때의 디폴트 값
-- https://dev.mysql.com/doc/refman/8.0/en/window-functions-frames.html
-- with order by : RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
-- without order by : RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING   

-- 프레임절로 집계 범위 조정하기
-- rows와 range의 차이

select employee_id, emp_name, dept_name, salary,
  sum(salary) over (partition by dept_name order by salary desc rows between unbounded preceding and current row) row_sum,
  sum(salary) over (partition by dept_name order by salary desc range between unbounded preceding and current row) range_sum
  from emp_hierarchy
order by 3, 4 desc;

-- rows : rows between 1 preceding and  1 following (현재 로우를 기준으로 앞 1행부터 뒤 1행까지)
-- ranges : ranges between 1000 preceding and 1000 following  (현재 로우를 기준으로 (현재로우값 - 1000) 부터 (현재로우값 +1000)

select employee_id, emp_name, dept_name, salary,
  sum(salary) over (partition by dept_name order by salary desc rows between 1 preceding and 1 following) row_sum,
  sum(salary) over (partition by dept_name order by salary desc range between 1000 preceding and 1000 following) range_sum
														-- 104번 행 기준 range : (6000-1000) 부터 (6000+1000), 5000~7000 구간은 104번만 한 프레임
  from emp_hierarchy
order by 3, 4 desc;


-- rows : first_value(), last_value()
select employee_id, emp_name, dept_name, salary,
  first_value(salary) over (partition by dept_name order by salary desc rows between 1 preceding and 1 following) firstvalue,
  last_value(salary) over (partition by dept_name order by salary desc rows between 1 preceding and 1 following) lastvalue
														
  from emp_hierarchy
order by 3, 4 desc;

-- ranges : first_value(), last_value()
select employee_id, emp_name, dept_name, salary,
  first_value(salary) over (partition by dept_name order by salary desc range between 1000 preceding and 1000 following) firstvalue,
  last_value(salary) over (partition by dept_name order by salary desc range between 1000 preceding and 1000 following) lastvalue
														
  from emp_hierarchy
order by 3, 4 desc;

-- nth_value(__, n)
select employee_id, emp_name, dept_name, salary,
  nth_value(salary, 2) over (partition by dept_name order by salary desc rows between 1 preceding and 1 following) firstvalue,
  nth_value(salary, 3) over (partition by dept_name order by salary desc range between 1000 preceding and 1000 following) lastvalue
														
  from emp_hierarchy
order by 3, 4 desc;

/* 뷰 생성하고 사용하기 */
-- 현재 기준으로 부서에 할당된 사원 정보 조회
select *
 from dept_emp
 where sysdate() between from_date and to_date;

-- (1) 뷰 생성하기
create or replace view dept_emp_v as
select *
 from dept_emp
 where sysdate() between from_date and to_date;

select *
 from dept_emp_v;
 
 -- (2) 뷰 수정하기
 -- option 1
create or replace view dept_emp_v as
select emp_no, dept_no
 from dept_emp
 where sysdate() between from_date and to_date;
 
 select *
 from dept_emp_v;
 
 -- option 2
 alter view dept_emp_v as
 select emp_no, dept_no, from_date, to_date
 from dept_emp
 where sysdate() between from_date and to_date;
 
  select *
 from dept_emp_v;
 
 -- (3) 뷰 삭제하기
 drop view dept_emp_v;
 
select *
 from dept_emp_v;
 
 create view qt_amt_v as
 select years, sum(case qtr when 1 then qt_sum_amt else 0 end) qt1_amt, 
			  sum(case qtr when 2 then qt_sum_amt else 0 end) qt2_amt, 
              sum(case qtr when 3 then qt_sum_amt else 0 end) qt3_amt, 
              sum(case qtr when 4 then qt_sum_amt else 0 end) qt4_amt
 from (
 select year(release_date) years, quarter(release_date) qtr , sum(sale_amt) qt_sum_amt
  from box_office
  where year(release_date) in (2018, 2019)
  group by year(release_date), quarter(release_date)
  order by 1, 2
  )a
  group by 1
  order by 1;
  
  
  select *
   from qt_amt_v
   where years = 2018;
   