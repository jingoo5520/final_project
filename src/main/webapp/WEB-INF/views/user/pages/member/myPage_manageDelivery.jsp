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
		getDeliveryInfo();
		const successMessage = '${successMessage}';
		
		if (successMessage) {
			$(".preloader").hide();
			$("#deliveryModal").modal("show");
			$("#deliveryModal .modal-text").html(successMessage);
			
			setTimeout(function() {
			$('#deliveryModal').modal('hide');
			}, 1500);
		}
		
	});
	
	function deleteDelivery(deliveryNo) {
		$("#deleteDeliveryModal").modal("show");
		$("#deleteDeliveryNo").val(deliveryNo);
	}

	function getDeliveryInfo() {
		
		$.ajax({
			async: false,
			type: 'GET',
			url: '/member/myPage/getDeliveryInfo',
			dataType: 'json',
	        success : function(response) {
	        	makeDeliveryList(response.deliveryList, response.memberInfo);
	        	console.log(response.deliveryList);
	        },
	        error : function(response) {
	        }
		})
		
	}

	function makeDeliveryList(deliveryList, memberInfo) {
		let mainDelivery = "";
		let output = "";
		let deliveryListCount = deliveryList.length;
		
		if (deliveryListCount == 0) {
			$(".addDeliveryArea").html(`
					<div class="button">
						<a class="btn" href="/member/myPage/addDeliveryPage?main=main">기본 배송지 등록</a>
					</div>
					`);
		}
		
		$("#countDeliveries").text(deliveryListCount);
		
		$.each(deliveryList, function(index, item) {
			let postcode = item.delivery_address.split("/")[0];
			let address = item.delivery_address.split("/")[1];
			let detailAddress = item.delivery_address.split("/")[2];
			
			if (item.is_main == "M") {
				mainDelivery = `<div class="row deliveryInfoBody">
									<div class="col-lg-2 col-md-2 col-12 memberName">
										<p>\${memberInfo.member_name}</p>
									</div>
									<div class="col-lg-8 col-md-8 col-12 addressInfo">
										<p class="deliveryName">\${item.delivery_name} <span class="badge bg-danger">기본배송지</span></p>
										<p>[\${postcode}] \${address} \${detailAddress}</p>
									</div>
									<div class="col-lg-1 col-md-1 col-12 modifyDelivery">
										<p><a onclick="window.location.href='/member/myPage/modifyDelivery?deliveryNo=\${item.delivery_no}&isMain=M'">수정</a></p>
									</div>
								</div>`;
			} else {
				output += `<div class="row deliveryInfoBody">
								<div class="col-lg-2 col-md-2 col-12 memberName">
									<p>\${memberInfo.member_name}</p>
								</div>
								<div class="col-lg-8 col-md-8 col-12 addressInfo">
									<p class="deliveryName">\${item.delivery_name} </p>
									<p>[\${postcode}] \${address} \${detailAddress}</p>
								</div>
								<div class="col-lg-1 col-md-1 col-12 modifyDelivery">
									<p><a onclick="window.location.href='/member/myPage/modifyDelivery?deliveryNo=\${item.delivery_no}&isMain=S'">수정</a></p>
								</div>
								<div class="col-lg-1 col-md-1 col-12 deleteDelivery">
									<p><a onclick="deleteDelivery(\${item.delivery_no});">삭제</a></p>
								</div>
							</div>`;
			}
		});
		
		output = mainDelivery + output;
		
		$(".deliveryInfoList").html(output);
		
	}




</script>

</head>

<style>
	.addDeliveryArea {
		display: flex;
		border-bottom: 1px solid #e6e6e6;
		justify-content: right;
		padding: 9px;
	}
	
	.deliveryCountArea {
		padding: 20px;
	}
	
	.deliveryInfoHead {
		border-bottom: 1px solid #e6e6e6;
	}
	
	.deliveryInfoHead p{
		text-align: center;
		padding-bottom: 20px;
	}
	
	.deliveryInfoBody {
		margin: 10px 0 10px 0;
		height: 50px;
		padding: 20px 0 20px 0;
		border-bottom: 1px solid #e6e6e6;
		height: 110px;
	}
	
	#countDeliveries {
		color: #FD5A67;
	}
	
	.addressInfo p {
		margin: 5px 0 5px 0;
	}
	
	.memberName, .modifyDelivery, .deleteDelivery {
		text-align: center;
		display: flex;
		align-items: center; 
		justify-content: center;
	}
	
	.deliveryName {
		text-align: center;
		display: flex;
		align-items: center;
		font-size: 16px;
		font-weight: bold;
		color: black;
	}
	
	.deliveryName span{
		margin-left: 10px;
		background-color: #FD5A67 !important;
		text-align: center;
		display: flex;
		align-items: center;
	}
	
	.modifyDelivery p a, .deleteDelivery p a {
		font-size: 16px;
		font-weight: bold;
		text-decoration: underline !important;
	}
	
	.modifyDelivery p:hover, .deleteDelivery p:hover {
		cursor:pointer;
	}
	
	.modifyDelivery {
		color: black;
		
	}
	
	.deleteDelivery {
		color: #FD5A67;
		border-left: 1px solid #e6e6e6;
	}
	
	.contents {
		background-color: #FFFFFF;
		border: 1px solid #eee;
		border-radius: 4px;
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
						<h1 class="page-title">배송지 관리</h1>
					</div>
				</div>
				<div class="col-lg-6 col-md-6 col-12">
					<ul class="breadcrumb-nav">
						<li><a href="/"><i class="lni lni-home"></i> Home</a></li>
						<li><a href="/member/myPage/viewOrder">myPage</a></li>
						<li>배송지 관리</li>
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

					<jsp:param name="pageName" value="manageDelivery" />

				</jsp:include>
				<!-- / sideBar -->
				
				<div class="col-lg-9 col-12 contents">
					<div class="addDeliveryArea">
						<div class="button">
							<a class="btn" href="/member/myPage/addDeliveryPage">배송지 추가</a>
						</div>
					</div>
					<div class="deliveryCountArea">
						<p>총 <span id="countDeliveries">0</span> 개</p>
					</div>
					<div class="row deliveryInfoHead">
						<div class="col-lg-2 col-md-2 col-12">
							<p>이름</p>
						</div>
						<div class="col-lg-8 col-md-8 col-12">
							<p>주소</p>
						</div>
						<div class="col-lg-2 col-md-2 col-12">
							<p>관리</p>
						</div>
					</div>
					<div class="deliveryInfoList">
					</div>
				</div>
				
			</div>
		</div>
	</section>

	<jsp:include page="/WEB-INF/views/user/pages/footer.jsp"></jsp:include>
	
	<jsp:include page="myPage_deleteDeliveryModal.jsp"></jsp:include>
	<jsp:include page="myPage_deliveryModal.jsp"></jsp:include>

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