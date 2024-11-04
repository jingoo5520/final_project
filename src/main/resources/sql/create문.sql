# create문

CREATE TABLE `guests` (
  `guest_id` VARCHAR(15) NOT NULL,
  `guest_name` VARCHAR(8) NOT NULL,
  `guest_email` INT NOT NULL,
  `guest_phone_number` INT NOT NULL,
  PRIMARY KEY (`guest_id`),
  UNIQUE INDEX `guest_id_UNIQUE` (`guest_id` ASC))
COMMENT = '비회원 정보를 관리하는 테이블';

CREATE TABLE `delivery_addrs` (
  `delivery_no` INT NOT NULL AUTO_INCREMENT,
  `delivery_name` VARCHAR(8) NULL,
  `delivery_address` VARCHAR(100) NULL,
  `is_main` ENUM('M', 'S') NULL,
  `member_id` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`delivery_no`),
  UNIQUE INDEX `delivery_no_UNIQUE` (`delivery_no` ASC),
  INDEX `members_member_id_fk_idx` (`member_id` ASC),
  CONSTRAINT `members_member_id_fk`
    FOREIGN KEY (`member_id`)
    REFERENCES `members` (`member_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
COMMENT = '회원의 배송지 정보를 저장하는 테이블';

CREATE TABLE `carts` (
  `cart_no` INT NOT NULL AUTO_INCREMENT,
  `member_id` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`cart_no`),
  UNIQUE INDEX `cart_no_UNIQUE` (`cart_no` ASC),
  INDEX `members_member_id_fk_idx` (`member_id` ASC),
  CONSTRAINT `carts_member_id_fk`
    FOREIGN KEY (`member_id`)
    REFERENCES `members` (`member_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
COMMENT = '장바구니 정보를 관리하는 테이블';

CREATE TABLE `cart_items` (
  `cart_item_no` INT NOT NULL AUTO_INCREMENT,
  `cart_no` INT NOT NULL,
  `product_no` INT NOT NULL,
  `product_count` INT NOT NULL,
  PRIMARY KEY (`cart_item_no`),
  UNIQUE INDEX `cart_item_no_UNIQUE` (`cart_item_no` ASC),
  INDEX `cart_items_cart_no_fk_idx` (`cart_no` ASC),
  INDEX `cart_items_product_no_fk_idx` (`product_no` ASC),
  CONSTRAINT `cart_items_cart_no_fk`
    FOREIGN KEY (`cart_no`)
    REFERENCES `carts` (`cart_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cart_items_product_no_fk`
    FOREIGN KEY (`product_no`)
    REFERENCES `products` (`product_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
COMMENT = '장바구니 상품 목록을 관리하는 테이블';

CREATE TABLE `wishes` (
  `wish_no` INT NOT NULL AUTO_INCREMENT,
  `member_id` VARCHAR(15) NOT NULL,
  `product_no` INT NOT NULL,
  `wish_status` CHAR(1) NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`wish_no`),
  UNIQUE INDEX `wish_no_UNIQUE` (`wish_no` ASC),
  INDEX `wishes_member_id_fk_idx` (`member_id` ASC),
  INDEX `wishes_product_no_fk_idx` (`product_no` ASC),
  CONSTRAINT `wishes_member_id_fk`
    FOREIGN KEY (`member_id`)
    REFERENCES `members` (`member_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `wishes_product_no_fk`
    FOREIGN KEY (`product_no`)
    REFERENCES `products` (`product_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
COMMENT = '찜 정보를 관리하는 테이블';

CREATE TABLE `coupons` (
  `coupon_no` INT NOT NULL AUTO_INCREMENT,
  `coupon_name` VARCHAR(50) NOT NULL,
  `coupon_dc_type` ENUM('A', 'R') NOT NULL,
  `coupon_dc_amount` INT NULL,
  `coupon_dc_rate` FLOAT NULL,
  PRIMARY KEY (`coupon_no`),
  UNIQUE INDEX `coupon_no_UNIQUE` (`coupon_no` ASC))
COMMENT = '쿠폰을 관리하는 테이블';

CREATE TABLE `coupon_paid` (
  `coupon_paid_no` INT NOT NULL AUTO_INCREMENT,
  `coupon_no` INT NULL,
  `coupon_code` VARCHAR(20) NULL,
  `member` VARCHAR(15) NULL,
  `pay_date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `expire_date` DATETIME NULL,
  PRIMARY KEY (`coupon_paid_no`),
  UNIQUE INDEX `coupon_paid_no_UNIQUE` (`coupon_paid_no` ASC),
  UNIQUE INDEX `coupon_code_UNIQUE` (`coupon_code` ASC),
  INDEX `coupon_paid_coupon_no_fk_idx` (`coupon_no` ASC),
  CONSTRAINT `coupon_paid_coupon_no_fk`
    FOREIGN KEY (`coupon_no`)
    REFERENCES `coupons` (`coupon_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
COMMENT = '쿠폰 지급 내역을 관리하는 테이블';

CREATE TABLE `coupon_used` (
  `coupon_use_no` INT NOT NULL AUTO_INCREMENT,
  `member_id` VARCHAR(15) NOT NULL,
  `coupon_code` VARCHAR(20) NOT NULL,
  `use_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`coupon_use_no`),
  INDEX `coupon_used_member_id_fk_idx` (`member_id` ASC),
  INDEX `coupon_used_coupon_code_fk_idx` (`coupon_code` ASC),
  CONSTRAINT `coupon_used_member_id_fk`
    FOREIGN KEY (`member_id`)
    REFERENCES `members` (`member_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `coupon_used_coupon_code_fk`
    FOREIGN KEY (`coupon_code`)
    REFERENCES `coupon_paid` (`coupon_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
COMMENT = '쿠폰 사용 내역을 관리하는 테이블';

CREATE TABLE `orders` (
  `order_no` INT NOT NULL AUTO_INCREMENT,
  `orderer_id` VARCHAR(15) NOT NULL,
  `coupon_no` INT NULL,
  `level_dc_rate` FLOAT NULL,
  `level_dc_amount` INT NULL,
  `use_point` INT NULL,
  `order_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `withdraw_possible` CHAR(1) NOT NULL DEFAULT 'Y',
  `order_delivery` VARCHAR(255) NOT NULL,
  `deliver_cost` INT NULL,
  `order_status` ENUM('1', '2', '3', '4', '5', '6') NOT NULL DEFAULT '1',
  `order_request` VARCHAR(100) NULL,
  `cs_status` ENUM('C', 'T', 'D') NULL,
  PRIMARY KEY (`order_no`),
  UNIQUE INDEX `order_no_UNIQUE` (`order_no` ASC),
  INDEX `orders_coupon_no_fk_idx` (`coupon_no` ASC),
  CONSTRAINT `orders_coupon_no_fk`
    FOREIGN KEY (`coupon_no`)
    REFERENCES `coupons` (`coupon_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
COMMENT = '주문 정보를 관리하는 테이블';

CREATE TABLE `order_products` (
  `orderproduct_no` INT NOT NULL AUTO_INCREMENT,
  `order_no` INT NOT NULL,
  `product_no` INT NOT NULL,
  `product_dc_rate` FLOAT NULL,
  `product_dc_amount` INT NULL,
  `order_count` INT NOT NULL,
  `order_price` INT NOT NULL,
  PRIMARY KEY (`orderproduct_no`),
  UNIQUE INDEX `orderproduct_no_UNIQUE` (`orderproduct_no` ASC),
  INDEX `order_products_order_no_fk_idx` (`order_no` ASC),
  INDEX `order_products_product_no_fk_idx` (`product_no` ASC),
  CONSTRAINT `order_products_order_no_fk`
    FOREIGN KEY (`order_no`)
    REFERENCES `orders` (`order_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `order_products_product_no_fk`
    FOREIGN KEY (`product_no`)
    REFERENCES `products` (`product_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
COMMENT = '주문 상품 목록을 관리하는 테이블';

CREATE TABLE `point_infos` (
  `point_code` INT NOT NULL,
  `point_reason` VARCHAR(50) NOT NULL,
  `point_amount` INT NOT NULL,
  PRIMARY KEY (`point_code`))
COMMENT = '포인트 지급 방법을 관리하는 테이블';

CREATE TABLE `point_used` (
  `point_used_no` INT NOT NULL AUTO_INCREMENT,
  `member_id` VARCHAR(15) NOT NULL,
  `use_point` INT NOT NULL,
  `point_used_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`point_used_no`),
  INDEX `point_used_member_id_fk_idx` (`member_id` ASC),
  CONSTRAINT `point_used_member_id_fk`
    FOREIGN KEY (`member_id`)
    REFERENCES `members` (`member_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
COMMENT = '포인트 사용내역을 관리하는 테이블';

CREATE TABLE `point_earned` (
  `point_earned_no` INT NOT NULL AUTO_INCREMENT,
  `member_id` VARCHAR(15) NOT NULL,
  `earned_point` INT NOT NULL,
  `point_code` INT NOT NULL,
  `point_earned_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`point_earned_no`),
  INDEX `point_earned_point_code_fk_idx` (`point_code` ASC),
  INDEX `point_earned_member_id_fk_idx` (`member_id` ASC),
  CONSTRAINT `point_earned_member_id_fk`
    FOREIGN KEY (`member_id`)
    REFERENCES `members` (`member_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `point_earned_point_code_fk`
    FOREIGN KEY (`point_code`)
    REFERENCES `point_infos` (`point_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
COMMENT = '포인트 적립내역을 관리하는 테이블';