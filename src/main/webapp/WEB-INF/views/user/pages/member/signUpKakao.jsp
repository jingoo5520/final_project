<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카카오 간편가입</title>
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
						<h1 class="page-title">회원가입</h1>
					</div>
				</div>
				<div class="col-lg-6 col-md-6 col-12">
					<ul class="breadcrumb-nav">
						<li><a href="/"><i class="lni lni-home"></i>Home</a></li>
						<li>회원가입 (KAKAO)</li>
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
							<h3>카카오 간편가입</h3>
							<p></p>
						</div>
						<form class="row" action="/member/kakao/signUp" method="post">
							<div class="col-sm-12">
								<div class="form-group">
									<label for="reg-id">*아이디</label> <input class="form-control"
										type="text" name="member_id" id="member_id"><span
										id="idStatus"></span> <input type="hidden" value="">
								</div>
							</div>
							<!-- 카카오 api로 받아온 유저 정보 -->
							<input type="hidden" name="email" value="${userInfo.email }">
							<input type="hidden" name="nickname"
								value="${userInfo.nickname }"> <input type="hidden"
								name="birthday" value="${userInfo.birthday }"> <input
								type="hidden" name="gender" value="${userInfo.gender }">
							<input type="hidden" name="address" value="${userInfo.address }">
							<input type="hidden" name="zipCode" value="${userInfo.zipCode }">
							<input type="hidden" name="address2"
								value="${userInfo.address2 }">
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
									<label for="reg-ph">*휴대폰</label> <input class="form-control"
										type="text" name="phone_number" id="phone_number"><span
										id="phoneStatus"></span> <input type="hidden" value="">
								</div>
							</div>
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
	var pwdExp = /^(?=.*[A-Za-z])(?=.*\d).{8,20}$/; // 비밀번호 정규식(영문자, 숫자를 포함한 8자이상 20자 이하)
	var nameExp = /^[가-힣]{2,8}$/; // 이름 정규식(한글만 가능 2글자 이상 8자 이하)

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
				
	});
	
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

		let pwdCheck = $("#member_pwd").next().next().val();
		let pwd2Check = $("#member_pwd2").next().next().val();
		let nameCheck = $("#member_name").next().next().val();
		let phoneCheck = $("#phone_number").next().next().val();
		
		let text = ""; // modal의 text영역에 들어갈 내용
		
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
		if(phoneCheck!="true") {
			result = false;
			text += "<div>휴대폰번호</div>";
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