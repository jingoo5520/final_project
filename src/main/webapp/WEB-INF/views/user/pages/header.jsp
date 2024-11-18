<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html class="no-js" lang="zxx">
<head>
<meta charset="utf-8" />
<meta http-equiv="x-ua-compatible" content="ie=edge" />
<title>Header</title>
<meta name="description" content="" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="shortcut icon" type="image/x-icon"
	href="/resources/assets/user/images/logo/favicon.png" />

<!-- ========================= CSS here ========================= -->
<link rel="stylesheet" href="/resources/assets/user/css/bootstrap.min.css" />
<link rel="stylesheet" href="/resources/assets/user/css/LineIcons.3.0.css" />
<link rel="stylesheet" href="/resources/assets/user/css/tiny-slider.css" />
<link rel="stylesheet" href="/resources/assets/user/css/glightbox.min.css" />
<link rel="stylesheet" href="/resources/assets/user/css/main.css" />

<style type="text/css">
.user-login a:hover {
	color: #fff !important;
}

.levelImg {
	width: 30px;
	border-radius: 10px;
	margin-bottom: 5px;
}
</style>
</head>
<body>
	<!-- Start Header Area -->
	<header class="header navbar-area">
		<!-- Start Topbar -->
		<div class="topbar">
			<div class="container" id="test">
				<div class="row align-items-center">
					<div class="col-lg-4 col-md-4 col-12">
						<div class="top-left"></div>
					</div>
					<div class="col-lg-4 col-md-4 col-12">
						<div class="top-middle"></div>
					</div>
					<div class="col-lg-4 col-md-4 col-12">
						<div class="top-end">
							<!-- 로그인 안됬을 때 -->
							<c:if test="${empty sessionScope.loginMember }">
								<div class="user">
									<i class="lni lni-user"></i> 로그인하세요.
								</div>
								<ul class="user-login">
									<li><a href="${pageContext.request.contextPath}/member/viewLogin">로그인</a></li>
									<li><a href="${pageContext.request.contextPath}/member/viewSignUp">회원가입</a></li>
									<li><a href="/serviceCenter/inquiries">고객센터</a></li>
								</ul>
							</c:if>
							<!-- 로그인 됬을 때 -->
							<c:if test="${not empty sessionScope.loginMember }">
								<div class="user">
									<c:if test="${sessionScope.loginMember.member_level == 1}">

										<a
											href="${pageContext.request.contextPath}/member/myPage/viewOrder"><img
											class="levelImg" alt="" src="/resources/images/bronze.png"></a>
									</c:if>
									<c:if test="${sessionScope.loginMember.member_level == 2}">
										<a
											href="${pageContext.request.contextPath}/member/myPage/viewOrder"><img
											class="levelImg" alt="" src="/resources/images/silver.png"></a>
									</c:if>
									<c:if test="${sessionScope.loginMember.member_level == 3}">
										<a
											href="${pageContext.request.contextPath}/member/myPage/viewOrder"><img
											class="levelImg" alt="" src="/resources/images/gold.png"></a>
									</c:if>
									<c:if test="${sessionScope.loginMember.member_level == 4}">
										<a
											href="${pageContext.request.contextPath}/member/myPage/viewOrder"><img
											class="levelImg" alt="" src="/resources/images/diamond.png"></a>

									</c:if>
									${sessionScope.loginMember.nickname } 님
								</div>
								<ul class="user-login">
									<li><a href="${pageContext.request.contextPath}/member/myPage/viewOrder">내 정보</a></li>
									<li><a href="${pageContext.request.contextPath}/member/logout">로그아웃</a></li>
									<li><a href="/serviceCenter/inquiries">고객센터</a></li>
								</ul>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- End Topbar -->
		<!-- Start Header Middle -->
		<div class="header-middle">
			<div class="container">
				<div class="row align-items-center">
					<div class="col-lg-3 col-md-3 col-7">
						<!-- Start Header Logo -->
						<a class="navbar-brand" href="${pageContext.request.contextPath}/"> <img src="/resources/assets/user/images/logo/logo.svg" alt="Logo" />
						</a>
						<!-- End Header Logo -->
					</div>
					<div class="col-lg-5 col-md-7 d-xs-none"></div>
					<div class="col-lg-4 col-md-2 col-5">
						<div class="middle-right-area" style="flex-direction: row; justify-content: flex-end;">

							<div class="navbar-cart">
								<div class="wishlist">
									<a href="${pageContext.request.contextPath}/member/myPage/wishList"> <i class="lni lni-heart"></i> <span class="total-items">${wishCount }</span>
									</a>
								</div>
								<div class="cart-items">
									<a href="/cart" class="main-btn"> <i class="lni lni-cart"></i> <span class="total-items">${cartItemCount }</span>
									</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- End Header Middle -->
		<!-- Start Header Bottom -->
		<div class="container">
			<div class="row align-items-center">
				<div class="col-lg-10 col-md-6 col-6">
					<div class="nav-inner">
						<!-- Start Mega Category Menu -->
						<span class="cat-button"> </span>

						<!-- End Mega Category Menu -->
						<!-- Start Navbar -->
						<nav class="navbar navbar-expand-lg">
							<button class="navbar-toggler mobile-menu-btn" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
								<span class="toggler-icon"></span> <span class="toggler-icon"></span> <span class="toggler-icon"></span>
							</button>
							<div class="collapse navbar-collapse sub-menu-bar" id="navbarSupportedContent">
								<ul id="nav" class="navbar-nav ms-auto">

									<li class="nav-item"><a
										href="/product/jewelry?category=196"
										class="<%="nacklace".equals(request.getParameter("categoryName")) ? "active" : ""%>"
										aria-label="Toggle navigation">nacklace</a></li>
									<li class="nav-item"><a
										href="/product/jewelry?category=195"
										class="<%="earring".equals(request.getParameter("categoryName")) ? "active" : ""%>"
										aria-label="Toggle navigation">earring</a></li>
									<li class="nav-item"><a
										href="/product/jewelry?category=203"
										class="<%="piercing".equals(request.getParameter("categoryName")) ? "active" : ""%>"
										aria-label="Toggle navigation">piercing</a></li>
									<li class="nav-item"><a
										href="/product/jewelry?category=197"
										class="<%="bangle".equals(request.getParameter("categoryName")) ? "active" : ""%>"
										aria-label="Toggle navigation">bangle</a></li>
									<li class="nav-item"><a
										href="/product/jewelry?category=201"
										class="<%="anklet".equals(request.getParameter("categoryName")) ? "active" : ""%>"
										aria-label="Toggle navigation">anklet</a></li>
									<li class="nav-item"><a
										href="/product/jewelry?category=198"
										class="<%="ring".equals(request.getParameter("categoryName")) ? "active" : ""%>"
										aria-label="Toggle navigation">ring</a></li>
									<li class="nav-item"><a
										href="/product/jewelry?category=200"
										class="<%="coupling".equals(request.getParameter("categoryName")) ? "active" : ""%>"
										aria-label="Toggle navigation">coupling</a></li>
									<li class="nav-item"><a
										href="/product/jewelry?category=202"
										class="<%="pendant".equals(request.getParameter("categoryName")) ? "active" : ""%>"
										aria-label="Toggle navigation">pendant</a></li>
									<li class="nav-item"><a
										href="/product/jewelry?category=204"
										class="<%="etc".equals(request.getParameter("categoryName")) ? "active" : ""%>"
										aria-label="Toggle navigation">etc</a></li>

								</ul>
							</div>

							<!-- navbar collapse -->
						</nav>
						<!-- End Navbar -->
					</div>
				</div>
				<div class="col-lg-2 col-md-6 col-6" style="margin-block-end: 0em">
					<ul id="nav" class="navbar-nav ms-auto" style="flex-direction: row; justify-content: flex-end">
						<li class="nav-item"><a href="/event" aria-label="Toggle navigation" style="color: #b4b5b4">이벤트</a></li>
						<li class="nav-item"><a href="/serviceCenter/notice" aria-label="Toggle navigation" style="color: #b4b5b4">공지사항</a></li>
					</ul>
				</div>
			</div>
		</div>
		<!-- End Header Bottom -->
	</header>
	<!-- End Header Area -->
</body>
</html>
