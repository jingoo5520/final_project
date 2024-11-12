<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html class="no-js" lang="zxx">

<head>
<meta charset="utf-8" />
<meta http-equiv="x-ua-compatible" content="ie=edge" />
<title>ELOLIA</title>
<meta name="description" content="" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="shortcut icon" type="image/x-icon" href="/resources/assets/user/images/logo/favicon.png" />

<!-- ========================= CSS here ========================= -->
<link rel="stylesheet" href="/resources/assets/user/css/bootstrap.min.css" />
<link rel="stylesheet" href="/resources/assets/user/css/LineIcons.3.0.css" />
<link rel="stylesheet" href="/resources/assets/user/css/tiny-slider.css" />
<link rel="stylesheet" href="/resources/assets/user/css/glightbox.min.css" />
<link rel="stylesheet" href="/resources/assets/user/css/main.css" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script>
	$(document).ready(function() {
		getPaidCouponList();
		getUsedCouponList();
		getRecentCouponList();
	});
	
	function getPaidCouponList() {
		
		$.ajax({
			async: false,
			type: 'GET',
			url: '/member/myPage/getPaidCouponList',
			dataType: 'json',
	        success : function(response) {
	        	console.log("paidCouponList" + response.paidCouponList);
	        	makeCouponList(response.paidCouponList);
	        },
	        error : function(response) {
	        }
		})
		
	}
	
	function getRecentCouponList() {
		
		$.ajax({
			async: false,
			type: 'GET',
			url: '/member/myPage/getRecentCouponList',
			dataType: 'json',
	        success : function(response) {
	        	console.log("recentCouponList" + response.recentCouponList);
	        	makeCouponList(response.recentCouponList);
	        },
	        error : function(response) {
	        }
		})
		
	}

	function getUsedCouponList() {
		
		$.ajax({
			async: false,
			type: 'GET',
			url: '/member/myPage/getUsedCouponList',
			dataType: 'json',
	        success : function(response) {
	        	console.log("usedCouponList" + response.usedCouponList);
	        	makeCouponList(response.usedCouponList);
	        },
	        error : function(response) {
	        }
		})
		
	}
	
	function makeCouponList(couponList) {
		$.each(couponList, function(index, item) {
			console.log(item);
		});
	}

</script>

</head>

<style>
	
</style>

<body>
	<!-- Preloader -->
	<div class="preloader">
		<div class="preloader-inner">
			<div class="preloader-icon">
				<span></span>
				<span></span>
			</div>
		</div>
	</div>
	<!-- /End Preloader -->

	<jsp:include page="/WEB-INF/views/user/pages/header.jsp"></jsp:include>

	<!-- Start Breadcrumbs -->
	<div class="breadcrumbs">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-lg-6 col-md-6 col-12">
					<div class="breadcrumbs-content">
						<h1 class="page-title">쿠폰 내역</h1>
					</div>
				</div>
				<div class="col-lg-6 col-md-6 col-12">
					<ul class="breadcrumb-nav">
						<li><a href="/"><i class="lni lni-home"></i> Home</a></li>
						<li><a href="/member/myPage/viewOrder">MyPage</a></li>
						<li>쿠폰 내역</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- End Breadcrumbs -->

	<section class="product-grids section">
		<div class="container">
			<div class="row">
				<!-- sideBar -->
				<jsp:include page="/WEB-INF/views/user/pages/myPageSideBar.jsp">

					<jsp:param name="pageName" value="couponList" />

				</jsp:include>
				<!-- / sideBar -->
				
				<div class="col-lg-9 col-12">
					<div class="couponList"></div>
				</div>
				
			</div>
		</div>
	</section>

	<jsp:include page="/WEB-INF/views/user/pages/footer.jsp"></jsp:include>
	
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