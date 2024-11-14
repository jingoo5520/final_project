<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ELOLIA</title>
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
						<h1 class="page-title">로그인 (KAKAO)</h1>
					</div>
				</div>
				<div class="col-lg-6 col-md-6 col-12">
					<ul class="breadcrumb-nav">
						<li><a href="index.html"><i class="lni lni-home"></i>
								Home</a></li>
						<li>Login</li>
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
								<h3>로그인 하세요</h3>
								<p>You can login using your social media account or email
									address.</p>
							</div>
							<div class="social-login">
								<div class="row">
									<div class="col-lg-4 col-md-4 col-12">
										<a class="btn facebook-btn" href="javascript:void(0)"><i
											class="lni lni-facebook-filled"></i> 페이스북 로그인</a>
									</div>
									<div class="col-lg-4 col-md-4 col-12">
										<a class="btn twitter-btn" href="javascript:void(0)"><i
											class="lni lni-twitter-original"></i> 트위터 로그인</a>
									</div>
									<div class="col-lg-4 col-md-4 col-12">
										<a class="btn google-btn" href="javascript:void(0)"><i
											class="lni lni-google"></i> 구글 로그인</a>
									</div>
								</div>
							</div>
							<div class="alt-option">
								<span>Or</span>
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

</html>
