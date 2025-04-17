-- 1. 사용자 (User)
CREATE TABLE User (
    user_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL UNIQUE,
    address TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. 음식점 (Restaurant)
CREATE TABLE Restaurant (
    restaurant_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    location TEXT NOT NULL,
    business_hours VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. 메뉴 (Menu)
CREATE TABLE Menu (
    menu_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    restaurant_id BIGINT NOT NULL,
    name VARCHAR(100) NOT NULL,
    price INT NOT NULL,
    description TEXT,
    FOREIGN KEY (restaurant_id) REFERENCES Restaurant(restaurant_id)
);

-- 4. 라이더 (Rider)
CREATE TABLE Rider (
    rider_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    status ENUM('대기 중', '픽업 완료', '배달 중') DEFAULT '대기 중',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. 주문 (Order)
CREATE TABLE `Order` (
    order_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    rider_id BIGINT,
    order_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total_price INT NOT NULL,
    status ENUM('준비 중', '배달 중', '배달 완료', '주문 취소') DEFAULT '준비 중',
    delivery_address TEXT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (rider_id) REFERENCES Rider(rider_id)
);

-- 6. 주문 상세 (OrderItem)
CREATE TABLE OrderItem (
    order_item_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    order_id BIGINT NOT NULL,
    menu_id BIGINT NOT NULL,
    menu_name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    unit_price INT NOT NULL,
    total_price INT NOT NULL,
    option_text VARCHAR(255),
    FOREIGN KEY (order_id) REFERENCES `Order`(order_id),
    FOREIGN KEY (menu_id) REFERENCES Menu(menu_id)
);

-- 7. 결제 (Payment)
CREATE TABLE Payment (
    payment_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    order_id BIGINT UNIQUE NOT NULL,
    user_id BIGINT NOT NULL,
    payment_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    method ENUM('카드', '간편결제', '현금') NOT NULL,
    amount INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES `Order`(order_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);
