<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html class="no-js" lang="zxx">
<head>
<meta charset="utf-8" />
<meta http-equiv="x-ua-compatible" content="ie=edge" />
<title>MyPageSideBar</title>
<meta name="description" content="" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="shortcut icon" type="image/x-icon" href="/resources/assets/user/images/logo/favicon.png" />

<!-- ========================= CSS here ========================= -->
<link rel="stylesheet" href="/resources/assets/user/css/bootstrap.min.css" />
<link rel="stylesheet" href="/resources/assets/user/css/LineIcons.3.0.css" />
<link rel="stylesheet" href="/resources/assets/user/css/tiny-slider.css" />
<link rel="stylesheet" href="/resources/assets/user/css/glightbox.min.css" />
<link rel="stylesheet" href="/resources/assets/user/css/main.css" />

<style type="text/css">
.user-login li a:hover {
	color: red;
}

a.active {
	color: #a8a691 !important;
}

h3 {
	font-size: 18px !important;
}

h5 {
	color: #666 !important;
	position: relative !important;
	font-weight: 600 !important;
	font-size: 16px !important;
	display: inline-block !important;
	margin-right: 3px !important;
}
</style>
</head>
<body>
	<div class="col-lg-3 col-12">
		<!-- Start Product Sidebar -->
		<div class="product-sidebar">
				<!-- Start Single Widget -->
				<div class="single-widget">
					<h3>마이페이지</h3>
					<ul class="list">
						<li><h5>쇼핑 내역</h5></li>
						<li><a href="/member/myPage/viewOrder" class="<%="viewOrder".equals(request.getParameter("pageName")) ? "active" : ""%>">주문 / 배송 조회</a></li>
						<li><a href="/member/myPage/manageDelivery" class="<%="manageDelivery".equals(request.getParameter("pageName")) ? "active" : ""%>">배송지 관리</a></li>
					</ul>
					<hr>
					<ul class="list">
						<li><h5>내 활동</h5></li>
						<li><a href="/serviceCenter/inquiries" class="<%="inquiries".equals(request.getParameter("pageName")) ? "active" : ""%>">내 문의 </a></li>
						<li><a href="/review/writableReview" class="<%="writableReview".equals(request.getParameter("pageName")) ? "active" : ""%>">내 리뷰 </a></li>
						<li><a href="${pageContext.request.contextPath}/member/myPage/wishList" class="<%="wishList".equals(request.getParameter("pageName")) ? "active" : ""%>">내 관심상품 </a></li>
					</ul>
					<hr>
					<ul class="list">
						<li><h5>내 혜택</h5></li>
						<li><a href="/member/myPage/pointList" class="<%="pointList".equals(request.getParameter("pageName")) ? "active" : ""%>">포인트 내역 </a></li>
						<li><a href="/member/myPage/couponList" class="<%="couponList".equals(request.getParameter("pageName")) ? "active" : ""%>">쿠폰 내역 </a></li>
					</ul>
					<hr>
					<ul class="list">
						<li><h5>회원 정보</h5></li>
						<li><a href="${pageContext.request.contextPath}/member/myPage/modiInfo" class="<%="modiInfo".equals(request.getParameter("pageName")) ? "active" : ""%>">회원 정보 수정</a></li>
						<li><a href="${pageContext.request.contextPath}/member/myPage/modiPwd" class="<%="modiPwd".equals(request.getParameter("pageName")) ? "active" : ""%>">비밀 번호 변경</a></li>
						<li><a href="${pageContext.request.contextPath}/member/myPage/withdraw" class="<%="withdraw".equals(request.getParameter("pageName")) ? "active" : ""%>">회원 탈퇴</a></li>
					</ul>
				</div>
				<!-- End Single Widget -->
			</div>
		<!-- End Product Sidebar -->
	</div>
</body>
</html>
