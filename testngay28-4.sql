-- phần 2 
USE SalesManagement ;
DROP TABLE IF EXISTS product ;
DROP TABLE IF EXISTS customer ;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS  order_detail;

CREATE TABLE product(
		product_id VARCHAR(255) NOT NULL UNIQUE PRIMARY KEY ,
        product_name VARCHAR(255) NOT NULL ,
        stock INT NOT NULL CHECK(stock >= 0 ) ,
        manufacturer VARCHAR(255) NOT NULL ,
        price DECIMAL(19,4) NOT NULL check(price > 0 )
        
);

CREATE TABLE customer(
		customer_id VARCHAR(255) NOT NULL UNIQUE PRIMARY KEY ,
        full_name VARCHAR(255) NOT NULL ,
        email VARCHAR(100) NOT NULL UNIQUE ,
        phone_number VARCHAR(15) NOT NULL UNIQUE ,
        address VARCHAR(255) NOT NULL ,
        order_id VARCHAR(255) NOT NULL UNIQUE ,
        FOREIGN KEY (order_id) REFERENCES orders(order_id) 
        
        
);


CREATE TABLE orders(
		order_id VARCHAR(255) NOT NULL UNIQUE PRIMARY KEY ,
        order_date DATE DEFAULT (current_date) ,
        total_amount DECIMAL(19,4) NOT NULL CHECK(total_amount > 0 ) ,
        FOREIGN KEY (product_id) REFERENCES product(product_id)
		
);


CREATE TABLE order_detail(
		quantity_purchased MIDDLEINT NOT NULL CHECK(quantity_purchased > 0) ,
        sell_price INT NOT NULL CHECK( sell_price > 0 ) ,
        product_id VARCHAR(255) NOT NULL UNIQUE ,
        FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

ALTER TABLE orders ADD note VARCHAR(255) DEFAULT ' không có ghi chú ' ;
ALTER TABLE product CHANGE COLUMN manufacturer producer VARCHAR(255) NOT NULL ;


DROP TABLE orders ;
DROP TABLE order_detail ;

-- phần 3 

