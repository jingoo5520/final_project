SELECT * FROM final_project.members; 
-- 회원가입 중복체크 쿼리문
select * from members where member_id = 'lch1999'; -- id중복 체크
select * from members where email = 'lch1999@naver.com'; -- email 중복 체크
select * from members where phone_number = '010-1212-3434'; -- phone_number 중복 체크
select * from members where member_id = 'testuser12';

select count(member_id) from members where member_id = 'testuser12';