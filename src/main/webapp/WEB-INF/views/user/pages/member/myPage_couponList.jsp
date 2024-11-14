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
	        	makePaidCouponList(response.paidCouponList);
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
	        	makeRecentCouponList(response.recentCouponList);
	        	show(response.recentCouponList);
	        },
	        error : function(response) {
	        }
		})
		
	}
	
	function show(recentCouponList) {
		$.each(recentCouponList, function (index, item) {
			console.log(item);
		});
		
	}

	function makeRecentCouponList(recentCouponList) {
		const today = new Date();
		let output = "";
		let couponDCText = "";
		let expireText = "";
		let usedDateText = "";
		let usedCouponCard = "";
		$(".recentCouponCount").html("총 <span style='color:#fd5a67'> " + recentCouponList.length + "</span> 개");
		output += "<div class='row couponCards'>";
		$.each(recentCouponList, function (index, item) {
			const expireDate = new Date(item.expire_date.replace(" ", "T"));
			if (item.member == "All") {
				if (item.coupon_dc_type == "R") {
					couponDCText = `\${item.coupon_dc_rate * 100} %`;
				} else if (item.coupon_dc_type == "A"){
					couponDCText = `\${item.coupon_dc_amount.toLocaleString('ko-KR')} 원`;
				}
				if (expireDate >= today) {
					expireText = `<span style="color: #0DCAF0">사용가능</span>`;
				} else if (expireDate < today) {
					expireText = `<span style="color: #FD5A67">만료됨</span>`;
				}
				if (item.use_date != null) {
					usedDateText = `<div>
										<p>지급 날짜 : \${item.pay_date}</p>
										<p>사용 날짜 : \${item.use_date.substring(0, 10)}</p>
									</div>`;
					expireText = `<span style="color: #FD5A67">사용됨</span>`;
					usedCouponCard = `<div class='couponCard usedCouponCard card mb-30 col-lg-5 col-md-5 col-12' id="\${item.coupon_no}_coupon">`;
				} else if (item.use_date == null) {
					usedDateText = `<p>지급 날짜 : \${item.pay_date}</p>`;
					usedCouponCard = `<div class='couponCard card mb-30 col-lg-5 col-md-5 col-12' id="\${item.coupon_no}_coupon">`;
				}
				output += `\${usedCouponCard}
								<div class='card-header'>전체 지급</div>
								<div class='card-body'>
									<h4>\${item.coupon_name}</h4>
									<div class="couponInfo mt-30">
										\${expireText}
										\${usedDateText}
									</div>
								</div>
								<div class='card-footer'>
									<div>
										<h3>\${couponDCText}</h3>
									</div>
								</div>
							</div>`;
			} else {
				if (item.coupon_dc_type == "R") {
					couponDCText = `\${item.coupon_dc_rate * 100} %`;
				} else if (item.coupon_dc_type == "A"){
					couponDCText = `\${item.coupon_dc_amount.toLocaleString('ko-KR')} 원`;
				}
				if (expireDate >= today) {
					expireText = `<span style="color: #0DCAF0">사용가능</span>`;
				} else if (expireDate < today) {
					expireText = `<span style="color: #FD5A67">만료됨</span>`;
				}
				if (item.use_date != null) {
					usedDateText = `<div>
										<p>지급 날짜 : \${item.pay_date}</p>
										<p>사용 날짜 : \${item.use_date.substring(0, 10)}</p>
									</div>`;
					expireText = `<span style="color: #FD5A67">사용됨</span>`;
					usedCouponCard = `<div class='couponCard usedCouponCard card mb-30 col-lg-5 col-md-5 col-12' id="\${item.coupon_no}_coupon">`;
				} else if (item.use_date == null) {
					usedDateText = `<p>지급 날짜 : \${item.pay_date}</p>`;
					usedCouponCard = `<div class='couponCard card mb-30 col-lg-5 col-md-5 col-12' id="\${item.coupon_no}_coupon">`;
				}
				output += `\${usedCouponCard}
								<div class='card-header'>특별 지급</div>
								<div class='card-body'>
									<h4>\${item.coupon_name}</h4>
									<div class="couponInfo mt-30">
										\${expireText}
										\${usedDateText}
									</div>
								</div>
								<div class='card-footer'>
									<div>
										<h3>\${couponDCText}</h3>
									</div>
								</div>
							</div>`;
			}
			
			
		});
		output += "</div>";
		output = output;
		
		$(".recentCouponList-body").html(output);
	}
	
	function makePaidCouponList(paidCouponList) {
		let output = "";
		let couponDCText = "";
		let remainingDaysText = "";
		$(".paidCouponCount").html("총 <span style='color:#fd5a67'> " + paidCouponList.length + "</span> 개");
		output += "<div class='row couponCards'>";
		$.each(paidCouponList, function (index, item) {
			if (item.member == "All") {
				if (item.coupon_dc_type == "R") {
					couponDCText = `\${item.coupon_dc_rate * 100} %`;
				} else if (item.coupon_dc_type == "A"){
					couponDCText = `\${item.coupon_dc_amount.toLocaleString('ko-KR')} 원`;
				}
				if (item.remaining_days > 14) {
					remainingDaysText = `<span style="color: #0DCAF0">\${item.remaining_days} 일</span>`;
				} else if (item.remaining_days <= 14) {
					remainingDaysText = `<span style="color: #FD5A67">\${item.remaining_days} 일</span>`;
				}
				
				output += `<div class='couponCard card mb-30 col-lg-5 col-md-5 col-12' id="\${item.coupon_no}_coupon">
								<div class='card-header'>전체 지급</div>
								<div class='card-body'>
									<h4>\${item.coupon_name}</h4>
									<div class="couponInfo mt-30">
										<p>남은 기한 : \${remainingDaysText}</p>
										<p>지급 날짜 : \${item.pay_date}</p>
									</div>
								</div>
								<div class='card-footer'>
									<div>
										<h3>\${couponDCText}</h3>
									</div>
								</div>
							</div>`;
			} else {
				if (item.coupon_dc_type == "R") {
					couponDCText = `\${item.coupon_dc_rate * 100} %`;
				} else if (item.coupon_dc_type == "A"){
					couponDCText = `\${item.coupon_dc_amount.toLocaleString('ko-KR')} 원`;
				}
				if (item.remaining_days > 14) {
					remainingDaysText = `<span style="color: #0DCAF0">\${item.remaining_days} 일</span>`;
				} else if (item.remaining_days <= 14) {
					remainingDaysText = `<span style="color: #FD5A67">\${item.remaining_days} 일</span>`;
				}
				
				output += `<div class='couponCard card mb-30 col-lg-5 col-md-5 col-12' id="\${item.coupon_no}_coupon">
							<div class='card-header'>특별 지급</div>
							<div class='card-body'>
								<h4>\${item.coupon_name}</h4>
								<div class="couponInfo mt-30">
									<p>남은 기한 : \${remainingDaysText}</p>
									<p>지급 날짜 : \${item.pay_date}</p>
								</div>
							</div>
							<div class='card-footer'>
								<div>
									<h3>\${couponDCText}</h3>
								</div>
							</div>
						</div>`;
			}
			
			
		});
		output += "</div>";
		output = output;
		
		$(".paidCouponList-body").html(output);
	}

</script>

</head>

<style>
	#nav-tab, .nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active {
		border:none;
	}
	
	.couponList {
		padding: 14px;
		border: 1px solid #eee;
		border-radius: 4px;
		padding-bottom: 50px;
	}
	
	#nav-tab {
		height: 51px;
		padding: 9px;
	}
	
	#nav-tab button {
		font-size: 18px;
		padding: 0;
	}
	
	#nav-tab .active{
		color: #222222 !important;
	}
	
	#nav-tab .nav-link {
		color: #888888;
		font-weight: bold;
	}
	
	#paidCouponList-tab {
		margin-right: 10px;
	}
	
	#recentCouponList-tab {
		margin-left: 10px;
	}
	
	#nav-tabContent {
		border-top: 1px solid #e6e6e6;
		padding-top: 20px;
	}
	
	.couponList {
		background-color: #FFFFFF !important;
	}
	
	.couponCard .card-header,
	.couponCard .card-footer {
		border: none;
		background-color: #FFFFFF;
	}
	
	.couponCard .card-footer {
		height: 38px;
	}
	
	.couponCard .cart-body {
		padding: 0 16px !important;
	}
	
	.couponCard .couponInfo {
		display: flex;
		justify-content: space-between;
	}
	
	.couponCard .card-body {
		padding: 0 16px;
	}
	
	.couponCard .card-footer {
		padding: 5px 16px 8px 16px;
	}
	
	.paidCouponCount, .recentCouponCount {
		margin-bottom: 30px;
		display:flex;
		align-items:center;
		margin-left: 21px;
	}
	
	.couponCard {
		margin: 30px 30px;
	}
	
	.couponCards {
		display: flex;
		justify-content: space-between !important;
	}
	
	.paidCouponCount span, .recentCouponCount span {
		margin-left: 5px;
		margin-right: 5px;
	}
	
	.usedCouponCard .card-header,
	.usedCouponCard .card-footer,
	.usedCouponCard {
		background-color : #eee !important;
	}
	
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
					<div class="couponList">
						<nav>
							<div class="nav nav-tabs" id="nav-tab" role="tablist">
								<button class="nav-link active" id="paidCouponList-tab" data-bs-toggle="tab" data-bs-target="#paidCouponList" type="button" role="tab" aria-controls="paidCouponList" aria-selected="true" onclick="getPaidCouponList()">사용가능한 쿠폰</button>
								<button class="nav-link" id="recentCouponList-tab" data-bs-toggle="tab" data-bs-target="#recentCouponList" type="button" role="tab" aria-controls="recentCouponList" aria-selected="false" onclick="getRecentCouponList()">지난 쿠폰 (최근 3개월)</button>
							</div>
						</nav>
						<div class="tab-content" id="nav-tabContent">
							<div class="tab-pane fade show active" id="paidCouponList" role="tabpanel" aria-labelledby="paidCouponList-tab" tabindex="0">
								<div class="paidCouponCount">총 0개</div>
								<div class="paidCouponList-body"></div>
							</div>
							<div class="tab-pane fade" id="recentCouponList" role="tabpanel" aria-labelledby="recentCouponList-tab" tabindex="0">
								<div class="recentCouponCount">총 0개</div>
								<div class="recentCouponList-body"></div>
							</div>
						</div>
					</div>
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