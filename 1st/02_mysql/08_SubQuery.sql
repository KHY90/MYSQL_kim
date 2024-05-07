/* 서브쿼리 */

select 
	category_code
  from tbl_menu
 where menu_name = '민트미역국';
 
 
select 
	menu_code ,
	menu_name ,
	menu_price ,
	category_code ,
	orderable_status
  from tbl_menu
 where category_code in 
 	(select
 		category_code 
 	   from tbl_menu);
 	  where menu_name = '홍어마카롱');
 	

-- from절에 쓰인 써브쿼리 (테이블에 별칭을 꼭 주어야한다.)
select 
	max(count)
--	*
  from (
  	select
  		count(*) as 'count'
  	  from tbl_menu
  	 group by category_code
  ) as countmenu;

 -- 카테고리별 평균 가격보다 높은 가격의 메뉴 조회
 select 
 	menu_code,
 	menu_name,
 	menu_price ,
 	category_code ,
 	orderable_status 
   from tbl_menu a
  where menu_price > (select
  						 avg(menu_price)
  					    from tbl_menu tm
  					   where category_code  =a.category_code);
 
 
/* EXISTS */
 -- 조회 겨로가가 있을 때 true 아니면 false
select 
	category_name
  from tbl_category a
 where exists (
 	select
 		1
 	  from tbl_menu b
 	 where b.category_code = a.category_code
 	);

 
/* SET OPERATORS */
 
/* UNION */
SELECT 
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
FROM
    tbl_menu
WHERE
    category_code = 10
UNION
SELECT 
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
FROM
    tbl_menu
WHERE
    menu_price < 9000;

/* UNION ALL */
SELECT 
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
FROM
    tbl_menu
WHERE
    category_code = 10
UNION ALL
SELECT 
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
FROM
    tbl_menu
WHERE
    menu_price < 9000;
 
/* INTERSECT */
-- MySQL은 INTERSECT를 제공하지 않는다. 하지만 INNER JOIN 또는 IN을 활용해서 구현하는 것은 가능하다.

-- 1) INNER JOIN 활용
SELECT 
    a.menu_code,
    a.menu_name,
    a.menu_price,
    a.category_code,
    a.orderable_status
FROM
    tbl_menu a
INNER JOIN (SELECT 
      menu_code,
      menu_name,
      menu_price,
      category_code,
      orderable_status
   FROM
      tbl_menu 
   WHERE
      menu_price < 9000) b on (a.menu_code = b.menu_code)
WHERE
    a.category_code = 10;
    
-- 2) IN 연산자 활용
SELECT 
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
FROM
    tbl_menu
WHERE
    category_code = 10 AND
    menu_code IN (SELECT 
      menu_code
   FROM
      tbl_menu 
   WHERE
      menu_price < 9000);

/* MINUS */
-- MySQL은 MINUS를 제공하지 않는다. 하지만 LEFT JOIN을 활용해서 구현하는 것은 가능하다.
SELECT 
    a.menu_code,
    a.menu_name,
    a.menu_price,
    a.category_code,
    a.orderable_status
FROM
    tbl_menu a
LEFT JOIN (SELECT 
      menu_code,
      menu_name,
      menu_price,
      category_code,
      orderable_status
   FROM
      tbl_menu 
   WHERE
      menu_price < 9000) b on (a.menu_code = b.menu_code)
WHERE
    a.category_code = 10 AND
    b.menu_code IS NULL;

