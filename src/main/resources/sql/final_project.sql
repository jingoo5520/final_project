SELECT * FROM final_project.members order by reg_date desc; 
-- 회원가입 중복체크 쿼리문
select * from members where member_id = 'lch1999'; -- id중복 체크
select * from members where email = 'lch1999@naver.com'; -- email 중복 체크
select * from members where phone_number = '010-1212-3434'; -- phone_number 중복 체크
select * from members where member_id = 'testuser12';

select count(*) from members where member_id = 'testuser12';
-- 회원가입처리
-- insert into members(member_id, member_name, member_pwd, phone_number, birthday, gender, email, address, nickname)
-- values(#{member_id}, #{member_name}, #{member_pwd}, #{phone_number}, #{birthday}, #{gender}, #{email}, #{address}, #{nickname});

-- 비밀번호는 sha256 암호화
update members set member_pwd = sha2('xptmxm12', 256);

-- 자동 로그인 정보 저장
update members set autologin_code = 'uuid', autologin_date = date_add(now(), interval 7 day) where member_id = '1';

-- 자동 로그인 정보 조회
select count(*) from members where autologin_code = '536c7e52-f089-41f2-ad7b-393e7e3ead58' and autologin_date > now();

-- 아이디로 정보 조회(마이페이지)
select * from members where member_id = 1;

-- 회원 정보 변경(마이페이지)
update members
set nickname = '업데이트xmxm', gender = 'M', phone_number = '010-1212-3434'
, address = '05237/서울 강동구 아리수로 46/102호', email = 'lch1999@naver.com'
where member_id = '1';

-- 비밀번호 변경(마이페이지)
update members
set member_pwd = sha2('xptmxm12', 256)
where member_id = '1';

-- 회원 탈퇴(마이페이지)
update members
set member_status = 'withdrawn'
where member_id = '1';

-- 로그인
select * from members where
member_id = '1' and member_pwd = sha2('xptmxm12', 256) and member_status = 'active';

-- 아이디 찾기
select member_id from members where email = 'email@email.com' and member_status = 'active';

-- 비밀번호 찾기
select member_pwd from members where member_id = 'ckdgus12' and email = 'fhtkwhgdk99@gmail.com' and member_status = 'active';

-- 비밀번호 찾기(랜덤비밀번호 지정)
update members
set member_pwd = sha2('xptmxm12', 256) where member_id = 'ckdgus12' and member_status = 'active';

-- 내 찜목록 불러오기
select product_no from wishes where member_id = '2';

-- 찜 상태 확인
select count(*) from wishes where member_id = '1' and product_no = '226';

-- 찜 정보 추가
insert into wishes (member_id, product_no)
values ('1', '240');

-- 찜 정보 삭제
delete from wishes where member_id = '1' and product_no = '240';

-- 기본주소로 저장(회원가입)
insert into delivery_addrs (delivery_name, delivery_address, is_main, member_id)
values ('테스터의집', '00000/테스트시 테스트구 테스트동/테스트호', 'M', 'ckdgus12');