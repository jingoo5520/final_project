<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ELOLIA</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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

<body>
	<!--[if lte IE 9]>
      <p class="browserupgrade">
        You are using an <strong>outdated</strong> browser. Please
        <a href="https://browsehappy.com/">upgrade your browser</a> to improve
        your experience and security.
      </p>
    <![endif]-->

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
						<h1 class="page-title">아이디 찾기</h1>
					</div>
				</div>
				<div class="col-lg-6 col-md-6 col-12">
					<ul class="breadcrumb-nav">
						<li><a href="/"><i class="lni lni-home"></i>
								Home</a></li>
						<li>아이디 찾기</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- End Breadcrumbs -->

	<!-- Start Account Login Area -->
	<div class="account-login section">
		<div class="container">
			<div class="row">
				<div class="col-lg-6 offset-lg-3 col-md-10 offset-md-1 col-12">
					<form class="card login-form" action="/member/login" method="post">
						<div class="card-body">
							<div class="title">
								<p>회원가입 당시 입력했던 이메일을 입력해주세요.</p>
							</div>
							<div class="form-group input-group">
								<label for="reg-fn">이메일</label> <input class="form-control"
									type="text" name="email" id="email" required> <span></span>
								<input type="hidden">
							</div>
							<div class="button">
								<button class="btn" type="button" id="sendMailBtn" onclick="checkMail();">확인</button>
							</div>
							<div
								class="d-flex flex-wrap justify-content-between bottom-content">
								<a class="lost-pass"
									href="${pageContext.request.contextPath}/member/viewLogin">로그인
									하러가기</a> <a class="lost-pass"
									href="${pageContext.request.contextPath}/member/find_pwd">비밀번호
									찾기</a>
							</div>

							<p class="outer-link">
								아직 회원이 아니신가요? <a
									href="${pageContext.request.contextPath}/member/viewSignUp">회원가입
									하기 </a>
							</p>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- End Account Login Area -->

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
	var emailExp = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/; // 이메일 정규식(testuser@test.com)
	function checkMail() {
		let email = $("#email").val();
		if (emailExp.test(email)) { // 이메일 정규식 검사
			sendMail(email);
			isMsg("email", "잠시만 기다려 주세요", "green", true);
			$("#sendMailBtn").attr("disabled", true);
			$("#email").attr("readonly", true);
		} else {
			isMsg("email", "이메일 형식이 아닙니다.", "red", false);
		}

	}
	
	// 입력값에 따라 msg출력
	function isMsg(id, msg, color, result) {
		$("#" + id).next().text(msg);
		$("#" + id).next().css("color", color);
		$("#" + id).next().next().val(result);
	}

	function sendMail(email) {
		$.ajax({
			url : "/member/find/id",
			type : "GET",
			data : {
				email : email
			},
			dataType : "json",
			success : function(data) {
				console.log(data);
				if(data.status=="success") {
					isMsg("email", "이메일을 전송했습니다.", "blue", true);
					$("#email").attr("readonly", true);
					$("#sendMailBtn").attr("disabled", true);
				} else if(data.status=="fail" && data.value=="없는 이메일") {
					isMsg("email", "가입되지 않은 이메일 입니다.", "red", false);
					$("#email").attr("readonly", false);
					$("#sendMailBtn").attr("disabled", false);
				} else {
					isMsg("email", "알수없는 에러", "red", false);
					$("#email").attr("readonly", false);
					$("#sendMailBtn").attr("disabled", false);
				}
			},
			error : function() {
			},
			complete : function() {
			},
		});
	}
</script>

</html>