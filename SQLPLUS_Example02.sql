SELECT * FROM BLAH_BLAH WHERE COLUMN like '%gmail%'; -- BLAH : 테이블 , COLUMN : 찾을거, 따움표->퍼센트 로 묶어주기

-- 첫번째 문제
-- member 테이블에서 gmail 을 사용하는 사람을 구하라.
SELECT LEN(PASSWORD)
FROM  MEMBER
WHERE MEMBER.EMAIL like '%gmail.com'

-- 두번째 문제
-- 이메일이 GMAIL 이면서 이메일의 길이가 12글자 이상인 데이터 뽑아라.
-- LENGTH(컬럼명) - 해당 컬럼의 길이가 나옵니다
-- 조건과 조건 사이를 잇는 AND OR 조건은 다음과 같이 컬럼1 = '어쩌구' AND 컬럼2 = '저쩌구
-- 와 같이 AND, OR 로 쓰입니다

SELECT LEN(PASSWORD)
FROM  MEMBER
WHERE MEMBER.EMAIL like '%gmail.com' AND LENGTH(MEMBER.EMAIL) >= 12;


--세번째 문제
-- 이메일이 gmail 이면서 이메일의 길이가 12글자 이상이거나,
-- 이메일이 naver.com 을 사용하면서 길이가 10글자 이상인 조건에 해당하는 멤버를 찾으시오
select * from MEMBER where (EMAIL like '%gmail.com' AND LENGTH (MEMBER.EMAIL) >= 12) 
OR
 (EMAIL like '%naver.com%' AND LENGTH (MEMBER.EMAIL) >= 10); 

 -- 네번째 문제
 -- PAYMENT_HISTORY 테이블을 이용함
 -- 결제금액이 1,000,000 이상이면서 구매 개수(stock)이 10개 이하인 주문이거나,
 -- 결제 금액이 100,000 이하면서 구매 개수가 10개 이상인 주문을 찾아주세요.
 -- 주문지(address)가 (서울, 서울특별시, 서울시) 셋중 하나인 경우를 모두 찾아주세요.

 select * from PAYMENT_HISTORY where (PAYMENT_HISTORY.ORDER_PRICE >= 1000000 AND ORDER_COUNT <= 10) 
 or
 (PAYMENT_HISTORY.ORDER_PRICE <= 100000 AND ORDER_COUNT >= 10);
 

-- 조건문에 IN 절을 사용 가능합니다
-- IN 절은 뒤에 따라오는 문자열 여러개 중 하나라도 들어있으면 TRUE 를 반환합니다
-- 예) 컬럼명 IN ('A', 'B', 'C') -> TRUE

-- 다섯번째 문제
-- PAYMENT_HISTORY 테이블을 이용함
-- 결제 금액(order_price)이 1,000,000 이상이면서 구매 개수(order_count)가 10개 이하인 주문이거나,
-- 결제 금액이 100,000 이하면서 구매 개수가 10개 이상인 주문이면서
-- 주문지(address)가 (서울, 서울특별시, 서울시) 셋중 하나인 경우를 모두 찾아주세요

select * from PAYMENT_HISTORY
where 
(PAYMENT_HISTORY.ORDER_PRICE >= 1000000 AND ORDER_COUNT <= 10) 
OR (PAYMENT_HISTORY.ORDER_PRICE <= 100000 AND ORDER_COUNT >= 10) 
OR (PAYMENT_HISTORY.ADDRESS like '%서울특별시%', '%서울시%', '%서울%');

-- SELECET A.NUMBER AS SUMMARY_NUMBER, B.NUMBER AS AVERAGE_NUMBER, C.NUMBER FROM A, B, C
-- 컬럼명. 뒤, 혹은 함수 뒤에 "AS 불리게될 컬럼명" 을 적어주시면 불리게될 컬럼명으로 출력됩니다.

-- 미니 문제 #1
-- 아래 쿼리에서 컬럼명이 COUNT(1) 으로 나오게 되는데
-- COUNT(1) 이 아닌 TABLE_ROW_COUNT 로 나오게 해주세요

SELECT COUNT(1) AS TABLE_ROW_COUNT FROM MEMBER;

-- BETWEEN 문법은 x 부터 Y 까지 사이에 있는 데이터를 뽑기에 적합합니다
-- 예) PRICE BETWEEN 10000 AND 100000;

-- 문제 6. 
-- PAYMENT_HISTORY 테이블에서 판매액(ORDER_PRICE) 가 100000 이상, 
-- 10000000 이하 인 값을 찾아주세요

select * from PAYMENT_HISTORY
where 
ORDER_PRICE BETWEEN 100000 AND 10000000; 

-- EXIST <- 존재 하는지를 확인할수 있다
-- 예) 컬럼명 IS NULL

-- 문제 7.
-- PRODUCT 테이블에서 ORIGIN(원산지)이 없는 데이터를 찾아주세요

-- 문제 8.
-- MEMBER 테이블을 사용합니다
-- GMAIL 이메일 주소를 사용하면서 "서울시" 안에 살고 있으며, PASSWORD 의 길이가 10자리 이상이거나
-- NAVER 이메일 주소를 사용하면서 폰번호 안에 1 이 들어가있는 사람을 찾아 주세요
-- 다만 나이는 19살 이상이어야 합니다

select * from MEMBER
where 
((EMAIL like '%gmail.com%' AND ADDRESS like '%서울시%' AND LENGTH(PASSWORD) >= 10) 
OR (EMAIL like '%naver.com%' AND LENGTH(PHONE) like '%1%'))
AND (LENGTH(AGE) <= 100);

-- DISTINCT 문은 중복을 제거할수 있습니다
-- 예를들어 address 가 ('서울시', '서울시', '은평구') 와 같이 3row 가 있다고 가정한다면
-- 다음과 같이 사용하면 중복을 제거할수 있습니다, 따라서 값은 ('서울시', '은평구')
-- SELECT DISTINCT COLUMN FROM TABLE;

-- 문제 9. 
-- MEMBER 테이블을 이용합니다
-- 회원들이 살고있는 주소만 중복없이 찾아주세요
-- SELECT ADDRESS 만 하세요

select DISTINCT ADDRESS FROM MEMBER
select DISTINCT ADDRESS FROM PAYMENT_HISTORY

-- ORDER BY 문은 뽑아온 데이터를 정렬할때 사용합니다
-- DESC 는 내림차순을 의미하며, ASC 는 오름차순을 의미합니다
-- 사용 법은 SELECT 문 제일 뒤에(WHERE) 사용합니다
-- SELECT * FROM TABLE ORDER BY ID DESC

SELECT * FROM PRODUCT WHERE STOCK >= 10 ORDER BY DESC

SELECT * FROM MEMBER ORDER BY id DESC

-- 문제 10.
-- MEMBER 테이블과 PAYMENT_HISTORY 테이블을 조인하여 데이터를 표시하시오.
-- 구매자명, 구매 금액, 구매 일자만 나오게끔 작성해 주세요.

SELECT MEMBER.NAME AS 구매자명, 
PAYMENT_HISTORY.ORDER_PRICE AS 구매 금액,
PAYMENT_HISTORY.ORDER_DATE AS 구매일자
FROM
    MEMBER, PAYMENT_HISTORY
WHERE   
    MEMBER.ID = PAYMENT_HISTORY.MEMBER_ID

-- 문제 11.
-- MEMBER 테이블과 PAYMENT_HISTORY 테이블을 조인하여 데이터를 표시하시요
-- 구매자명, 구매 금액, 구매 일자만 나오게끔 작성해 주세요
-- 구매 금액이 1,000,000 이상인 값만 나오게끔 작성해 주세요
-- 구매금액 높은 순으로 정렬하여 주세요

SELECT MEMBER.NAME AS 구매자명, 
PAYMENT_HISTORY.ORDER_PRICE AS 구매금액,
PAYMENT_HISTORY.ORDER_DATE AS 구매일자
FROM
    MEMBER, PAYMENT_HISTORY
WHERE   
    MEMBER.ID = PAYMENT_HISTORY.MEMBER_ID AND 
    PAYMENT_HISTORY.ORDER_PRICE >= 1000000
ORDER BY
    PAYMENT_HISTORY.ORDER_PRICE DESC;

-- 문제12 
-- PAYMENT_HISTORY, PRODUCT, CATEGORY 를 전부 가져오게끔 한다.
-- 구매 금액, 카테고리, 상품명을 출력해야 한다.

SELECT 
    PAYMENT_HISTORY.ORDER_PRICE AS 구매금액,
    PAYMENT_HISTORY.ORDER_COUNT AS 구매개수,
    CATEGORY.NAME AS 카테고리명,
    PRODUCT.NAME AS 상품명
FROM 
    PAYMENT_HISTORY, CATEGORY, PRODUCT
WHERE
    PAYMENT_HISTORY.PRODUCT_ID = PRODUCT.ID AND
    PRODUCT.CATEGORY_ID = CATEGORY.ID

    -- 문제 13.
-- PAYMENT_HISTORY, PRODUCT, CATEGORY, MEMBER 를 전부 가져오게끔 합니다
-- 구매 금액, 구매 개수, 카테고리, 상품명, 구매자명을 출력해야 합니다

select PAYMENT_HISTORY.ORDER_PRICE AS 구매금액,
       PAYMENT_HISTORY.ORDER_COUNT AS 구매개수,
       CATEGORY.NAME AS 카테고리명,
       PRODUCT.NAME AS 상품명,
       MEMBER.NAME AS 구매자명
FROM
    PAYMENT_HISTORY, CATEGORY, PRODUCT, MEMBER
WHERE 
    PAYMENT_HISTORY.PRODUCT_ID = PRODUCT.ID AND
    PRODUCT.CATEGORY_ID = CATEGORY.ID AND
    MEMBER.ID = PAYMENT_HISTORY.MEMBER_ID;

-- COUNT, SUM, AVG, MIN, MAX 
-- 개수 ,  합, 평균, 최대, 최소
-- 예) SELECT SUM(PRICE) FROM PRODUCT;

-- 문제 14.
-- 모든 상품의 개수, 합, 평균, 최대, 최소값을 동시에 뽑아주세요.

SELECT 
COUNT(PRICE) AS 개수,
SUM(PRICE) AS 가격의_합,
AVG(PRICE) AS 가격의_평균,
MIN(PRICE) AS 가격의_최소, 
MAX(PRICE) AS 가격의_최대 
FROM PRODUCT 
GROUP BY 
    CATEGORY_ID;

-- 문제 15.
-- 모든 상품의 개수, 가격의 합, 가격의 평균, 가격의 최대, 가격의 최소값을 동시에 뽑아주세요
-- 다만, 그룹핑 하기 전의 상품의 가격이 1,000,000 넘는 상품은 제외해주세요

select 
COUNT(PRICE) AS 개수,
SUM(PRICE) AS 가격의_합,
AVG(PRICE) AS 가격의_평균,
MIN(PRICE) AS 가격의_최소, 
MAX(PRICE) AS 가격의_최대 
FROM PRODUCT 
WHERE 
PRICE <= 1000000 
GROUP BY 
    CATEGORY_ID;