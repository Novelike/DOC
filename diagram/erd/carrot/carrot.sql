CREATE TABLE User (
    user_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    profile_image VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Region (
    region_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    sido VARCHAR(50),
    sigungu VARCHAR(50),
    dong VARCHAR(50)
);

CREATE TABLE UserRegion (
    user_region_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    region_id BIGINT NOT NULL,
    is_certified BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE,
    FOREIGN KEY (region_id) REFERENCES Region(region_id) ON DELETE CASCADE
);

CREATE TABLE Item (
    item_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    title VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price INT NOT NULL,
    description TEXT,
    status ENUM('판매 중', '예약 중', '거래 완료') DEFAULT '판매 중',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE
);

CREATE TABLE ChatRoom (
    chat_room_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    item_id BIGINT NOT NULL,
    buyer_id BIGINT NOT NULL,
    seller_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (item_id) REFERENCES Item(item_id) ON DELETE CASCADE,
    FOREIGN KEY (buyer_id) REFERENCES User(user_id) ON DELETE CASCADE,
    FOREIGN KEY (seller_id) REFERENCES User(user_id) ON DELETE CASCADE
);

CREATE TABLE ChatMessage (
    message_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    chat_room_id BIGINT NOT NULL,
    sender_id BIGINT NOT NULL,
    content TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (chat_room_id) REFERENCES ChatRoom(chat_room_id) ON DELETE CASCADE,
    FOREIGN KEY (sender_id) REFERENCES User(user_id) ON DELETE CASCADE
);

CREATE TABLE Deal (
    deal_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    item_id BIGINT NOT NULL UNIQUE,
    buyer_id BIGINT NOT NULL,
    deal_price INT NOT NULL,
    deal_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    deal_location VARCHAR(255),
    status ENUM('거래 완료', '취소됨') DEFAULT '거래 완료',
    FOREIGN KEY (item_id) REFERENCES Item(item_id) ON DELETE CASCADE,
    FOREIGN KEY (buyer_id) REFERENCES User(user_id) ON DELETE CASCADE
);

CREATE TABLE Review (
    review_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    deal_id BIGINT NOT NULL UNIQUE,
    writer_id BIGINT NOT NULL,
    receiver_id BIGINT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    content TEXT,
    written_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (deal_id) REFERENCES Deal(deal_id) ON DELETE CASCADE,
    FOREIGN KEY (writer_id) REFERENCES User(user_id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES User(user_id) ON DELETE CASCADE
);