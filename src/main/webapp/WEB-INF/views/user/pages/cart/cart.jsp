<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html class="no-js" lang="zxx">

<head>
<meta charset="utf-8" />
<meta http-equiv="x-ua-compatible" content="ie=edge" />
<title>ELOLIA</title>
<meta name="description" content="" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="shortcut icon" type="image/x-icon"
	href="/resources/assets/user/images/logo/favicon.png" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- ========================= CSS here ========================= -->
<link rel="stylesheet"
	href="/resources/assets/user/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="/resources/assets/user/css/LineIcons.3.0.css" />
<link rel="stylesheet" href="/resources/assets/user/css/tiny-slider.css" />
<link rel="stylesheet"
	href="/resources/assets/user/css/glightbox.min.css" />
<link rel="stylesheet" href="/resources/assets/user/css/main.css" />

</head>

<script type="text/javascript">

$(document).ready(function() {
	var successMessage = '${successMessage}';
	
	if (successMessage) {
		showCartModal(successMessage);
	}
	let productCount = $("div.cart-single-list").length;
	
	makeCalResult();
	
	const checkedCount = $('input[type="checkbox"].checkProduct').length;
    $(".checkedProductCount").text(checkedCount + "개");
    
    if (checkedCount <= 0) {
    	if ($("#removeChecked").hasClass("active-remove")) {
    		$("#removeChecked").removeClass("active-remove").addClass("disabled-remove");
        }
    } else {
    	if ($("#removeChecked").hasClass("disabled-remove")) {
    		$("#removeChecked").removeClass("disabled-remove").addClass("active-remove");
        }
    }
	
	$('input[type="checkbox"].checkProduct').change(function() {
		const checkedCount = $('input[type="checkbox"].checkProduct:checked').length;
	    $(".checkedProductCount").text(checkedCount + "개");
	    
	    let productNoId = 0;
	    
	    let totalCheckedPrice = 0;
	    let totalCheckedDcPrice = 0;
	    let totalCheckedPoint = 0;
	    
	    $('input[type="checkbox"].checkProduct:checked').each(function() {
	        productNoId = parseInt(this.id);
	        
	        console.log($('#' + productNoId + '_productDCPrice').text());
	        
	        totalCheckedPrice += parseInt($.trim($('#' + productNoId + '_productPrice').text().replace(" 원", "").replace(/,/g, "")));
	        if ($('#' + productNoId + '_productDCPrice').text() == "0" || $('#' + productNoId + '_productDCPrice').text() == "") {
	        	totalCheckedDcPrice += 0;
	        } else {
		        totalCheckedDcPrice += parseInt($.trim($('#' + productNoId + '_productPrice').text().replace(" 원", "").replace(/,/g, ""))) - parseInt($.trim($('#' + productNoId + '_productDCPrice').text().replace(" 원", "").replace(/,/g, "")));
		        console.log(parseInt($.trim($('#' + productNoId + '_productPrice').text().replace(" 원", "").replace(/,/g, ""))) - parseInt($.trim($('#' + productNoId + '_productDCPrice').text().replace(" 원", "").replace(/,/g, ""))));
		        
	        }
	        if ($('#' + productNoId + '_point').text() == "0") {
	        	totalCheckedPoint += 0;
	        } else {
		        totalCheckedPoint += parseInt($.trim($('#' + productNoId + '_point').text().replace(" P", "").replace(/,/g, "")));
	        }
	        console.log("totalCheckedPrice" + totalCheckedPrice);
	        console.log("totalCheckedDcPrice" + totalCheckedDcPrice);
	        console.log("totalCheckedPoint" + totalCheckedPoint);
	        
	        $(".totalPrice").text(totalCheckedPrice.toLocaleString() + " 원");
	        $(".dcProduct").text(totalCheckedDcPrice.toLocaleString() + " 원");
	        $(".totalPay").text((totalCheckedPrice - totalCheckedDcPrice).toLocaleString() + " 원");
	        $(".totalPoint").text(totalCheckedPoint.toLocaleString() + " P");
	    });
	    
	    if (productCount == checkedCount) {
			$('#allProductChecked').prop("checked", true);
		} else {
			$('#allProductChecked').prop("checked", false);
		}
	    
	    if (checkedCount <= 0) {
	    	$(".totalPrice").text("0 원");
	        $(".dcProduct").text("0 원");
	        $(".totalPay").text("0 원");
	        $(".totalPoint").text("0 P");
	        
	    	if ($("#removeChecked").hasClass("active-remove")) {
	    		$("#removeChecked").removeClass("active-remove").addClass("disabled-remove");
	        }
	    } else {
	    	if ($("#removeChecked").hasClass("disabled-remove")) {
	    		$("#removeChecked").removeClass("disabled-remove").addClass("active-remove");
	        }
	    }
	    
    });
	
	$("#allProductChecked").change(function() {
        if ($(this).prop("checked")) {
            $("input[type='checkbox'].checkProduct").prop("checked", true);
            if ($("#removeChecked").hasClass("disabled-remove")) {
	    		$("#removeChecked").removeClass("disabled-remove").addClass("active-remove");
	        }
    		makeCalResult();
        } else {
            $("input[type='checkbox'].checkProduct").prop("checked", false);
            if ($("#removeChecked").hasClass("active-remove")) {
	    		$("#removeChecked").removeClass("active-remove").addClass("disabled-remove");
	        }
            $(".totalPrice").text("0 원");
	        $(".dcProduct").text("0 원");
	        $(".totalPay").text("0 원");
	        $(".totalPoint").text("0 P");
        }
        const checkedCount = $('input[type="checkbox"].checkProduct:checked').length;
	    $(".checkedProductCount").text(checkedCount + "개");
    });
	
});

function makeCalResult() {
	let totalPrices = 0;
	let totalPoints = 0;
	
	$(".productPrice").each(function() {
		let productPriceText = parseInt($.trim($(this).text().replace(" 원", "").replace(/,/g, "")));
		totalPrices += productPriceText;
	});
	
	$(".totalPrice").text(totalPrices.toLocaleString() + " 원");
	
	$(".productPoint").each(function() {
		let productPointText = parseInt($.trim($(this).text().replace(" P", "").replace(/,/g, "")));
		totalPoints += productPointText;
	});
	
	totalPoints = Math.round(parseFloat(totalPoints));
	$(".totalPoint").text(totalPoints.toLocaleString() + " P");
	
	var levelInfo = "${not empty levelInfo ? levelInfo : ''}";
	
	let levelDC = 0;
	
	if(levelInfo) {
		levelDC = parseFloat("${levelInfo.level_dc }");
		console.log("levelDC" + levelDC);
	}
	
	let levelDCPrice = 0;
	
	if (levelDC != 0) {
		levelDCPrice = totalPrices * levelDC;
		// 최소단위 10원으로 변경
		levelDCPrice =  Math.floor(levelDCPrice / 10) * 10;
		
		console.log("levelDCPrice" + levelDCPrice);
	} else {
		levelDCPrice = 0;
	}
	
	let productDCPrice = 0;
	
	$(".cart-single-list").each(function() {
		let currentElement = $(this);
		let discountedPrice = parseInt($.trim(currentElement.find(".hiddenDiscoutedPrice").text()));
		let productPrice = parseInt($.trim(currentElement.find(".productPrice").text().replace(" 원", "").replace(/,/g, "")));

		if (discountedPrice != 0) {
			productDCPrice += productPrice - discountedPrice;
		}
		// 최소단위 10원으로 변경
		productDCPrice = Math.floor(productDCPrice / 10) * 10;
	});
	
	$(".dcProduct").text((levelDCPrice + productDCPrice).toLocaleString() + " 원");
	
	let totalPay = totalPrices - levelDCPrice - productDCPrice;
	
	$(".totalPay").text(totalPay.toLocaleString() + " 원");
} 

function countUp(productNo) {
	let quantity = parseInt($("#"+productNo + "_quantity").text());
	
	$("#"+productNo + "_quantity").text(quantity + 1);
}

function countDown(productNo) {
	let quantity = parseInt($("#"+productNo + "_quantity").text());
	
	if (quantity <= 1) {
		showCartModal("최소수량 1개 이하로 <br/> 내릴 수 없습니다.");
	} else {
		$("#"+productNo + "_quantity").text(quantity - 1);
	} 
	
}


function applyQuantity(productNo) {
	let quantity = parseInt($("#"+productNo + "_quantity").text());
	
	if (quantity < 1) {
		showCartModal("최소수량 1개 이하로 내릴 수 없습니다.");
		location.reload();
	} else {
		
		$.ajax({
		    url: 'updateQuantity',
		    type: 'POST',
		    data: {
		    	productNo : productNo,
		    	quantity: quantity
		    	},
		    dataType: 'json',
		    success: function(data) {
		        if (data == "success") {
		            location.reload();
		        } else if (data == "fail"){
		            showCartModal('수정에 실패했습니다. <br/> 다시 시도해주세요.');
		        }
		    },
		    error: function() {
		    },
		    complete: function(data) {
		    	// 요청이 성공했을 때 실행되는 콜백 함수
		        
		        if (data.status == 200) {
		            // 수정 성공 시 페이지 새로 고침
		            location.reload();
		        } else if (data.responseText == 400){
		            // 수정 실패 시 에러 메시지 표시
		            showCartModal('수정에 실패했습니다. <br/> 다시 시도해주세요.');
		        }
		    }
		});
	}
	
}

function removeItem(productNo) {
	$("#deleteCartModal .modal-text").text("상품을 삭제하시겠습니까?");
	$("#deleteCart").off("click").on("click", function() {
        deleteCart(productNo);
    });
	$("#deleteCartModal").modal("show");
}

function deleteCart(productNo) {
	$.ajax({
	    url: 'removeCartItem',
	    type: 'POST',
	    data: {
	    	productNo : productNo
	    	},
	    dataType: 'json',
	    success: function(data) {
	    },
	    error: function() {
	    },
	    complete: function(xhr) {
	        if (xhr.status == 200) {
	        	$("#deleteCartModal").modal("hide");
	            location.reload();
	        } else if (xhr.status == 400) {
	            showCartModal('상품 삭제에 실패했습니다. <br/> 다시 시도해주세요.');
	        }
	    }
	});
}

function removeCheckedItem() {
    $("#deleteCartModal .modal-text").text("선택한 상품들을 삭제하시겠습니까?");
    $("#deleteCart").off("click").on("click", function() {
        deleteCheckedCart();
    });
    $("#deleteCartModal").modal("show");
}

function deleteCheckedCart() {
    let productNos = [];
    
    $('input[type="checkbox"].checkProduct:checked').each(function() {
        productNos.push(parseInt(this.id));
    });

    $.ajax({
        url: 'removeCheckedItems',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(productNos),
        dataType: 'json',
        success: function(data) {
        },
        error: function() {
        },
        complete: function(data) {
            if (data.status == 200) {
            	$("#deleteCartModal").modal("hide");
                location.reload();
            } else if (data.responseText == 400) {
                showCartModal('상품 삭제에 실패했습니다. <br/> 다시 시도해주세요.');
            }
        }
    });
}


function checkedOrder() {
	let productsInfo = [];
	let productNo = 0;
	let quantity = 0;
	
	let checkboxes = $('input[type="checkbox"].checkProduct');
	
	const checkedCount = $('input[type="checkbox"].checkProduct:checked').length;
	
	if (checkedCount == 0) {
		showCartModal("체크된 상품이 없습니다.");
		return;
	}
	
    for (let i = 0; i < checkboxes.length; i++) {
        let checkbox = checkboxes[i];
        if (checkbox.checked) {
            productNo = parseInt(checkbox.id);
            quantity = parseInt($("#"+productNo + "_quantity").text());
            
            productsInfo.push({ productNo: parseInt(productNo), quantity: quantity });
        }
    }

    $('.productInfos').val(JSON.stringify(productsInfo));

    $('.orderForm').submit();
	
}

function showCartModal(message) {
	$("#cartModal").modal("show");
	$("#cartModal .modal-text").html(message);
	
	setTimeout(function() {
		$('#cartModal').modal('hide');
	}, 1500);
}

</script>

<style>
.count-input-div {
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 0;
	margin: 0;
}

.count-input-div .btn {
	background-color: #a8a691;
	color: white;
}

.count-input-div .btn:hover {
	background-color: #807e6f;
	color: white;
}

.count-input-div .countUp {
	border-radius: 0 4px 4px 0;
}

.count-input-div .countDown {
	border-radius: 4px 0 0 4px;
}

.count-input-div .countApply {
	margin-left: 10px;
	border-radius: 4px;
	font-weigth: bold;
	font-size: 13px;
	height: 38px;
	width: 60px;
	padding: 0;
}

.count-input-div .count-div {
	text-align: center;
	border: 1px solid #efefef;
	height: 38px;
	line-height: 38px;
	width: 50px;
	padding: 0;
	margin: 0;
}

.form-check-input:focus {
	border-color: #a8a691 !important;
}

.chkbox {
	color: black;
	font-weight: bold;
}

#checkedProductCount {
	color: #fd5a68;
}

input[type="checkbox"]:hover {
	cursor: pointer;
}

.active-remove {
	color: black;
	font-weight: bold;
}

.disabled-remove {
	color: gray;
	pointer-events: none;
	font-weight: bold;
}

#removeChecked:hover {
	color: #807e6f;
}

#removeChecked:focus {
	color: #807e6f;
}

.cartInfo {
	height: 384px;
	margin: 40px 20px 0 0;
	padding-top : 40px !important;
	background-color: #FFFFFF;
	padding: 0;
	border: 1px solid #eee;
	border-radius: 4px;
}

.cartInfo .container {
	height: 180px;
	
}

#instruction {
	padding: 10px;
	color: black;
	font-weight: bold;
	margin-bottom: 15px;
}

#instructionList li {
	padding: 10px;
	padding-left: 15px;
	position: relative;
	margin-bottom: 5px;
}

.hero-area {
	border: 1px solid #eee;
	border-radius: 4px;
	margin-bottom: 40px !important;
	display: flex;
   	flex-direction: column;
   	align-items: center;
	padding-bottom: 40px;
}

.warning {
	padding-top: 80px !important;
	height: 180px;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	text-align: center;
}

.goList {
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

.cart-total {
	display: flex;
	justify-content: right;
}

.cart-total .cartInfo{
	max-width: 846px;
}

.cart-total .right {
	width: 450px;
}


</style>

<body>

	<jsp:include page="../header.jsp"></jsp:include>

	<!-- Preloader -->
	<div class="preloader">
		<div class="preloader-inner">
			<div class="preloader-icon">
				<span></span> <span></span>
			</div>
		</div>
	</div>
	<!-- /End Preloader -->

	<!-- Start Breadcrumbs -->
	<div class="breadcrumbs">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-lg-6 col-md-6 col-12">
					<div class="breadcrumbs-content">
						<h1 class="page-title">장바구니</h1>
					</div>
				</div>
				<div class="col-lg-6 col-md-6 col-12">
					<ul class="breadcrumb-nav">
						<li><a href="../"><i class="lni lni-home"></i> Home</a></li>
                        <li><a href="/product/jewelry">Shop</a></li>
                        <li>장바구니</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- End Breadcrumbs -->

	<!-- Shopping Cart -->
	<div class="shopping-cart section">
		<div class="container">
			<c:choose>
				<c:when test="${not empty cartItems || not empty cookieCartItems }">
					<div class="row">
						<div class="chkbox col-lg-11 col-md-2 col-12" id="allCheckDiv">
							<input type="checkbox" class="form-check-input"
								id="allProductChecked" checked> 전체선택 (<span
								class="checkedProductCount" id="checkedProductCount"></span>)
						</div>
						<div class="chkbox col-lg-1 col-md-10 col-12">
							<a class="active-remove" href="#" onclick="removeCheckedItem();"
								id="removeChecked"><u>선택삭제</u></a>
						</div>
					</div>
					<div class="cart-list-head">
						<!-- Cart List Title -->
						<div class="cart-list-title">
							<div class="row">
								<div class="col-lg-1 col-md-1 col-12">
									<p></p>
								</div>
								<div class="col-lg-3 col-md-3 col-12">
									<p>상품 이름</p>
								</div>
								<div class="col-lg-2 col-md-2 col-12">
									<p>수량</p>
								</div>
								<div class="col-lg-2 col-md-2 col-12">
									<p>적립예정포인트</p>
								</div>
								<div class="col-lg-3 col-md-2 col-12 row">
									<div class="col-lg-6 col-md-6 col-12">
										<p>상품 금액</p>
									</div>
									<div class="col-lg-6 col-md-6 col-12">
										<p>할인 금액</p>
									</div>
								</div>
								<div class="col-lg-1 col-md-1 col-12">
									<p>제거</p>
								</div>
								
							</div>
						</div>
						<!-- End Cart List Title -->
						<c:if test="${not empty cartItems }">
							<c:forEach var="item" items="${cartItems }">
								<!-- Cart Single List list -->
								<div class="cart-single-list">
									<div class="chkbox">
										<input id="${item.product_no }" type="checkbox"
											class="form-check-input checkProduct" checked>
									</div>
									<div class="row align-items-center">
										<div class="col-lg-1 col-md-1 col-12">
											<a href="/product/jewelry/detail?productNo=${item.product_no }">
										<c:choose>
											<c:when test="${empty item.image_url}">
												<img src="/resources/images/noP_image.png" alt="${item.product_name }" onerror="this.src='/resources/images/noP_image.png';">
											</c:when>
											<c:otherwise>
												<c:if test="${fn:contains(item.image_url, 'Main')}">
													<img src="/resources/product/${item.image_url}" alt="${item.product_name }" onerror="this.src='/resources/images/noP_image.png';">
												</c:if>
												<c:if test="${fn:contains(item.image_url, 'https')}">
													<img src="${item.image_url}" alt="${item.product_name }" onerror="this.src='/resources/images/noP_image.png';">
												</c:if>
											</c:otherwise>
										</c:choose>
										
											</a>
										</div>
										<div class="col-lg-3 col-md-3 col-12">
											<h5 class="product-name">
												<a
													href="/product/jewelry/detail?productNo=${item.product_no }">
													${item.product_name }</a>
											</h5>
											<p class="product-des">
												<span>${item.category_name }</span>
											</p>
										</div>
										<div class="count-input-div col-lg-2 col-md-2 col-12">
											<button class="btn countDown"
												onclick="countDown(${item.product_no })">-</button>
											<div class="count-div" id="${item.product_no }_quantity">${item.product_count }</div>
											<button class="btn countUp"
												onclick="countUp(${item.product_no})">+</button>
											<button class="btn countApply"
												onclick="applyQuantity(${item.product_no });">변경</button>
										</div>
										<c:if test="${not empty levelInfo}">
											<div class="col-lg-2 col-md-2 col-12">
												<p class="productPoint" id="${item.product_no }_point">
													<fmt:formatNumber value="${item.product_price * item.product_count * (1 - item.dc_rate - levelInfo.level_dc) * levelInfo.level_point}" type="number" pattern="#,###" />P
												</p>
												<p class="product-des">
													<span><em>등급:</em> ${levelInfo.level_name }</span> <span><em>포인트적립:</em>
														${Math.round(levelInfo.level_point * 100) } %</span>
												</p>
											</div>
										</c:if>
										<c:if test="${empty levelInfo }">
											<div class="col-lg-2 col-md-2 col-12">
												<p class="price">0 P</p>
											</div>
										</c:if>
										<div class="col-lg-3 col-md-2 col-12 row">
											<div class="col-lg-6 col-md-6 col-12">
												<p class="productPrice" id="${item.product_no }_productPrice">
													<fmt:formatNumber value="${item.product_price * item.product_count}" type="number" pattern="#,###" /> 원
												</p>
											</div>
											<c:if test="${empty levelInfo or levelInfo.level_dc == 0}">
												<div class="col-lg-6 col-md-6 col-12">
													<c:if test="${item.product_dc_type == 'P'}">
														<p><em><del><fmt:formatNumber value="${item.product_price * item.product_count}" type="number" pattern="#,###" /> 원</del></em></p>
														<p class="productDCPrice" id="${item.product_no }_productDCPrice"><span><fmt:formatNumber value="${item.product_price * item.product_count * (1 - item.dc_rate)}" type="number" pattern="#,###" /> 원</span></p>
														<p class="product-des"><span><em>상품 할인율:</em> ${Math.round( (item.dc_rate) * 100) } %</span></p>
														<span style="display: none;" class="hiddenDiscoutedPrice"> ${item.product_price * item.product_count * (1 - item.dc_rate)} </span>
													</c:if>
													
													<c:if test="${empty item.product_dc_type or item.product_dc_type == 'N'}">
														<p class="productDCPrice" id="${item.product_no }_productDCPrice"></p>
														<span style="display: none;" class="hiddenDiscoutedPrice"> ${item.product_price * item.product_count} </span>
													</c:if>
												</div>
											</c:if>
											<c:if test="${not empty levelInfo and levelInfo.level_dc > 0}">
												<div class="col-lg-6 col-md-6 col-12">
													<c:if test="${item.product_dc_type == 'P'}">
														<p><em><del><fmt:formatNumber value="${item.product_price * item.product_count}" type="number" pattern="#,###" /> 원</del></em></p>
														<p class="productDCPrice" id="${item.product_no }_productDCPrice">
															<span>
																<fmt:formatNumber value="${item.product_price * item.product_count * (1 - item.dc_rate - levelInfo.level_dc)}" type="number" pattern="#,###" /> 원
															</span>
														</p>
														<p class="product-des"><span><em>상품 할인율:</em> ${Math.round( (item.dc_rate) * 100) } %</span></p>
														<p class="product-des"><span><em>회원등급 할인율:</em> ${Math.round( (levelInfo.level_dc) * 100) } %</span></p>
														<span style="display: none;" class="hiddenDiscoutedPrice"> ${item.product_price * item.product_count * (1 - item.dc_rate)} </span>
													</c:if>
													<c:if test="${empty item.product_dc_type or item.product_dc_type == 'N'}">
														<p><em><del><fmt:formatNumber value="${item.product_price * item.product_count}" type="number" pattern="#,###" /> 원</del></em></p>
														<p class="productDCPrice" id="${item.product_no }_productDCPrice">
															<span>
																<fmt:formatNumber value="${item.product_price * item.product_count * (1 - levelInfo.level_dc)}" type="number" pattern="#,###" /> 원
															</span>
														</p>
														<p class="product-des"><span><em>회원등급 할인율:</em> ${Math.round( (levelInfo.level_dc) * 100) } %</span></p>
														<span style="display: none;" class="hiddenDiscoutedPrice"> ${item.product_price * item.product_count} </span>
													</c:if>
												</div>
											</c:if>
										</div>
										<div class="col-lg-1 col-md-1 col-12">
											<a class="remove-item" href="#"
												onclick="removeItem(${item.product_no });"><i
												class="lni lni-close"></i></a>
										</div>
									</div>
								</div>
								<!-- End Single List list -->
							</c:forEach>
						</c:if>
						<c:if test="${not empty cookieCartItems }">
							<c:forEach var="item" items="${cookieCartItems }">
								<!-- Cart Single List list -->
								<div class="cart-single-list">
									<div class="chkbox">
										<input id="${item.product_no }" type="checkbox"
											class="form-check-input checkProduct" checked>
									</div>
									<div class="row align-items-center">
										<div class="col-lg-1 col-md-1 col-12">
											<a href="/product/jewelry/detail?productNo=${item.product_no }">
											
										<c:choose>
											<c:when test="${empty item.image_url}">
												<img src="/resources/images/noP_image.png" alt="${item.product_name }" onerror="this.src='/resources/images/noP_image.png';">
											</c:when>
											<c:otherwise>
												<c:if test="${fn:contains(item.image_url, 'Main')}">
													<img src="/resources/product/${item.image_url}" alt="${item.product_name }" onerror="this.src='/resources/images/noP_image.png';">
												</c:if>
												<c:if test="${fn:contains(item.image_url, 'https')}">
													<img src="${item.image_url}" alt="${item.product_name }" onerror="this.src='/resources/images/noP_image.png';">
												</c:if>
											</c:otherwise>
										</c:choose>
										
											</a>
										</div>
										<div class="col-lg-3 col-md-2 col-12">
											<h5 class="product-name">
												<a
													href="/product/jewelry/detail?productNo=${item.product_no }">
													${item.product_name }</a>
											</h5>
											<p class="product-des">
												<span>${item.category_name }</span>
											</p>
										</div>
										<div class="count-input-div col-lg-2 col-md-1 col-12">
											<button class="btn countDown"
												onclick="countDown(${item.product_no })">-</button>
											<div class="count-div" id="${item.product_no }_quantity">${item.product_count }</div>
											<button class="btn countUp"
												onclick="countUp(${item.product_no})">+</button>
											<button class="btn countApply"
												onclick="applyQuantity(${item.product_no });">변경</button>
										</div>
										<c:if test="${empty levelInfo }">
											<div class="col-lg-2 col-md-3 col-12">
												<p id="${item.product_no }_point">0</p>
											</div>
										</c:if>
										<div class="col-lg-3 col-md-2 col-12 row">
											<div class="col-lg-6 col-md-6 col-12">
												<p class="productPrice" id="${item.product_no }_productPrice">
													<fmt:formatNumber value="${item.product_price * item.product_count}" type="number" pattern="#,###" /> 원
												</p>
											</div>
											<div class="col-lg-6 col-md-6 col-12">
												<c:if test="${item.product_dc_type == 'P'}">
													<p><em><del><fmt:formatNumber value="${item.product_price * item.product_count}" type="number" pattern="#,###" /> 원</del></em></p>
													<p class="productDCPrice" id="${item.product_no }_productDCPrice"><span><fmt:formatNumber value="${item.product_price * item.product_count * (1 - item.dc_rate)}" type="number" pattern="#,###" /> 원</span></p>
													<p class="product-des"><span><em>상품 할인율:</em> ${Math.round(item.dc_rate * 100) } %</span></p>
													<span style="display: none;" class="hiddenDiscoutedPrice"> ${item.product_price * item.product_count * (1 - item.dc_rate)} </span>
												</c:if>
												<c:if test="${empty item.product_dc_type or item.product_dc_type == 'N'}">
													<p class="productDCPrice" id="${item.product_no }_productDCPrice"></p>
													<span style="display: none;" class="hiddenDiscoutedPrice"> ${item.product_price * item.product_count} </span>
												</c:if>
											</div>
										</div>
										<div class="col-lg-1 col-md-2 col-12">
											<a class="remove-item" href="#"
												onclick="removeItem(${item.product_no });"><i
												class="lni lni-close"></i></a>
										</div>
									</div>
								</div>
								<!-- End Single List list -->
							</c:forEach>
						</c:if>
					</div>
				</c:when>
				<c:otherwise>
					<section class="hero-area">
						<div class="warning">
							<div class="warningImg">
								<img alt="경고" src="/resources/assets/user/images/error/warning.png">
							</div>
							<div class="warningInfo">
								<p class="warningInfoHead">
									<span> 장바구니에 담긴 상품이 없습니다. </span>
								</p>
							</div>
						</div>
						<div class="repositBtn">
							<div class="button">
								<a href="/product/jewelry/all" class="btn btn goList">상품 보러 가기</a>
							</div>
						</div>
					</section>
				</c:otherwise>
			</c:choose>
			<!-- Total Amount -->
		<c:if test="${not empty cartItems || not empty cookieCartItems }">
			<div class="total-amount cart-total">
				<div class="cartInfo container">
					<span id="instruction">장바구니 이용안내</span>
					<ul id="instructionList">
						<li>상품 옵션에 따라 결제 금액이 변경 될 수 있습니다.</li>
						<li>쇼핑백 보관 기간 중 상품 가격이나 혜택이 변동 될수 있습니다.</li>
						<li>쇼핑백의 상품을 찜 하시면 지속적으로 보실 수 있습니다.</li>
					</ul>
				</div>
				<div class="right">
					<ul>
						<li><b>총 상품금액</b><span class="totalPrice">0</span></li>
						<li><b>총 할인금액</b><span class="dcProduct">0</span></li>
						<li class="last"><b>총 결제금액</b><span class="totalPay">0</span></li>
						<li><b>총 적립예정포인트</b><span class="totalPoint">0</span></li>
					</ul>
					<div class="button">
						<form action="/order" method="post" class="orderForm">
							<input type="hidden" class="productInfos" name="productInfos">
							<a onclick="checkedOrder();" class="btn">총 (<span class="checkedProductCount"></span>) <span class="totalPay">0</span><br />결제하기</a>
							<a href="/product/jewelry/all" class="btn">상품 보러 가기</a>
						</form>
				 	</div>
				 </div>
			 
			 </div>
		 </c:if>
			 <!--/ End Total Amount -->
		</div>
	</div>
	<!--/ End Shopping Cart -->
	

	<jsp:include page="../footer.jsp"></jsp:include>
	<jsp:include page="cartModal.jsp"></jsp:include>
	<jsp:include page="deleteCartModal.jsp"></jsp:include>

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