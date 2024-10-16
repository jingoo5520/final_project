CREATE TABLE levels (
    level_no INT NOT NULL AUTO_INCREMENT PRIMARY KEY,    -- 등급 번호
    level_name VARCHAR(8) NOT NULL,                     -- 등급 이름
    level_min INT NOT NULL,                             -- 사용 금액 최소값
    level_max INT,                                      -- 사용 금액 최대값
    level_dc FLOAT,                                     -- 등급별 할인율
    level_point FLOAT,                                  -- 등급별 적립포인트
    UNIQUE (level_no)                                   -- 등급 번호는 고유
);

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