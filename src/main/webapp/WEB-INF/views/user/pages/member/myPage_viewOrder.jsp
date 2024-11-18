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

<!-- 커스텀 스타일 -->
<style>
	.btn {
		width: 100%;
	}

	.form-group input.text-input:focus {
		border-color: #A8A691;
	}

	.form-group input.text-input {
		width: 100%;
		padding: 15px 20px;
		border-radius: 4px;
		border: 1px solid #e6e2f5;
		transition: all 0.4s ease;
		margin-bottom: 1rem;
	}

	.form-group textarea:focus {
  		border-color: #A8A691;
		resize: none;
	}
	
	.form-group textarea {
		height: 180px;
		width: 100%;
		border: 1px solid #e6e2f5;
		padding: 15px 20px;
		color: #333;
		resize: none;
		font-weight: 400;
		resize: vertical;
		border-radius: 4px;
		background-color: #fff;
		-webkit-transition: all 0.4s ease;
		transition: all 0.4s ease;
	}
	
	#emptyOrderList {
	    display: flex;
	    justify-content: center; /* 수평 정렬 */
	    align-items: center;    /* 수직 정렬 */
	    height: 100%;
	}
	
	<!-- 모달 디자인 -->
	.modal-content .modal-header{
		margin: 0;
		height: 65px;
		border: none !important;
	}
	
	.modal-content .modal-body {
		height: 100px;
		border: none !important;
		
	}
	
	.modal-content .modal-body .modal-text {
		height: 20px;
		text-align: center;
		font-weight: bold;
		font-size: 16px;
		color: rgb(34,34,34);
		display: block;
	}
	
	.modal-content .modal-footer {
		height: 60px;
		padding:0;
		display: flex;
		justify-content: space-between !important;
		margin:0 !important;
	}
	
	.exceeded {
		color: red;
	}

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>

<style>
#writeInquiryBtnArea {
	display: flex;
	flex-direction: row;
	justify-content: flex-end;
}

.cart-single-list {
	padding: 10px 20px !important;
}

.pagination {
	margin: 20px 0px !important;
}

.cart-single-list:hover {
	background-color: #f0f0f0;
	cursor: pointer;
	transition: background-color 0.3s ease;
}
</style>

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

	<jsp:include page="/WEB-INF/views/user/pages/header.jsp"></jsp:include>

	<!-- Start Breadcrumbs -->
	<div class="breadcrumbs">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-lg-6 col-md-6 col-12">
					<div class="breadcrumbs-content">
						<h1 class="page-title">주문 / 배송 조회</h1>
					</div>
				</div>
				<div class="col-lg-6 col-md-6 col-12">
					<ul class="breadcrumb-nav">
						<li>
							<a href="/">
								<i class="lni lni-home"></i> Home
							</a>
						</li>
						<li>
							<a href="/member/myPage/viewOrder">MyPage</a>
						</li>
						<li>주문 / 배송 조회</li>
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
					<jsp:param name="pageName" value="viewOrder" />
				</jsp:include>
				<!-- / sideBar -->

				<div class="col-lg-9 col-12" id="productsView">
				</div>

				<!--/ End Shopping Cart -->
			</div>
		</div>
	</section>
	<!-- End Product Grids -->

	<!-- 모달 -->
	<div class="modal fade" id="alertModal" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
				<p class="modal-text">변경처리할 상품을 선택하십시오.</p>
				</div>

				<!-- Modal footer 
				<div class="modal-footer">
				</div> -->

			</div>
		</div>
	</div>




	<jsp:include page="/WEB-INF/views/user/pages/footer.jsp"></jsp:include>

	<!-- ========================= scroll-top ========================= -->
	<a href="#" class="scroll-top">
		<i class="lni lni-chevron-up"></i>
	</a>

	<!-- ========================= JS here ========================= -->
	<script src="/resources/assets/user/js/bootstrap.min.js"></script>
	<script src="/resources/assets/user/js/tiny-slider.js"></script>
	<script src="/resources/assets/user/js/glightbox.min.js"></script>
	<script src="/resources/assets/user/js/main.js"></script>

	<script src="/resources/assets/user/js/viewOrder.js"></script>

	<script>
		var orderInfo = null

		$(document).ready(function() {
			orderInfo = loadOrderInfo()
			showViewOrderPage(orderInfo)
		})

		// 모달 열기
		function openModal(title, text) {
			/* 		$("#modalcontainer").css("display", "block");
			 $("#modalTitle").text(title);
			 $("#modalText").html(text); */
			$('#myModal').modal('show');
		}
	</script>
</body>

</html>