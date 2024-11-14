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

<style type="text/css">
	.topHeader {
		background-image: url("/resources/assets/user/images/error/404-bg.png");
		padding: 25px 0 25px 0;
		margin: 0;
		height: 124px;
		text-align: center;
		border-bottom: 1px solid #e6e6e6;
	}
	
	.hero-area {
		margin: 90px 0 200px 0 !important;
		display: flex;
    	flex-direction: column;
    	align-items: center;
		
	}
	
	.warning {
		height: 300px;
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		text-align: center;
	}
	
	.goMain {
		width: 223px;
		height: 60px;
		font-size: 16px;
		font-weight: bold;
		line-height: 60px;
		padding: 20px 30px 0 30px !important;
	}
	
	.repositBtn {
		height: 150px;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	
	.warningImg {
    	margin-bottom: 20px;
    	text-align: center;
	}
	
	.warningInfoHead {
		font-size: 16px !important;
		font-weight: bold !important;
		color: black !important;
		margin-bottom: 10px;
		text-align: center !important;
	}
	
	.warningInfoHead span {
	    display: block; 
	}
	
</style>

</head>

<body>
	<!-- Preloader -->
	<div class="preloader">
		<div class="preloader-inner">
			<div class="preloader-icon">
				<span></span> <span></span>
			</div>
		</div>
	</div>
	<!-- /End Preloader -->

	<div class="topHeader">
		<a class="navbar-brand" href="${pageContext.request.contextPath}/">
			<img src="/resources/assets/user/images/logo/logo.svg" alt="Logo" />
		</a>
	</div>

	<!-- Start Hero Area -->
	<section class="hero-area">
		<div class="warning">
			<div class="warningImg">
				<img alt="경고" src="/resources/assets/user/images/error/warning.png">
			</div>
			<div class="warningInfo">
				<p class="warningInfoHead">
					<span> 주문 실패 <br>
					 이용에 불편을 드려 죄송합니다. 
					</span>
				</p>
				<p class="warningInfoBody">
					 일시적인 오류 혹은 변경으로 주문을 완료할 수 없습니다.<br>
					 잠시 후에 다시 시도해주십시오.<br>
					 감사합니다. 
				</p>
			</div>
		</div>
		<div class="repositBtn">
			<div class="button">
				<a class="btn goMain" href="/">메인으로</a>
			</div>
		</div>
		
	</section>
	<!-- End Shipping Info -->

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