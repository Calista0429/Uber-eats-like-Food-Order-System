-- International dishes seed data
-- Source: TheMealDB (https://www.themealdb.com) — real dish names & images
-- Idempotent: re-running will not create duplicates (guarded by name).
-- Appends to existing sample data; does not modify it.

SET NAMES utf8mb4;

-- Dish categories
INSERT INTO category (type, name, sort, status, create_time, update_time, create_user, update_user)
SELECT 1, 'Appetizers', 20, 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM category WHERE name='Appetizers');
INSERT INTO category (type, name, sort, status, create_time, update_time, create_user, update_user)
SELECT 1, 'Chicken', 21, 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM category WHERE name='Chicken');
INSERT INTO category (type, name, sort, status, create_time, update_time, create_user, update_user)
SELECT 1, 'Beef', 22, 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM category WHERE name='Beef');
INSERT INTO category (type, name, sort, status, create_time, update_time, create_user, update_user)
SELECT 1, 'Seafood', 23, 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM category WHERE name='Seafood');
INSERT INTO category (type, name, sort, status, create_time, update_time, create_user, update_user)
SELECT 1, 'Pasta', 24, 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM category WHERE name='Pasta');
INSERT INTO category (type, name, sort, status, create_time, update_time, create_user, update_user)
SELECT 1, 'Vegetarian', 25, 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM category WHERE name='Vegetarian');
INSERT INTO category (type, name, sort, status, create_time, update_time, create_user, update_user)
SELECT 1, 'Breakfast', 26, 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM category WHERE name='Breakfast');
INSERT INTO category (type, name, sort, status, create_time, update_time, create_user, update_user)
SELECT 1, 'Desserts', 27, 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM category WHERE name='Desserts');

-- Dishes
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Ajo blanco', (SELECT id FROM category WHERE name='Appetizers' LIMIT 1), 5.99, 'https://www.themealdb.com/images/media/meals/5jdtie1763289302.jpg', 'A perfect bite to start your meal.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Ajo blanco');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Broccoli & Stilton soup', (SELECT id FROM category WHERE name='Appetizers' LIMIT 1), 7.39, 'https://www.themealdb.com/images/media/meals/tvvxpv1511191952.jpg', 'A perfect bite to start your meal.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Broccoli & Stilton soup');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Clam chowder', (SELECT id FROM category WHERE name='Appetizers' LIMIT 1), 8.39, 'https://www.themealdb.com/images/media/meals/rvtvuw1511190488.jpg', 'A perfect bite to start your meal.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Clam chowder');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Cream Cheese Tart', (SELECT id FROM category WHERE name='Appetizers' LIMIT 1), 6.79, 'https://www.themealdb.com/images/media/meals/wurrux1468416624.jpg', 'A perfect bite to start your meal.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Cream Cheese Tart');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Creamy Tomato Soup', (SELECT id FROM category WHERE name='Appetizers' LIMIT 1), 9.19, 'https://www.themealdb.com/images/media/meals/stpuws1511191310.jpg', 'A perfect bite to start your meal.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Creamy Tomato Soup');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Ayam Percik', (SELECT id FROM category WHERE name='Chicken' LIMIT 1), 11.99, 'https://www.themealdb.com/images/media/meals/020z181619788503.jpg', 'Tender chicken, freshly prepared to order.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Ayam Percik');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Brown Stew Chicken', (SELECT id FROM category WHERE name='Chicken' LIMIT 1), 14.09, 'https://www.themealdb.com/images/media/meals/sypxpx1515365095.jpg', 'Tender chicken, freshly prepared to order.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Brown Stew Chicken');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Chick-Fil-A Sandwich', (SELECT id FROM category WHERE name='Chicken' LIMIT 1), 15.59, 'https://www.themealdb.com/images/media/meals/sbx7n71587673021.jpg', 'Tender chicken, freshly prepared to order.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Chick-Fil-A Sandwich');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Chicken & chorizo rice pot', (SELECT id FROM category WHERE name='Chicken' LIMIT 1), 13.19, 'https://www.themealdb.com/images/media/meals/fk80jp1763280767.jpg', 'Tender chicken, freshly prepared to order.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Chicken & chorizo rice pot');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Chicken & mushroom Hotpot', (SELECT id FROM category WHERE name='Chicken' LIMIT 1), 16.79, 'https://www.themealdb.com/images/media/meals/uuuspp1511297945.jpg', 'Tender chicken, freshly prepared to order.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Chicken & mushroom Hotpot');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Chicken Alfredo Primavera', (SELECT id FROM category WHERE name='Chicken' LIMIT 1), 14.99, 'https://www.themealdb.com/images/media/meals/syqypv1486981727.jpg', 'Tender chicken, freshly prepared to order.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Chicken Alfredo Primavera');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Algerian Kefta (Meatballs)', (SELECT id FROM category WHERE name='Beef' LIMIT 1), 14.99, 'https://www.themealdb.com/images/media/meals/8rfd4q1764112993.jpg', 'Hearty beef dish full of flavor.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Algerian Kefta (Meatballs)');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Arepa Pabellón', (SELECT id FROM category WHERE name='Beef' LIMIT 1), 17.79, 'https://www.themealdb.com/images/media/meals/13fg4j1764441982.jpg', 'Hearty beef dish full of flavor.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Arepa Pabellón');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Arepa pelua', (SELECT id FROM category WHERE name='Beef' LIMIT 1), 19.79, 'https://www.themealdb.com/images/media/meals/jgl9qq1764437635.jpg', 'Hearty beef dish full of flavor.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Arepa pelua');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Asado', (SELECT id FROM category WHERE name='Beef' LIMIT 1), 16.59, 'https://www.themealdb.com/images/media/meals/kgfh3q1763075438.jpg', 'Hearty beef dish full of flavor.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Asado');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Aussie Burgers', (SELECT id FROM category WHERE name='Beef' LIMIT 1), 21.39, 'https://www.themealdb.com/images/media/meals/44bzep1761848278.jpg', 'Hearty beef dish full of flavor.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Aussie Burgers');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Beef and Broccoli Stir-Fry', (SELECT id FROM category WHERE name='Beef' LIMIT 1), 18.99, 'https://www.themealdb.com/images/media/meals/m0p0j81765568742.jpg', 'Hearty beef dish full of flavor.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Beef and Broccoli Stir-Fry');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Arroz con gambas y calamar', (SELECT id FROM category WHERE name='Seafood' LIMIT 1), 13.99, 'https://www.themealdb.com/images/media/meals/jc6oub1763196663.jpg', 'Fresh seafood cooked to perfection.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Arroz con gambas y calamar');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Balchi di Pisca', (SELECT id FROM category WHERE name='Seafood' LIMIT 1), 16.79, 'https://www.themealdb.com/images/media/meals/qqwhw51780093126.jpg', 'Fresh seafood cooked to perfection.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Balchi di Pisca');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Bang bang prawn salad', (SELECT id FROM category WHERE name='Seafood' LIMIT 1), 18.79, 'https://www.themealdb.com/images/media/meals/4xcfai1763765676.jpg', 'Fresh seafood cooked to perfection.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Bang bang prawn salad');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Barramundi with Moroccan spices', (SELECT id FROM category WHERE name='Seafood' LIMIT 1), 15.59, 'https://www.themealdb.com/images/media/meals/4o4wh11761848573.jpg', 'Fresh seafood cooked to perfection.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Barramundi with Moroccan spices');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Cajun spiced fish tacos', (SELECT id FROM category WHERE name='Seafood' LIMIT 1), 20.39, 'https://www.themealdb.com/images/media/meals/uvuyxu1503067369.jpg', 'Fresh seafood cooked to perfection.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Cajun spiced fish tacos');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Clam, chorizo & white bean stew', (SELECT id FROM category WHERE name='Seafood' LIMIT 1), 17.99, 'https://www.themealdb.com/images/media/meals/92wbmf1763252334.jpg', 'Fresh seafood cooked to perfection.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Clam, chorizo & white bean stew');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Chilli prawn linguine', (SELECT id FROM category WHERE name='Pasta' LIMIT 1), 10.99, 'https://www.themealdb.com/images/media/meals/usywpp1511189717.jpg', 'Classic pasta made the authentic way.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Chilli prawn linguine');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Fettuccine Alfredo', (SELECT id FROM category WHERE name='Pasta' LIMIT 1), 13.09, 'https://www.themealdb.com/images/media/meals/0jv5gx1661040802.jpg', 'Classic pasta made the authentic way.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Fettuccine Alfredo');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Fettucine alfredo', (SELECT id FROM category WHERE name='Pasta' LIMIT 1), 14.59, 'https://www.themealdb.com/images/media/meals/uquqtu1511178042.jpg', 'Classic pasta made the authentic way.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Fettucine alfredo');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Grilled Mac and Cheese Sandwich', (SELECT id FROM category WHERE name='Pasta' LIMIT 1), 12.19, 'https://www.themealdb.com/images/media/meals/xutquv1505330523.jpg', 'Classic pasta made the authentic way.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Grilled Mac and Cheese Sandwich');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Lasagna Sandwiches', (SELECT id FROM category WHERE name='Pasta' LIMIT 1), 15.79, 'https://www.themealdb.com/images/media/meals/xr0n4r1576788363.jpg', 'Classic pasta made the authentic way.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Lasagna Sandwiches');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Air fryer patatas bravas', (SELECT id FROM category WHERE name='Vegetarian' LIMIT 1), 9.99, 'https://www.themealdb.com/images/media/meals/3m8yae1763257951.jpg', 'Wholesome vegetarian favorite.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Air fryer patatas bravas');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Aubergine & hummus grills', (SELECT id FROM category WHERE name='Vegetarian' LIMIT 1), 11.74, 'https://www.themealdb.com/images/media/meals/zub3s91764110535.jpg', 'Wholesome vegetarian favorite.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Aubergine & hummus grills');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Aubergine couscous salad', (SELECT id FROM category WHERE name='Vegetarian' LIMIT 1), 12.99, 'https://www.themealdb.com/images/media/meals/02s6gc1763799560.jpg', 'Wholesome vegetarian favorite.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Aubergine couscous salad');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Avocado dip with new potatoes', (SELECT id FROM category WHERE name='Vegetarian' LIMIT 1), 10.99, 'https://www.themealdb.com/images/media/meals/flrajf1762341295.jpg', 'Wholesome vegetarian favorite.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Avocado dip with new potatoes');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Baingan Bharta', (SELECT id FROM category WHERE name='Vegetarian' LIMIT 1), 13.99, 'https://www.themealdb.com/images/media/meals/urtpqw1487341253.jpg', 'Wholesome vegetarian favorite.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Baingan Bharta');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Bread omelette', (SELECT id FROM category WHERE name='Breakfast' LIMIT 1), 6.99, 'https://www.themealdb.com/images/media/meals/hqaejl1695738653.jpg', 'A satisfying way to start the day.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Bread omelette');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Breakfast Potatoes', (SELECT id FROM category WHERE name='Breakfast' LIMIT 1), 8.74, 'https://www.themealdb.com/images/media/meals/1550441882.jpg', 'A satisfying way to start the day.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Breakfast Potatoes');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Dutch poffertjes (mini pancakes)', (SELECT id FROM category WHERE name='Breakfast' LIMIT 1), 9.99, 'https://www.themealdb.com/images/media/meals/oaqz9f1766593912.jpg', 'A satisfying way to start the day.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Dutch poffertjes (mini pancakes)');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'English Breakfast', (SELECT id FROM category WHERE name='Breakfast' LIMIT 1), 7.99, 'https://www.themealdb.com/images/media/meals/utxryw1511721587.jpg', 'A satisfying way to start the day.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='English Breakfast');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Flija Layered Pancake / Crepe', (SELECT id FROM category WHERE name='Breakfast' LIMIT 1), 10.99, 'https://www.themealdb.com/images/media/meals/eqnf3p1779649407.jpg', 'A satisfying way to start the day.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Flija Layered Pancake / Crepe');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Æbleskiver', (SELECT id FROM category WHERE name='Desserts' LIMIT 1), 4.99, 'https://www.themealdb.com/images/media/meals/wkhg581762773124.jpg', 'Sweet treat to finish your meal.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Æbleskiver');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Alfajores', (SELECT id FROM category WHERE name='Desserts' LIMIT 1), 6.39, 'https://www.themealdb.com/images/media/meals/a4kgf21763075288.jpg', 'Sweet treat to finish your meal.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Alfajores');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Anzac biscuits', (SELECT id FROM category WHERE name='Desserts' LIMIT 1), 7.39, 'https://www.themealdb.com/images/media/meals/q47rkb1762324620.jpg', 'Sweet treat to finish your meal.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Anzac biscuits');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Apam balik', (SELECT id FROM category WHERE name='Desserts' LIMIT 1), 5.79, 'https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg', 'Sweet treat to finish your meal.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Apam balik');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Apple & Blackberry Crumble', (SELECT id FROM category WHERE name='Desserts' LIMIT 1), 8.19, 'https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg', 'Sweet treat to finish your meal.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Apple & Blackberry Crumble');
INSERT INTO dish (name, category_id, price, image, description, status, create_time, update_time, create_user, update_user)
SELECT 'Apple cake', (SELECT id FROM category WHERE name='Desserts' LIMIT 1), 6.99, 'https://www.themealdb.com/images/media/meals/c0gmo31766594751.jpg', 'Sweet treat to finish your meal.', 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish WHERE name='Apple cake');

-- Dish flavors
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Ajo blanco' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Ajo blanco' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Ajo blanco' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Ajo blanco' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Broccoli & Stilton soup' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Broccoli & Stilton soup' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Broccoli & Stilton soup' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Broccoli & Stilton soup' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Clam chowder' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Clam chowder' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Clam chowder' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Clam chowder' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Cream Cheese Tart' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Cream Cheese Tart' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Cream Cheese Tart' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Cream Cheese Tart' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Creamy Tomato Soup' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Creamy Tomato Soup' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Creamy Tomato Soup' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Creamy Tomato Soup' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Ayam Percik' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Ayam Percik' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Ayam Percik' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Ayam Percik' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Brown Stew Chicken' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Brown Stew Chicken' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Brown Stew Chicken' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Brown Stew Chicken' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Chick-Fil-A Sandwich' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Chick-Fil-A Sandwich' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Chick-Fil-A Sandwich' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Chick-Fil-A Sandwich' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Chicken & chorizo rice pot' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Chicken & chorizo rice pot' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Chicken & chorizo rice pot' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Chicken & chorizo rice pot' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Chicken & mushroom Hotpot' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Chicken & mushroom Hotpot' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Chicken & mushroom Hotpot' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Chicken & mushroom Hotpot' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Chicken Alfredo Primavera' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Chicken Alfredo Primavera' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Chicken Alfredo Primavera' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Chicken Alfredo Primavera' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Algerian Kefta (Meatballs)' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Algerian Kefta (Meatballs)' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Algerian Kefta (Meatballs)' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Algerian Kefta (Meatballs)' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Arepa Pabellón' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Arepa Pabellón' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Arepa Pabellón' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Arepa Pabellón' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Arepa pelua' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Arepa pelua' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Arepa pelua' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Arepa pelua' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Asado' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Asado' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Asado' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Asado' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Aussie Burgers' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Aussie Burgers' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Aussie Burgers' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Aussie Burgers' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Beef and Broccoli Stir-Fry' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Beef and Broccoli Stir-Fry' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Beef and Broccoli Stir-Fry' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Beef and Broccoli Stir-Fry' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Arroz con gambas y calamar' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Arroz con gambas y calamar' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Arroz con gambas y calamar' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Arroz con gambas y calamar' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Balchi di Pisca' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Balchi di Pisca' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Balchi di Pisca' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Balchi di Pisca' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Bang bang prawn salad' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Bang bang prawn salad' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Bang bang prawn salad' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Bang bang prawn salad' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Barramundi with Moroccan spices' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Barramundi with Moroccan spices' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Barramundi with Moroccan spices' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Barramundi with Moroccan spices' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Cajun spiced fish tacos' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Cajun spiced fish tacos' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Cajun spiced fish tacos' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Cajun spiced fish tacos' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Clam, chorizo & white bean stew' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Clam, chorizo & white bean stew' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Clam, chorizo & white bean stew' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Clam, chorizo & white bean stew' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Chilli prawn linguine' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Chilli prawn linguine' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Chilli prawn linguine' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Chilli prawn linguine' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Fettuccine Alfredo' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Fettuccine Alfredo' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Fettuccine Alfredo' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Fettuccine Alfredo' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Fettucine alfredo' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Fettucine alfredo' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Fettucine alfredo' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Fettucine alfredo' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Grilled Mac and Cheese Sandwich' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Grilled Mac and Cheese Sandwich' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Grilled Mac and Cheese Sandwich' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Grilled Mac and Cheese Sandwich' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Lasagna Sandwiches' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Lasagna Sandwiches' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Lasagna Sandwiches' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Lasagna Sandwiches' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Air fryer patatas bravas' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Air fryer patatas bravas' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Air fryer patatas bravas' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Air fryer patatas bravas' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Aubergine & hummus grills' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Aubergine & hummus grills' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Aubergine & hummus grills' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Aubergine & hummus grills' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Aubergine couscous salad' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Aubergine couscous salad' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Aubergine couscous salad' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Aubergine couscous salad' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Avocado dip with new potatoes' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Avocado dip with new potatoes' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Avocado dip with new potatoes' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Avocado dip with new potatoes' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Baingan Bharta' LIMIT 1), 'Spice Level', '["Mild","Medium","Hot","Extra Hot"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Baingan Bharta' AND df.name='Spice Level');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Baingan Bharta' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Baingan Bharta' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Bread omelette' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Bread omelette' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Breakfast Potatoes' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Breakfast Potatoes' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Dutch poffertjes (mini pancakes)' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Dutch poffertjes (mini pancakes)' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='English Breakfast' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='English Breakfast' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Flija Layered Pancake / Crepe' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Flija Layered Pancake / Crepe' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Æbleskiver' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Æbleskiver' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Æbleskiver' LIMIT 1), 'Add-ons', '["None","Ice Cream","Extra Sauce"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Æbleskiver' AND df.name='Add-ons');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Alfajores' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Alfajores' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Alfajores' LIMIT 1), 'Add-ons', '["None","Ice Cream","Extra Sauce"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Alfajores' AND df.name='Add-ons');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Anzac biscuits' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Anzac biscuits' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Anzac biscuits' LIMIT 1), 'Add-ons', '["None","Ice Cream","Extra Sauce"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Anzac biscuits' AND df.name='Add-ons');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Apam balik' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Apam balik' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Apam balik' LIMIT 1), 'Add-ons', '["None","Ice Cream","Extra Sauce"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Apam balik' AND df.name='Add-ons');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Apple & Blackberry Crumble' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Apple & Blackberry Crumble' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Apple & Blackberry Crumble' LIMIT 1), 'Add-ons', '["None","Ice Cream","Extra Sauce"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Apple & Blackberry Crumble' AND df.name='Add-ons');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Apple cake' LIMIT 1), 'Portion', '["Regular","Large"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Apple cake' AND df.name='Portion');
INSERT INTO dish_flavor (dish_id, name, value)
SELECT (SELECT id FROM dish WHERE name='Apple cake' LIMIT 1), 'Add-ons', '["None","Ice Cream","Extra Sauce"]' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM dish_flavor df JOIN dish d ON df.dish_id=d.id WHERE d.name='Apple cake' AND df.name='Add-ons');

-- Combo (setmeal) category
INSERT INTO category (type, name, sort, status, create_time, update_time, create_user, update_user)
SELECT 2, 'Combo Meals', 30, 1, NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM category WHERE name='Combo Meals');

-- Setmeals
INSERT INTO setmeal (category_id, name, price, status, description, image, create_time, update_time, create_user, update_user)
SELECT (SELECT id FROM category WHERE name='Combo Meals' LIMIT 1), 'Family Feast Combo', 32.27, 1, 'Two mains, a starter and a dessert for the whole family.', 'https://www.themealdb.com/images/media/meals/020z181619788503.jpg', NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM setmeal WHERE name='Family Feast Combo');
INSERT INTO setmeal_dish (setmeal_id, dish_id, name, price, copies)
SELECT (SELECT id FROM setmeal WHERE name='Family Feast Combo' LIMIT 1), (SELECT id FROM dish WHERE name='Ayam Percik' LIMIT 1), 'Ayam Percik', 11.99, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM setmeal_dish sd JOIN setmeal s ON sd.setmeal_id=s.id WHERE s.name='Family Feast Combo' AND sd.name='Ayam Percik');
INSERT INTO setmeal_dish (setmeal_id, dish_id, name, price, copies)
SELECT (SELECT id FROM setmeal WHERE name='Family Feast Combo' LIMIT 1), (SELECT id FROM dish WHERE name='Algerian Kefta (Meatballs)' LIMIT 1), 'Algerian Kefta (Meatballs)', 14.99, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM setmeal_dish sd JOIN setmeal s ON sd.setmeal_id=s.id WHERE s.name='Family Feast Combo' AND sd.name='Algerian Kefta (Meatballs)');
INSERT INTO setmeal_dish (setmeal_id, dish_id, name, price, copies)
SELECT (SELECT id FROM setmeal WHERE name='Family Feast Combo' LIMIT 1), (SELECT id FROM dish WHERE name='Ajo blanco' LIMIT 1), 'Ajo blanco', 5.99, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM setmeal_dish sd JOIN setmeal s ON sd.setmeal_id=s.id WHERE s.name='Family Feast Combo' AND sd.name='Ajo blanco');
INSERT INTO setmeal_dish (setmeal_id, dish_id, name, price, copies)
SELECT (SELECT id FROM setmeal WHERE name='Family Feast Combo' LIMIT 1), (SELECT id FROM dish WHERE name='Æbleskiver' LIMIT 1), 'Æbleskiver', 4.99, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM setmeal_dish sd JOIN setmeal s ON sd.setmeal_id=s.id WHERE s.name='Family Feast Combo' AND sd.name='Æbleskiver');
INSERT INTO setmeal (category_id, name, price, status, description, image, create_time, update_time, create_user, update_user)
SELECT (SELECT id FROM category WHERE name='Combo Meals' LIMIT 1), 'Lunch Special Combo', 18.67, 1, 'A quick pasta lunch with a starter and a sweet finish.', 'https://www.themealdb.com/images/media/meals/usywpp1511189717.jpg', NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM setmeal WHERE name='Lunch Special Combo');
INSERT INTO setmeal_dish (setmeal_id, dish_id, name, price, copies)
SELECT (SELECT id FROM setmeal WHERE name='Lunch Special Combo' LIMIT 1), (SELECT id FROM dish WHERE name='Chilli prawn linguine' LIMIT 1), 'Chilli prawn linguine', 10.99, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM setmeal_dish sd JOIN setmeal s ON sd.setmeal_id=s.id WHERE s.name='Lunch Special Combo' AND sd.name='Chilli prawn linguine');
INSERT INTO setmeal_dish (setmeal_id, dish_id, name, price, copies)
SELECT (SELECT id FROM setmeal WHERE name='Lunch Special Combo' LIMIT 1), (SELECT id FROM dish WHERE name='Ajo blanco' LIMIT 1), 'Ajo blanco', 5.99, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM setmeal_dish sd JOIN setmeal s ON sd.setmeal_id=s.id WHERE s.name='Lunch Special Combo' AND sd.name='Ajo blanco');
INSERT INTO setmeal_dish (setmeal_id, dish_id, name, price, copies)
SELECT (SELECT id FROM setmeal WHERE name='Lunch Special Combo' LIMIT 1), (SELECT id FROM dish WHERE name='Æbleskiver' LIMIT 1), 'Æbleskiver', 4.99, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM setmeal_dish sd JOIN setmeal s ON sd.setmeal_id=s.id WHERE s.name='Lunch Special Combo' AND sd.name='Æbleskiver');
INSERT INTO setmeal (category_id, name, price, status, description, image, create_time, update_time, create_user, update_user)
SELECT (SELECT id FROM category WHERE name='Combo Meals' LIMIT 1), 'Seafood Lovers Combo', 16.98, 1, 'A seafood main paired with a fresh starter.', 'https://www.themealdb.com/images/media/meals/jc6oub1763196663.jpg', NOW(), NOW(), 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM setmeal WHERE name='Seafood Lovers Combo');
INSERT INTO setmeal_dish (setmeal_id, dish_id, name, price, copies)
SELECT (SELECT id FROM setmeal WHERE name='Seafood Lovers Combo' LIMIT 1), (SELECT id FROM dish WHERE name='Arroz con gambas y calamar' LIMIT 1), 'Arroz con gambas y calamar', 13.99, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM setmeal_dish sd JOIN setmeal s ON sd.setmeal_id=s.id WHERE s.name='Seafood Lovers Combo' AND sd.name='Arroz con gambas y calamar');
INSERT INTO setmeal_dish (setmeal_id, dish_id, name, price, copies)
SELECT (SELECT id FROM setmeal WHERE name='Seafood Lovers Combo' LIMIT 1), (SELECT id FROM dish WHERE name='Ajo blanco' LIMIT 1), 'Ajo blanco', 5.99, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM setmeal_dish sd JOIN setmeal s ON sd.setmeal_id=s.id WHERE s.name='Seafood Lovers Combo' AND sd.name='Ajo blanco');

