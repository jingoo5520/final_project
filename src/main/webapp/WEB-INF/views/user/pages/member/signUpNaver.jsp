<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>네이버 간편가입</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- ========================= CSS here ========================= -->
<link rel="stylesheet"
	href="/resources/assets/user/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="/resources/assets/user/css/LineIcons.3.0.css" />
<link rel="stylesheet" href="/resources/assets/user/css/tiny-slider.css" />
<link rel="stylesheet"
	href="/resources/assets/user/css/glightbox.min.css" />
<link rel="stylesheet" href="/resources/assets/user/css/main.css" />
<link rel="shortcut icon" type="image/x-icon" href="/resources/assets/user/images/logo/favicon.png" />

</head>
<style>
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

.addressName {
	display: none;
}
</style>

<body>

	<!-- Preloader -->
	<div class="preloader">
		<div class="preloader-inner">
			<div class="preloader-icon">
				<span></span> <span></span>
			</div>
		</div>
	</div>
	<!-- /End Preloader -->

	<jsp:include page="../header.jsp"></jsp:include>

	<!-- Start Breadcrumbs -->
	<div class="breadcrumbs">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-lg-6 col-md-6 col-12">
					<div class="breadcrumbs-content">
						<h1 class="page-title">Registration</h1>
					</div>
				</div>
				<div class="col-lg-6 col-md-6 col-12">
					<ul class="breadcrumb-nav">
						<li><a href="index.html"><i class="lni lni-home"></i>
								Home</a></li>
						<li>Registration</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- End Breadcrumbs -->

	<!-- Start Account Register Area -->
	<div class="account-login section">
		<div class="container">
			<div class="row">
				<div class="col-lg-6 offset-lg-3 col-md-10 offset-md-1 col-12">
					<div class="register-form">
						<div class="title">
							<h3>네이버 간편가입</h3>
							<p></p>
						</div>
						<form class="row" action="/member/naver/signUp" method="post">
							<div class="col-sm-12">
								<div class="form-group">
									<label for="reg-id">*아이디</label> <input class="form-control"
										type="text" name="member_id" id="member_id"><span
										id="idStatus"></span> <input type="hidden" value="">
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="reg-pw">*비밀번호</label> <input class="form-control"
										type="password" name="member_pwd" id="member_pwd"><span
										id="pwdStatus"></span><input type="hidden" value="">
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="reg-pw2">*비밀번호 확인</label> <input
										class="form-control" type="password" name="member_pwd2"
										id="member_pwd2"><span id="pwd2Status"></span><input
										type="hidden" value="">
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="reg-n">*이름</label> <input class="form-control"
										type="text" name="member_name" id="member_name"><span
										id="nameStatus"></span> <input type="hidden" value="">
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="reg-nn">별명</label> <input class="form-control"
										type="text" name="nickname" id="nickname"
										value="${userInfo.nickname }"><span
										id="nicknameStatus"></span> <input type="hidden" value="">
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group" style="margin-bottom: 0px">
									<label for="reg-ad">*주소</label> <input class="form-control"
										type="text" name="address" id="address" readonly
										onclick="selectAddress();"><span id="addressStatus"></span>
									<input type="hidden" value="">
								</div>
							</div>
							<div class="col-sm-6">
								<div class="form-group" style="margin-bottom: 0px">
									<label for="reg-ad">*우편번호</label> <input class="form-control"
										type="text" name="zipCode" id="zipCode" readonly
										onclick="selectAddress();"><span id="zipCodeStatus"></span>
									<input type="hidden" value="">
								</div>
								<div class="form-check">
									<input type="checkbox" class="form-check-input"
										id="basicAddress" name="basicAddress" value="기본주소"> <label
										class="form-check-label" for="basicAddress">기본 주소로 설정</label>
								</div>
							</div>
							<div class="col-sm-6">
								<div class="form-group">
									<label for="reg-ad2">상세 주소</label> <input class="form-control"
										type="text" name="address2" id="address2"><span
										id="address2Status"></span> <input type="hidden" value="">
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group addressName">
									<label for="reg-ad">배송지명</label> <input class="form-control"
										type="text" name="addressName" id="addressName">
								</div>
							</div>
							<div class="form-group">
								<span id=""></span> <input type="hidden" value="">
							</div>
							<div class="col-sm-7">
								<div class="form-group">
									<label for="reg-em">*이메일</label> <input class="form-control"
										type="text" name="email" id="email"><span
										id="emailStatus"></span> <input type="hidden" value="">
								</div>
							</div>
							<div class="col-sm-5 button" id="requestArea">
								<br> <input type="button" id="authTimer" class="btn"
									value="인증메일 요청" onclick="mailRequest();"><span></span>
								<input type="hidden" value="">
							</div>
							<div class="col-sm-7" style="margin-top: 10px">
								<div class="form-group">
									<input class="form-control" type="hidden" name="authCode"
										id="authCode" placeholder="인증코드를 입력하세요"><span
										id="authStatus"></span> <input type="hidden" value="">
								</div>
							</div>

							<div class="col-sm-5 button">
								<input type="hidden" id="mailRequest2" class="btn"
									value="인증메일 재요청" onclick="mailRequest();"><span></span>
								<input type="hidden" value="">
							</div>

							<div class="col-sm-12 button">
								<input id="mailAuthBtn" class="btn" type="hidden"
									onclick="mailVerify();" value="인증"><span></span> <input
									type="hidden" value="">
							</div>


							<div class="col-sm-12">
								<div class="form-group">
									<label for="reg-ph">*휴대폰</label> <input class="form-control"
										type="text" name="phone_number" id="phone_number"><span
										id="phoneStatus"></span> <input type="hidden" value="">
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<div class="form-check">
										<input type="checkbox" class="form-check-input" id="check1"
											name="option1" value="something"> <label
											class="form-check-label" for="check1">약관 동의(필수)<span
											id="checkboxStatus"></span><input type="hidden" value=""></label>
									</div>
								</div>
							</div>
							<!-- 네이버 api로 받아온 유저 정보 -->
							<input type="hidden" name="gender" value="${userInfo.gender }">
							<input type="hidden" name="naver_id" value="${userInfo.naver_id }">
							<input type="hidden" name="birthday"
								value="${userInfo.birthday }">
							<div class="button">
								<button class="btn" type="submit" value="회원가입"
									onclick="return checkData();">회원 가입</button>
							</div>
							<p class="outer-link">
								이미 ELOLIA의 회원이신가요? <a
									href="${pageContext.request.contextPath}/member/viewLogin">로그인
									하기</a>
							</p>
						</form>
					</div>
				</div>
			</div>
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

	<!-- End Account Register Area -->

	<jsp:include page="../footer.jsp"></jsp:include>

	<!-- ========================= scroll-top ========================= -->
	<a href="#" class="scroll-top"> <i class="lni lni-chevron-up"></i>
	</a>

	<!-- ========================= JS here ========================= -->
	<script src="/resources/assets/user/js/bootstrap.min.js"></script>
	<script src="/resources/assets/user/js/tiny-slider.js"></script>
	<script src="/resources/assets/user/js/glightbox.min.js"></script>
	<script src="/resources/assets/user/js/main.js"></script>
</body>
<script type="text/javascript">
var idExp = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z0-9]{6,15}$/; // 아이디 정규식(영문자, 숫자를 포함한 6자 이상 15자 이하)
var phoneExp = /010(-\d{4}-\d{4}|\d{8})$/; // 휴대폰 번호 정규식 (010-1234-5678), 01012345678 형식만 허용
var emailExp = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/; // 이메일 정규식(testuser@test.com)
var pwdExp = /^(?=.*[A-Za-z])(?=.*\d).{8,20}$/; // 비밀번호 정규식(영문자, 숫자를 포함한 8자이상 20자 이하)
var nameExp = /^[가-힣]{2,8}$/; // 이름 정규식(한글만 가능 2글자 이상 8자 이하)
var birthdayExp = /^(19|20)\d{2}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])$/; // 생일 정규식(1900년대 또는 2000년대,  01월부터 12월, 01일부터 31일)
let authTime = 0; // 메일인증 시간(0초)
let minute = 0;
let seconds = 0;

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
		
		// 기본 주소 설정 체크
		$("#basicAddress").change(function () {
			if($('#basicAddress').is(':checked')) {
				$(".addressName").css("display", "block");
				//$("#addressName").attr("type", "text");
			} else {
				$(".addressName").css("display", "none");
				//$("#addressName").attr("type", "hidden");
			}
		});
				
	});
	
	// daum 주소 api
	// 주소칸에서 onclick으로 호출
	function selectAddress() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
	            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
	            console.log(data);
	            $("#address").val(data.address);
	            $("#zipCode").val(data.zonecode);
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

	// 입력값에 따라 msg출력
	function isMsg(id, msg, color, result) {
		$("#" + id).next().text(msg);
		$("#" + id).next().css("color", color);
		$("#" + id).next().next().val(result);
	}
	
	// 인증메일 요청
	function mailRequest() {
		let replaceTag = `<input type="button" id="modiMail" class="btn" value="메일 수정"><span></span> <input
			type="hidden" value="">`;
		let emailCheck = $("#email").next().next().val();
		console.log(emailCheck);
		console.log(replaceTag);
		if(emailCheck=="true") {
			if(authTime > 0) { // 인증메일 요청후 제한시간이 지나지 않았다면,
				openModal("!", "아직 요청 시간이 남았습니다.")
			} else {
				let email = $("#email").val();
				$("#email").attr("readonly", true); // 이메일을 입력한 input태그를 수정할수없도록 변경
				// 인증메일 요청버튼을 없애고 인증코드를 입력하는 input태그로 변경
				$("#requestArea").children("input").first().replaceWith(replaceTag);
				isMsg("authCode", "인증메일을 발송했습니다. 메일을 확인하세요.", "blue", true);
				authTime = 180;
				console.log(authTime);
				$("#mailAuthBtn").attr("type", "button");
				$("#authCode").attr("type", "text");
				$("#authCode").val("");
				$("#mailRequest2").attr("type", "button");
				// 메일 수정(재입력)
				$("#modiMail").click(function () {
					$("#mailAuthBtn").attr("type", "hidden");
					$("#authCode").attr("type", "hidden");
					$("#mailRequest2").attr("type", "hidden");
					isMsg("authCode", "", "blue", false);
					authTime = 0;
					let restorationTag = `<input type="button" class="btn" value="인증메일 요청"
						onclick="mailRequest();">`;
					$("#requestArea").children("input").first().replaceWith(restorationTag);
					$("#requestArea").children("input").eq(1).replaceWith("");
					$("#requestArea").children("span").first().replaceWith("");
					$("#email").attr("readonly", false); // 이메일을 입력한 input태그를 다시 수정가능하도록 변경
					isMsg("modiMail", "", "blue", false); // 인증 상태를 다시 false로 변경
				});
				console.log(email);
				$.ajax({
					url: "/member/mailRequest",
					type: "GET",
					data: {email : email},
					dataType: "json",
					success: function (data) {
						console.log(data);
					},
					error: function () {},
					complete: function () {},
				});
			}
		}
	}
	
	// 메일인증하기
	function mailVerify() {
		let inputAuthCode = $("#authCode").val();
		$.ajax({
			url: "/member/mailAuth",
			type: "GET",
			data: {inputAuthCode : inputAuthCode},
			dataType: "json",
			success: function (data) {
				console.log(data);
				if(data.status=="success") {
					$("#mailAuthBtn").attr("type", "hidden");
					$("#authCode").attr("type", "hidden");
					$("#mailRequest2").attr("type", "hidden");
					isMsg("authCode", "", "blue", false);
					isMsg("modiMail", "메일인증 완료", "blue", true);
					authTime = 0;
					isMsg("mailRequest2", "", "gray", false);
				} else if(data.status=="fail" && data.value=="코드 불일치") {
					openModal("에러", "코드가 일치하지 않습니다.");
				} else if(data.status=="fail" && data.value=="세션 만료") {
					openModal("에러", "세션이 만료되었습니다. 인증코드를 다시 요청하세요.");
				}
			},
			error: function () {},
			complete: function () {},
		});
	}

	// id, email, phone_number를 중복인지 아닌지 체크하는 ajax
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

	// 회원가입 실행 전 값 유효성 체크
	function checkData() {
		let result = true;
		let tmp = $("#address").val();
		if(tmp == "") {
			$("#address").next().next().val("false");
		} else {
			$("#address").next().next().val("true");			
		}
		let text = ""; // modal의 text영역에 들어갈 내용
		
		let idCheck = $("#member_id").next().next().val();
		let pwdCheck = $("#member_pwd").next().next().val();
		let pwd2Check = $("#member_pwd2").next().next().val();
		let nameCheck = $("#member_name").next().next().val();
		let addressCheck = $("#address").next().next().val();
		let emailCheck = $("#email").next().next().val();
		let phoneCheck = $("#phone_number").next().next().val();
		let check1Check = $("#check1").prop("checked");
		let emailAuthCheck = $("#modiMail").next().next().val();
		
		if(idCheck!="true") {
			result = false;
			text += "<div>아이디</div>";
		}
		if(pwdCheck!="true") {
			result = false;
			text += "<div>비밀번호</div>";
		}
		if(pwd2Check!="true") {
			result = false;
			text += "<div>비밀번호 확인</div>";
		}
		if(nameCheck!="true") {
			result = false;
			text += "<div>이름</div>";
		}
		if(addressCheck!="true") {
			result = false;
			text += "<div>주소</div>";
		}
		if(emailCheck!="true") {
			result = false;
			text += "<div>이메일</div>";
		}
		if(phoneCheck!="true") {
			result = false;
			text += "<div>휴대폰번호</div>";
		}
		if(check1Check!=true) {
			result = false;
			text += "<div>약관 동의</div>";
		}
		
		if(emailAuthCheck!="true") {
			result = false;
			text += "<div>이메일 인증</div>";
		}
		
		if(!result) {
			openModal("아래 항목들을 입력해야합니다.", text);
		}
		
		return result;
	}
	
	// 모달 열기
	function openModal(title, text) {
		$("#modalcontainer").css("display", "block");
		$("#modalTitle").text(title);
		$("#modalText").html(text);
	}
	
	// 모달 닫기
	function closeModal() {
		$("#modalcontainer").css("display", "none");
	}
	
</script>

</html>