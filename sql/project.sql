CREATE TABLE levels (
    level_no INT NOT NULL AUTO_INCREMENT PRIMARY KEY,    -- 등급 번호
    level_name VARCHAR(8),                     			 -- 등급 이름
    level_min INT,                             			 -- 사용 금액 최소값
    level_max INT,                                       -- 사용 금액 최대값
    level_dc FLOAT,                                      -- 등급별 할인율
    level_point FLOAT,                                   -- 등급별 적립포인트
    UNIQUE (level_no)                                    -- 등급 번호는 고유
);

insert into levels values(
'1', 'bronze', '0', '50', '0', '0.01');
insert into levels values(
'2', 'silver', '50', '100', '0', '0.02');
insert into levels values(
'3', 'gold', '100', '200', '0.02', '0.05');
insert into levels values(
'4', 'diamond', '200', null, 0.05, '0.05');

CREATE TABLE members (
    member_id VARCHAR(15) NOT NULL PRIMARY KEY,          -- 회원 ID
    member_name VARCHAR(8) NOT NULL,                     -- 회원 이름
    member_pwd VARCHAR(64) NOT NULL,                     -- 회원 비밀번호
    phone_number VARCHAR(13),                             -- 회원 휴대전화번호
    birthday INT,                                         -- 회원 생년월일
    gender ENUM('M', 'F', 'N'),                           -- 회원 성별
    email VARCHAR(45),                                   -- 회원 이메일주소
    address VARCHAR(255),                                 -- 회원 주소
    member_point INT DEFAULT 0,                          -- 회원 포인트
    member_level INT,                                     -- 회원 등급
    reg_date DATETIME DEFAULT NOW(),                      -- 회원 가입일
    member_status VARCHAR(15) DEFAULT 'active',          -- 회원 상태
    nickname VARCHAR(15),                                 -- 회원 닉네임
    member_image VARCHAR(255) DEFAULT 'no_image.png',   -- 회원 이미지
    member_price INT DEFAULT 0,                          -- 회원 금액
    is_admin ENUM('0', '1', '9') DEFAULT '0',           -- 회원 구분
    FOREIGN KEY (member_level) REFERENCES levels(level_no) -- 외래키 제약조건
);

CREATE TABLE categories (
    category_no INT NOT NULL AUTO_INCREMENT,
    category_name VARCHAR(100),
    PRIMARY KEY (category_no)
);

CREATE TABLE products (
    product_no INT NOT NULL AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL,
    product_stock_count INT NOT NULL DEFAULT 0,
    product_price INT NOT NULL,
    product_dc_type ENUM('P', 'M'),
    dc_rate FLOAT,
    dc_amount INT,
    product_sell_count INT NOT NULL DEFAULT 0,
    product_content VARCHAR(1000),
    product_like INT NOT NULL DEFAULT 0,
    product_reg_date DATETIME NOT NULL DEFAULT now(),
    product_category INT NOT NULL,
    product_cost INT NOT NULL DEFAULT 0,
    product_delete CHAR(1) NOT NULL DEFAULT 'N',
    product_show CHAR(1) NOT NULL DEFAULT 'N',
    PRIMARY KEY (product_no),
    UNIQUE (product_no),
    CONSTRAINT categories_category_no_fk FOREIGN KEY (product_category) REFERENCES categories(category_no)
);

CREATE TABLE product_images (
    image_no INT NOT NULL AUTO_INCREMENT,
    product_no INT NOT NULL,
    image_main_url VARCHAR(255) DEFAULT 'noP_image.png',
    image_sub_url VARCHAR(255) DEFAULT 'noP_image.png',
    PRIMARY KEY (image_no),
    UNIQUE (image_no),
    CONSTRAINT producs_product_no_fk FOREIGN KEY (product_no) REFERENCES products(product_no)
);

insert into categories (category_no, category_name) VALUES
(196, 'nacklace'),
(195, 'earring'),
(203, 'piercing'),
(197, 'bangle'),
(201, 'anklet'),
(198, 'ring'),
(200, 'coupling'),
(202, 'pendant'),
(204, 'etc');

CREATE TABLE carts (
    cart_no INT AUTO_INCREMENT PRIMARY KEY,
    member_id VARCHAR(15),
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE
);

CREATE TABLE wishes (
    wish_no INT AUTO_INCREMENT PRIMARY KEY,
    member_id VARCHAR(20),
    product_no INT,
    wish_status CHAR(1),
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
    FOREIGN KEY (product_no) REFERENCES products(product_no) ON DELETE CASCADE
);

CREATE TABLE cartlists (
    cartlist_no INT AUTO_INCREMENT PRIMARY KEY,
    cart_no INT,
    member_id VARCHAR(15),
    product_no INT,
    product_count INT DEFAULT 1,
    FOREIGN KEY (cart_no) REFERENCES carts(cart_no) ON DELETE CASCADE,
    FOREIGN KEY (product_no) REFERENCES products(product_no) ON DELETE CASCADE
);

CREATE TABLE `coupons` (
  `coupon_no` INT NOT NULL AUTO_INCREMENT,
  `coupon_name` VARCHAR(50) NOT NULL,
  `coupon_dc_type` ENUM('P', 'M') NOT NULL,
  `coupon_dc_amount` INT NULL,
  `coupon_dc_rate` FLOAT NULL,
  PRIMARY KEY (`coupon_no`),
  UNIQUE INDEX `coupon_no_UNIQUE` (`coupon_no` ASC) VISIBLE)
COMMENT = '쿠폰을 관리하는 테이블';

CREATE TABLE `coupon_paid` (
  `coupon_paid_no` INT NOT NULL AUTO_INCREMENT,
  `coupon_no` INT NOT NULL,
  `coupon_code` VARCHAR(20) NOT NULL,
  `member` VARCHAR(15) NOT NULL,
  `pay_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expire_date` DATETIME NOT NULL,
  PRIMARY KEY (`coupon_paid_no`),
  UNIQUE INDEX `coupon_paid_no_UNIQUE` (`coupon_paid_no` ASC) VISIBLE,
  UNIQUE INDEX `coupon_code_UNIQUE` (`coupon_code` ASC) VISIBLE, -- coupon_code에 UNIQUE 제약 추가
  INDEX `coupons_coupon_name_fk_idx` (`coupon_no` ASC) VISIBLE,
  CONSTRAINT `coupons_coupon_no_fk`
    FOREIGN KEY (`coupon_no`)
    REFERENCES `jyw`.`coupons` (`coupon_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
COMMENT = '쿠폰 지급 내역을 관리하는 테이블';

CREATE TABLE `jyw`.`coupon_used` (
  `coupon_use_no` INT NOT NULL AUTO_INCREMENT,
  `member_id` VARCHAR(15) NULL,
  `coupon_code` VARCHAR(20) NULL,
  `use_date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`coupon_use_no`),
  UNIQUE INDEX `coupon_use_no_UNIQUE` (`coupon_use_no` ASC) VISIBLE,
  INDEX `coupon_paid_coupon_code_fk_idx` (`coupon_code` ASC) VISIBLE,
  INDEX `members_member_id_fk_idx` (`member_id` ASC) VISIBLE,
  CONSTRAINT `coupon_paid_coupon_code_fk`
    FOREIGN KEY (`coupon_code`)
    REFERENCES `jyw`.`coupon_paid` (`coupon_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `members_member_id_fk`
    FOREIGN KEY (`member_id`)
    REFERENCES `jyw`.`members` (`member_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
COMMENT = '쿠폰 사용 내역을 관리하는 테이블';

insert into members (member_id, member_name, member_pwd, phone_number, email, address, nickname) 
values('test', '테스트', sha2('1234', 256), '010-0101-9999', 'test1234@abc.abc', '테스트시 테스트구 테스트동 123번지 1234', '테스터');