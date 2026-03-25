-- Active: 1774441088564@@127.0.0.1@3306@coffee_base
-- @BLOCK
CREATE TABLE coffee_bean(                           
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    origin VARCHAR(100),
    roast_level INT NOT NULL CHECK (roast_level BETWEEN 1 AND 5),
    flavor_notes TEXT,
    extra_price DECIMAL(10,2) DEFAULT 0.00,
    image_url VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE
);--פולי קפה לבחירה בעת ביצוע הזמנה


-- @BLOCK
CREATE TABLE milk_type(                             
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    image_url VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE
);--סוג חלב לבחירה בעת ביצוע הזמנה


-- @BLOCK
CREATE TABLE ingredient(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    unit_of_measure ENUM('ML', 'GRAM', 'UNIT')
);--רשימת המרכיבים באופן כללי


-- @BLOCK
CREATE TABLE product(
    id INT PRIMARY KEY AUTO_INCREMENT,
    category ENUM('COFFEE', 'BAKERY', 'DRINKS') NOT NULL,
    name VARCHAR(255),
    price DECIMAL(10, 2) NOT NULL CHECK (price > 0),
    default_bean_id INT,
    is_seasonal BOOLEAN DEFAULT FALSE,
    description TEXT,
    image_url VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (default_bean_id) REFERENCES coffee_bean(id) ON DELETE SET NULL
);--מוצר שקיים להזמנה


-- @BLOCK
CREATE TABLE product_ingredient(
    product_id INT,
    ingredient_id INT,
    amount INT,
    PRIMARY KEY (product_id, ingredient_id),
    FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES ingredient(id) ON DELETE CASCADE
);--רשימת המרכיבים לכל מוצר


-- @BLOCK
CREATE TABLE user(
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) NOT NULL UNIQUE CHECK (email LIKE '%@%.%'),
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('ADMIN', 'CUSTOMER') DEFAULT 'CUSTOMER',
    total_orders INT DEFAULT 0,
    is_military_reserve BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);--פרטי המשתמשים/מנהלים באתר


-- @BLOCK
CREATE TABLE `order`(
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_price DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE
);--פרטי הזמנה טכניים


-- @BLOCK
CREATE TABLE order_item(
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    selected_bean_id INT,
    selected_milk_id INT,
    quantity INT DEFAULT 1,
    price_at_purchase DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES `order`(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (selected_bean_id) REFERENCES coffee_bean(id),
    FOREIGN KEY (selected_milk_id) REFERENCES milk_type(id)
);--פירוט המוצרים בהזמנה
/* הסיבה שלא נעשה שימוש במפתח מורכב 
(order_id, product_id) 
היא כדי לספק גמישות גבוהה יותר במקרה הצורך,
אם לקוח ירצה בהזמנה אחת 
(אותו order_id)
 להזמין שני פריטים 
(אותו product_id)
אבל שיש במוצרים שוני מסוים ( לדוגמה -  [1] לאטה{חלב רגיל}  [2] לאטה{חלב סויה} ) 
לא נרצה שהמפתח הראשי יחסום את ההוספה של השורה הנוספת כמקרה כפילות
*/


-- @BLOCK
CREATE TABLE sticker(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    required_orders INT,
    special_event VARCHAR(100),
    image_url VARCHAR(255)
);--פרטים על כל מדבקה


-- @BLOCK
CREATE TABLE user_sticker(
    user_id INT,
    sticker_id INT,
    earned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, sticker_id),
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
    FOREIGN KEY (sticker_id) REFERENCES sticker(id) ON DELETE CASCADE
);--רשימת המדבקות לכל משתמש


-- @BLOCK
CREATE TABLE announcement(
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);--הודעות לקהל


-- @BLOCK
INSERT INTO coffee_bean (name, origin, roast_level, flavor_notes, extra_price)
VALUES 
('Floral Sunrise', 'Ethiopia', 1, 'Jasmine, Peach, Citrus', 3.00),    
('Central Park', 'Colombia', 2, 'Milk Chocolate, Apple', 0.00),      
('House Blend', 'Brazil', 3, 'Caramel, Toasted Nut', 0.00),          
('Italian Roast', 'Italy', 4, 'Dark Chocolate, Smoke', 1.50),        
('Midnight Express', 'Sumatra', 5, 'Molasses, Tobacco, Heavy', 2.00);


-- @BLOCK
INSERT INTO milk_type(name)
VALUES
('cow milk'),
('oat milk'),
('soy milk'),
('almond milk'),
('rice milk');


-- @BLOCK
INSERT INTO ingredient (name, unit_of_measure)
VALUES
('espresso shot', 'UNIT'),
('milk', 'ML'),
('foamd milk', 'ML'),
('water', 'ML'),
('cinamon dust', 'GRAM'),
('vanilla syrup', 'ML'),
('caramel', 'ML'),
('walnuts', 'GRAM'),
('coco powder', 'GRAM'),
('chocolate', 'GRAM');

-- @BLOCK
INSERT INTO product (category, name, description, price, default_bean_id)
VALUES
('COFFEE', 'espresso', 'pure caffeine injection', 9, 2),
('COFFEE', 'latte', 'nice creamy latte made with milk of your choise, love and cache invalidation', 15, 3),
('COFFEE', 'americano', 'lighter and fancier then your old "HAZAK"', 12, 4),
('COFFEE', 'macchiato', 'basically mini Latte', 13, 1);

-- @BLOCK
INSERT INTO product_ingredient (product_id, ingredient_id, amount)
VALUES 
-- espresso: 1 shot
(1, 1, 1), 
-- latte: 1 shot, 150ml milk, 50ml foam
(2, 1, 1), (2, 2, 150), (2, 3, 50),
-- americano: 2 shots, 200ml water
(3, 1, 2), (3, 4, 200),
-- macchiato: 1 shot, 20ml foam
(4, 1, 1), (4, 3, 20);




-- @BLOCK
INSERT INTO user (email, password_hash)
VALUES ('wrong_email_format', 'hashed_pass_123');











-- @BLOCK
SELECT * FROM product;
-- ביטול בדיקת מפתחות זרים כדי שנוכל למחוק טבלאות שתלויות אחת בשנייה
SET FOREIGN_KEY_CHECKS = 0;

-- מחיקת כל הטבלאות הקיימות
DROP TABLE IF EXISTS user_sticker;
DROP TABLE IF EXISTS sticker;
DROP TABLE IF EXISTS order_item;
DROP TABLE IF EXISTS `order`;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS product_ingredient;
DROP TABLE IF EXISTS ingredient;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS coffee_bean;
DROP TABLE IF EXISTS announcement;

-- החזרת בדיקת המפתחות הזרים למצב תקין
SET FOREIGN_KEY_CHECKS = 1;