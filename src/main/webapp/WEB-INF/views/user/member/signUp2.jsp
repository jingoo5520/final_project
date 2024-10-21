<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<!-- ========================= CSS here ========================= -->
<link rel="stylesheet"
	href="/resources/assets/user/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="/resources/assets/user/css/LineIcons.3.0.css" />
<link rel="stylesheet" href="/resources/assets/user/css/tiny-slider.css" />
<link rel="stylesheet"
	href="/resources/assets/user/css/glightbox.min.css" />
<link rel="stylesheet" href="/resources/assets/user/css/main.css" />

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
							<h3>No Account? Register</h3>
							<p>Registration takes less than a minute but gives you full
								control over your orders.</p>
						</div>
						<form class="row" action="/member/signUp" method="post">
							<div class="col-sm-12">
								<div class="form-group">
									<label for="reg-id">*아이디</label> <input class="form-control"
										type="text" name="member_id" id="member_id" required><span
										id="idStatus"></span> <input type="hidden" value="">
								</div>
							</div>
							<div class="col-sm-6">
								<div class="form-group">
									<label for="reg-pw">*비밀번호</label> <input class="form-control"
										type="password" name="member_pwd" id="member_pwd" required><span
										id="pwdStatus"></span><input type="hidden" value="">
								</div>
							</div>
							<div class="col-sm-6">
								<div class="form-group">
									<label for="reg-pw2">*비밀번호 확인</label> <input
										class="form-control" type="password" name="member_pwd2"
										id="member_pwd2" required><span id="pwd2Status"></span><input
										type="hidden" value="">
								</div>
							</div>
							<div class="col-sm-6">
								<div class="form-group">
									<label for="reg-n">*이름</label> <input class="form-control"
										type="text" name="member_name" id="member_name" required><span
										id="nameStatus"></span> <input type="hidden" value="">
								</div>
							</div>
							<div class="col-sm-6">
								<div class="form-group">
									<label for="reg-nn">별명</label> <input class="form-control"
										type="text" name="nickname" id="nickname" required><span
										id="nicknameStatus"></span> <input type="hidden" value="">
								</div>
							</div>
							<div class="col-sm-6">
								<div class="form-group">
									<label for="reg-bd">생일</label> <input class="form-control"
										type="date" name="birthday" id="birthday" required><span
										id="birthdayStatus"></span> <input type="hidden" value="">
								</div>
							</div>
							<div class="col-sm-6">
								<div id="gender" class="area">
									성별<span id="genderStatus"></span><input type="hidden" value="">
								</div>
								<div class="form-check">
									<input type="radio" class="form-check-input" id="M"
										name="gender" value="M"> <label
										class="form-check-label" for="M">남자</label>
								</div>
								<div class="form-check">
									<input type="radio" class="form-check-input" id="F"
										name="gender" value="F"> <label
										class="form-check-label" for="F">여자</label>
								</div>
							</div>
							<div class="col-sm-6">
								<div class="form-group">
									<label for="reg-nn">*주소</label> <input class="form-control"
										type="text" name="address" id="address" readonly
										onclick="selectAddress(this);"><span
										id="addressStatus"></span> <input type="hidden" value="">
								</div>
							</div>
							<div class="col-sm-6">
								<div class="form-group">
									<label for="reg-nn">상세 주소</label> <input class="form-control"
										type="text" name="address2" id="address2" required><span
										id="address2Status"></span> <input type="hidden" value="">
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="reg-nn">*이메일</label> <input class="form-control"
										type="text" name="email" id="email" required><span
										id="emailStatus"></span> <input type="hidden" value="">
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label for="reg-nn">*휴대폰</label> <input class="form-control"
										type="text" name="phone_number" id="phone_number" required><span
										id="phoneStatus"></span> <input type="hidden" value=""><input
										type="button" value="인증요청" onclick="phoneVerify();">
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
								</div>
							</div>

							<div class="button">
								<button class="btn" type="submit" value="회원가입"
									onclick="return checkData();">회원 가입</button>
							</div>
							<p class="outer-link">
								이미 ELOLIA의 회원이신가요? <a href="login.html">로그인 하기</a>
							</p>
						</form>
					</div>
				</div>
			</div>
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

</html>