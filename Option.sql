SELECT * FROM TB_DEPARTMENT;
SELECT * FROM TB_STUDENT;
SELECT * FROM TB_CLASS;
SELECT * FROM TB_CLASS_PROFESSOR;
SELECT * FROM TB_PROFESSOR;
SELECT * FROM TB_GRADE;

-- 1. 학생 이름과 주소지를 표시하시오.
--    단, 출력 헤더는 "학생 이름", "주소지"로 하고,
--    정렬은 이름으로 오름차순 표시하도록 한다.

SELECT STUDENT_NAME "학생 이름", STUDENT_ADDRESS "주소지"
FROM TB_STUDENT
ORDER BY STUDENT_NAME;

-- 2. 휴학 중인 학생들의 이름과 주민번호를 나이가 적은 순서로 화면에 출력하시오.

SELECT STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY SUBSTR(STUDENT_SSN, 1, 5) DESC; -- 그냥 ORDER BY STUDENT_SSN DESC; 해도 된다


-- 3. 주소지가 강원도나 경기도인 학생들 중 1900년대 학번을 가진 학생들의 이름과 학번,
--    주소를 이름의 오름차순으로 화면에 출력하시오
--    단, 출력헤더에는 "학생이름", "학번", "거주지 주소"가 출력되도록 한다.

SELECT STUDENT_NAME 학생이름, STUDENT_NO 학번, STUDENT_ADDRESS "거주지 주소"
FROM TB_STUDENT
WHERE (STUDENT_ADDRESS LIKE '강원도%' OR STUDENT_ADDRESS LIKE '경기도%')
AND STUDENT_NO LIKE '9%' 
ORDER BY STUDENT_NAME;

-- 4. 현재 법학과 교수 중 가장 나이가 많은 사람부터 이름을 확인할 수 있는 SQL 문장을 작성하시오.
--    (법학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 조회해서 찾아내도록 하자)

SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '법학과'
ORDER BY PROFESSOR_SSN;

-- 5. 2004년 2학기에 'C3118100'과목을 수강한 학생들의 학점을 조회하려고 한다.
--    학점이 높은 학생부터 표시하고, 학점이 같으면 학번이 낮은 학생부터 표시하는 구문을 작성해보시오

SELECT STUDENT_NO, POINT
FROM TB_GRADE
WHERE CLASS_NO = 'C3118100'
AND TERM_NO = '200402' 
ORDER BY POINT DESC, STUDENT_NO; -- 학번 낮은 학생부터 표시

-- 6. 학생 번호, 학생 이름, 학과 이름을 학생 이름으로 오름차순 정렬하여 출력하는 SQL 문을 작성하시오.

SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
ORDER BY STUDENT_NAME;

-- 7. 춘 기술대학교의 과목 이름과 과목의 학과 이름을 출력하는 SQL 문장을 작성하시오.

SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS JOIN TB_DEPARTMENT USING(DEPARTMENT_NO);

-- 8. 과목별 교수 이름을 찾으려고 한다. 과목 이름과 교수 이름을 출력하는 SQL문을 작성하시오.

SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_PROFESSOR USING(PROFESSOR_NO);

-- TB_CLASS와  TB_PROFESSOR 테이블이 공통으로
-- DEPARTMENT_NO 컬럼을 가지고 있다 해서 이를 이용해서 JOIN을 하면 안됨!

/* 
	TB_CLASS와  TB_PROFESSOR 테이블을 조회 해보면
	같은 컬럼 값을 가지는 DEPARTMENT_NO가 많이 존재함
	
	--> 이럴 경우 
  	TB_CLASS의  DEPARTMENT_NO 와
  	TB_PROFESSOR의 DEPARTMENT_NO 컬럼 값들이
 	서로 연결되기 위한 모든 경우의 수를 만들어냄 (곱집합이 되어버림)
*/


-- 9. 8번의 결과 중 '인문사회' 계열에 속한 과목의 교수 이름을 찾으려고 한다.
--    이에 해당하는 과목 이름과 교수 이름을 출력하는 SQL 문을 작성하시오. *

SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_PROFESSOR P USING(PROFESSOR_NO)
JOIN TB_DEPARTMENT D ON(P.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE CATEGORY = '인문사회';

-- 10. '음악학과' 학생들의 평점을 구하려고 한다.
--      음악학과 학생들의 "학번", "학생 이름", "전체 평점"을 출력하는 SQL 문장을 작성하시오.
--      (단, 평점은 소수점 1자리까지만 반올림하여 표시한다.) ***

--SELECT STUDENT_NO 학번, STUDENT_NAME "학생 이름", AVG(POINT) "전체 평점"
--FROM TB_STUDENT S JOIN TB_GRADE G ON(S.STUDENT_NO = G.STUDENT_NO)
--WHERE DEPARTMENT_NAME = '음악학과'; 

-- 11. 학번이 A313047인 학생이 학교에 나오고 있지 않다. 지도 교수에게 내용을 전달하기 위한
--     학과 이름, 학생 이름과 지도 교수 이름이 필요하다. 이때 사용할 SQL 문을 작성하시오.
--     (단, 출력헤더는 "학과이름", "학생이름", "지도교수이름"으로 출력되도록 한다.) ***



-- 12. 2007년도에 '인간관계론' 과목을 수강한 학생을 찾아
--     학생이름과 수강학기를 표시하는 SQL 문장을 작성하시오

SELECT STUDENT_NAME, TERM_NO TERM_NAME
FROM TB_STUDENT JOIN TB_GRADE USING(STUDENT_NO);

-- 13. 예체능 계열 과목 중 과목 담당교수를 한 명도 배정받지 못한 과목을 찾아
--     그 과목 이름과 학과 이름을 출력하는 SQL문장을 작성하시오.

-- 14. 춘 기술대학교 서반아어학과 학생들의 지도교수를 게시하고자 한다.
--     학생이름과 지도교수 이름을 찾고 만일 지도 교수가 없는 학생일 경우
--     "지도교수 미지정"으로 표시하도록 하는 SQL 문을 작성하시오.
--     단, 출력헤더는 "학생이름", "지도교수"로 표시하며 고학번 학생이 먼저 표시되도록 한다.

-- 15. 휴학생이 아닌 학생 중 평점이 4.0 이상인 학생을 찾아
--     그 학생의 학번, 이름, 학과, 이름, 평점을 출력하는 SQL문을 작성하시오.

-- 16. 환경조경학과 전공과목들의 과목 별 평점을 파악할 수 있는 SQL문을 작성하시오

-- 17. 춘 기술대학교에 다니고 있는 최경희 학생과 같은 과 학생들의 이름과 주소를 출력하는 SQL문을 작성하시오

-- 18. 국어국문학과에서 총 평점이 가장 높은 학생의 이름과 학번을 표시하는 SQL문을 작성하시오

-- 19. 춘 기술대학교의 "환경조경학과"가 속한 같은 계열 학과들의 학과 별 전공과목 평점을
--     파악하기 위한 적절한 SQL문을 찾아내시오. 단, 출력헤더는 "계열 학과명", "전공평점"으로
--     표시되도록 하고, 평점은 소수점 한 자리까지만 반올림하여 표시되도록 한다.