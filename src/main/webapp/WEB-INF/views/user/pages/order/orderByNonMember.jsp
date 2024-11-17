<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ELOLIA</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="shortcut icon" type="image/x-icon" href="/resources/assets/user/images/logo/favicon.png" />
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- ========================= CSS here ========================= -->
<link rel="stylesheet" href="/resources/assets/user/css/bootstrap.min.css" />
<link rel="stylesheet" href="/resources/assets/user/css/LineIcons.3.0.css" />
<link rel="stylesheet" href="/resources/assets/user/css/tiny-slider.css" />
<link rel="stylesheet" href="/resources/assets/user/css/glightbox.min.css" />
<link rel="stylesheet" href="/resources/assets/user/css/main.css" />
</head>
<style>
/* 모달 */
#modalcontainer {
	display: none; /* 기본적으로 숨김 */
	position: fixed;
	z-index: 100;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgb(0, 0, 0);
	background-color: rgba(0, 0, 0, 0.4); /* 배경 색상 */
}

.modalBody {
	background-color: #fff;
	margin: 15% auto;
	padding: 30px;
	border: 1px solid #888;
	width: 30%;
}

.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}


.section {
    background-color: #f9f9f9;
}

.cart-list-title {
	background-color: white !important;
}

.cart-single-list {
	padding: 10px 20px !important;
	background-color: white !important;
}

.cart-single-list:hover {
	background-color: #f0f0f0;
	cursor: pointer;
	transition: background-color 0.3s ease;
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

.button .btn {
	width: 100%;
}
</style>

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
						<h1 class="page-title">주문조회(비회원)</h1>
					</div>
				</div>
				<div class="col-lg-6 col-md-6 col-12">
					<ul class="breadcrumb-nav">
						<li><a href="/"><i class="lni lni-home"></i>
								Home</a></li>
						<li>주문조회(비회원)</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- End Breadcrumbs -->
	
	<!-- Start Account Register Area -->
	<div class="account-login section">
		<div class="container" id="container">
			<div class="row">
				<div class="col-lg-6 offset-lg-3 col-md-10 offset-md-1 col-12">
					<div class="register-form">
						<div class="col-sm-12">
							<div class="form-group">
								<label for="name">이름</label> 
								<input class="form-control" type="text" id="name">
							</div>
						</div>
						<div class="col-sm-12">
							<div class="form-group">
								<label for="name">휴대폰 번호</label> 
								<input class="form-control" type="text" id="phoneNumber">
							</div>
						</div>
						<div class="col-sm-12">
							<div class="form-group">
								<label for="name">email</label> 
								<input class="form-control" type="text" id="email">
							</div>
						</div>
						<div class="button">
							<button class="btn" onclick="onViewOrderClick()">조회하기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- End Account Register Area -->

	<!-- TODO : 모달 예쁘게 바꾸기 -->
	<!-- 모달 -->
	<div id="modalcontainer">
		<div class="modalBody">
			<span class="close" onclick="closeModal();">&times;</span>
			<h2 id="modalTitle">제목</h2>
			<p id="modalText">내용</p>
		</div>
	</div>
	
	<jsp:include page="../footer.jsp"></jsp:include>

	<!-- ========================= scroll-top ========================= -->
	<a href="#" class="scroll-top"> <i class="lni lni-chevron-up"></i>
	</a>

	<!-- ========================= JS here ========================= -->
	<script src="/resources/assets/user/js/bootstrap.min.js"></script>
	<script src="/resources/assets/user/js/tiny-slider.js"></script>
	<script src="/resources/assets/user/js/glightbox.min.js"></script>
	<script src="/resources/assets/user/js/main.js"></script>
	
	<script src="/resources/assets/user/js/viewOrder.js"></script>
	
	<script>
		
		// submitOrderCancel 재정의 (확인 버튼을 눌렀을 때 이벤트 핸들러)
		function submitOrderCancel(cancelType) {
			let products = []
			$(".form-check-input").each(function() {
				if ($(this).is(':checked')) {
					let p = {}
					p.orderproductNo = ($(this).attr("attr-orderproduct-no"))
					p.request = ($(this).attr("attr-checked-msg"))
					products.push(p)
				}
			})
			let orderId = $("#order-id").text()
			let cancelReason = $("#cancel-reason").val()
			let accountOwner =  $("#account-owner").val()
			let accountBank = $("#account-bank").val()
			let accountNumber = $("#account-number").val()
			
			
			console.log("products : ")
			console.log(products)
			if (products.length <= 0) {
				openModal("변경처리할 상품을 선택해주세요", "")
				return false
			}

			$.ajax({
				async: false,
				type: 'POST',
				url: '/cancelOrder',
				data: JSON.stringify({
					orderId: orderId,
					cancelType: cancelType,
					products: products,
					cancelReason: cancelReason,
					accountOwner: accountOwner,
					accountBank: accountBank,
					accountNumber: accountNumber
				}),
				dataType: 'json',
				contentType: 'application/json',
	            success : function(response) {
	                console.log("/cancelOrder 요쳥의 응답 : " + response)
	                // TODO : 원본에서 이것밖에 바뀐 거 없음. 중복 코드 많음. 리팩토링 필요할지도
	                showViewOrderPage(orderInfo)
	            },
	            error : function(request, status, error) {
	                console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	                // TODO : 에러 페이지 보여주기
	            }
			})
		}
	
	
	
		// 모달 열기
		function openModal(title, text) {
			$("#modalcontainer").css("display", "block");
			$("#modalTitle").text(title);
			$("#modalText").html(text);
		}
		
		// 모달 닫기
		function closeModal() {
			$("#modalcontainer").css("display", "none");
		}
		
		function onViewOrderClick() {
			// let orderInfo;
			$.ajax({
				url: "/orderByNonMember",
				type: "GET",
				contentType: "application/json",
				dataType: 'json',
				data: {
					name: $("#name").val(),
					phoneNumber: $("#phoneNumber").val(),
					email: $("#email").val()
				},
				success: function(res) {
					console.log(res)
					orderInfo = res
					$('.account-login').removeClass('account-login').addClass('products-grid');
					$("#container").html(`<div class="row" style="justify-content: center;"><div class="col-lg-9 col-12" id="productsView"></div></div>`)
					showViewOrderPage(orderInfo)
				},
				error: function(xhr, status, error) {
					console.error(`Error: ${status}, ${error}`);
					console.error(xhr.responseText);
				}
			});
			// TODO : orderList가 빈배열이면 '입력한 정보로 주문 내역이 존재하지 않습니다. 라고 모달창 띄워주기'
		}
	</script>
</body>
</html>