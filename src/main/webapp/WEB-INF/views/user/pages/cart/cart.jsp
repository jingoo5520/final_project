<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html class="no-js" lang="zxx">

<head>
<meta charset="utf-8" />
<meta http-equiv="x-ua-compatible" content="ie=edge" />
<title>장바구니</title>
<meta name="description" content="" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="shortcut icon" type="image/x-icon"
	href="/resources/assets/user/images/logo/white-logo.svg" />
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
	
	logWindowSize();
	
    // 창 크기가 변경될 때마다 크기를 찍기
    $(window).resize(function() {
        logWindowSize();
    });
	
	
	let productCount = $("div.cart-single-list").length;
	let totalPrices = 0;
	let totalPoints = 0;
	
	$(".productPrice").each(function() {
		let productPriceText = parseInt($.trim($(this).text().replace(" 원", "").replace(/,/g, "")));
		totalPrices += productPriceText;
	});
	console.log(totalPrices);
	
	$(".totalPrice").text(totalPrices.toLocaleString() + " 원");
	
	$(".productPoint").each(function() {
		let productPointText = parseInt($.trim($(this).text().replace(" P", "").replace(/,/g, "")));
		totalPoints += productPointText;
	});
	console.log(totalPoints);
	
	$(".totalPoint").text(totalPoints.toLocaleString() + " P");
	
	var levelInfo = "${not empty levelInfo ? levelInfo : ''}";
	
	let levelDC = 0;
	
	if(levelInfo) {
		levelDC = parseFloat("${levelInfo.level_dc }");
		console.log(levelDC);
	}
	
	let levelDCPrice = 0;
	
	if (levelDC != 0) {
		levelDCPrice = Math.floor(totalPrices * levelDC / 10) * 10;
	} else {
		levelDCPrice = 0;
	}
	
	$(".dcLevel").text(levelDCPrice.toLocaleString() + " 원");
	
	let productDCPrice = 0;
	
	$(".cart-single-list").each(function() {
		let currentElement = $(this);
		
		let discountedPrice = parseInt($.trim(currentElement.find(".productDCPrice").text().replace(" 원", "").replace(/,/g, "")));
		
		let productPrice = parseInt($.trim(currentElement.find(".productPrice").text().replace(" 원", "").replace(/,/g, "")));
		
		if (discountedPrice != 0) {
			productDCPrice += productPrice - discountedPrice;
		}
	});
	
	$(".dcProduct").text(productDCPrice.toLocaleString() + " 원");
	
	let totalPay = totalPrices - levelDCPrice - productDCPrice;
	
	$(".totalPay").text(totalPay.toLocaleString() + " 원");
	
	
	
	
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
	    
	    if (productCount == checkedCount) {
			$('#allProductChecked').prop("checked", true);
		} else {
			$('#allProductChecked').prop("checked", false);
		}
	    
	    if (checkedCount <= 0) {
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
        } else {
            $("input[type='checkbox'].checkProduct").prop("checked", false);
            if ($("#removeChecked").hasClass("active-remove")) {
	    		$("#removeChecked").removeClass("active-remove").addClass("disabled-remove");
	        }
        }
        const checkedCount = $('input[type="checkbox"].checkProduct:checked').length;
	    $(".checkedProductCount").text(checkedCount + "개");
    });
	
});

function countUp(productNo) {
	let quantity = parseInt($("#"+productNo + "_quantity").text());
	
	$("#"+productNo + "_quantity").text(quantity + 1);
}

function countDown(productNo) {
	let quantity = parseInt($("#"+productNo + "_quantity").text());
	
	if (quantity <= 1) {
		alert("최소수량 1개 이하로 내릴 수 없습니다.");
	} else {
		$("#"+productNo + "_quantity").text(quantity - 1);
	} 
	
}


function applyQuantity(productNo) {
	let quantity = parseInt($("#"+productNo + "_quantity").text());
	
	if (quantity < 1) {
		alert("최소수량 1개 이하로 내릴 수 없습니다.");
		location.reload();
	} else {
		console.log("수량 : " + quantity + ", 상품 번호 : " + productNo);
		
		$.ajax({
		    url: 'updateQuantity',
		    type: 'POST',
		    data: {
		    	productNo : productNo,
		    	quantity: quantity
		    	},
		    dataType: 'json',
		    success: function(data) {
		        // 요청이 성공했을 때 실행되는 콜백 함수
		        console.log(data);
		        
		        if (data == "success") {
		            // 수정 성공 시 페이지 새로 고침
		            location.reload();
		        } else if (data == "fail"){
		            // 수정 실패 시 에러 메시지 표시
		            alert('수정에 실패했습니다. 다시 시도해주세요.');
		        } else {
		        	// 로그인 안했음
		        	alert("로그인 안했는데요?");
		        }
		    },
		    error: function() {
		    },
		    complete: function(data) {
		    	// 요청이 성공했을 때 실행되는 콜백 함수
		        console.log(data);
		        
		        if (data.status == 200) {
		            // 수정 성공 시 페이지 새로 고침
		            location.reload();
		        } else if (data.responseText == 400){
		            // 수정 실패 시 에러 메시지 표시
		            alert('수정에 실패했습니다. 다시 시도해주세요.');
		        } else if (data.responseText == 401){
		        	// 로그인 안했음
		        	alert("로그인 안했는데요?");
		        }
		    }
		});
	}
	
}

function removeItem(productNo) {
	
	let isConfirmed = confirm("선택한 상품을 삭제 하시겠습니까?");
	
	if (isConfirmed) {
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
		            location.reload();
		        } else if (xhr.status == 400) {
		            alert('상품 삭제에 실패했습니다. 다시 시도해주세요.');
		        } else if (xhr.status == 401) {
		            alert("로그인 안했는데요?");
		        }
		    }
		});
	}
	
}

function removeCheckedItem() {
    let isConfirmed = confirm("선택한 상품을 삭제 하시겠습니까?");
    
    if (isConfirmed) {
        let checkboxes = $('input[type="checkbox"].checkProduct');
        let productNos = [];
        
        for (let i = 0; i < checkboxes.length; i++) {
            let checkbox = checkboxes[i];
            if (checkbox.checked) {
                productNos.push(parseInt(checkbox.id));
            }
        }
        
        console.log(productNos);
        
        $.ajax({
            url: 'removeCheckedItems',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(productNos),  // 단순 배열로 전송
            dataType: 'json',
            success: function(data) {
            },
            error: function() {
            },
            complete: function(data) {
                if (data.status == 200) {
                    location.reload();
                } else if (data.responseText == 400) {
                    alert('상품 삭제에 실패했습니다. 다시 시도해주세요.');
                } else if (data.responseText == 401) {
                    alert("로그인 안했는데요?");
                }
            }
        });
    }
}

function logWindowSize() {   
   let width = window.width
    
    if (width >= 1837) {
        $('.hide-total').hide();
        $('.total-amount.fixed-total').show();
    } else {
        $('.hide-total').show();
        $('.total-amount.fixed-total').hide();
    }
}

$(window).scroll(function() {
	let width = $(window).width(); // 현재 문서의 너비
	var scrollTop = $(window).scrollTop();
	var documentHeight = $(document).height();
	var windowHeight = $(window).height();
	var remainingScroll = documentHeight - (scrollTop + windowHeight);
	
	 if (width >= 1837) {
	        $('.hide-total').hide();
	        
	        if (remainingScroll <= 552) {
	            $('.total-amount.fixed-total').hide();
	        } else {
	            $('.total-amount.fixed-total').show();
	        }
	    } else {
	        $('.hide-total').show();
	        $('.total-amount.fixed-total').hide();
	    }
	
});


function checkedOrder() {
	let productsInfo = [];
	let productNo = 0;
	let quantity = 0;
	
	let checkboxes = $('input[type="checkbox"].checkProduct');
    
    for (let i = 0; i < checkboxes.length; i++) {
        let checkbox = checkboxes[i];
        if (checkbox.checked) {
            productNo = parseInt(checkbox.id);
            quantity = parseInt($("#"+productNo + "_quantity").text());
            
            productsInfo.push({ productNo: parseInt(productNo), quantity: quantity });
        }
    }

	console.log(productsInfo);
	
	// 숨겨진 필드에 JSON 형식으로 저장
    $('.productInfos').val(JSON.stringify(productsInfo));

    // 폼 제출
    $('.orderForm').submit();
	
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

.fixed-total {
    position: fixed;
    top: 442px;
    right: 60px;
    width: 300px;
    height: 404px;
    background-color: #a8a691;
    box-shadow: 2px 2px 15px rgba(0, 0, 0, 0.3), 0 10px 15px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
    z-index: 1000;
    padding: 20px;
    border-radius: 8px;
    margin: 0;
    padding: 0; /* 상단 패딩 제거 */
}

.fixed-right {
    padding: 0;
    margin: 10px !important;/* 상단 마진을 음수로 설정하여 빈 공간 줄이기 */
}

.bingonggans {
	height: 180px;
	margin-bottom: 100px;
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
						<li><a href="../">Shop</a></li>
						<li>Cart</li>
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
											<a
												href="/product/productDetail?productNo=${item.product_no }"><img
												src="${item.image_url }" alt="#"></a>
										</div>
										<div class="col-lg-3 col-md-3 col-12">
											<h5 class="product-name">
												<a
													href="/product/productDetail?productNo=${item.product_no }">
													${item.product_name }</a>
											</h5>
											<p class="product-des">
												<span><em>Type:</em> Mirrorless</span>
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
										<c:if test="${not empty levelInfo }">
											<div class="col-lg-2 col-md-2 col-12">
												<p class="productPoint">
													<fmt:formatNumber value="${Math.floor(item.product_price * item.product_count * levelInfo.level_point / 10) * 10}" type="number" pattern="#,###" />P
												</p>
												<p class="product-des">
													<span><em>등급:</em> ${levelInfo.level_name }</span> <span><em>포인트적립:</em>
														${Math.round(levelInfo.level_point * 100) } %</span>
												</p>
											</div>
										</c:if>
										<c:if test="${empty levelInfo }">
											<div class="col-lg-2 col-md-2 col-12">
												<p class="price">0</p>
											</div>
										</c:if>
										<div class="col-lg-3 col-md-2 col-12 row">
											<div class="col-lg-6 col-md-6 col-12">
												<p class="productPrice">
													<fmt:formatNumber value="${item.product_price * item.product_count}" type="number" pattern="#,###" /> 원
												</p>
											</div>
											<div class="col-lg-6 col-md-6 col-12">
												<c:if test="${item.product_dc_type == 'P'}">
													<p><em><del><fmt:formatNumber value="${item.product_price * item.product_count}" type="number" pattern="#,###" /> 원</del></em></p>
													<p class="productDCPrice"><span><fmt:formatNumber value="${item.product_price * item.product_count * (1 - item.dc_rate)}" type="number" pattern="#,###" /> 원</span></p>
													<p class="product-des"><span><em>할인율:</em> ${Math.round(item.dc_rate * 100) } %</span></p>
												</c:if>
												<c:if test="${empty item.product_dc_type || item.product_dc_type == 'N'}">
													<p class="productDCPrice">0</p>
												</c:if>
											</div>
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
											<a
												href="/product/productDetail?productNo=${item.product_no }"><img
												src="${item.image_url }" alt="#"></a>
										</div>
										<div class="col-lg-3 col-md-2 col-12">
											<h5 class="product-name">
												<a
													href="/product/productDetail?productNo=${item.product_no }">
													${item.product_name }</a>
											</h5>
											<p class="product-des">
												<span><em>Type:</em> Mirrorless</span>
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
												<p>0</p>
											</div>
										</c:if>
										<div class="col-lg-3 col-md-2 col-12 row">
											<div class="col-lg-6 col-md-6 col-12">
												<p class="productPrice">
													<fmt:formatNumber value="${item.product_price * item.product_count}" type="number" pattern="#,###" /> 원
												</p>
											</div>
											<div class="col-lg-6 col-md-6 col-12">
												<c:if test="${item.product_dc_type == 'P'}">
													<p><em><del><fmt:formatNumber value="${item.product_price * item.product_count}" type="number" pattern="#,###" /> 원</del></em></p>
													<p class="productDCPrice"><span><fmt:formatNumber value="${item.product_price * item.product_count * (1 - item.dc_rate)}" type="number" pattern="#,###" /> 원</span></p>
													<p class="product-des"><span><em>할인율:</em> ${Math.round(item.dc_rate * 100) } %</span></p>
												</c:if>
												<c:if test="${empty item.product_dc_type || item.product_dc_type == 'N'}">
													<p class="productDCPrice">0</p>
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
					<!-- Total Amount -->
					<div class="total-amount fixed-total ">
						<div class="right fixed-right">
							<ul>
								<li>총 상품금액<span class="totalPrice">0</span></li>
								<li>상품 할인금액<span class="dcProduct">0</span></li>
								<li>등급 할인금액<span class="dcLevel"></span></li>
								<li class="last">총 결제금액<span class="totalPay">0</span></li>
								<li>총 적립예정포인트<span class="totalPoint">0</span></li>
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
					 <!--/ End Total Amount -->
				</c:when>
				<c:otherwise>
					<h1>장바구니에 상품이 없습니다.</h1>
					<div class="button">
						<a href="/product/jewelry/all" class="btn btn">상품 보러 가기</a>
					</div>
				</c:otherwise>
			</c:choose>
			<!-- Total Amount -->
			<div class="total-amount hide-total">
				<div class="right">
					<ul>
						<li>총 상품금액<span class="totalPrice">0</span></li>
						<li>상품 할인금액<span class="dcProduct">0</span></li>
						<li>등급 할인금액<span class="dcLevel"></span></li>
						<li class="last">총 결제금액<span class="totalPay">0</span></li>
						<li>총 적립예정포인트<span class="totalPoint">0</span></li>
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
			 <!--/ End Total Amount -->
		</div>
	</div>
	<!--/ End Shopping Cart -->
	<div class="bingonggans container">
		<span id="instruction">장바구니 이용안내</span>
		<ul id="instructionList">
			<li>상품 옵션에 따라 결제 금액이 변경 될 수 있습니다.</li>
			<li>쇼핑백 보관 기간 중 상품 가격이나 혜택이 변동 될수 있습니다.</li>
			<li>쇼핑백의 상품을 찜 하시면 지속적으로 보실 수 있습니다.</li>
		</ul>
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
</body>

</html>