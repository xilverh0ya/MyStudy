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

       
-- (1-2) 성별 생존자 수와 사망자 수의 비율 조회



-- (2) 연령대별 생존자 수와 사망자 수 조회

        
       


-- (3) 연령대별, 객실 등급별 생존자 수와 사망자 수 조회

  
-- (추가 응용) 객실 등급을 컬럼 형태로 전환해 보기

       
       

-- (4) 가족 동반과 미동반 시 생존자 수와 사망자 수의 비율 조회
       
 
 
-- (추가 문제) 탑승 항구별로 생존자 수와 사망자수를 구하는 쿼리를 작성하세요.

 


 

 
-- (추가 문제) 타이타닉 탑승 항구별로 생존자 수와 사망자 수의 비율을 구하는 쿼리를 작성하세요.

 

