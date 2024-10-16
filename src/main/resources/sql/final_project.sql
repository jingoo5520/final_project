SELECT * FROM final_project.members order by reg_date desc; 
-- 회원가입 중복체크 쿼리문
select * from members where member_id = 'lch1999'; -- id중복 체크
select * from members where email = 'lch1999@naver.com'; -- email 중복 체크
select * from members where phone_number = '010-1212-3434'; -- phone_number 중복 체크
select * from members where member_id = 'testuser12';

select count(*) from members where member_id = 'testuser12';
-- 회원가입처리
insert into members(member_id, member_name, member_pwd, phone_number, birthday, gender, email, address, nickname)
values(#{member_id}, #{member_name}, #{member_pwd}, #{phone_number}, #{birthday}, #{gender}, #{email}, #{address}, #{nickname});

