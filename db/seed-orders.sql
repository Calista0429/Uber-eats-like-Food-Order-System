-- Simulated orders seed data (covers all merchant-managed statuses)
-- Idempotent: guarded by orders.number. Appends; does not modify existing rows.
SET NAMES utf8mb4;

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,cancel_reason,cancel_time,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'SIM20260619090000001',2,4,2,'2026-06-19 09:00:00','2026-06-19 09:00:00',1,1,15.18,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User',NULL,NULL,NULL,'2026-06-19 10:00:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='SIM20260619090000001');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Ajo blanco','https://www.themealdb.com/images/media/meals/5jdtie1763289302.jpg',(SELECT id FROM orders WHERE number='SIM20260619090000001' LIMIT 1),74,1,5.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='SIM20260619090000001' AND od.name='Ajo blanco');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Creamy Tomato Soup','https://www.themealdb.com/images/media/meals/stpuws1511191310.jpg',(SELECT id FROM orders WHERE number='SIM20260619090000001' LIMIT 1),78,1,9.19 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='SIM20260619090000001' AND od.name='Creamy Tomato Soup');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,cancel_reason,cancel_time,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'SIM20260619060000002',2,4,2,'2026-06-19 06:00:00','2026-06-19 06:00:00',1,1,15.18,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User',NULL,NULL,NULL,'2026-06-19 07:00:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='SIM20260619060000002');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Cream Cheese Tart','https://www.themealdb.com/images/media/meals/wurrux1468416624.jpg',(SELECT id FROM orders WHERE number='SIM20260619060000002' LIMIT 1),77,1,6.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='SIM20260619060000002' AND od.name='Cream Cheese Tart');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Clam chowder','https://www.themealdb.com/images/media/meals/rvtvuw1511190488.jpg',(SELECT id FROM orders WHERE number='SIM20260619060000002' LIMIT 1),76,1,8.39 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='SIM20260619060000002' AND od.name='Clam chowder');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,cancel_reason,cancel_time,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'SIM20260619030000003',2,4,2,'2026-06-19 03:00:00','2026-06-19 03:00:00',1,1,28.18,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User',NULL,NULL,NULL,'2026-06-19 04:00:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='SIM20260619030000003');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Chicken Alfredo Primavera','https://www.themealdb.com/images/media/meals/syqypv1486981727.jpg',(SELECT id FROM orders WHERE number='SIM20260619030000003' LIMIT 1),84,1,14.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='SIM20260619030000003' AND od.name='Chicken Alfredo Primavera');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Chicken & chorizo rice pot','https://www.themealdb.com/images/media/meals/fk80jp1763280767.jpg',(SELECT id FROM orders WHERE number='SIM20260619030000003' LIMIT 1),82,1,13.19 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='SIM20260619030000003' AND od.name='Chicken & chorizo rice pot');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,cancel_reason,cancel_time,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'SIM20260619000000004',2,4,2,'2026-06-19 00:00:00','2026-06-19 00:00:00',1,1,30.88,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User',NULL,NULL,NULL,'2026-06-19 01:00:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='SIM20260619000000004');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Chicken & mushroom Hotpot','https://www.themealdb.com/images/media/meals/uuuspp1511297945.jpg',(SELECT id FROM orders WHERE number='SIM20260619000000004' LIMIT 1),83,1,16.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='SIM20260619000000004' AND od.name='Chicken & mushroom Hotpot');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Brown Stew Chicken','https://www.themealdb.com/images/media/meals/sypxpx1515365095.jpg',(SELECT id FROM orders WHERE number='SIM20260619000000004' LIMIT 1),80,1,14.09 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='SIM20260619000000004' AND od.name='Brown Stew Chicken');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,cancel_reason,cancel_time,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'SIM20260618210000005',3,4,2,'2026-06-18 21:00:00','2026-06-18 21:00:00',1,1,13.38,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User',NULL,NULL,NULL,'2026-06-18 22:00:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='SIM20260618210000005');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Ajo blanco','https://www.themealdb.com/images/media/meals/5jdtie1763289302.jpg',(SELECT id FROM orders WHERE number='SIM20260618210000005' LIMIT 1),74,1,5.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='SIM20260618210000005' AND od.name='Ajo blanco');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Broccoli & Stilton soup','https://www.themealdb.com/images/media/meals/tvvxpv1511191952.jpg',(SELECT id FROM orders WHERE number='SIM20260618210000005' LIMIT 1),75,1,7.39 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='SIM20260618210000005' AND od.name='Broccoli & Stilton soup');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,cancel_reason,cancel_time,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'SIM20260618180000006',3,4,2,'2026-06-18 18:00:00','2026-06-18 18:00:00',1,1,19.98,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User',NULL,NULL,NULL,'2026-06-18 19:00:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='SIM20260618180000006');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Cream Cheese Tart','https://www.themealdb.com/images/media/meals/wurrux1468416624.jpg',(SELECT id FROM orders WHERE number='SIM20260618180000006' LIMIT 1),77,1,6.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='SIM20260618180000006' AND od.name='Cream Cheese Tart');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Chicken & chorizo rice pot','https://www.themealdb.com/images/media/meals/fk80jp1763280767.jpg',(SELECT id FROM orders WHERE number='SIM20260618180000006' LIMIT 1),82,1,13.19 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='SIM20260618180000006' AND od.name='Chicken & chorizo rice pot');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,cancel_reason,cancel_time,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'SIM20260618150000007',4,4,2,'2026-06-18 15:00:00','2026-06-18 15:00:00',1,1,19.98,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User',NULL,NULL,NULL,'2026-06-18 16:00:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='SIM20260618150000007');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Chicken & chorizo rice pot','https://www.themealdb.com/images/media/meals/fk80jp1763280767.jpg',(SELECT id FROM orders WHERE number='SIM20260618150000007' LIMIT 1),82,1,13.19 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='SIM20260618150000007' AND od.name='Chicken & chorizo rice pot');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Cream Cheese Tart','https://www.themealdb.com/images/media/meals/wurrux1468416624.jpg',(SELECT id FROM orders WHERE number='SIM20260618150000007' LIMIT 1),77,1,6.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='SIM20260618150000007' AND od.name='Cream Cheese Tart');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,cancel_reason,cancel_time,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'SIM20260618120000008',4,4,2,'2026-06-18 12:00:00','2026-06-18 12:00:00',1,1,39.17,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User',NULL,NULL,NULL,'2026-06-18 13:00:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='SIM20260618120000008');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Cream Cheese Tart','https://www.themealdb.com/images/media/meals/wurrux1468416624.jpg',(SELECT id FROM orders WHERE number='SIM20260618120000008' LIMIT 1),77,1,6.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='SIM20260618120000008' AND od.name='Cream Cheese Tart');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Chick-Fil-A Sandwich','https://www.themealdb.com/images/media/meals/sbx7n71587673021.jpg',(SELECT id FROM orders WHERE number='SIM20260618120000008' LIMIT 1),81,1,15.59 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='SIM20260618120000008' AND od.name='Chick-Fil-A Sandwich');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Chicken & mushroom Hotpot','https://www.themealdb.com/images/media/meals/uuuspp1511297945.jpg',(SELECT id FROM orders WHERE number='SIM20260618120000008' LIMIT 1),83,1,16.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='SIM20260618120000008' AND od.name='Chicken & mushroom Hotpot');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,cancel_reason,cancel_time,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'SIM20260618090000009',5,4,2,'2026-06-18 09:00:00','2026-06-18 09:00:00',1,1,28.47,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User',NULL,NULL,'2026-06-18 09:00:00','2026-06-18 10:00:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='SIM20260618090000009');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Ajo blanco','https://www.themealdb.com/images/media/meals/5jdtie1763289302.jpg',(SELECT id FROM orders WHERE number='SIM20260618090000009' LIMIT 1),74,1,5.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='SIM20260618090000009' AND od.name='Ajo blanco');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Clam chowder','https://www.themealdb.com/images/media/meals/rvtvuw1511190488.jpg',(SELECT id FROM orders WHERE number='SIM20260618090000009' LIMIT 1),76,1,8.39 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='SIM20260618090000009' AND od.name='Clam chowder');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Brown Stew Chicken','https://www.themealdb.com/images/media/meals/sypxpx1515365095.jpg',(SELECT id FROM orders WHERE number='SIM20260618090000009' LIMIT 1),80,1,14.09 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='SIM20260618090000009' AND od.name='Brown Stew Chicken');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,cancel_reason,cancel_time,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'SIM20260618060000010',5,4,2,'2026-06-18 06:00:00','2026-06-18 06:00:00',1,1,24.37,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User',NULL,NULL,'2026-06-18 06:00:00','2026-06-18 07:00:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='SIM20260618060000010');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Creamy Tomato Soup','https://www.themealdb.com/images/media/meals/stpuws1511191310.jpg',(SELECT id FROM orders WHERE number='SIM20260618060000010' LIMIT 1),78,1,9.19 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='SIM20260618060000010' AND od.name='Creamy Tomato Soup');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Clam chowder','https://www.themealdb.com/images/media/meals/rvtvuw1511190488.jpg',(SELECT id FROM orders WHERE number='SIM20260618060000010' LIMIT 1),76,1,8.39 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='SIM20260618060000010' AND od.name='Clam chowder');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Cream Cheese Tart','https://www.themealdb.com/images/media/meals/wurrux1468416624.jpg',(SELECT id FROM orders WHERE number='SIM20260618060000010' LIMIT 1),77,1,6.79 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='SIM20260618060000010' AND od.name='Cream Cheese Tart');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,cancel_reason,cancel_time,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'SIM20260618030000011',5,4,2,'2026-06-18 03:00:00','2026-06-18 03:00:00',1,1,36.47,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User',NULL,NULL,'2026-06-18 03:00:00','2026-06-18 04:00:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='SIM20260618030000011');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Broccoli & Stilton soup','https://www.themealdb.com/images/media/meals/tvvxpv1511191952.jpg',(SELECT id FROM orders WHERE number='SIM20260618030000011' LIMIT 1),75,1,7.39 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='SIM20260618030000011' AND od.name='Broccoli & Stilton soup');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Algerian Kefta (Meatballs)','https://www.themealdb.com/images/media/meals/8rfd4q1764112993.jpg',(SELECT id FROM orders WHERE number='SIM20260618030000011' LIMIT 1),85,1,14.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='SIM20260618030000011' AND od.name='Algerian Kefta (Meatballs)');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Brown Stew Chicken','https://www.themealdb.com/images/media/meals/sypxpx1515365095.jpg',(SELECT id FROM orders WHERE number='SIM20260618030000011' LIMIT 1),80,1,14.09 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='SIM20260618030000011' AND od.name='Brown Stew Chicken');

INSERT INTO orders (number,status,user_id,address_book_id,order_time,checkout_time,pay_method,pay_status,amount,phone,address,consignee,user_name,cancel_reason,cancel_time,delivery_time,estimated_delivery_time,delivery_status,pack_amount,tableware_number,tableware_status)
SELECT 'SIM20260618000000012',6,4,2,'2026-06-18 00:00:00','2026-06-18 00:00:00',1,1,26.98,'13712341234','12345 Market Street, Apt 6','Alex Chen','WeChat User','Out of stock','2026-06-18 00:00:00',NULL,'2026-06-18 01:00:00',1,2,2,1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM orders WHERE number='SIM20260618000000012');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Ayam Percik','https://www.themealdb.com/images/media/meals/020z181619788503.jpg',(SELECT id FROM orders WHERE number='SIM20260618000000012' LIMIT 1),79,1,11.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='SIM20260618000000012' AND od.name='Ayam Percik');
INSERT INTO order_detail (name,image,order_id,dish_id,number,amount)
SELECT 'Algerian Kefta (Meatballs)','https://www.themealdb.com/images/media/meals/8rfd4q1764112993.jpg',(SELECT id FROM orders WHERE number='SIM20260618000000012' LIMIT 1),85,1,14.99 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM order_detail od JOIN orders o ON od.order_id=o.id WHERE o.number='SIM20260618000000012' AND od.name='Algerian Kefta (Meatballs)');

