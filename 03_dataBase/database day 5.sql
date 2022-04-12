/* 서브 쿼리 복습 */
-- (실습 1) 현재를 기준으로 각 부서에서 급여를 가장 많이 받는 사원은 누구인지 찾는 쿼리 작성하기
select a.dept_no, max(b.salary)
  from dept_emp a
  join salaries b
    on a.emp_no = b.emp_no
  where sysdate() between b.from_date and b.to_date
  group by a.dept_no;
-- > a.dept_no, max(b.salary) 정보를 취해서 서브쿼리로 지정
133516
134662
113318
126182
144434
119397
149440
124181
144866;

desc salaries;
select count(*) from salaries;

select k.dept_no, c.emp_no, k.max_salary
from salaries c,
(
select a.dept_no, max(b.salary) max_salary
  from dept_emp a
  join salaries b
    on a.emp_no = b.emp_no
  where sysdate() between b.from_date and b.to_date
  group by a.dept_no
) k
where c.salary = k.max_salary
order by 1;

-- (실습 2) box_office 테이블에서 2018년과 2019년에 개봉한 영화를 대상으로 연도별, 분기별 매출액을 구하는데,
-- 다음 형식으로 조회되도록 쿼리를 작성하기
-- ----------------------------------------------
-- 연도  |    1분기  |   2분기  |   3분기  |  4분기 
-- ----------------------------------------------
-- 2018 |          |         |         |
-- ----------------------------------------------
-- 2019 |          |         |         |
-- ----------------------------------------------

select year(release_date), quarter(release_date), sum(sale_amt)
  from box_office
  where year(release_date) in (2018, 2019)
  group by year(release_date), quarter(release_date)
  order by 1, 2;


-- > idea :  sum(sale_amt)를 활용할 수 있는 서브쿼리 만들기
-- 형식은 아래처럼
-- select years, qt1_amt, qt2_amt, qt3_amt, qt4_amt

select years, case qtr when 1 then qt_sum_amt else 0 end qt1_amt, 
			  case qtr when 2 then qt_sum_amt else 0 end qt2_amt, 
              case qtr when 3 then qt_sum_amt else 0 end qt3_amt, 
              case qtr when 4 then qt_sum_amt else 0 end qt4_amt
 from (
 select year(release_date) years, quarter(release_date) qtr , sum(sale_amt) qt_sum_amt
  from box_office
  where year(release_date) in (2018, 2019)
  group by year(release_date), quarter(release_date)
  order by 1, 2
  )a;
2018	342938316151	0	0	0
2018	0	386576979377	0	0
2018	0	0	538954726849	0
2018	0	0	0	466402187954
2019	448801333715	0	0	0
2019	0	499027844273	0	0
2019	0	0	465802548725	0
2019	0	0	0	457152436475
;  

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
  
  
-- (실습 3) 현재를 기준으로 어느 부서에도 속하지 않은 사원은 모두 몇 명인지 구하는 쿼리 작성하기

select count(*)
  from employees;
select count(*)
  from dept_emp;
  
select count(*)
from employees a
  where a.emp_no not in ( select b.emp_no
                           from dept_emp b
                             where sysdate() between b.from_date and b.to_date
						);
select count(*)
from employees a
  where not exists ( select b.emp_no
                           from dept_emp b
                             where sysdate() between b.from_date and b.to_date
                             and a.emp_no = b.emp_no
					);                        
                            
/* 1. Insert문으로 데이터 입력하기 */
use mywork;

-- 테이블 생성
create table emp_test(
   emp_no int not null,
   emp_name varchar(30) not null,
   hire_date date null,
   salary int null,
   primary key (emp_no)
);

insert into emp_test(emp_no, emp_name, hire_date)
           values (1002, "아이작뉴턴", "2022-02-01");

select * from emp_test;

insert into emp_test(hire_date, emp_no, emp_name )
           values ("2022-02-10", 1003, "갈릴레오");

-- (오류 예) not null 옵션있는 컬럼은 필히 입력 
insert into emp_test(emp_no, hire_date)
        values (1004, "2021-02-10");
        
-- (오류 예) pk 중복 값 입력
insert into emp_test(emp_no, emp_name, hire_date)
       values (1003, "리처드파인만", "2022-01-10");

-- 컬럼 리스트 생략
insert into emp_test
         values (1004, "리처드파인만", "2022-01-10", 3000);

select * from emp_test;

insert into emp_test values
             (1005, "퀴리부인", "2022-03-01", 4000),
             (1006, "스티븐호킹", "2022-03-05", 5000);
             
insert into emp_test values
             (1007, "마이클패러데이", "2022-04-01", 2200),
             (1008, "맥스웰", "2022-04-05", 3300),
             (1009, "막스플랑크", "2022-04-05", 4400);    
             
-- 테이블 생성
create table emp_test2(
   emp_no int not null,
   emp_name varchar(30) not null,
   hire_date date null,
   salary int null,
   primary key (emp_no)
);             

select * from emp_test2;

insert into emp_test2 (emp_no, emp_name, hire_date, salary)
select emp_no, emp_name, hire_date, salary
  from emp_test
  where emp_no in (1001, 1002);
  
select * from emp_test2;  
   
insert into emp_test2 
select *
  from emp_test
  where emp_no in (1003, 1004);
  
select * from emp_test2;  

-- (오류 예) 중복된 키값 입력
insert into emp_test2 (emp_no, emp_name, hire_date, salary)
select emp_no, emp_name, hire_date, salary
  from emp_test
  where emp_no >= 1004;
  
select * from emp_test;

insert into emp_test
select emp_no + 10, emp_name, hire_date, 100
  from emp_test
  where emp_no >= 1008;

select * from emp_test;

/* Update 문으로 데이터 수정하기 */

-- emp_update1 테이블을 만들되, emp_test로부터 복사하고
-- alter 명령어를 사용하여 primary key 지정하기

create table emp_update1 as
select *
  from emp_test;

alter table emp_update1
  add constraint primary key (emp_no);


create table emp_update2 as
select *
  from emp_test2;

alter table emp_update2
  add constraint primary key (emp_no);
  
  
select * from emp_update1;
select * from emp_update2;

update emp_update1
set emp_name = concat(emp_name, '2'),
    salary = salary + 100;

select * from emp_update1;

-- (오류 예) pk 중복 입력
update emp_update1
 set emp_no = emp_no + 1
where emp_no >= 1018;

-- 
update emp_update1
  set emp_no = emp_no + 1
  where emp_no >= 1018
  order by emp_no desc;

select * from emp_update1;

-- (주의) 기본키는 테이블의 근간이 되므로 수정하지 말자!!

 -- 두 테이블간 관계를 이용해 다른 테이블을 컬럼을 참조해 변경
select * from emp_update1;
select * from emp_update2;
1002	아이작뉴턴2	2022-02-01	
1003	갈릴레오2	2022-02-10	
1004	리처드파인만2	2022-01-10	3100
1005	퀴리부인2	2022-03-01	4100
1006	스티븐호킹2	2022-03-05	5100
1007	마이클패러데이2	2022-04-01	2300
1008	맥스웰2	2022-04-05	3400
1009	막스플랑크2	2022-04-05	4500
1019	맥스웰2	2022-04-05	200
1020	막스플랑크2	2022-04-05	200
			
-- 
1002	아이작뉴턴	2022-02-01	
1003	갈릴레오	2022-02-10	
1004	리처드파인만	2022-01-10	3000
			            
;
            
update emp_update2 a, emp_update1 b
   set b.salary = ifnull(b.salary, 0),
       a.salary = b.salary + 2000 
	where a.emp_no = b.emp_no;


select * from emp_update1;
1003	갈릴레오2	2022-02-10	0
1004	리처드파인만2	2022-01-10	3100
1005	퀴리부인2	2022-03-01	4100
;
select * from emp_update2;
1002	아이작뉴턴	2022-02-01	
1003	갈릴레오	2022-02-10	
1004	리처드파인만	2022-01-10	5100
;
    
-- 입력(1005)과 수정(1003, 1004)을 동시에 처리
insert into emp_update2
select emp_no, emp_name, hire_date, salary
  from emp_update1 a
  where emp_no between 1003 and 1005
  on duplicate key update emp_name = a.emp_name,
                          salary = a.salary;
select * from emp_update2;
1002	아이작뉴턴	2022-02-01	
1003	갈릴레오2	2022-02-10	0
1004	리처드파인만2	2022-01-10	3100
1005	퀴리부인2	2022-03-01	4100
;  

select * from emp_update1;
select * from emp_update2;
-- (실습) emp_update2 테이블에서 사번이 1001과 1002인 건의 사원명을
-- emp_update1 테이블의 동일 사번을 가진 사원명으로 "emp_update2"에 변경하는 update문 작성하기
update emp_update2 a, emp_update1 b
  set a.emp_name = b.emp_name
  where a.emp_no = b.emp_no
    and a.emp_no in (1001, 1002);
    
/* 3. Delete 문으로 데이터 삭제하기 */
-- 테이블 생성
create table emp_delete
select * from emp_test;

alter table emp_delete
add constraint primary key(emp_no);

select * from emp_delete;    

delete from emp_delete
  where salary is null;

select * from emp_delete;    

delete from emp_delete;

insert into emp_delete
select * from emp_test;

-- 두명의 맥스웰 중 한명(뒷번호 1018)만 삭제하기
delete from emp_delete
 where emp_name = "맥스웰"
 order by emp_no desc
 limit 1;

select * from emp_delete;  

-- 다중 테이블 삭제
create table emp_delete2
select * from emp_test;

alter table emp_delete2
add constraint primary key(emp_no);

select * from emp_delete2;  

-- 두 테이블이 1018 멕스웰 한 레코드만 다른 상태
delete a, b
 from emp_delete a, emp_delete2 b
 where a.emp_no = b.emp_no;
 
select * from emp_delete;
select * from emp_delete2;  

-- 원래 상태로 복구 (1018이 각각 다르게 세팅)
delete from emp_delete2;

insert into emp_delete
select * from emp_test
where emp_no <> 1018; -- 1018번만 빼고 복사
 
insert into emp_delete2
select * from emp_test;

-- using 문법으로 대체 ( 삭제 대상 테이블을 1개만 두었음)
delete from b
 using emp_delete a, emp_delete2 b
 where a.emp_no = b.emp_no;

select * from emp_delete; 
select * from emp_delete2; 


-- (실습) emp_delete 테이블에서 사원명이 막스플랑크인 데이터를 삭제하는데,
-- 이번에는 사번이 빠른 건 1개만 삭제하는 쿼리 작성하기
delete from emp_delete 
 where emp_name = "막스플랑크"
 order by emp_no
 limit 1;


/* 4. 트랜잭션 처리하기 */

-- 자동커밋 기본값은 활성화되어 있음
select @@autocommit;

-- 비활성화하기
set autocommit = 0;

select @@autocommit;

-- 자동커밋 비활성화 상태에서 트랜잭션 처리하기
create table emp_tran1 as
select * from emp_test;

alter table emp_tran1
add constraint primary key (emp_no);

create table emp_tran2 as
select * from emp_test;

alter table emp_tran2
add constraint primary key (emp_no);
-- ddl은 영향 받지 않으므로 commit/rollback 사용할 필요 없음
-- dml만 transaction 처리 가능!!

-- rollback
delete from emp_tran1;
delete from emp_tran2;

select * from emp_tran1;

rollback; 
select * from emp_tran1;
select * from emp_tran2;

-- commit 적용
delete from emp_tran1;
commit;
delete from emp_tran2;
rollback;

select * from emp_tran1;
select * from emp_tran2;


insert into emp_tran1
select * from emp_test;

select @@autocommit;
set autocommit = 1;

select * from emp_test;
-- start transaction : 일시적으로 자동커밋이 비활성화 
start transaction;

-- 데이터 삭제
delete from emp_tran1
  where emp_no >= 1006;

update emp_tran1
  set salary = 0
  where salary is null;
  
rollback;

select * from emp_tran1;  

-- savepoint 활용

start transaction;

savepoint a;

delete from emp_tran1
 where salary is null;

savepoint b;

delete from emp_tran1
  where emp_name = "맥스웰"
  order by emp_no
  limit 1;

rollback to savepoint b;

select * from emp_tran1;  

-- 수동으로 트랜재션 처리 하던중 emp_trans2 테이블에서 salary 컬럼 값이 1000인 건을 삭제하려고 delete문을 실행
-- 그런데 실수로 1000이 아닌 100인건을 삭제. 삭제전으로 되돌리는 일련의 과정을 sql 문으로...
start transaction;

delete from emp_tran2
  where salary = 100;
  
select * from emp_tran2;
-- 없어진 것 확인

-- 삭제 작업 취소
rollback;
select * from emp_tran2;



-- (실습) box_office 테이블을 참조해 box_office_copy 테이블을 만들기
-- 이 때 box_office 테이블에서 2019년 개봉 영화 중 관객수가 800만 명 이상인 데이터를 box_office_copy 테이블에 넣는 insert문 작성하기

-- option 1
create table box_office_copy as
select * from box_office 
  where 1 = 2;

select * from box_office_copy;

insert into box_office_copy
select * from box_office
 where year(release_date) = 2019
  and audience_num >= 8000000;

select ranks, audience_num from box_office_copy;
1	16265618
2	13934592
3	13369064
4	12552283
5	10085275
6	9426011
7	8021145
;
-- option 2
create table box_office_copy as
select *
from box_office
where year(release_date) = 2019 and audience_num >=8000000;


-- (실습) box_office_copy 테이블에 last_year_audi_num 이라는 이름의 int 컬럼을 추가한뒤
-- "box_office 테이블의 2018년 개봉 영화와 순위(ranks)가 같은 건"의 관객수(audience_num) 값으로 변경하는 update 문 작성하기
alter table box_office_copy
 add column last_year_audi_num int null;
 -- update 될 내용 미리보기
select b.ranks, b.audience_num -- 원본
 from box_office b, box_office_copy a
 where a.ranks = b.ranks
   and year(b.release_date) = 2018;
1	12274996
2	11212710
3	9224582
4	6584915
6	5661128
7	5448134
;

update box_office_copy a, box_office b
  set a.last_year_audi_num = b.audience_num
   where a.ranks = b.ranks
   and year(b.release_date) = 2018;
   
select ranks, audience_num, last_year_audi_num from box_office_copy;

-- (실습) 사원의 부서 할당 정보가 들어 있는 dept_emp 테이블에서 
-- 현재 기준이 아닌 과거 기준으로 데이터를 삭제(현재 일하고 있는 않은 사람 삭제)하는 delete 문 작성

create table dept_emp_test as
 select * from dept_emp;

select count(*) from dept_emp; -- 33188

select count(*) from dept_emp  -- 9053
where sysdate() not between from_date and to_date;

delete from dept_emp_test
 where sysdate() not between from_date and to_date;

select count(*) from dept_emp_test; -- 24135 (33188 - 9053)

-- transaction 이용
start transaction;
delete from dept_emp
 where sysdate() not between from_date and to_date;
rollback;
select *  from dept_emp;





/*
컬럼 추가 (Add)
ALTER TABLE table_name ADD COLUMN ex_column varchar(32) NOT NULL;


컬럼 변경 (Modify)
ALTER TABLE table_name MODIFY COLUMN ex_column varchar(16) NULL;


컬럼 이름까지 변경 (Change)
ALTER TABLE table_name CHANGE COLUMN ex_column ex_column2 varchar(16) NULL;


컬럼 삭제 (Drop)
ALTER TABLE table_name DROP COLUMN ex_column;

테이블 이름 변경 (RENAME)
ALTER TABLE table_name1 RENAME table_name2;


출처: https://extbrain.tistory.com/39 
*/


/* CTE */
-- 부서 관리자 테이블(dept_manager)과 사원 테이블(employees)을 조인해 
-- 현재 관리자의 부서번호, 사번, 사원 이름을 조회하는 쿼리
select c.dept_no, c.dept_name, mng.emp_no, mng.fname
  from departments c,
  (select a.dept_no, b.emp_no, concat(b.first_name, ' ', b.last_name) fname
    from dept_manager a, employees b
      where a.emp_no = b.emp_no
  )mng
where c.dept_no = mng.dept_no;

with mng1 as
(select a.dept_no, b.emp_no, concat(b.first_name, ' ', b.last_name) fname
    from dept_manager a, employees b
      where a.emp_no = b.emp_no
)
select c.dept_no, c.dept_name, b.emp_no, b.fname
  from departments c, mng b
  where c.dept_no = b.dept_no;
  
-- box_office 테이블에서 2018년 이후 개봉된 영화 중에서 매출 10위 안에 든 영화들의 총 매출액과 평균 매출액을 연도로 구하는 쿼리 작성하기
with summary as(
select year(release_date) years, sum(sale_amt) sum_amt, avg(sale_amt) avg_amt
  from box_office
where year(release_date) >= 2018
 and ranks <= 10
group by 1
) -- 2건
select b.years, a.ranks, a.movie_name, a.sale_amt, b.sum_amt, b.avg_amt
from box_office a
join summary b
 on year(a.release_date) = b.years
 where a.ranks <= 10
 order by 1;

-- window 함수 : 복잡한 서브쿼리를 간단히 구현
select year(release_date), a.ranks, a.movie_name, a.sale_amt, 
   sum(sale_amt) over (partition by year(release_date)) sum_amt,-- sum_amt
   avg(sale_amt) over (partition by year(release_date)) avg_amt -- avg_amt
from box_office a
 where a.ranks <= 10
  and year(release_date) >= 2018
 order by 1;


  