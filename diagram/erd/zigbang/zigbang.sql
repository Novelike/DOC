CREATE TABLE User (
    user_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Region (
    region_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    sido VARCHAR(50),
    sigungu VARCHAR(50),
    dong VARCHAR(50)
);

CREATE TABLE Realtor (
    realtor_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    office_name VARCHAR(100),
    agent_name VARCHAR(50),
    phone VARCHAR(20),
    license_number VARCHAR(50),
    office_address VARCHAR(255)
);

CREATE TABLE Property (
    property_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    realtor_id BIGINT NOT NULL,
    region_id BIGINT NOT NULL,
    title VARCHAR(100) NOT NULL,
    type VARCHAR(50) NOT NULL,
    price VARCHAR(100),
    size FLOAT,
    address VARCHAR(255),
    description TEXT,
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (realtor_id) REFERENCES Realtor(realtor_id),
    FOREIGN KEY (region_id) REFERENCES Region(region_id)
);

CREATE TABLE Favorite (
    favorite_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    property_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (property_id) REFERENCES Property(property_id)
);

CREATE TABLE Inquiry (
    inquiry_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    property_id BIGINT NOT NULL,
    content TEXT,
    inquiry_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    reply TEXT,
    visit_schedule DATETIME,
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (property_id) REFERENCES Property(property_id)
);

CREATE TABLE Reservation (
    reservation_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    property_id BIGINT NOT NULL,
    requested_time DATETIME,
    status VARCHAR(20) DEFAULT '요청',
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (property_id) REFERENCES Property(property_id)
);
