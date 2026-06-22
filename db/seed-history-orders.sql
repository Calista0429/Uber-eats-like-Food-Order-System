-- Historical COMPLETED orders (past 30 days) for statistics charts
-- Idempotent: guarded by orders.number (prefix HIST). Appends only.
SET NAMES utf8mb4;

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260621150900001',5,4,2,'2026-06-21 15:09:00','2026-06-21 15:09:00',1,1,29.77,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-21 16:09:00','2026-06-21 16:09:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260621150900001');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Broccoli & Stilton soup','https://www.themealdb.com/images/media/meals/tvvxpv1511191952.jpg',(SELECT id FROM orders WHERE number='HIST20260621150900001' LIMIT 1),75,1,7.39 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260621150900001' AND od.name='Broccoli & Stilton soup');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Clam chowder','https://www.themealdb.com/images/media/meals/rvtvuw1511190488.jpg',(SELECT id FROM orders WHERE number='HIST20260621150900001' LIMIT 1),76,1,8.39 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260621150900001' AND od.name='Clam chowder');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Arroz con gambas y calamar','https://www.themealdb.com/images/media/meals/jc6oub1763196663.jpg',(SELECT id FROM orders WHERE number='HIST20260621150900001' LIMIT 1),91,1,13.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260621150900001' AND od.name='Arroz con gambas y calamar');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260621112300002',5,4,2,'2026-06-21 11:23:00','2026-06-21 11:23:00',1,1,33.08,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-21 12:23:00','2026-06-21 12:23:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260621112300002');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Beef and Broccoli Stir-Fry','https://www.themealdb.com/images/media/meals/m0p0j81765568742.jpg',(SELECT id FROM orders WHERE number='HIST20260621112300002' LIMIT 1),90,1,18.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260621112300002' AND od.name='Beef and Broccoli Stir-Fry');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Brown Stew Chicken','https://www.themealdb.com/images/media/meals/sypxpx1515365095.jpg',(SELECT id FROM orders WHERE number='HIST20260621112300002' LIMIT 1),80,1,14.09 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260621112300002' AND od.name='Brown Stew Chicken');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260620100500003',5,4,2,'2026-06-20 10:05:00','2026-06-20 10:05:00',1,1,43.77,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-20 11:05:00','2026-06-20 11:05:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260620100500003');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Arepa pelua','https://www.themealdb.com/images/media/meals/jgl9qq1764437635.jpg',(SELECT id FROM orders WHERE number='HIST20260620100500003' LIMIT 1),87,1,19.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260620100500003' AND od.name='Arepa pelua');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Clam chowder','https://www.themealdb.com/images/media/meals/rvtvuw1511190488.jpg',(SELECT id FROM orders WHERE number='HIST20260620100500003' LIMIT 1),76,1,8.39 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260620100500003' AND od.name='Clam chowder');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Chick-Fil-A Sandwich','https://www.themealdb.com/images/media/meals/sbx7n71587673021.jpg',(SELECT id FROM orders WHERE number='HIST20260620100500003' LIMIT 1),81,1,15.59 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260620100500003' AND od.name='Chick-Fil-A Sandwich');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260620113500004',5,4,2,'2026-06-20 11:35:00','2026-06-20 11:35:00',1,1,30.97,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-20 12:35:00','2026-06-20 12:35:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260620113500004');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Broccoli & Stilton soup','https://www.themealdb.com/images/media/meals/tvvxpv1511191952.jpg',(SELECT id FROM orders WHERE number='HIST20260620113500004' LIMIT 1),75,1,7.39 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260620113500004' AND od.name='Broccoli & Stilton soup');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Balchi di Pisca','https://www.themealdb.com/images/media/meals/qqwhw51780093126.jpg',(SELECT id FROM orders WHERE number='HIST20260620113500004' LIMIT 1),92,1,16.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260620113500004' AND od.name='Balchi di Pisca');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Cream Cheese Tart','https://www.themealdb.com/images/media/meals/wurrux1468416624.jpg',(SELECT id FROM orders WHERE number='HIST20260620113500004' LIMIT 1),77,1,6.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260620113500004' AND od.name='Cream Cheese Tart');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260619134000005',5,4,2,'2026-06-19 13:40:00','2026-06-19 13:40:00',1,1,35.58,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-19 14:40:00','2026-06-19 14:40:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260619134000005');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Balchi di Pisca','https://www.themealdb.com/images/media/meals/qqwhw51780093126.jpg',(SELECT id FROM orders WHERE number='HIST20260619134000005' LIMIT 1),92,1,16.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260619134000005' AND od.name='Balchi di Pisca');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Bang bang prawn salad','https://www.themealdb.com/images/media/meals/4xcfai1763765676.jpg',(SELECT id FROM orders WHERE number='HIST20260619134000005' LIMIT 1),93,1,18.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260619134000005' AND od.name='Bang bang prawn salad');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260619160300006',5,4,2,'2026-06-19 16:03:00','2026-06-19 16:03:00',1,1,21.38,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-19 17:03:00','2026-06-19 17:03:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260619160300006');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Broccoli & Stilton soup','https://www.themealdb.com/images/media/meals/tvvxpv1511191952.jpg',(SELECT id FROM orders WHERE number='HIST20260619160300006' LIMIT 1),75,1,7.39 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260619160300006' AND od.name='Broccoli & Stilton soup');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Arroz con gambas y calamar','https://www.themealdb.com/images/media/meals/jc6oub1763196663.jpg',(SELECT id FROM orders WHERE number='HIST20260619160300006' LIMIT 1),91,1,13.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260619160300006' AND od.name='Arroz con gambas y calamar');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260618121800007',5,4,2,'2026-06-18 12:18:00','2026-06-18 12:18:00',1,1,29.97,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-18 13:18:00','2026-06-18 13:18:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260618121800007');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Creamy Tomato Soup','https://www.themealdb.com/images/media/meals/stpuws1511191310.jpg',(SELECT id FROM orders WHERE number='HIST20260618121800007' LIMIT 1),78,1,9.19 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260618121800007' AND od.name='Creamy Tomato Soup');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Arroz con gambas y calamar','https://www.themealdb.com/images/media/meals/jc6oub1763196663.jpg',(SELECT id FROM orders WHERE number='HIST20260618121800007' LIMIT 1),91,1,13.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260618121800007' AND od.name='Arroz con gambas y calamar');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Cream Cheese Tart','https://www.themealdb.com/images/media/meals/wurrux1468416624.jpg',(SELECT id FROM orders WHERE number='HIST20260618121800007' LIMIT 1),77,1,6.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260618121800007' AND od.name='Cream Cheese Tart');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260618191900008',5,4,2,'2026-06-18 19:19:00','2026-06-18 19:19:00',1,1,23.58,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-18 20:19:00','2026-06-18 20:19:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260618191900008');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Cream Cheese Tart','https://www.themealdb.com/images/media/meals/wurrux1468416624.jpg',(SELECT id FROM orders WHERE number='HIST20260618191900008' LIMIT 1),77,1,6.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260618191900008' AND od.name='Cream Cheese Tart');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Balchi di Pisca','https://www.themealdb.com/images/media/meals/qqwhw51780093126.jpg',(SELECT id FROM orders WHERE number='HIST20260618191900008' LIMIT 1),92,1,16.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260618191900008' AND od.name='Balchi di Pisca');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260617194000009',5,4,2,'2026-06-17 19:40:00','2026-06-17 19:40:00',1,1,21.78,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-17 20:40:00','2026-06-17 20:40:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260617194000009');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Algerian Kefta (Meatballs)','https://www.themealdb.com/images/media/meals/8rfd4q1764112993.jpg',(SELECT id FROM orders WHERE number='HIST20260617194000009' LIMIT 1),85,1,14.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260617194000009' AND od.name='Algerian Kefta (Meatballs)');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Cream Cheese Tart','https://www.themealdb.com/images/media/meals/wurrux1468416624.jpg',(SELECT id FROM orders WHERE number='HIST20260617194000009' LIMIT 1),77,1,6.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260617194000009' AND od.name='Cream Cheese Tart');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260617184500010',5,4,2,'2026-06-17 18:45:00','2026-06-17 18:45:00',1,1,24.18,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-17 19:45:00','2026-06-17 19:45:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260617184500010');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Balchi di Pisca','https://www.themealdb.com/images/media/meals/qqwhw51780093126.jpg',(SELECT id FROM orders WHERE number='HIST20260617184500010' LIMIT 1),92,1,16.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260617184500010' AND od.name='Balchi di Pisca');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Broccoli & Stilton soup','https://www.themealdb.com/images/media/meals/tvvxpv1511191952.jpg',(SELECT id FROM orders WHERE number='HIST20260617184500010' LIMIT 1),75,1,7.39 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260617184500010' AND od.name='Broccoli & Stilton soup');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260616191300011',5,4,2,'2026-06-16 19:13:00','2026-06-16 19:13:00',1,1,48.77,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-16 20:13:00','2026-06-16 20:13:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260616191300011');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Arroz con gambas y calamar','https://www.themealdb.com/images/media/meals/jc6oub1763196663.jpg',(SELECT id FROM orders WHERE number='HIST20260616191300011' LIMIT 1),91,1,13.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260616191300011' AND od.name='Arroz con gambas y calamar');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Arepa pelua','https://www.themealdb.com/images/media/meals/jgl9qq1764437635.jpg',(SELECT id FROM orders WHERE number='HIST20260616191300011' LIMIT 1),87,1,19.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260616191300011' AND od.name='Arepa pelua');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Chicken Alfredo Primavera','https://www.themealdb.com/images/media/meals/syqypv1486981727.jpg',(SELECT id FROM orders WHERE number='HIST20260616191300011' LIMIT 1),84,1,14.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260616191300011' AND od.name='Chicken Alfredo Primavera');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260616173700012',5,4,2,'2026-06-16 17:37:00','2026-06-16 17:37:00',1,1,47.37,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-16 18:37:00','2026-06-16 18:37:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260616173700012');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Algerian Kefta (Meatballs)','https://www.themealdb.com/images/media/meals/8rfd4q1764112993.jpg',(SELECT id FROM orders WHERE number='HIST20260616173700012' LIMIT 1),85,1,14.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260616173700012' AND od.name='Algerian Kefta (Meatballs)');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Chicken & mushroom Hotpot','https://www.themealdb.com/images/media/meals/uuuspp1511297945.jpg',(SELECT id FROM orders WHERE number='HIST20260616173700012' LIMIT 1),83,1,16.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260616173700012' AND od.name='Chicken & mushroom Hotpot');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Chick-Fil-A Sandwich','https://www.themealdb.com/images/media/meals/sbx7n71587673021.jpg',(SELECT id FROM orders WHERE number='HIST20260616173700012' LIMIT 1),81,1,15.59 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260616173700012' AND od.name='Chick-Fil-A Sandwich');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260615124400013',5,4,2,'2026-06-15 12:44:00','2026-06-15 12:44:00',1,1,25.18,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-15 13:44:00','2026-06-15 13:44:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260615124400013');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Clam chowder','https://www.themealdb.com/images/media/meals/rvtvuw1511190488.jpg',(SELECT id FROM orders WHERE number='HIST20260615124400013' LIMIT 1),76,1,8.39 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260615124400013' AND od.name='Clam chowder');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Balchi di Pisca','https://www.themealdb.com/images/media/meals/qqwhw51780093126.jpg',(SELECT id FROM orders WHERE number='HIST20260615124400013' LIMIT 1),92,1,16.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260615124400013' AND od.name='Balchi di Pisca');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260615143300014',5,4,2,'2026-06-15 14:33:00','2026-06-15 14:33:00',1,1,48.37,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-15 15:33:00','2026-06-15 15:33:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260615143300014');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Chicken Alfredo Primavera','https://www.themealdb.com/images/media/meals/syqypv1486981727.jpg',(SELECT id FROM orders WHERE number='HIST20260615143300014' LIMIT 1),84,1,14.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260615143300014' AND od.name='Chicken Alfredo Primavera');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Asado','https://www.themealdb.com/images/media/meals/kgfh3q1763075438.jpg',(SELECT id FROM orders WHERE number='HIST20260615143300014' LIMIT 1),88,1,16.59 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260615143300014' AND od.name='Asado');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Chicken & mushroom Hotpot','https://www.themealdb.com/images/media/meals/uuuspp1511297945.jpg',(SELECT id FROM orders WHERE number='HIST20260615143300014' LIMIT 1),83,1,16.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260615143300014' AND od.name='Chicken & mushroom Hotpot');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260614190400015',5,4,2,'2026-06-14 19:04:00','2026-06-14 19:04:00',1,1,38.78,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-14 20:04:00','2026-06-14 20:04:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260614190400015');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Beef and Broccoli Stir-Fry','https://www.themealdb.com/images/media/meals/m0p0j81765568742.jpg',(SELECT id FROM orders WHERE number='HIST20260614190400015' LIMIT 1),90,1,18.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260614190400015' AND od.name='Beef and Broccoli Stir-Fry');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Arepa pelua','https://www.themealdb.com/images/media/meals/jgl9qq1764437635.jpg',(SELECT id FROM orders WHERE number='HIST20260614190400015' LIMIT 1),87,1,19.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260614190400015' AND od.name='Arepa pelua');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260614124800016',5,4,2,'2026-06-14 12:48:00','2026-06-14 12:48:00',1,1,50.37,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-14 13:48:00','2026-06-14 13:48:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260614124800016');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Creamy Tomato Soup','https://www.themealdb.com/images/media/meals/stpuws1511191310.jpg',(SELECT id FROM orders WHERE number='HIST20260614124800016' LIMIT 1),78,1,9.19 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260614124800016' AND od.name='Creamy Tomato Soup');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Aussie Burgers','https://www.themealdb.com/images/media/meals/44bzep1761848278.jpg',(SELECT id FROM orders WHERE number='HIST20260614124800016' LIMIT 1),89,1,21.39 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260614124800016' AND od.name='Aussie Burgers');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Arepa pelua','https://www.themealdb.com/images/media/meals/jgl9qq1764437635.jpg',(SELECT id FROM orders WHERE number='HIST20260614124800016' LIMIT 1),87,1,19.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260614124800016' AND od.name='Arepa pelua');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260613104200017',5,4,2,'2026-06-13 10:42:00','2026-06-13 10:42:00',1,1,30.78,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-13 11:42:00','2026-06-13 11:42:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260613104200017');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Arroz con gambas y calamar','https://www.themealdb.com/images/media/meals/jc6oub1763196663.jpg',(SELECT id FROM orders WHERE number='HIST20260613104200017' LIMIT 1),91,1,13.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260613104200017' AND od.name='Arroz con gambas y calamar');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Balchi di Pisca','https://www.themealdb.com/images/media/meals/qqwhw51780093126.jpg',(SELECT id FROM orders WHERE number='HIST20260613104200017' LIMIT 1),92,1,16.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260613104200017' AND od.name='Balchi di Pisca');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260613152100018',5,4,2,'2026-06-13 15:21:00','2026-06-13 15:21:00',1,1,56.77,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-13 16:21:00','2026-06-13 16:21:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260613152100018');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Bang bang prawn salad','https://www.themealdb.com/images/media/meals/4xcfai1763765676.jpg',(SELECT id FROM orders WHERE number='HIST20260613152100018' LIMIT 1),93,1,18.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260613152100018' AND od.name='Bang bang prawn salad');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Aussie Burgers','https://www.themealdb.com/images/media/meals/44bzep1761848278.jpg',(SELECT id FROM orders WHERE number='HIST20260613152100018' LIMIT 1),89,1,21.39 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260613152100018' AND od.name='Aussie Burgers');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Asado','https://www.themealdb.com/images/media/meals/kgfh3q1763075438.jpg',(SELECT id FROM orders WHERE number='HIST20260613152100018' LIMIT 1),88,1,16.59 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260613152100018' AND od.name='Asado');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260612115300019',5,4,2,'2026-06-12 11:53:00','2026-06-12 11:53:00',1,1,34.58,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-12 12:53:00','2026-06-12 12:53:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260612115300019');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Chicken & chorizo rice pot','https://www.themealdb.com/images/media/meals/fk80jp1763280767.jpg',(SELECT id FROM orders WHERE number='HIST20260612115300019' LIMIT 1),82,1,13.19 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260612115300019' AND od.name='Chicken & chorizo rice pot');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Aussie Burgers','https://www.themealdb.com/images/media/meals/44bzep1761848278.jpg',(SELECT id FROM orders WHERE number='HIST20260612115300019' LIMIT 1),89,1,21.39 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260612115300019' AND od.name='Aussie Burgers');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260612200400020',5,4,2,'2026-06-12 20:04:00','2026-06-12 20:04:00',1,1,33.58,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-12 21:04:00','2026-06-12 21:04:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260612200400020');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Chicken & mushroom Hotpot','https://www.themealdb.com/images/media/meals/uuuspp1511297945.jpg',(SELECT id FROM orders WHERE number='HIST20260612200400020' LIMIT 1),83,1,16.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260612200400020' AND od.name='Chicken & mushroom Hotpot');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Balchi di Pisca','https://www.themealdb.com/images/media/meals/qqwhw51780093126.jpg',(SELECT id FROM orders WHERE number='HIST20260612200400020' LIMIT 1),92,1,16.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260612200400020' AND od.name='Balchi di Pisca');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260611205200021',5,4,2,'2026-06-11 20:52:00','2026-06-11 20:52:00',1,1,49.57,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-11 21:52:00','2026-06-11 21:52:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260611205200021');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Chicken & mushroom Hotpot','https://www.themealdb.com/images/media/meals/uuuspp1511297945.jpg',(SELECT id FROM orders WHERE number='HIST20260611205200021' LIMIT 1),83,1,16.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260611205200021' AND od.name='Chicken & mushroom Hotpot');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Arepa Pabellón','https://www.themealdb.com/images/media/meals/13fg4j1764441982.jpg',(SELECT id FROM orders WHERE number='HIST20260611205200021' LIMIT 1),86,1,17.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260611205200021' AND od.name='Arepa Pabellón');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Algerian Kefta (Meatballs)','https://www.themealdb.com/images/media/meals/8rfd4q1764112993.jpg',(SELECT id FROM orders WHERE number='HIST20260611205200021' LIMIT 1),85,1,14.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260611205200021' AND od.name='Algerian Kefta (Meatballs)');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260611102900022',5,4,2,'2026-06-11 10:29:00','2026-06-11 10:29:00',1,1,40.17,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-11 11:29:00','2026-06-11 11:29:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260611102900022');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Ayam Percik','https://www.themealdb.com/images/media/meals/020z181619788503.jpg',(SELECT id FROM orders WHERE number='HIST20260611102900022' LIMIT 1),79,1,11.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260611102900022' AND od.name='Ayam Percik');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Cream Cheese Tart','https://www.themealdb.com/images/media/meals/wurrux1468416624.jpg',(SELECT id FROM orders WHERE number='HIST20260611102900022' LIMIT 1),77,1,6.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260611102900022' AND od.name='Cream Cheese Tart');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Aussie Burgers','https://www.themealdb.com/images/media/meals/44bzep1761848278.jpg',(SELECT id FROM orders WHERE number='HIST20260611102900022' LIMIT 1),89,1,21.39 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260611102900022' AND od.name='Aussie Burgers');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260610101300023',5,4,2,'2026-06-10 10:13:00','2026-06-10 10:13:00',1,1,42.57,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-10 11:13:00','2026-06-10 11:13:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260610101300023');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Creamy Tomato Soup','https://www.themealdb.com/images/media/meals/stpuws1511191310.jpg',(SELECT id FROM orders WHERE number='HIST20260610101300023' LIMIT 1),78,1,9.19 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260610101300023' AND od.name='Creamy Tomato Soup');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Chick-Fil-A Sandwich','https://www.themealdb.com/images/media/meals/sbx7n71587673021.jpg',(SELECT id FROM orders WHERE number='HIST20260610101300023' LIMIT 1),81,1,15.59 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260610101300023' AND od.name='Chick-Fil-A Sandwich');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Arepa Pabellón','https://www.themealdb.com/images/media/meals/13fg4j1764441982.jpg',(SELECT id FROM orders WHERE number='HIST20260610101300023' LIMIT 1),86,1,17.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260610101300023' AND od.name='Arepa Pabellón');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260610165800024',5,4,2,'2026-06-10 16:58:00','2026-06-10 16:58:00',1,1,36.97,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-10 17:58:00','2026-06-10 17:58:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260610165800024');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Clam chowder','https://www.themealdb.com/images/media/meals/rvtvuw1511190488.jpg',(SELECT id FROM orders WHERE number='HIST20260610165800024' LIMIT 1),76,1,8.39 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260610165800024' AND od.name='Clam chowder');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Ayam Percik','https://www.themealdb.com/images/media/meals/020z181619788503.jpg',(SELECT id FROM orders WHERE number='HIST20260610165800024' LIMIT 1),79,1,11.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260610165800024' AND od.name='Ayam Percik');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Asado','https://www.themealdb.com/images/media/meals/kgfh3q1763075438.jpg',(SELECT id FROM orders WHERE number='HIST20260610165800024' LIMIT 1),88,1,16.59 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260610165800024' AND od.name='Asado');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260609163500025',5,4,2,'2026-06-09 16:35:00','2026-06-09 16:35:00',1,1,42.97,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-09 17:35:00','2026-06-09 17:35:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260609163500025');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Creamy Tomato Soup','https://www.themealdb.com/images/media/meals/stpuws1511191310.jpg',(SELECT id FROM orders WHERE number='HIST20260609163500025' LIMIT 1),78,1,9.19 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260609163500025' AND od.name='Creamy Tomato Soup');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Arepa pelua','https://www.themealdb.com/images/media/meals/jgl9qq1764437635.jpg',(SELECT id FROM orders WHERE number='HIST20260609163500025' LIMIT 1),87,1,19.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260609163500025' AND od.name='Arepa pelua');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Arroz con gambas y calamar','https://www.themealdb.com/images/media/meals/jc6oub1763196663.jpg',(SELECT id FROM orders WHERE number='HIST20260609163500025' LIMIT 1),91,1,13.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260609163500025' AND od.name='Arroz con gambas y calamar');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260609144500026',5,4,2,'2026-06-09 14:45:00','2026-06-09 14:45:00',1,1,48.37,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-09 15:45:00','2026-06-09 15:45:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260609144500026');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Algerian Kefta (Meatballs)','https://www.themealdb.com/images/media/meals/8rfd4q1764112993.jpg',(SELECT id FROM orders WHERE number='HIST20260609144500026' LIMIT 1),85,1,14.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260609144500026' AND od.name='Algerian Kefta (Meatballs)');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Arepa Pabellón','https://www.themealdb.com/images/media/meals/13fg4j1764441982.jpg',(SELECT id FROM orders WHERE number='HIST20260609144500026' LIMIT 1),86,1,17.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260609144500026' AND od.name='Arepa Pabellón');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Chick-Fil-A Sandwich','https://www.themealdb.com/images/media/meals/sbx7n71587673021.jpg',(SELECT id FROM orders WHERE number='HIST20260609144500026' LIMIT 1),81,1,15.59 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260609144500026' AND od.name='Chick-Fil-A Sandwich');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260608120500027',5,4,2,'2026-06-08 12:05:00','2026-06-08 12:05:00',1,1,24.78,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-08 13:05:00','2026-06-08 13:05:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260608120500027');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Creamy Tomato Soup','https://www.themealdb.com/images/media/meals/stpuws1511191310.jpg',(SELECT id FROM orders WHERE number='HIST20260608120500027' LIMIT 1),78,1,9.19 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260608120500027' AND od.name='Creamy Tomato Soup');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Chick-Fil-A Sandwich','https://www.themealdb.com/images/media/meals/sbx7n71587673021.jpg',(SELECT id FROM orders WHERE number='HIST20260608120500027' LIMIT 1),81,1,15.59 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260608120500027' AND od.name='Chick-Fil-A Sandwich');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260608201400028',5,4,2,'2026-06-08 20:14:00','2026-06-08 20:14:00',1,1,38.18,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-08 21:14:00','2026-06-08 21:14:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260608201400028');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Aussie Burgers','https://www.themealdb.com/images/media/meals/44bzep1761848278.jpg',(SELECT id FROM orders WHERE number='HIST20260608201400028' LIMIT 1),89,1,21.39 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260608201400028' AND od.name='Aussie Burgers');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Balchi di Pisca','https://www.themealdb.com/images/media/meals/qqwhw51780093126.jpg',(SELECT id FROM orders WHERE number='HIST20260608201400028' LIMIT 1),92,1,16.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260608201400028' AND od.name='Balchi di Pisca');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260607121600029',5,4,2,'2026-06-07 12:16:00','2026-06-07 12:16:00',1,1,34.97,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-07 13:16:00','2026-06-07 13:16:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260607121600029');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Ajo blanco','https://www.themealdb.com/images/media/meals/5jdtie1763289302.jpg',(SELECT id FROM orders WHERE number='HIST20260607121600029' LIMIT 1),74,1,5.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260607121600029' AND od.name='Ajo blanco');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Creamy Tomato Soup','https://www.themealdb.com/images/media/meals/stpuws1511191310.jpg',(SELECT id FROM orders WHERE number='HIST20260607121600029' LIMIT 1),78,1,9.19 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260607121600029' AND od.name='Creamy Tomato Soup');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Arepa pelua','https://www.themealdb.com/images/media/meals/jgl9qq1764437635.jpg',(SELECT id FROM orders WHERE number='HIST20260607121600029' LIMIT 1),87,1,19.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260607121600029' AND od.name='Arepa pelua');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260607182300030',5,4,2,'2026-06-07 18:23:00','2026-06-07 18:23:00',1,1,35.57,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-07 19:23:00','2026-06-07 19:23:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260607182300030');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Creamy Tomato Soup','https://www.themealdb.com/images/media/meals/stpuws1511191310.jpg',(SELECT id FROM orders WHERE number='HIST20260607182300030' LIMIT 1),78,1,9.19 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260607182300030' AND od.name='Creamy Tomato Soup');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Beef and Broccoli Stir-Fry','https://www.themealdb.com/images/media/meals/m0p0j81765568742.jpg',(SELECT id FROM orders WHERE number='HIST20260607182300030' LIMIT 1),90,1,18.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260607182300030' AND od.name='Beef and Broccoli Stir-Fry');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Broccoli & Stilton soup','https://www.themealdb.com/images/media/meals/tvvxpv1511191952.jpg',(SELECT id FROM orders WHERE number='HIST20260607182300030' LIMIT 1),75,1,7.39 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260607182300030' AND od.name='Broccoli & Stilton soup');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260606175700031',5,4,2,'2026-06-06 17:57:00','2026-06-06 17:57:00',1,1,53.37,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-06 18:57:00','2026-06-06 18:57:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260606175700031');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Arepa Pabellón','https://www.themealdb.com/images/media/meals/13fg4j1764441982.jpg',(SELECT id FROM orders WHERE number='HIST20260606175700031' LIMIT 1),86,1,17.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260606175700031' AND od.name='Arepa Pabellón');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Bang bang prawn salad','https://www.themealdb.com/images/media/meals/4xcfai1763765676.jpg',(SELECT id FROM orders WHERE number='HIST20260606175700031' LIMIT 1),93,1,18.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260606175700031' AND od.name='Bang bang prawn salad');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Balchi di Pisca','https://www.themealdb.com/images/media/meals/qqwhw51780093126.jpg',(SELECT id FROM orders WHERE number='HIST20260606175700031' LIMIT 1),92,1,16.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260606175700031' AND od.name='Balchi di Pisca');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260606113000032',5,4,2,'2026-06-06 11:30:00','2026-06-06 11:30:00',1,1,29.87,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-06 12:30:00','2026-06-06 12:30:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260606113000032');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Broccoli & Stilton soup','https://www.themealdb.com/images/media/meals/tvvxpv1511191952.jpg',(SELECT id FROM orders WHERE number='HIST20260606113000032' LIMIT 1),75,1,7.39 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260606113000032' AND od.name='Broccoli & Stilton soup');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Brown Stew Chicken','https://www.themealdb.com/images/media/meals/sypxpx1515365095.jpg',(SELECT id FROM orders WHERE number='HIST20260606113000032' LIMIT 1),80,1,14.09 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260606113000032' AND od.name='Brown Stew Chicken');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Clam chowder','https://www.themealdb.com/images/media/meals/rvtvuw1511190488.jpg',(SELECT id FROM orders WHERE number='HIST20260606113000032' LIMIT 1),76,1,8.39 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260606113000032' AND od.name='Clam chowder');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260605132800033',5,4,2,'2026-06-05 13:28:00','2026-06-05 13:28:00',1,1,21.78,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-05 14:28:00','2026-06-05 14:28:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260605132800033');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Cream Cheese Tart','https://www.themealdb.com/images/media/meals/wurrux1468416624.jpg',(SELECT id FROM orders WHERE number='HIST20260605132800033' LIMIT 1),77,1,6.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260605132800033' AND od.name='Cream Cheese Tart');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Chicken Alfredo Primavera','https://www.themealdb.com/images/media/meals/syqypv1486981727.jpg',(SELECT id FROM orders WHERE number='HIST20260605132800033' LIMIT 1),84,1,14.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260605132800033' AND od.name='Chicken Alfredo Primavera');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260605190300034',5,4,2,'2026-06-05 19:03:00','2026-06-05 19:03:00',1,1,22.78,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-05 20:03:00','2026-06-05 20:03:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260605190300034');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Ajo blanco','https://www.themealdb.com/images/media/meals/5jdtie1763289302.jpg',(SELECT id FROM orders WHERE number='HIST20260605190300034' LIMIT 1),74,1,5.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260605190300034' AND od.name='Ajo blanco');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Balchi di Pisca','https://www.themealdb.com/images/media/meals/qqwhw51780093126.jpg',(SELECT id FROM orders WHERE number='HIST20260605190300034' LIMIT 1),92,1,16.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260605190300034' AND od.name='Balchi di Pisca');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260604123400035',5,4,2,'2026-06-04 12:34:00','2026-06-04 12:34:00',1,1,20.98,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-04 13:34:00','2026-06-04 13:34:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260604123400035');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Algerian Kefta (Meatballs)','https://www.themealdb.com/images/media/meals/8rfd4q1764112993.jpg',(SELECT id FROM orders WHERE number='HIST20260604123400035' LIMIT 1),85,1,14.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260604123400035' AND od.name='Algerian Kefta (Meatballs)');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Ajo blanco','https://www.themealdb.com/images/media/meals/5jdtie1763289302.jpg',(SELECT id FROM orders WHERE number='HIST20260604123400035' LIMIT 1),74,1,5.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260604123400035' AND od.name='Ajo blanco');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260604115500036',5,4,2,'2026-06-04 11:55:00','2026-06-04 11:55:00',1,1,36.58,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-04 12:55:00','2026-06-04 12:55:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260604115500036');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Bang bang prawn salad','https://www.themealdb.com/images/media/meals/4xcfai1763765676.jpg',(SELECT id FROM orders WHERE number='HIST20260604115500036' LIMIT 1),93,1,18.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260604115500036' AND od.name='Bang bang prawn salad');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Arepa Pabellón','https://www.themealdb.com/images/media/meals/13fg4j1764441982.jpg',(SELECT id FROM orders WHERE number='HIST20260604115500036' LIMIT 1),86,1,17.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260604115500036' AND od.name='Arepa Pabellón');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260603124000037',5,4,2,'2026-06-03 12:40:00','2026-06-03 12:40:00',1,1,55.17,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-03 13:40:00','2026-06-03 13:40:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260603124000037');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Algerian Kefta (Meatballs)','https://www.themealdb.com/images/media/meals/8rfd4q1764112993.jpg',(SELECT id FROM orders WHERE number='HIST20260603124000037' LIMIT 1),85,1,14.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260603124000037' AND od.name='Algerian Kefta (Meatballs)');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Bang bang prawn salad','https://www.themealdb.com/images/media/meals/4xcfai1763765676.jpg',(SELECT id FROM orders WHERE number='HIST20260603124000037' LIMIT 1),93,1,18.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260603124000037' AND od.name='Bang bang prawn salad');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Aussie Burgers','https://www.themealdb.com/images/media/meals/44bzep1761848278.jpg',(SELECT id FROM orders WHERE number='HIST20260603124000037' LIMIT 1),89,1,21.39 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260603124000037' AND od.name='Aussie Burgers');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260603110700038',5,4,2,'2026-06-03 11:07:00','2026-06-03 11:07:00',1,1,54.77,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-03 12:07:00','2026-06-03 12:07:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260603110700038');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Asado','https://www.themealdb.com/images/media/meals/kgfh3q1763075438.jpg',(SELECT id FROM orders WHERE number='HIST20260603110700038' LIMIT 1),88,1,16.59 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260603110700038' AND od.name='Asado');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Aussie Burgers','https://www.themealdb.com/images/media/meals/44bzep1761848278.jpg',(SELECT id FROM orders WHERE number='HIST20260603110700038' LIMIT 1),89,1,21.39 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260603110700038' AND od.name='Aussie Burgers');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Balchi di Pisca','https://www.themealdb.com/images/media/meals/qqwhw51780093126.jpg',(SELECT id FROM orders WHERE number='HIST20260603110700038' LIMIT 1),92,1,16.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260603110700038' AND od.name='Balchi di Pisca');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260602140500039',5,4,2,'2026-06-02 14:05:00','2026-06-02 14:05:00',1,1,21.78,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-02 15:05:00','2026-06-02 15:05:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260602140500039');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Cream Cheese Tart','https://www.themealdb.com/images/media/meals/wurrux1468416624.jpg',(SELECT id FROM orders WHERE number='HIST20260602140500039' LIMIT 1),77,1,6.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260602140500039' AND od.name='Cream Cheese Tart');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Chicken Alfredo Primavera','https://www.themealdb.com/images/media/meals/syqypv1486981727.jpg',(SELECT id FROM orders WHERE number='HIST20260602140500039' LIMIT 1),84,1,14.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260602140500039' AND od.name='Chicken Alfredo Primavera');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260602143000040',5,4,2,'2026-06-02 14:30:00','2026-06-02 14:30:00',1,1,24.98,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-02 15:30:00','2026-06-02 15:30:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260602143000040');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Beef and Broccoli Stir-Fry','https://www.themealdb.com/images/media/meals/m0p0j81765568742.jpg',(SELECT id FROM orders WHERE number='HIST20260602143000040' LIMIT 1),90,1,18.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260602143000040' AND od.name='Beef and Broccoli Stir-Fry');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Ajo blanco','https://www.themealdb.com/images/media/meals/5jdtie1763289302.jpg',(SELECT id FROM orders WHERE number='HIST20260602143000040' LIMIT 1),74,1,5.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260602143000040' AND od.name='Ajo blanco');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260601133300041',5,4,2,'2026-06-01 13:33:00','2026-06-01 13:33:00',1,1,29.17,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-01 14:33:00','2026-06-01 14:33:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260601133300041');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Creamy Tomato Soup','https://www.themealdb.com/images/media/meals/stpuws1511191310.jpg',(SELECT id FROM orders WHERE number='HIST20260601133300041' LIMIT 1),78,1,9.19 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260601133300041' AND od.name='Creamy Tomato Soup');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Arroz con gambas y calamar','https://www.themealdb.com/images/media/meals/jc6oub1763196663.jpg',(SELECT id FROM orders WHERE number='HIST20260601133300041' LIMIT 1),91,1,13.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260601133300041' AND od.name='Arroz con gambas y calamar');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Ajo blanco','https://www.themealdb.com/images/media/meals/5jdtie1763289302.jpg',(SELECT id FROM orders WHERE number='HIST20260601133300041' LIMIT 1),74,1,5.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260601133300041' AND od.name='Ajo blanco');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260601181900042',5,4,2,'2026-06-01 18:19:00','2026-06-01 18:19:00',1,1,32.18,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-06-01 19:19:00','2026-06-01 19:19:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260601181900042');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Chicken & chorizo rice pot','https://www.themealdb.com/images/media/meals/fk80jp1763280767.jpg',(SELECT id FROM orders WHERE number='HIST20260601181900042' LIMIT 1),82,1,13.19 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260601181900042' AND od.name='Chicken & chorizo rice pot');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Beef and Broccoli Stir-Fry','https://www.themealdb.com/images/media/meals/m0p0j81765568742.jpg',(SELECT id FROM orders WHERE number='HIST20260601181900042' LIMIT 1),90,1,18.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260601181900042' AND od.name='Beef and Broccoli Stir-Fry');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260531155800043',5,4,2,'2026-05-31 15:58:00','2026-05-31 15:58:00',1,1,30.58,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-05-31 16:58:00','2026-05-31 16:58:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260531155800043');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Algerian Kefta (Meatballs)','https://www.themealdb.com/images/media/meals/8rfd4q1764112993.jpg',(SELECT id FROM orders WHERE number='HIST20260531155800043' LIMIT 1),85,1,14.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260531155800043' AND od.name='Algerian Kefta (Meatballs)');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Chick-Fil-A Sandwich','https://www.themealdb.com/images/media/meals/sbx7n71587673021.jpg',(SELECT id FROM orders WHERE number='HIST20260531155800043' LIMIT 1),81,1,15.59 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260531155800043' AND od.name='Chick-Fil-A Sandwich');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260531183400044',5,4,2,'2026-05-31 18:34:00','2026-05-31 18:34:00',1,1,48.47,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-05-31 19:34:00','2026-05-31 19:34:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260531183400044');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Chick-Fil-A Sandwich','https://www.themealdb.com/images/media/meals/sbx7n71587673021.jpg',(SELECT id FROM orders WHERE number='HIST20260531183400044' LIMIT 1),81,1,15.59 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260531183400044' AND od.name='Chick-Fil-A Sandwich');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Brown Stew Chicken','https://www.themealdb.com/images/media/meals/sypxpx1515365095.jpg',(SELECT id FROM orders WHERE number='HIST20260531183400044' LIMIT 1),80,1,14.09 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260531183400044' AND od.name='Brown Stew Chicken');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Bang bang prawn salad','https://www.themealdb.com/images/media/meals/4xcfai1763765676.jpg',(SELECT id FROM orders WHERE number='HIST20260531183400044' LIMIT 1),93,1,18.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260531183400044' AND od.name='Bang bang prawn salad');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260530164700045',5,4,2,'2026-05-30 16:47:00','2026-05-30 16:47:00',1,1,33.08,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-05-30 17:47:00','2026-05-30 17:47:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260530164700045');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Brown Stew Chicken','https://www.themealdb.com/images/media/meals/sypxpx1515365095.jpg',(SELECT id FROM orders WHERE number='HIST20260530164700045' LIMIT 1),80,1,14.09 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260530164700045' AND od.name='Brown Stew Chicken');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Beef and Broccoli Stir-Fry','https://www.themealdb.com/images/media/meals/m0p0j81765568742.jpg',(SELECT id FROM orders WHERE number='HIST20260530164700045' LIMIT 1),90,1,18.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260530164700045' AND od.name='Beef and Broccoli Stir-Fry');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260530172200046',5,4,2,'2026-05-30 17:22:00','2026-05-30 17:22:00',1,1,19.18,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-05-30 18:22:00','2026-05-30 18:22:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260530172200046');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Ajo blanco','https://www.themealdb.com/images/media/meals/5jdtie1763289302.jpg',(SELECT id FROM orders WHERE number='HIST20260530172200046' LIMIT 1),74,1,5.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260530172200046' AND od.name='Ajo blanco');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Chicken & chorizo rice pot','https://www.themealdb.com/images/media/meals/fk80jp1763280767.jpg',(SELECT id FROM orders WHERE number='HIST20260530172200046' LIMIT 1),82,1,13.19 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260530172200046' AND od.name='Chicken & chorizo rice pot');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260529171600047',5,4,2,'2026-05-29 17:16:00','2026-05-29 17:16:00',1,1,33.78,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-05-29 18:16:00','2026-05-29 18:16:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260529171600047');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Bang bang prawn salad','https://www.themealdb.com/images/media/meals/4xcfai1763765676.jpg',(SELECT id FROM orders WHERE number='HIST20260529171600047' LIMIT 1),93,1,18.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260529171600047' AND od.name='Bang bang prawn salad');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Algerian Kefta (Meatballs)','https://www.themealdb.com/images/media/meals/8rfd4q1764112993.jpg',(SELECT id FROM orders WHERE number='HIST20260529171600047' LIMIT 1),85,1,14.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260529171600047' AND od.name='Algerian Kefta (Meatballs)');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260529175100048',5,4,2,'2026-05-29 17:51:00','2026-05-29 17:51:00',1,1,38.97,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-05-29 18:51:00','2026-05-29 18:51:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260529175100048');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Algerian Kefta (Meatballs)','https://www.themealdb.com/images/media/meals/8rfd4q1764112993.jpg',(SELECT id FROM orders WHERE number='HIST20260529175100048' LIMIT 1),85,1,14.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260529175100048' AND od.name='Algerian Kefta (Meatballs)');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Clam chowder','https://www.themealdb.com/images/media/meals/rvtvuw1511190488.jpg',(SELECT id FROM orders WHERE number='HIST20260529175100048' LIMIT 1),76,1,8.39 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260529175100048' AND od.name='Clam chowder');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Chick-Fil-A Sandwich','https://www.themealdb.com/images/media/meals/sbx7n71587673021.jpg',(SELECT id FROM orders WHERE number='HIST20260529175100048' LIMIT 1),81,1,15.59 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260529175100048' AND od.name='Chick-Fil-A Sandwich');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260528111400049',5,4,2,'2026-05-28 11:14:00','2026-05-28 11:14:00',1,1,47.87,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-05-28 12:14:00','2026-05-28 12:14:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260528111400049');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Brown Stew Chicken','https://www.themealdb.com/images/media/meals/sypxpx1515365095.jpg',(SELECT id FROM orders WHERE number='HIST20260528111400049' LIMIT 1),80,1,14.09 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260528111400049' AND od.name='Brown Stew Chicken');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Chicken Alfredo Primavera','https://www.themealdb.com/images/media/meals/syqypv1486981727.jpg',(SELECT id FROM orders WHERE number='HIST20260528111400049' LIMIT 1),84,1,14.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260528111400049' AND od.name='Chicken Alfredo Primavera');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Bang bang prawn salad','https://www.themealdb.com/images/media/meals/4xcfai1763765676.jpg',(SELECT id FROM orders WHERE number='HIST20260528111400049' LIMIT 1),93,1,18.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260528111400049' AND od.name='Bang bang prawn salad');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260528173900050',5,4,2,'2026-05-28 17:39:00','2026-05-28 17:39:00',1,1,36.38,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-05-28 18:39:00','2026-05-28 18:39:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260528173900050');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Aussie Burgers','https://www.themealdb.com/images/media/meals/44bzep1761848278.jpg',(SELECT id FROM orders WHERE number='HIST20260528173900050' LIMIT 1),89,1,21.39 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260528173900050' AND od.name='Aussie Burgers');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Algerian Kefta (Meatballs)','https://www.themealdb.com/images/media/meals/8rfd4q1764112993.jpg',(SELECT id FROM orders WHERE number='HIST20260528173900050' LIMIT 1),85,1,14.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260528173900050' AND od.name='Algerian Kefta (Meatballs)');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260527200500051',5,4,2,'2026-05-27 20:05:00','2026-05-27 20:05:00',1,1,31.88,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-05-27 21:05:00','2026-05-27 21:05:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260527200500051');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Arepa Pabellón','https://www.themealdb.com/images/media/meals/13fg4j1764441982.jpg',(SELECT id FROM orders WHERE number='HIST20260527200500051' LIMIT 1),86,1,17.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260527200500051' AND od.name='Arepa Pabellón');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Brown Stew Chicken','https://www.themealdb.com/images/media/meals/sypxpx1515365095.jpg',(SELECT id FROM orders WHERE number='HIST20260527200500051' LIMIT 1),80,1,14.09 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260527200500051' AND od.name='Brown Stew Chicken');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260527175600052',5,4,2,'2026-05-27 17:56:00','2026-05-27 17:56:00',1,1,34.78,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-05-27 18:56:00','2026-05-27 18:56:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260527175600052');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Arepa pelua','https://www.themealdb.com/images/media/meals/jgl9qq1764437635.jpg',(SELECT id FROM orders WHERE number='HIST20260527175600052' LIMIT 1),87,1,19.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260527175600052' AND od.name='Arepa pelua');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Chicken Alfredo Primavera','https://www.themealdb.com/images/media/meals/syqypv1486981727.jpg',(SELECT id FROM orders WHERE number='HIST20260527175600052' LIMIT 1),84,1,14.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260527175600052' AND od.name='Chicken Alfredo Primavera');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260526115100053',5,4,2,'2026-05-26 11:51:00','2026-05-26 11:51:00',1,1,42.77,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-05-26 12:51:00','2026-05-26 12:51:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260526115100053');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Asado','https://www.themealdb.com/images/media/meals/kgfh3q1763075438.jpg',(SELECT id FROM orders WHERE number='HIST20260526115100053' LIMIT 1),88,1,16.59 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260526115100053' AND od.name='Asado');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Arepa Pabellón','https://www.themealdb.com/images/media/meals/13fg4j1764441982.jpg',(SELECT id FROM orders WHERE number='HIST20260526115100053' LIMIT 1),86,1,17.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260526115100053' AND od.name='Arepa Pabellón');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Clam chowder','https://www.themealdb.com/images/media/meals/rvtvuw1511190488.jpg',(SELECT id FROM orders WHERE number='HIST20260526115100053' LIMIT 1),76,1,8.39 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260526115100053' AND od.name='Clam chowder');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260526121000054',5,4,2,'2026-05-26 12:10:00','2026-05-26 12:10:00',1,1,15.18,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-05-26 13:10:00','2026-05-26 13:10:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260526121000054');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Ajo blanco','https://www.themealdb.com/images/media/meals/5jdtie1763289302.jpg',(SELECT id FROM orders WHERE number='HIST20260526121000054' LIMIT 1),74,1,5.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260526121000054' AND od.name='Ajo blanco');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Creamy Tomato Soup','https://www.themealdb.com/images/media/meals/stpuws1511191310.jpg',(SELECT id FROM orders WHERE number='HIST20260526121000054' LIMIT 1),78,1,9.19 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260526121000054' AND od.name='Creamy Tomato Soup');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260525195700055',5,4,2,'2026-05-25 19:57:00','2026-05-25 19:57:00',1,1,45.57,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-05-25 20:57:00','2026-05-25 20:57:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260525195700055');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Creamy Tomato Soup','https://www.themealdb.com/images/media/meals/stpuws1511191310.jpg',(SELECT id FROM orders WHERE number='HIST20260525195700055' LIMIT 1),78,1,9.19 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260525195700055' AND od.name='Creamy Tomato Soup');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Aussie Burgers','https://www.themealdb.com/images/media/meals/44bzep1761848278.jpg',(SELECT id FROM orders WHERE number='HIST20260525195700055' LIMIT 1),89,1,21.39 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260525195700055' AND od.name='Aussie Burgers');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Algerian Kefta (Meatballs)','https://www.themealdb.com/images/media/meals/8rfd4q1764112993.jpg',(SELECT id FROM orders WHERE number='HIST20260525195700055' LIMIT 1),85,1,14.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260525195700055' AND od.name='Algerian Kefta (Meatballs)');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260525123500056',5,4,2,'2026-05-25 12:35:00','2026-05-25 12:35:00',1,1,24.78,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-05-25 13:35:00','2026-05-25 13:35:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260525123500056');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Ajo blanco','https://www.themealdb.com/images/media/meals/5jdtie1763289302.jpg',(SELECT id FROM orders WHERE number='HIST20260525123500056' LIMIT 1),74,1,5.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260525123500056' AND od.name='Ajo blanco');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Bang bang prawn salad','https://www.themealdb.com/images/media/meals/4xcfai1763765676.jpg',(SELECT id FROM orders WHERE number='HIST20260525123500056' LIMIT 1),93,1,18.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260525123500056' AND od.name='Bang bang prawn salad');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260524200600057',5,4,2,'2026-05-24 20:06:00','2026-05-24 20:06:00',1,1,33.88,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-05-24 21:06:00','2026-05-24 21:06:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260524200600057');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Arepa pelua','https://www.themealdb.com/images/media/meals/jgl9qq1764437635.jpg',(SELECT id FROM orders WHERE number='HIST20260524200600057' LIMIT 1),87,1,19.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260524200600057' AND od.name='Arepa pelua');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Brown Stew Chicken','https://www.themealdb.com/images/media/meals/sypxpx1515365095.jpg',(SELECT id FROM orders WHERE number='HIST20260524200600057' LIMIT 1),80,1,14.09 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260524200600057' AND od.name='Brown Stew Chicken');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260524130100058',5,4,2,'2026-05-24 13:01:00','2026-05-24 13:01:00',1,1,49.87,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-05-24 14:01:00','2026-05-24 14:01:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260524130100058');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Brown Stew Chicken','https://www.themealdb.com/images/media/meals/sypxpx1515365095.jpg',(SELECT id FROM orders WHERE number='HIST20260524130100058' LIMIT 1),80,1,14.09 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260524130100058' AND od.name='Brown Stew Chicken');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Chicken & mushroom Hotpot','https://www.themealdb.com/images/media/meals/uuuspp1511297945.jpg',(SELECT id FROM orders WHERE number='HIST20260524130100058' LIMIT 1),83,1,16.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260524130100058' AND od.name='Chicken & mushroom Hotpot');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Beef and Broccoli Stir-Fry','https://www.themealdb.com/images/media/meals/m0p0j81765568742.jpg',(SELECT id FROM orders WHERE number='HIST20260524130100058' LIMIT 1),90,1,18.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260524130100058' AND od.name='Beef and Broccoli Stir-Fry');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260523134800059',5,4,2,'2026-05-23 13:48:00','2026-05-23 13:48:00',1,1,46.97,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-05-23 14:48:00','2026-05-23 14:48:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260523134800059');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Chicken & chorizo rice pot','https://www.themealdb.com/images/media/meals/fk80jp1763280767.jpg',(SELECT id FROM orders WHERE number='HIST20260523134800059' LIMIT 1),82,1,13.19 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260523134800059' AND od.name='Chicken & chorizo rice pot');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Arroz con gambas y calamar','https://www.themealdb.com/images/media/meals/jc6oub1763196663.jpg',(SELECT id FROM orders WHERE number='HIST20260523134800059' LIMIT 1),91,1,13.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260523134800059' AND od.name='Arroz con gambas y calamar');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Arepa pelua','https://www.themealdb.com/images/media/meals/jgl9qq1764437635.jpg',(SELECT id FROM orders WHERE number='HIST20260523134800059' LIMIT 1),87,1,19.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260523134800059' AND od.name='Arepa pelua');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'HIST20260523120300060',5,4,2,'2026-05-23 12:03:00','2026-05-23 12:03:00',1,1,52.37,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','2026-05-23 13:03:00','2026-05-23 13:03:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='HIST20260523120300060');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Asado','https://www.themealdb.com/images/media/meals/kgfh3q1763075438.jpg',(SELECT id FROM orders WHERE number='HIST20260523120300060' LIMIT 1),88,1,16.59 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260523120300060' AND od.name='Asado');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Balchi di Pisca','https://www.themealdb.com/images/media/meals/qqwhw51780093126.jpg',(SELECT id FROM orders WHERE number='HIST20260523120300060' LIMIT 1),92,1,16.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260523120300060' AND od.name='Balchi di Pisca');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Beef and Broccoli Stir-Fry','https://www.themealdb.com/images/media/meals/m0p0j81765568742.jpg',(SELECT id FROM orders WHERE number='HIST20260523120300060' LIMIT 1),90,1,18.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='HIST20260523120300060' AND od.name='Beef and Broccoli Stir-Fry');

