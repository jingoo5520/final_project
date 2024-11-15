<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html class="no-js" lang="zxx">
<head>
<meta charset="utf-8" />
<meta http-equiv="x-ua-compatible" content="ie=edge" />
<title>ServiceCenterSideBar</title>
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
</style>
</head>
<body>
	<div class="col-lg-3 col-12">
		<!-- Start Product Sidebar -->
		<div class="product-sidebar">
			<!-- Start Single Widget -->
			<div class="single-widget">
				<h3>고객센터</h3>
				<ul class="list">
					<li><a href="/serviceCenter/notice" class="<%="notices".equals(request.getParameter("pageName")) ? "active" : ""%>">공지사항 </a></li>
					<li><a href="/event">이벤트 </a></li>
					<li><a href="/serviceCenter/inquiries" class="<%="inquiries".equals(request.getParameter("pageName")) ? "active" : ""%>">문의</a></li>
					<li><a href="/serviceCenter/memberships" class="<%="memberships".equals(request.getParameter("pageName")) ? "active" : ""%>">멤버십 혜택</a></li>
				</ul>
			</div>
			<!-- End Single Widget -->

		</div>
		<!-- End Product Sidebar -->
	</div>

</body>
</html>
