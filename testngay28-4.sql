-- phần 2 
USE SalesManagement ;



DROP TABLE IF EXISTS  order_detail;
DROP TABLE IF EXISTS customer ;

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS product ;



CREATE TABLE product(
		product_id VARCHAR(255) NOT NULL PRIMARY KEY ,
        product_name VARCHAR(255) NOT NULL ,
        stock INT NOT NULL CHECK(stock >= 0 ) ,
        manufacturer VARCHAR(255) NOT NULL ,
        price DECIMAL(19,4) NOT NULL check(price > 0 )
        
);

CREATE TABLE orders(
		order_id VARCHAR(255) NOT NULL PRIMARY KEY ,
        order_date DATE DEFAULT (current_date) ,
        total_amount DECIMAL(19,4) NOT NULL CHECK(total_amount > 0 ) ,
        product_id VARCHAR(255) NOT NULL ,
        address VARCHAR(255) NOT NULL , 
        FOREIGN KEY (product_id) REFERENCES product(product_id)
        
		
);


CREATE TABLE customer(
		customer_id VARCHAR(255) NOT NULL PRIMARY KEY ,
        full_name VARCHAR(255) NOT NULL ,
        email VARCHAR(100) NOT NULL UNIQUE ,
        phone_number VARCHAR(15)  UNIQUE ,
        address VARCHAR(255) NOT NULL ,
        order_id VARCHAR(255) NOT NULL  ,
        FOREIGN KEY (order_id) REFERENCES orders(order_id) 
        
        
);



CREATE TABLE order_detail(
		quantity_purchased MEDIUMINT NOT NULL CHECK(quantity_purchased > 0) ,
        sell_price INT NOT NULL CHECK( sell_price > 0 ) ,
        order_id VARCHAR(255) NOT NULL ,
        FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

ALTER TABLE orders ADD note VARCHAR(255) DEFAULT ' không có ghi chú ' ;
ALTER TABLE product CHANGE COLUMN manufacturer producer VARCHAR(255) NOT NULL ;


-- DROP TABLE orders ;
-- DROP TABLE order_detail ;

-- phần 3 

INSERT INTO product (product_id, product_name, stock, producer, price) VALUES
('P001', 'Laptop Dell XPS 15',     50,  'Apple',    35000000.0000),
('P002', 'Chuột Logitech MX Master', 200, 'Apple', 850000.0000),
('P003', 'Bàn phím Keychron K2',   150, 'Keychron', 1200000.0000),
('P004', 'Màn hình LG 27inch',      80, 'LG',      1500000.0000),
('P005', 'Tai nghe Sony WH-1000XM5',120, 'Sony',   1200000.0000);


INSERT INTO orders (order_id, order_date, total_amount, product_id,address, note) VALUES
('OR001', '2025-01-10', 35000000.0000, 'P001','TPHCM', 'Giao hàng nhanh'),
('OR002', '2025-01-12',   850000.0000, 'P002','Hà Nội', 'Không có ghi chú'),
('OR003', '2025-01-15',  1200000.0000, 'P003','TPHCM', 'Đóng gói kỹ'),
('OR004', '2025-01-18',  7500000.0000, 'P004','Hà Nội', 'Không có ghi chú'),
('OR005', '2025-01-20',  4200000.0000, 'P005','TPHCM', 'Gọi trước khi giao');


INSERT INTO customer (customer_id, full_name, email, phone_number, address, order_id) VALUES
('C001', 'Nguyễn Văn An',   'an.nguyen@gmail.com',   '0901234561', 'TPHCM',         'OR001'),
('C002', 'Trần Thị Bích',   'bich.tran@gmail.com',   '0901234562', 'Hà Nội',      'OR002'),
('C003', 'Lê Minh Châu',    'chau.le@gmail.com',     '0901234563', 'TPHCM',       'OR003'),
('C004', 'Phạm Quốc Dũng',  'dung.pham@gmail.com',   '0901234564', 'Hà Nội',     'OR004'),
('C005', 'Hoàng Thị Emm',   'em.hoang@gmail.com',    '0901234565', 'TPHCM',      'OR005');

INSERT INTO order_detail (quantity_purchased, sell_price, order_id) VALUES
(1,  35000000, 'OR001'),
(2,    425000, 'OR002'),
(3,    400000, 'OR003'),
(1,   7500000, 'OR004'),
(2,   2100000, 'OR005');


UPDATE product 
set price =  price * 1.1 
where producer = "Apple" ;

DELETE FROM customer WHERE phone_number IS NULL ;

-- phần 4 
SELECT * FROM product 
WHERE price BETWEEN 10000000 AND 20000000 ;

SELECT * FROM orders WHERE order_id = "OR001" ;

SELECT order_id , order_date FROM orders WHERE  address = "TPHCM" ;

SELECT o.order_id, o.order_date
FROM orders o
JOIN customer c ON o.customer_id = c.customer_id
WHERE c.address = 'TPHCM';