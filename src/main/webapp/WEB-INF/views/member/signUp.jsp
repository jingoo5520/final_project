<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style type="text/css">
body {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh; /* 화면 전체 높이 */
	margin: 0; /* 기본 여백 제거 */
	background-color: #f0f0f0; /* 배경색 설정 */
}

.signUpContainer {
	background: white; /* 배경색 설정 */
	padding: 20px 100px 20px 50px; /* 안쪽 여백 */
	border-radius: 10px; /* 둥근 모서리 */
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
}

.box {
	/* display: block; /* 입력 요소를 블록으로 설정 */ */
	margin-bottom: 10px; /* 아래쪽 여백 */
	/* width: 100%; /* 너비 100% */ */
	padding: 10px; /* 안쪽 여백 */
	border: 1px solid #ccc; /* 테두리 */
	border-radius: 5px; /* 둥근 모서리 */
}

.red {
	color: red;
}

.blue {
	color: blue;
}
</style>
<script type="text/javascript">
	var idExp = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z0-9]{8,20}$/; // 영문자, 숫자를 포함한 8자 이상 20자 이하
	var phoneExp = /^(070|02|0[3-9]{1}[0-9]{1})[0-9]{3,4}[0-9]{4}$/; // 휴대폰 번호 정규식
	var emailExp = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/; // 이메일 정규식
	$(function() {
		// 아이디 입력중
		$("#member_id").keyup(function() {
	        let tmp = $("#member_id").val();
	        if (isCheck("member_id", tmp, idExp, "영문자, 숫자를 포함한 8자 이상 20자 이하", "red")) {
	            dbCheck("id", tmp).then(isAvailable => {
	                if (isAvailable) {
	                    isMsg("member_id", "사용가능한 ID 입니다.", "blue");
	                } else {
	                    isMsg("member_id", "이미 사용중인 ID 입니다.", "red");
	                }
	            }).catch(error => {
	                isMsg("member_id", error, "red");
	            });
	        }
	    });
	});

	// 정규식 테스트 결과에 따라 ture, false 반환
	function isCheck(id, tmp, regExp, msg, color) {
		if (regExp.test(tmp)) { // 정규식 유효성 true
			console.log("정규식 : true");
			console.log("#" + id);
			$("#" + id).next().text("");
			return true;
		} else { // 정규식 유효성 false
			console.log("정규식 : false");
			console.log("#" + id);
			$("#" + id).next().text(msg);
			$("#" + id).next().css("color", color);
			return false;
		}
	}
	
	function isMsg(id, msg, color) {
		$("#" + id).next().text(msg);
		$("#" + id).next().css("color", color);
	}

	function dbCheck(key, value) {
	    return new Promise((resolve, reject) => {
	        $.ajax({
	            url: "/member/isDuplicate",
	            type: "POST",
	            dataType: "json",
	            data: {
	                key: key,
	                value: value
	            },
	            success: function(data) {
	                console.log(data);
	                if (data.status === "Duplicate") {
	                    resolve(false); // 중복이면 false
	                } else if (data.status === "notDuplicate") {
	                    resolve(true); // 중복이 아니면 true
	                }
	            },
	            error: function() {
	                reject("서버 오류"); // 오류 발생 시 reject
	            }
	        });
	    });
	}

	function checkData() {

	}
</script>
</head>
<body>
	<form action="/member/signUp" method="post">
		<div class="signUpContainer container mt-3">
			<h1>회원가입</h1>
			<div>
				아이디<input class="box" type="text" name="member_id" id="member_id"
					placeholder="id"> <span id="idStatus"></span>
			</div>
			<div>
				비밀번호<input class="box" type="password" name="member_pwd"
					id="member_pwd" placeholder="비밀번호"><span id="pwdStatus"></span>
			</div>
			<div>
				비밀번호 확인<input class="box" type="password" name="member_pwd2"
					id="member_pwd2" placeholder="비밀번호 확인"><span
					id="pwd2Status"></span>
			</div>
			<div>
				이름<input class="box" type="text" name="member_name" id="member_name"
					placeholder="홍길동"><span id="nameStatus"></span>
			</div>
			<div>
				별명<input class="box" type="text" name="nickname" id="nickname"
					placeholder="강원감자14"><span id="nicknameStatus"></span>
			</div>
			<div>
				생일<input class="box" type="date" name="birthday" id="birthday">
				<span id="birthdayStatus"></span>
			</div>
			<div>
				성별<span id="genderStatus"></span>
			</div>
			<div class="form-check">
				<input type="radio" class="form-check-input" id="M" name="gender"
					value="M" checked> <label class="form-check-label" for="M">남자</label>
			</div>
			<div class="form-check">
				<input type="radio" class="form-check-input" id="F" name="gender"
					value="F"> <label class="form-check-label" for="F">여자</label>
			</div>
			<div>
				주소<input class="box" type="text" name="address" id="address"
					placeholder=""><span id="addressStatus"></span>
			</div>
			<div>
				상세주소<input class="box" type="text" name="address2" id="address2"
					placeholder="201호">
			</div>


			<div>
				이메일<input class="box" type="text" name="email" id="email"
					placeholder="gildong@gmail.com"> <span id="emailStatus"></span>
			</div>
			<div>
				휴대폰번호<input class="box" type="text" name="phone_number"
					id="phone_number" placeholder="010-1234-5678"> <span
					id="phoneStatus"></span>
			</div>

			<div class="form-check">
				<input type="checkbox" class="form-check-input" id="check1"
					name="option1" value="something"> <label
					class="form-check-label" for="check1">약관 동의(필수)</label><span
					id="checkboxStatus"></span>
			</div>
			<div class="form-check">
				<input type="checkbox" class="form-check-input" id="check2"
					name="option2" value="something"> <label
					class="form-check-label" for="check2">이메일 수신 동의(선택)</label>
			</div>
			<div class="form-check">
				<input type="checkbox" class="form-check-input" id="check3"
					name="option3" value="something"> <label
					class="form-check-label" for="check3">문자 수신 동의(선택)</label>
			</div>

			<div class="container mt-3">
				<button type="submit" class="btn btn-primary" value="회원가입"
					onclick="return checkData();">회원가입</button>
				<button type="reset" class="btn btn-danger" value="취소">취소</button>
			</div>
		</div>
	</form>
</body>
</html>
