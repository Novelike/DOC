CREATE TABLE User (
    user_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    ssn VARCHAR(20),
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Account (
    account_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    account_number VARCHAR(30) NOT NULL UNIQUE,
    bank_name VARCHAR(50),
    balance DECIMAL(15, 2) DEFAULT 0,
    opened_at TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

CREATE TABLE Transfer (
    transfer_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    from_account_id BIGINT NOT NULL,
    to_account_id BIGINT NOT NULL,
    amount DECIMAL(15, 2) NOT NULL,
    transfer_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    memo VARCHAR(255),
    status VARCHAR(20) DEFAULT '완료',
    FOREIGN KEY (from_account_id) REFERENCES Account(account_id),
    FOREIGN KEY (to_account_id) REFERENCES Account(account_id)
);

CREATE TABLE FinancialProduct (
    product_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    type VARCHAR(50),
    min_invest_amount DECIMAL(15, 2),
    interest_rate FLOAT,
    duration_month INT,
    status VARCHAR(20)
);

CREATE TABLE Subscription (
    subscription_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    subscribed_at TIMESTAMP,
    amount DECIMAL(15, 2),
    expected_return_rate FLOAT,
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (product_id) REFERENCES FinancialProduct(product_id)
);
