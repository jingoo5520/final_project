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
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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

/* 모달 */
#modalcontainer {
	display: none; /* 기본적으로 숨김 */
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgb(0, 0, 0);
	background-color: rgba(0, 0, 0, 0.4); /* 배경 색상 */
}

.modalBody {
	background-color: #fff;
	margin: 15% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 80%;
}

.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}
</style>
<script type="text/javascript">
	var idExp = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z0-9]{6,15}$/; // 아이디 정규식(영문자, 숫자를 포함한 6자 이상 15자 이하)
	var phoneExp = /010(-\d{4}-\d{4}|\d{8})$/; // 휴대폰 번호 정규식 (010-1234-5678), 01012345678 형식만 허용
	var emailExp = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/; // 이메일 정규식(testuser@test.com)
	var pwdExp = /^(?=.*[A-Za-z])(?=.*\d).{8,20}$/; // 비밀번호 정규식(영문자, 숫자를 포함한 8자이상 20자 이하)
	var nameExp = /^[가-힣]{2,8}$/; // 이름 정규식(한글만 가능 2글자 이상 8자 이하)
	var birthdayExp = /^(19|20)\d{2}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])$/; // 생일 정규식(1900년대 또는 2000년대,  01월부터 12월, 01일부터 31일)
	$(function() {
		// 아이디 입력중
		$("#member_id").keyup(function() {
	        let tmp = $("#member_id").val();
	        if (isCheck("member_id", tmp, idExp, "영문자, 숫자를 포함한 6자 이상 15자 이하", "red")) {
	            dbCheck("id", tmp).then(isAvailable => {
	                if (isAvailable) {
	                    isMsg("member_id", "사용가능한 ID 입니다.", "blue", true);
	                } else {
	                    isMsg("member_id", "이미 사용중인 ID 입니다.", "red", false);
	                }
	            }).catch(error => {
	                isMsg("member_id", error, "red");
	            });
	        }
	    });
		// 이메일 입력중
		$("#email").keyup(function() {
	        let tmp = $("#email").val();
	        if (isCheck("email", tmp, emailExp, "이메일 형식이 아닙니다.", "red")) {
	            dbCheck("email", tmp).then(isAvailable => {
	                if (isAvailable) {
	                    isMsg("email", "사용가능한 이메일 입니다.", "blue", true);
	                } else {
	                    isMsg("email", "이미 사용중인 이메일 입니다.", "red", false);
	                }
	            }).catch(error => {
	                isMsg("email", error, "red", false);
	            });
	        }
	    });
		// 휴대폰번호 입력중
		$("#phone_number").keyup(function() {
	        let tmp = $("#phone_number").val();
	        if (isCheck("phone_number", tmp, phoneExp, "전화번호 형식이 아닙니다.", "red")) {
	            dbCheck("phone", tmp).then(isAvailable => {
	                if (isAvailable) {
	                    isMsg("phone_number", "사용가능한 휴대폰번호 입니다.", "blue", true);
	                } else {
	                    isMsg("phone_number", "이미 사용중인 휴대폰번호 입니다.", "red", false);
	                }
	            }).catch(error => {
	                isMsg("phone_number", error, "red", false);
	            });
	        }
	    });
		// 비밀번호 입력중
		$("#member_pwd").keyup(function() {
			let tmp = $("#member_pwd").val();
			if(isCheck("member_pwd", tmp, pwdExp, "영문, 숫자를 포함한 8자 이상 20자 이하", "red")) {
				isMsg("member_pwd", "사용가능한 비밀번호 입니다.", "blue", true);
			} else {
				isMsg("member_pwd", "영문, 숫자를 포함한 8자 이상 20자 이하", "red", false);
			}
		});
		// 비밀번호 확인 입력중
		$("#member_pwd2").keyup(function() {
			let tmp1 = $("#member_pwd").val();
			let tmp2 = $("#member_pwd2").val();
			if(tmp1 !== tmp2) {
				isMsg("member_pwd2", "비밀번호 불일치", "red", false);
			} else {
				isMsg("member_pwd2", "비밀번호 일치", "blue", true);
			}
		});
		// 이름 입력중
		$("#member_name").keyup(function() {
			let tmp = $("#member_name").val();
			if(isCheck("member_name", tmp, nameExp, "한글2자~8자", "red")){
				isMsg("member_name", "ok", "blue", true);
			} else {
				isMsg("member_name", "한글2자~8자", "red", false);
			}
		});
		// 생일 입력
		$("#birthday").change(function() {
			let tmp = $("#birthday").val();
			if(isCheck("birthday", tmp, birthdayExp, "값이 올바르지 않습니다.", "red")) {
				isMsg("birthday", "ok", "blue", true);
			} else {
				isMsg("birthday", "값이 올바르지 않습니다.", "red", false);
			}
		});
		
		
	});
	
	// daum 주소 api
	// 주소칸에서 onclick으로 호출
	function selectAddress(obj) {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
	            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
	            console.log(data);
	            $(obj).val(data.zonecode + "/" + data.address);
	        }
	    }).open();
	}

	// 정규식 테스트 결과에 따라 ture, false 반환
	function isCheck(id, tmp, regExp, msg, color) {
		if (regExp.test(tmp)) { // 정규식 유효성 true
			console.log("정규식 : true");
			console.log("#" + id);
			$("#" + id).next().text("");
			$("#" + id).next().next().val("true");
			return true;
		} else { // 정규식 유효성 false
			console.log("정규식 : false");
			console.log("#" + id);
			$("#" + id).next().text(msg);
			$("#" + id).next().css("color", color);
			$("#" + id).next().next().val("false");
			return false;
		}
	}
	
	function isMsg(id, msg, color, result) {
		$("#" + id).next().text(msg);
		$("#" + id).next().css("color", color);
		$("#" + id).next().next().val(result);
	}

	function dbCheck(key, value) {
		// https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Global_Objects/Promise
		// dbCheck()를 호출한 곳에서 ajax 응답결과를 기다리지 않고 동작하기 때문에, Promise 로 ajax결과값을 받은 후에 dbCheck()가 동작하도록 함.
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
		let result = true;
		let tmp = $("#address").val();
		if(tmp == "") {
			$("#address").next().next().val("false");
		} else {
			$("#address").next().next().val("true");			
		}
		let idCheck = $("#member_id").next().next().val();
		let pwdCheck = $("#member_pwd").next().next().val();
		let pwd2Check = $("#member_pwd2").next().next().val();
		let nameCheck = $("#member_name").next().next().val();
		let birthdayCheck = $("#birthday").next().next().val();
		//let genderCheck = $("#gender").next().next().val();
		let addressCheck = $("#address").next().next().val();
		let emailCheck = $("#email").next().next().val();
		let phoneCheck = $("#phone_number").next().next().val();
		//let check1Check = $("#check1").next().next().next().val();
		let check1Check = $("#check1").prop("checked");
		
		let text = ""; // modal의 text영역에 들어갈 내용
		
		if(!idCheck) {
			result = false;
			text += "<div>아이디</div>";
		}
		if(!pwdCheck) {
			result = false;
			text += "<div>비밀번호</div>";
		}
		if(!pwd2Check) {
			result = false;
			text += "<div>비밀번호 확인</div>";
		}
		if(!nameCheck) {
			result = false;
			text += "<div>이름</div>";
		}
		if(!birthdayCheck) {
			result = false;
			text += "<div>생일</div>";
		}
		if(!addressCheck) {
			result = false;
			text += "<div>주소</div>";
		}
		if(!emailCheck) {
			result = false;
			text += "<div>이메일</div>";
		}
		if(!phoneCheck) {
			result = false;
			text += "<div>휴대폰번호</div>";
		}
		if(!check1Check) {
			result = false;
			text += "<div>약관 동의</div>";
		}
		
		if(!result) {
			openModal("아래 항목들을 입력해야합니다.", text);
			console.log(idCheck);
			console.log(pwdCheck);
			console.log(pwd2Check);
			console.log(nameCheck);
			console.log(birthdayCheck);
			//console.log(genderCheck);
			console.log(addressCheck);
			console.log(emailCheck);
			console.log(phoneCheck);
			console.log(check1Check);
		}
		
		return result;
	}
	
	function openModal(title, text) {
		$("#modalcontainer").css("display", "block");
		$("#modalTitle").text(title);
		$("#modalText").html(text);
	}
	
	function closeModal() {
		$("#modalcontainer").css("display", "none");
	}
	
</script>
</head>
<body>
	<form action="/member/signUp" method="post">
		<div class="signUpContainer container mt-3">
			<h1>회원가입</h1>
			<div>
				아이디<input class="box" type="text" name="member_id" id="member_id"
					placeholder="id"> <span id="idStatus"></span> <input
					type="hidden" value="">
			</div>
			<div>
				비밀번호<input class="box" type="password" name="member_pwd"
					id="member_pwd" placeholder="비밀번호"><span id="pwdStatus"></span><input
					type="hidden" value="">
			</div>
			<div>
				비밀번호 확인<input class="box" type="password" name="member_pwd2"
					id="member_pwd2" placeholder="비밀번호 확인"><span
					id="pwd2Status"></span><input type="hidden" value="">
			</div>
			<div>
				이름<input class="box" type="text" name="member_name" id="member_name"
					placeholder="홍길동"><span id="nameStatus"></span><input
					type="hidden" value="">
			</div>
			<div>
				별명<input class="box" type="text" name="nickname" id="nickname"
					placeholder="강원감자14"><span id="nicknameStatus"></span>
			</div>
			<div>
				생일<input class="box" type="date" name="birthday" id="birthday">
				<span id="birthdayStatus"></span><input type="hidden" value="">
			</div>
			<div id="gender">
				성별<span id="genderStatus"></span><input type="hidden" value="">
			</div>
			<div class="form-check">
				<input type="radio" class="form-check-input" id="M" name="gender"
					value="M"> <label class="form-check-label" for="M">남자</label>
			</div>
			<div class="form-check">
				<input type="radio" class="form-check-input" id="F" name="gender"
					value="F"> <label class="form-check-label" for="F">여자</label>
			</div>
			<div>
				주소<input class="box" type="text" name="address" id="address"
					readonly onclick="selectAddress(this);"><span
					id="addressStatus"></span><input type="hidden" value="">
			</div>
			<div>
				상세주소<input class="box" type="text" name="address2" id="address2"
					placeholder="201호">
			</div>


			<div>
				이메일<input class="box" type="text" name="email" id="email"
					placeholder="gildong@gmail.com"> <span id="emailStatus"></span><input
					type="hidden" value="">
			</div>
			<div>
				휴대폰번호<input class="box" type="text" name="phone_number"
					id="phone_number" placeholder="010-1234-5678"> <span
					id="phoneStatus"></span><input type="hidden" value="">
			</div>

			<div class="form-check">
				<input type="checkbox" class="form-check-input" id="check1"
					name="option1" value="something"> <label
					class="form-check-label" for="check1">약관 동의(필수)</label><span
					id="checkboxStatus"></span><input type="hidden" value="">
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

		<!-- 모달 -->
		<div id="modalcontainer">
			<div class="modalBody">
				<span class="close" onclick="closeModal();">&times;</span>
				<h2 id="modalTitle">제목</h2>
				<p id="modalText">내용</p>
			</div>
		</div>

	</form>
</body>
</html>
