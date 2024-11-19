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
function showDeliveryModal(message) {
	$("#deliveryModal").modal("show");
	$("#deliveryModal .modal-text").html(message);
	
	setTimeout(function() {
		$('#deliveryModal').modal('hide');
	}, 1500);
}

</script>

</head>

<style>
	.sendDeliveryInfoArea {
		border-top: 1px solid #e6e6e6;
		margin-top: 60px;
		padding-top: 50px;
		display: flex;
		justify-content: center;
	}
	
	.saveDeliveryInfo .btn {
		
		width: 223px;
	}
	
	.form-input {
		width: 100%;
    	box-sizing: border-box; /* 패딩과 보더를 너비에 포함시킴 */
	}
	
	.form-input input[type="text"] {
		height: 50px;
		margin: 12px 0 12px 0;
		border-radius: 4px;
		border: 1px solid #B4B5B4;
		outline: none;
		padding: 12px;
	}
	
	.addressSearchArea {
		margin-left: 20px;
		padding-left: 12px;
	}
	
	#searchAddressBtn {
		margin: 12px;
		color: #FFFFFF;
		background-color: #A8A691;
		border:none;
		border-radius: 4px;
		font-size: 16px;
		font-weight: bold;
		width: 84px;
	}
	
	#searchAddressBtn:hover {
		background-color: #807E6F;
	}
	
	#saveDeliveryDiv, #saveAddressDiv {
		margin: 12px 0 12px 0;
	}
	
	#saveDeliveryDiv input:focus, #saveAddressDiv input:focus {
		border: 1px solid #A8A691;
	}
	
	.inputAreaHead {
		display: flex;
		text-align: center;
		justify-content: center;
		margin-top: 20px;
		font-size: 16px;
		font-weight: bold;
		color: black;
	}
	
</style>
<script type="text/javascript">
	function sendData() {
		let postCode = validateInfo($("#postcodeNew").val());
		let address = validateInfo($("#addressNew").val());
		let detailAddress = validateInfo($("#detailAddressNew").val());
		let deliveryName = validateInfo($("#deliveryName").val());
		
		if (!postCode || !address || !detailAddress || !deliveryName) {
			showDeliveryModal("정보를 입력해주세요");
			return;
		}
		
		if ($('#saveDeliveryCheck').prop('checked')) {
			$('input[name="isMain"]').val("M");
		} else {
			$('input[name="isMain"]').val("S");
		}
		
		if ($('#saveAddressCheck').prop('checked')) {
			$('input[name="deliveryType"]').val($('input[name="deliveryType"]').val() + "saveAddress");
		}
		
		
		$('input[name="deliveryName"]').val(deliveryName);
		$('input[name="deliveryAddress"]').val(postCode + "/" + address + "/" + detailAddress);
		
		$('#sendDataForm').submit();
	}
	
	function validateInfo(value) {
		if (value == "") {
			return false;
		}
		return value;
	}
</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function sample6_execDaumPostcode() {
		new daum.Postcode({
			oncomplete: function(data) {
				var addr = '';
				var extraAddr = '';
				
				if (data.userSelectedType === 'R') {
					addr = data.roadAddress;
				} else {
					addr = data.jibunAddress;
				}

				if (data.userSelectedType === 'R') {
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
					}
					if (extraAddr !== '') {
						extraAddr = ' (' + extraAddr + ')';
					}
				}

				document.getElementById('postcodeNew').value = data.zonecode;
				document.getElementById('addressNew').value = addr + extraAddr;
				document.getElementById('detailAddressNew').removeAttribute("readonly");
				document.getElementById('detailAddressNew').focus();
				document.getElementById('detailAddressNew').value = "";
				
			}
		}).open();
	}
		
</script>

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
						<h1 class="page-title">배송지 추가</h1>
					</div>
				</div>
				<div class="col-lg-6 col-md-6 col-12">
					<ul class="breadcrumb-nav">
						<li><a href="/"><i class="lni lni-home"></i> Home</a></li>
						<li><a href="/member/myPage/viewOrder">MyPage</a></li>
						<li><a href="/member/myPage/manageDelivery">배송지 관리</a></li>
						<li>배송지 추가</li>
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
				
				<div class="col-lg-9 col-12">
					<div class="row inputAddressArea">
						<div class="col-lg-2 col-md-2 col-12">
							<p class="inputAreaHead">주소</p>
						</div>
						<div class="col-lg-8 col-md-8 col-12">
							<div class="form-input form">
				                <div class="row addressSearchArea">
				                    <input class="postNumber col-md-8 col-lg-8 col-12" type="text" id="postcodeNew" placeholder="우편번호" readonly>
				                    <input id="searchAddressBtn" class="searchPost col-md-4 col-lg-2 col-12" type="button" onclick="sample6_execDaumPostcode()" value="검색"><br>
				                </div>
				                <input type="text" class="col-md-10 col-lg-10 col-12" id="addressNew" placeholder="주소" readonly><br>
				                <input type="text" class="col-md-10 col-lg-10 col-12" id="detailAddressNew" placeholder="상세주소">
				            </div>
				            <div class="form-check">
				            	<c:if test="${empty setMain or setMain != 'main'}">
					                <div id="saveDeliveryDiv">
					                    <input type="checkbox" class="form-check-input" id="saveDeliveryCheck">
					                    <label for="saveDeliveryCheck">기본배송지로 저장</label>
					                </div>
				                </c:if>
				                <c:if test="${not empty setMain and setMain == 'main'}">
					                <div id="saveDeliveryDiv">
					                    <input type="checkbox" class="form-check-input" id="saveDeliveryCheck" checked onclick="return false;"/>
					                    <label for="saveDeliveryCheck">기본배송지로 저장</label>
					                </div>
				                </c:if>
				                <div id="saveAddressDiv">
				                    <input type="checkbox" class="form-check-input" id="saveAddressCheck">
				                    <label for="saveAddressCheck">회원정보 주소로 저장</label>
				                </div>
				            </div>
						</div>
					</div>
					<div class="row inputDeliveryNameArea">
						<div class="col-lg-2 col-md-2 col-12">
							<p  class="inputAreaHead">배송지명</p>
						</div>
						<div class="col-lg-8 col-md-8 col-12">
							<div class="form-input form">
				                <input type="text" class="col-md-6 col-lg-6 col-12"  id="deliveryName" value="" placeholder="배송지명">
				            </div>
						</div>
					</div>
					<div class="sendDeliveryInfoArea">
						<div class="button saveDeliveryInfo">
							<form action="/member/myPage/saveDelivery" method="post" id="sendDataForm">
								<input type="hidden" name="deliveryName">
								<input type="hidden" name="deliveryAddress">
								<input type="hidden" name="memberId" value="${memberInfo.member_id }">
								<input type="hidden" name="isMain">
								<input type="hidden" name="deliveryType" value="saveDelivery">
								<div class="btn" onclick="sendData()">등록</div>
							</form>
						</div>
					</div>
				</div>
				
				
				
			</div>
		</div>
	</section>



	<jsp:include page="/WEB-INF/views/user/pages/footer.jsp"></jsp:include>
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