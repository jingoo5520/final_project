<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
h3 {
	font-size: 18px !important;
}
</style>

<body>
	<aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
		<div class="menu-inner-shadow"></div>

		<ul class="menu-inner py-1">
			<!-- Dashboard -->
			<li style="margin-top: 16px" class="menu-item <%="dashboard".equals(request.getParameter("pageName")) ? "active" : ""%>"><a href="/admin" class="menu-link"> <i class="menu-icon tf-icons bx bx-home-circle"></i>
					<div data-i18n="Analytics">Dashboard</div>
			</a></li>

			<li class="menu-header small text-uppercase"><span class="menu-header-text">Pages</span></li>

			<li class="menu-item <%="adminmemberview".equals(request.getParameter("pageName"))
		|| "adminmemberlevel".equals(request.getParameter("pageName")) ? "active open" : ""%>"><a href="javascript:void(0);" class="menu-link menu-toggle"> <i class="menu-icon tf-icons bx bx-dock-top"></i>
					<div data-i18n="managemember">회원 관리</div>
			</a>
				<ul class="menu-sub">
					<li class="menu-item <%="adminmemberview".equals(request.getParameter("pageName")) ? "active" : ""%>"><a href="/admin/memberView" class="menu-link">
							<div data-i18n="memberblack">회원 블랙</div>
						</a>
					</li>
				</ul>
			</li>

			<li class="menu-item <%="adminordercancelview".equals(request.getParameter("pageName"))
		|| "adminorderrefundview".equals(request.getParameter("pageName")) ? "active open" : ""%>"><a href="javascript:void(0);" class="menu-link menu-toggle"> <i class="menu-icon tf-icons bx bx-dock-top"></i>
					<div data-i18n="Admin Orders">주문 관리</div>
			</a>
				<ul class="menu-sub">
					<li class="menu-item <%="adminordercancelview".equals(request.getParameter("pageName")) ? "active" : ""%>"><a href="/admin/order/cancel" class="menu-link">
							<div data-i18n="orders">주문</div>
						</a>
					</li>
					<li class="menu-item <%="adminorderrefundview".equals(request.getParameter("pageName")) ? "active" : ""%>">
						<a href="/admin/order/refund" class="menu-link">
							<div data-i18n="">환불 내역</div>
						</a>
					</li>
				</ul>
			</li>

			<li class="menu-item <%="productSave".equals(request.getParameter("pageName")) || "productView".equals(request.getParameter("pageName"))
				? "active open"
				: ""%>"><a href="javascript:void(0);" class="menu-link menu-toggle"> <i class="menu-icon tf-icons bx bx-dock-top"></i>
					<div data-i18n="productmanage">상품 관리</div>
			</a>
				<ul class="menu-sub">
					<li class="menu-item <%="productSave".equals(request.getParameter("pageName")) ? "active" : ""%>"><a href="/admin/productmanage/productSave" class="menu-link">
							<div data-i18n="productSave">상품</div>
					</a></li>
					<li class="menu-item  <%="productView".equals(request.getParameter("pageName")) ? "active" : ""%>"><a href="/admin/productmanage/productView " class="menu-link">
							<div data-i18n="productView">상품 조회</div>
					</a></li>
				</ul></li>


			<li class="menu-item <%="coupons".equals(request.getParameter("pageName")) || "couponPay".equals(request.getParameter("pageName"))
		|| "couponPayLogs".equals(request.getParameter("pageName")) ? "active open" : ""%>"><a href="javascript:void(0);" class="menu-link menu-toggle"> <i class="menu-icon tf-icons bx bx-dock-top"></i>
					<div data-i18n="Amange Coupons">쿠폰 관리</div>
			</a>
				<ul class="menu-sub">

					<li class="menu-item <%="coupons".equals(request.getParameter("pageName")) ? "active" : ""%>"><a href="/admin/coupon/coupons" class="menu-link">
							<div data-i18n="Coupons">쿠폰</div>
					</a></li>
					<li class="menu-item <%="couponPay".equals(request.getParameter("pageName")) ? "active" : ""%>"><a href="/admin/coupon/couponPay" class="menu-link">
							<div data-i18n="Coupon Pay">쿠폰 지급</div>
					</a></li>
					<li class="menu-item <%="couponPayLogs".equals(request.getParameter("pageName")) ? "active" : ""%>"><a href="/admin/coupon/couponPayLogs" class="menu-link">
							<div data-i18n="Coupon use log">쿠폰 지급 내역</div>
					</a></li>
				</ul></li>

			<li class="menu-item <%="notice".equals(request.getParameter("pageName")) || "event".equals(request.getParameter("pageName"))
		? "active open"
		: ""%>"><a href="javascript:void(0);" class="menu-link menu-toggle"> <i class="menu-icon tf-icons bx bx-dock-top"></i>
					<div data-i18n="Admin Notices">공지사항 관리</div>
			</a>
				<ul class="menu-sub">
					<li class="menu-item <%="notice".equals(request.getParameter("pageName")) ? "active" : ""%>"><a href="/admin/notices/notice" class="menu-link">
							<div data-i18n="notices">공지</div>
					</a></li>
					<li class="menu-item <%="event".equals(request.getParameter("pageName")) ? "active" : ""%>"><a href="/admin/notices/event" class="menu-link">
							<div data-i18n="events">이벤트</div>
					</a></li>
				</ul></li>

			<li class="menu-item <%="adminInquiries".equals(request.getParameter("pageName")) ? "active open" : ""%>"><a href="javascript:void(0);" class="menu-link menu-toggle"> <i class="menu-icon tf-icons bx bx-dock-top"></i>
					<div data-i18n="Admin Inquiries, Reports">문의 관리</div>
			</a>
				<ul class="menu-sub">
					<li class="menu-item <%="adminInquiries".equals(request.getParameter("pageName")) ? "active" : ""%>"><a href="/admin/inquiry/adminInquiries" class="menu-link">
							<div data-i18n="inquiries">문의</div>
					</a></li>
				</ul></li>

			<li class="menu-item <%="adminReviews".equals(request.getParameter("pageName")) ? "active open" : ""%>"><a href="javascript:void(0);" class="menu-link menu-toggle"> <i class="menu-icon tf-icons bx bx-dock-top"></i>
					<div data-i18n="Admin Reviews">리뷰 관리</div>
			</a>
				<ul class="menu-sub">
					<li class="menu-item <%="adminReviews".equals(request.getParameter("pageName")) ? "active" : ""%>"><a href="/admin/review/adminReviews" class="menu-link">
							<div data-i18n="adminReviews">리뷰</div>
					</a></li>
				</ul></li>

			<li class="menu-item <%="banners".equals(request.getParameter("pageName")) ? "active open" : ""%>"><a href="javascript:void(0);" class="menu-link menu-toggle"> <i class="menu-icon tf-icons bx bx-dock-top"></i>
					<div data-i18n="Admin Homepage">홈페이지 관리</div>
			</a>
				<ul class="menu-sub">
					<li class="menu-item <%="banners".equals(request.getParameter("pageName")) ? "active" : ""%>"><a href="/admin/homepage/banners" class="menu-link">
							<div data-i18n="Banners">배너</div>
					</a></li>
				</ul></li>
		</ul>
	</aside>
</body>
</html>
