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
	href="/resources/assets/user/images/logo/white-logo.svg" />

<!-- ========================= CSS here ========================= -->
<link rel="stylesheet"
	href="/resources/assets/user/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="/resources/assets/user/css/LineIcons.3.0.css" />
<link rel="stylesheet" href="/resources/assets/user/css/tiny-slider.css" />
<link rel="stylesheet"
	href="/resources/assets/user/css/glightbox.min.css" />
<link rel="stylesheet" href="/resources/assets/user/css/main.css" />




<style type="text/css">
	.user-login li a:hover{
		color: red; 
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
						<div class="top-left">
						</div>
					</div>
					<div class="col-lg-4 col-md-4 col-12">
						<div class="top-middle">
						</div>
					</div>
					<div class="col-lg-4 col-md-4 col-12">
						<div class="top-end">
						<!-- 로그인 안됬을 때 -->
							<c:if test="${empty sessionScope.loginMember }">
								<div class="user">
									<i class="lni lni-user"></i> 로그인하세요.

								</div>
								<ul class="user-login">
									<li><a href="/member/viewLogin">로그인</a></li>
									<li><a href="/member/viewSignUp">회원가입</a></li>
								</ul>
							</c:if>
							<!-- 로그인 됬을 때 -->
							<c:if test="${not empty sessionScope.loginMember }">
								<div class="user">
									<i class="lni lni-user"></i>
									${sessionScope.loginMember.member_name } 님
								</div>
								<ul class="user-login">
									<li><a href="#">내 정보</a></li>
									<li><a href="/member/logout">로그아웃</a></li>
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
						<a class="navbar-brand" href="/"> <img
							src="/resources/assets/user/images/logo/logo.svg" alt="Logo">
						</a>
						<!-- End Header Logo -->
					</div>
					<div class="col-lg-5 col-md-7 d-xs-none">
						<!-- Start Main Menu Search -->
						<div class="main-menu-search">
							<!-- navbar search start -->
							<div class="navbar-search search-style-5">
								<div class="search-select">
									<div class="select-position">
										<select id="select1">
											<option selected>All</option>
											<option value="1">option 01</option>
											<option value="2">option 02</option>
											<option value="3">option 03</option>
											<option value="4">option 04</option>
											<option value="5">option 05</option>
										</select>
									</div>
								</div>
								<div class="search-input">
									<input type="text" placeholder="Search">
									
								</div>
								<div class="search-btn">
									<button>
										<i class="lni lni-search-alt"></i>
									</button>
								</div>
							</div>
							<!-- navbar search Ends -->
						</div>
						<!-- End Main Menu Search -->
					</div>
					<div class="col-lg-4 col-md-2 col-5">
						<div class="middle-right-area">
							<div class="nav-hotline">
								<i class="lni lni-phone"></i>
								<h3>
									Hotline: <span>(+100) 123 456 7890</span>
								</h3>
							</div>
							<div class="navbar-cart">
								<div class="wishlist">
									<a href="javascript:void(0)"> <i class="lni lni-heart"></i>
										<span class="total-items">0</span>
									</a>
								</div>
								<div class="cart-items">
									<a href="/cart" class="main-btn"> <i
										class="lni lni-cart"></i> <span class="total-items">${cartItemCount }</span>
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
				<div class="col-lg-8 col-md-6 col-12">
					<div class="nav-inner">
						<!-- Start Mega Category Menu -->
                        <div class="mega-category-menu">
                            <a href="/product/jewelry/all"><span class="cat-button"><i class="lni lni-menu"></i>JEWELRY</span></a>
                            <ul class="sub-category">
                                <li><a href="/product/jewelry?category=196">NACKLACE</a></li>
                                <li><a href="/product/jewelry?category=195">EARRING</a></li>
							    <li><a href="/product/jewelry?category=203">PIERCING</a></li>
							    <li><a href="/product/jewelry?category=197">BANGLE</a></li>
							    <li><a href="/product/jewelry?category=201">ANKLET</a></li>
							    <li><a href="/product/jewelry?category=198">RING</a></li>
							    <li><a href="/product/jewelry?category=200">COUPLING</a></li>
							    <li><a href="/product/jewelry?category=202">PENDANT</a></li>
							    <li><a href="/product/jewelry?category=204">기타</a></li>
                            </ul>
                        </div>
                        <!-- End Mega Category Menu -->
						<!-- Start Navbar -->
						<nav class="navbar navbar-expand-lg">
							<button class="navbar-toggler mobile-menu-btn" type="button"
								data-bs-toggle="collapse"
								data-bs-target="#navbarSupportedContent"
								aria-controls="navbarSupportedContent" aria-expanded="false"
								aria-label="Toggle navigation">
								<span class="toggler-icon"></span> <span class="toggler-icon"></span>
								<span class="toggler-icon"></span>
							</button>
							<div class="collapse navbar-collapse sub-menu-bar"
								id="navbarSupportedContent">
								<ul id="nav" class="navbar-nav ms-auto">
									<li class="nav-item"><a href="index.html" class="active"
										aria-label="Toggle navigation">Home</a></li>
									<li class="nav-item"><a class="dd-menu collapsed"
										href="javascript:void(0)" data-bs-toggle="collapse"
										data-bs-target="#submenu-1-2"
										aria-controls="navbarSupportedContent" aria-expanded="false"
										aria-label="Toggle navigation">Pages</a>
										<ul class="sub-menu collapse" id="submenu-1-2">
											<li class="nav-item"><a href="about-us.html">About
													Us</a></li>
											<li class="nav-item"><a href="faq.html">Faq</a></li>
											<c:if test="${empty sessionScope.loginMember }">
											<li class="nav-item"><a href="member/viewLogin">로그인</a></li>
											<li class="nav-item"><a href="member/viewSignUp">회원가입</a></li>
											</c:if>
											<c:if test="${not empty sessionScope.loginMember }">
											<li class="nav-item"><a href="#">내 정보</a></li>
											<li class="nav-item"><a href="member/logout">로그아웃</a></li>
											</c:if>
											<li class="nav-item"><a href="mail-success.html">Mail
													Success</a></li>
											<li class="nav-item"><a href="404.html">404 Error</a></li>
										</ul></li>
									<li class="nav-item"><a class="dd-menu collapsed"
										href="javascript:void(0)" data-bs-toggle="collapse"
										data-bs-target="#submenu-1-3"
										aria-controls="navbarSupportedContent" aria-expanded="false"
										aria-label="Toggle navigation">Shop</a>
										<ul class="sub-menu collapse" id="submenu-1-3">
											<li class="nav-item"><a href="product-grids.html">Shop
													Grid</a></li>
											<li class="nav-item"><a href="/product/productList">상품 리스트</a></li>
											<li class="nav-item"><a href="/product/productDetail">상품 상세</a></li>
											<li class="nav-item"><a href="/cart">Cart</a></li>
											<li class="nav-item"><a href="/order">Checkout</a></li>
										</ul></li>
									<li class="nav-item"><a class="dd-menu collapsed"
										href="javascript:void(0)" data-bs-toggle="collapse"
										data-bs-target="#submenu-1-4"
										aria-controls="navbarSupportedContent" aria-expanded="false"
										aria-label="Toggle navigation">Blog</a>
										<ul class="sub-menu collapse" id="submenu-1-4">
											<li class="nav-item"><a href="blog-grid-sidebar.html">Blog
													Grid Sidebar</a></li>
											<li class="nav-item"><a href="blog-single.html">Blog
													Single</a></li>
											<li class="nav-item"><a href="blog-single-sidebar.html">Blog
													Single Sibebar</a></li>
										</ul></li>
									<li class="nav-item"><a href="contact.html"
										aria-label="Toggle navigation">Contact Us</a></li>
								</ul>
							</div>
							<!-- navbar collapse -->
						</nav>
						<!-- End Navbar -->
					</div>
				</div>
				<div class="col-lg-4 col-md-6 col-12">
					<!-- Start Nav Social -->
					<div class="nav-social">
						<h5 class="title">Follow Us:</h5>
						<ul>
							<li><a href="javascript:void(0)"><i
									class="lni lni-facebook-filled"></i></a></li>
							<li><a href="javascript:void(0)"><i
									class="lni lni-twitter-original"></i></a></li>
							<li><a href="javascript:void(0)"><i
									class="lni lni-instagram"></i></a></li>
							<li><a href="javascript:void(0)"><i
									class="lni lni-skype"></i></a></li>
						</ul>
					</div>
					<!-- End Nav Social -->
				</div>
			</div>
		</div>
		<!-- End Header Bottom -->
	</header>
	<!-- End Header Area -->
</body>
</html>