/* 타이타닉 데이터 분석하기 */
CREATE TABLE titanic_data
(	passengerid  INT,
	survived     INT,
	pclass       INT,
	name         VARCHAR(100),
	gender       VARCHAR(50),
	age          DOUBLE,
	sibsp        INT,
	parch        INT,
	ticket       VARCHAR(80),
	fare         DOUBLE,
	cabin        VARCHAR(50) ,
	embarked     VARCHAR(20),
	PRIMARY KEY (passengerid)
);
       
       

-- file -> open sql script -> 03.titanic_data_insert.sql 파일 열기 -> 전체 실행
       
       
-- 테이블의 입력 건수 확인
SELECT *
  FROM titanic_data;  
       

-- 1. 데이터 정제 
CREATE TABLE titanic AS
SELECT passengerid,
       CASE WHEN survived = 0 THEN '사망'
            ELSE '생존'
       END survived,
       pclass,
       name,
       CASE WHEN gender = 'male' THEN '남성'
            ELSE '여성'
       END gender,
       age,
       sibsp,
       parch,
       ticket,
       fare,
       cabin,
       CASE embarked WHEN 'C' THEN '프랑스 셰르부르'
                     WHEN 'Q' THEN '아일랜드 퀸즈타운'
                     ELSE '영국 사우샘프턴'
       END embarked
  FROM titanic_data;

SELECT *
  FROM titanic;
  
-- (1) 성별 생존자 수와 사망자 수의 비율 조회하기    

-- (1-1) 성별 생존자 수와 사망자 수 조회
SELECT gender, survived, COUNT(*)
  FROM titanic
 GROUP BY gender, survived
 ORDER BY gender, survived ;
       
       
-- (1-2) 성별 생존자 수와 사망자 수의 비율 조회
SELECT gender, survived, cnt, 
       ROUND(cnt / SUM(cnt) OVER ( PARTITION BY gender 
                                   ORDER BY gender),2) rates
  FROM ( SELECT gender, survived, count(*) cnt
           FROM titanic
          GROUP BY gender, survived
       ) t ;


-- (2) 연령대별 생존자 수와 사망자 수 조회
SELECT CASE WHEN age BETWEEN  1 AND  9 THEN '1.10대이하' 
            WHEN age BETWEEN 10 AND 19 THEN '2.10대'
            WHEN age BETWEEN 20 AND 29 THEN '3.20대'
            WHEN age BETWEEN 30 AND 39 THEN '4.30대'
            WHEN age BETWEEN 40 AND 49 THEN '5.40대'
            WHEN age BETWEEN 50 AND 59 THEN '6.50대'
            WHEN age BETWEEN 60 AND 69 THEN '7.60대'
            ELSE '8.70대 이상'
       END ages,
       survived,
       COUNT(*) cnt
  FROM titanic
 GROUP BY 1, 2
 ORDER BY 1, 2;
        
       
-- 아래 쿼리를 통해서 null 값이 70대 이상에 포함된것과 0~1세 역시 70대 이상에 포함된것 확인
SELECT age, COUNT(*)
  FROM titanic
 GROUP BY age
 ORDER BY 1;
               
       
-- 다시 작성
SELECT CASE WHEN age BETWEEN  0 AND  9 THEN '1.10대이하' 
            WHEN age BETWEEN 10 AND 19 THEN '2.10대'
            WHEN age BETWEEN 20 AND 29 THEN '3.20대'
            WHEN age BETWEEN 30 AND 39 THEN '4.30대'
            WHEN age BETWEEN 40 AND 49 THEN '5.40대'
            WHEN age BETWEEN 50 AND 59 THEN '6.50대'
            WHEN age BETWEEN 60 AND 69 THEN '7.60대'
            WHEN age IS NULL           THEN '9.알수없음'
            ELSE '8.70대 이상'
       END ages,
       survived,
       COUNT(*) cnt
  FROM titanic
 GROUP BY 1, 2
 ORDER BY 1, 2;
       

-- (3) 연령대별, 객실 등급별 생존자 수와 사망자 수 조회
SELECT CASE WHEN age BETWEEN  0 AND  9 THEN '1.10대이하' 
            WHEN age BETWEEN 10 AND 19 THEN '2.10대'
            WHEN age BETWEEN 20 AND 29 THEN '3.20대'
            WHEN age BETWEEN 30 AND 39 THEN '4.30대'
            WHEN age BETWEEN 40 AND 49 THEN '5.40대'
            WHEN age BETWEEN 50 AND 59 THEN '6.50대'
            WHEN age BETWEEN 60 AND 69 THEN '7.60대'
            WHEN age IS NULL           THEN '9.알수없음'
            ELSE '8.70대 이상'
       END ages,
       pclass,
       survived,
       COUNT(*) cnt
  FROM titanic
 GROUP BY 1, 2, 3
 ORDER BY 1, 2, 3;
  
-- (추가 응용) 객실 등급을 컬럼 형태로 전화해 보기
WITH raw_data AS (
SELECT CASE WHEN age BETWEEN  0 AND  9 THEN '1.10대이하' 
            WHEN age BETWEEN 10 AND 19 THEN '2.10대'
            WHEN age BETWEEN 20 AND 29 THEN '3.20대'
            WHEN age BETWEEN 30 AND 39 THEN '4.30대'
            WHEN age BETWEEN 40 AND 49 THEN '5.40대'
            WHEN age BETWEEN 50 AND 59 THEN '6.50대'
            WHEN age BETWEEN 60 AND 69 THEN '7.60대'
            WHEN age IS NULL           THEN '9.알수없음'
            ELSE '8.70대 이상'
       END ages,
       pclass,
       survived,
       COUNT(*) cnt
  FROM titanic
 GROUP BY 1, 2, 3
)
SELECT ages, survived, 
       SUM(CASE WHEN pclass = 1 THEN cnt ELSE 0 END) first_class,
       SUM(CASE WHEN pclass = 2 THEN cnt ELSE 0 END) business_class,
       SUM(CASE WHEN pclass = 3 THEN cnt ELSE 0 END) economy_class
  FROM raw_data 
 GROUP BY 1, 2
 ORDER BY 1, 2;
       
       

-- (4) 가족 동반과 미동반 시 생존자 수와 사망자 수의 비율 조회
WITH raw_data AS (
SELECT CASE WHEN sibsp + parch > 0 THEN 'family'
            ELSE 'alone'
       END gubun,
       survived, 
       COUNT(*) cnt
  FROM titanic
 GROUP BY 1, 2
)
SELECT gubun, survived, cnt,
       cnt / SUM(cnt) OVER ( PARTITION BY gubun) gubun_rates,
       cnt / SUM(cnt) OVER ( ) total_rates
  FROM raw_data
 ORDER BY 1, 2;
       
 
 
-- (추가 문제) 탑승 항구별로 생존자 수와 사망자수를 구하는 쿼리를 작성하세요.

SELECT embarked, 
       survived,
       COUNT(*) cnt 
  FROM titanic
 GROUP BY 1, 2
 ORDER BY 1, 2;
 


 

 
-- (추가 문제) 타이타닉 탑승 항구별로 생존자 수와 사망자 수의 비율을 구하는 쿼리를 작성하세요.
SELECT embarked, 
       survived,
       COUNT(*) cnt,
       COUNT(*) / SUM(count(*)) OVER (PARTITION BY embarked)
  FROM titanic
 GROUP BY 1, 2
 ORDER BY 1, 2;
 

