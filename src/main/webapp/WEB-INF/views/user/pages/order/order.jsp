<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html class="no-js" lang="zxx">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <title>주문 결제</title>
    <meta name="description" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="shortcut icon" type="image/x-icon" href="/resources/assets/user/images/logo/white-logo.svg" />

    <!-- ========================= CSS here ========================= -->
    <link rel="stylesheet" href="/resources/assets/user/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/resources/assets/user/css/LineIcons.3.0.css" />
    <link rel="stylesheet" href="/resources/assets/user/css/tiny-slider.css" />
    <link rel="stylesheet" href="/resources/assets/user/css/glightbox.min.css" />
    <link rel="stylesheet" href="/resources/assets/user/css/main.css" />

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	
	<style>
    #overlay {
	    position: fixed;
	    top: 0;
	    left: 0;
	    width: 100%;
	    height: 100%;
	    background-color: rgba(0, 0, 0, 0.5); /* 반투명 검은색 */
	    z-index: 99999999; /* 다른 요소들보다 위에 표시되도록 설정 */
	    display: none; /* 기본적으로 숨김 */
	}
    </style>
	
</head>

<script type="text/javascript">
	

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

	<jsp:include page="../header.jsp"></jsp:include>

    <!-- Start Breadcrumbs -->
    <div class="breadcrumbs">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6 col-md-6 col-12">
                    <div class="breadcrumbs-content">
                        <h1 class="page-title">주문 결제</h1>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-12">
                    <ul class="breadcrumb-nav">
                        <li><a href="../"><i class="lni lni-home"></i> Home</a></li>
                        <li><a href="../">Shop</a></li>
                        <li>checkout</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!-- End Breadcrumbs -->

    <!--====== Checkout Form Steps Part Start ======-->

    <section class="checkout-wrapper section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="checkout-steps-form-style-1">
                     <form action="/order" method="post">
                        <ul id="accordionExample">
                            <li>
                               <h5 class="title collapsed" data-bs-toggle="collapse" data-bs-target="#collapseThree"
                                    aria-expanded="false" aria-controls="collapseThree">주문 상품</h5>
                                <c:forEach var="orderProduct" items="orderProductList">
                                <section class="checkout-steps-form-content collapse" id="collapseThree"
                                    aria-labelledby="headingThree" data-bs-parent="#accordionExample">
                                    <div class="col-md-6">
										<div class="single-form form-default">
											<div class="form-input form">
												<label>상품 수량</label>
												<label>${orderProduct.quantity }</label>
												<%-- <input type="text" placeholder="quantity" id="orderProductQuantity" name="orderProductQuantity" value="${orderProduct.quantity }"> --%>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="single-form form-default">
											<div class="form-input form">
												<img alt="productImg" src="${orderProduct.image_main_url }" width="67px;" height="67px;">
												<label>상품 이름</label>
												<label>${orderProduct.product_name }</label>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="single-form form-default">
											<div class="form-input form">
												<label>상품 가격</label>
												<h3 id="orderProductPrice">${orderProduct.product_price } 원</h3>
											</div>
										</div>
									</div>
									<c:if test="${not empty orderProduct.product_dc_type && orderProduct.product_dc_type != 'N' }">
									<div class="col-md-6">
										<div class="single-form form-default">
											<div class="form-input form">
												<label>할인</label>
												<c:if test="${orderProduct.product_dc_type == 'P' }">
													<h3>${(orderProduct.product_price) * (orderProduct.dc_rate) } 원</h3>
												</c:if>
											</div>
										</div>
									</div>
									</c:if>
                                </section>
                                </c:forEach>
                            </li>
                           	<c:if test="${empty orderMember }">
                            	<li>
                                	<h5 class="title collapsed" data-bs-toggle="collapse" data-bs-target="#collapseFour"
                                    	aria-expanded="false" aria-controls="collapseFour">주문자 정보</h5>
	                                	<section class="checkout-steps-form-content collapse" id="collapseFour"
	                                    		aria-labelledby="headingFour" data-bs-parent="#accordionExample">
	                                        <div class="col-md-6">
	                                            <div class="single-form form-default">
	                                                <div class="form-input form">
	                                                	<label>이름</label>
	                                                    <input type="text" placeholder="Name" name="name">
	                                                </div>
	                                            </div>
	                                        </div>
	                                        <div class="col-md-6">
	                                            <div class="single-form form-default">
	                                                <div class="form-input form">
	                                                	<label>휴대폰 번호</label>
	                                                    <input type="text" placeholder="Phone Number" name="phoneNumber">
	                                                </div>
	                                            </div>
	                                        </div>
	                                        <div class="col-md-6">
	                                            <div class="single-form form-default">
	                                                <div class="form-input form">
	                                                	<label>이메일</label>
	                                                    <input type="text" placeholder="Email Address" name="email">
	                                                </div>
	                                            </div>
	                                        </div>
	                                	</section>
	                            </li>
	                            <li>
	                               <h5 class="title collapsed" data-bs-toggle="collapse" data-bs-target="#collapsefive"
	                                    aria-expanded="false" aria-controls="collapsefive">배송지 정보</h5>
	                                <section class="checkout-steps-form-content collapse" id="collapsefive"
	                                    aria-labelledby="headingfive" data-bs-parent="#accordionExample">
		                                    <div class="col-md-6">
		                                            <div class="single-form form-default">
		                                                <div class="form-input form">
		                                                	<label>배송지</label>
		                                                    <input type="text" placeholder="Address" name="address">
		                                                </div>
		                                            </div>
		                                    </div>
	                                </section>
                            </li>
                            <li>
                               <h5 class="title collapsed" data-bs-toggle="collapse" data-bs-target="#collapseSix"
                                    aria-expanded="false" aria-controls="collapseSix">포인트 정보</h5>
                                <section class="checkout-steps-form-content collapse" id="collapseSix"
                                    aria-labelledby="headingSix" data-bs-parent="#accordionExample">
	                                    <div class="col-md-6">
	                                            <div class="single-form form-default">
	                                                <div class="form-input form">
	                                                	<label>회원만 포인트 사용이 가능합니다.</label>
	                                                </div>
	                                            </div>
	                                    </div>
                                </section>
							</c:if>
                            <c:if test="${not empty orderMember }">
                                <li>
                                	<h5 class="title collapsed" data-bs-toggle="collapse" data-bs-target="#collapseFour"
                                    	aria-expanded="false" aria-controls="collapseFour">주문자 정보</h5>
	                                	<section class="checkout-steps-form-content collapse" id="collapseFour"
	                                    		aria-labelledby="headingFour" data-bs-parent="#accordionExample">
                                        <div class="col-md-6">
                                            <div class="single-form form-default">
                                                <div class="form-input form">
                                                	<label>이름</label>
                                                    <input type="text" placeholder="Name" name="name" value="${orderMember.member_name }" readonly>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="single-form form-default">
                                                <div class="form-input form">
                                                	<label>휴대폰 번호</label>
                                                    <input type="text" placeholder="Phone Number" name="phoneNumber" value="${orderMember.phone_number }" readonly>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="single-form form-default">
                                                <div class="form-input form">
                                                	<label>이메일</label>
                                                    <input type="text" placeholder="Email Address" name="email" value="${orderMember.email }" readonly>
                                                </div>
                                            </div>
                                        </div>
                                    </section>
	                            </li>
	                            <li>
	                               <h5 class="title collapsed" data-bs-toggle="collapse" data-bs-target="#collapsefive"
	                                    aria-expanded="false" aria-controls="collapsefive">배송지 정보</h5>
	                                <section class="checkout-steps-form-content collapse" id="collapsefive"
	                                    aria-labelledby="headingfive" data-bs-parent="#accordionExample">
		                                    <div class="col-md-6">
		                                            <div class="single-form form-default">
		                                                <div class="form-input form">
		                                                	<label>배송지</label>
		                                                    <input type="text" placeholder="Address" name="address" value="${orderMember.address }" readonly>
		                                                </div>
		                                            </div>
		                                    </div>
	                                </section>
                            </li>
                            <li>
                               <h5 class="title collapsed" data-bs-toggle="collapse" data-bs-target="#collapseSix"
                                    aria-expanded="false" aria-controls="collapseSix">포인트 정보</h5>
                                <section class="checkout-steps-form-content collapse" id="collapseSix"
                                    aria-labelledby="headingSix" data-bs-parent="#accordionExample">
	                                    <div class="col-md-6">
	                                            <div class="single-form form-default">
	                                                <div class="form-input form">
	                                                	<label>보유 포인트 : ${orderMember.member_point }</label>
	                                                </div>
	                                            </div>
	                                    </div>
                                </section>
                                 	</c:if>
                                <section>
                                	<div>
                                		<div class="single-form form-default button">
                                        	<button class="btn" type="submit">정보 적용</button>
                                        </div>
                                	</div>
                                </section>
                            </li>
                            <li>
                                <h6 class="title collapsed" data-bs-toggle="collapse" data-bs-target="#collapseFour"
                                    aria-expanded="false" aria-controls="collapseFour">결제 수단</h6>
                                <section class="checkout-steps-form-content collapse" id="collapseFour"
                                    aria-labelledby="headingFour" data-bs-parent="#accordionExample">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="checkout-payment-option">
                                                <h6 class="heading-6 font-weight-400 payment-title">Select Delivery
                                                    Option</h6>
                                                <div class="payment-option-wrapper">
                                                    <!-- <div class="single-payment-option">
                                                        <input type="radio" name="shipping" id="shipping-2">
                                                        <label for="shipping-2">
                                                            <img src="https://via.placeholder.com/60x32"
                                                                alt="Sipping">
                                                            <p>Standerd Shipping</p>
                                                            <span class="price">$10.50</span>
                                                        </label>
                                                    </div> -->
                                                    <div class="single-payment-option">
                                                        <input type="radio" name="paymentMethod" id="paymentMethod-1"
                                                        onclick="selectPaymentMethod('CARD')">
                                                        <label for="paymentMethod-1">
                                                            <p>카드 결제</p>
                                                        </label>
                                                    </div>
                                                    <div class="single-payment-option">
                                                        <input type="radio" name="paymentMethod" id="paymentMethod-2"
                                                        onclick="selectPaymentMethod('VIRTUAL_ACCOUNT')">
                                                        <label for="paymentMethod-2">
                                                            <p>무통장 입금</p>
                                                        </label>
                                                    </div>
                                                    <div class="single-payment-option">
                                                        <input type="radio" name="paymentMethod" id="paymentMethod-3"
                                                        onclick="selectPaymentMethod('TRANSFER')">
                                                        <label for="paymentMethod-3">
                                                            <p>계좌 이체</p>
                                                        </label>
                                                    </div>
                                                    <div class="single-payment-option">
                                                        <input type="radio" name="paymentMethod" id="paymentMethod-4"
                                                        onclick="selectPaymentMethod('NAVER_PAY')">
                                                        <label for="paymentMethod-4">
                                                            <p>네이버 페이</p><!--TODO : 네이버 페이 로고로 바꾸기-->
                                                        </label>
                                                    </div>
                                                    <div class="single-payment-option">
                                                        <input type="radio" name="paymentMethod" id="paymentMethod-5"
                                                        onclick="selectPaymentMethod('KAKAO_PAY')">
                                                        <label for="paymentMethod-5">
                                                            <p>카카오 페이</p><!--TODO : 카카오 페이 로고로 바꾸기-->
                                                        </label>
                                                    </div>                        
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="steps-form-btn button">
                                                <button class="btn" data-bs-toggle="collapse"
                                                    data-bs-target="#collapseThree" aria-expanded="false"
                                                    aria-controls="collapseThree">previous</button>
                                                <a href="javascript:void(0)" class="btn btn-alt">Save & Continue</a>
                                            </div>
                                        </div>
                                    </div>
                                </section>
                            </li>
                        </ul>
                        </form>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="checkout-sidebar">
                        <div class="checkout-sidebar-coupon">
                            <p>쿠폰 입력</p>
                            <form action="#">
                                <div class="single-form form-default">
                                    <div class="form-input form">
                                        <input type="text" placeholder="쿠폰 번호를 입력하세요" name="couponUse">
                                    </div>
                                    <div class="button">
                                        <button class="btn">쿠폰 적용</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="checkout-sidebar-price-table mt-30">
                            <div class="sub-total-price" style="color: black;">
                                <div class="total-price">
                                    <p class="value">총 상품금액</p>
                                    <p class="price allProductPrice">0 원</p>
                                </div>
                                 <div class="total-price discount">
                                    <p class="value">총 할인금액</p>
                                    <p class="price">- 0 원</p>
                                </div>
                                <div class="total-price shipping">
                                    <p class="value">총 배송비</p>
                                    <p class="price">0 원</p>
                                </div>
                            </div>

                            <div class="total-payable">
                                <div class="payable-price">
                                    <h6 class="value bold" style="color: black;">총 결제금액</h6>
                                    <h6 class="price allProductPrice" style="color: red;">0 원</h6>
                                </div>
	                                <div class="sub-total-price">
	                                	<div class="total-price point mb-30">
	                                    	<p class="value">총 적립예정 포인트</p>
	                                    	<c:if test="${not empty orderMember }">
	                                    		<p class="price" id="point">0 P</p>
	                                    	</c:if>
	                                    	<c:if test="${empty orderMember }">
	                                    		<p class="price">0 P</p>
	                                    	</c:if>
	                                    </div>
	                                </div>
                            </div>
                            <div class="price-table-btn button">
                                <a href="javascript:void(0)" class="btn btn-alt">(총 1개) <span class="price allProductPrice">0</span> 원 결제하기</a>
                            </div>
                            <div class="price-table-btn button">
                                <a href="javascript:void(0)" class="btn btn-alt" onclick="requestPayment()">
                                결제하기</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--====== Checkout Form Steps Part Ends ======-->
    
    <jsp:include page="../footer.jsp"></jsp:include>

    <!-- ========================= scroll-top ========================= -->
    <a href="#" class="scroll-top">
        <i class="lni lni-chevron-up"></i>
    </a>

    <!-- ========================= JS here ========================= -->
    <script src="/resources/assets/user/js/bootstrap.min.js"></script>
    <script src="/resources/assets/user/js/tiny-slider.js"></script>
    <script src="/resources/assets/user/js/glightbox.min.js"></script>
    <script src="/resources/assets/user/js/main.js"></script>
    
        <!--toss 결제 API-->
    <script src="https://js.tosspayments.com/v2/standard"></script>

    <!-- 결제 처리(toss) -->
    <script>
        // ------  SDK 초기화 ------
        // @docs https://docs.tosspayments.com/sdk/v2/js#토스페이먼츠-초기화
        const clientKey = "test_ck_6BYq7GWPVv2PGpoD9mdaVNE5vbo1"; // TODO : 내 클라이언트 키, 나중에 서버에 저장해야 함
        const customerKey = "whygari4321"; // 구매자의 고유 아이디
        const tossPayments = TossPayments(clientKey);
        // 결제창 초기화
        const payment = tossPayments.payment({ customerKey });
        // TODO : 현재 페이지에서 총 결제금액 읽어서 갱신하기, 지금은 100원 결제
        const amount = {
            currency: "KRW",
            value: 100,
        };
    </script>

    <!-- 네이버페이 결제 API -->
    <script src="https://nsp.pay.naver.com/sdk/js/naverpay.min.js"></script>    

    <!-- 결제 처리(네이버페이) -->
    <script>
        var oPay = Naver.Pay.create({
             "mode" : "development", // development or production
             "clientId": "HN3GGCMDdTgGUfl0kFCo", // clientId
             "chainId": "S2VnY2NSaHlhb3V", // chainId
             // "openType" : "popup",
        });
    </script>
    
    <!-- 결제 처리(카카오페이) -->
    <script>
	var kakaopay = {
        ref: null,
    };
	
	function showKakaopayPaymentWindow(url) {
		kakaopay.ref = window.open('', 'paypopup', 'width=426,height=510,toolbar=no');
		const overlay = document.getElementById("overlay");
		
	    if (kakaopay.ref) {
	        // 팝업 창이 열렸을 때, 배경을 반투명 검은색으로 변경하고 입력을 막는다.
			overlay.style.display = "block"; 
	        // NOTE : 왠지는 모르겠는데 이걸로 입력 차단 안됨
        	// overlay.style.pointerEvents = 'none';
	        $(".container").css("pointerEvents", "none")
	        
	        setTimeout(function(){
	            kakaopay.ref.location.href=url
	        }, 0);
	    } else {
	    	throw new Error("popup을 열 수 없습니다!(cannot open popup)");
	    }
	    // TODO : 창이 띄워진 동안에는 배경 반투명 검은색으로 가리고 입력 막아야 할 것 같음
	}
	
	function releaseInputBlock() {
		const overlay = document.getElementById("overlay");
		overlay.style.display = "none"
		$(".container").css("pointerEvents", "auto")
	}
	</script>
    
    <!-- 결제 이벤트 핸들러(toss, 네이버페이, 카카오페이) -->
	<script>
        let selectedPaymentMethod = null;

        function selectPaymentMethod(method) {
            selectedPaymentMethod = method;
            console.log(method + "방법 선택")
        }

        // ------ '결제하기' 버튼 누르면 결제창 띄우기 ------
        // @docs https://docs.tosspayments.com/sdk/v2/js#paymentrequestpayment
        async function requestPayment() {
            // 결제를 요청하기 전에 orderId, amount를 서버에 저장하세요.
            // 결제 과정에서 악의적으로 결제 금액이 바뀌는 것을 확인하는 용도입니다.
            switch (selectedPaymentMethod) {
            case "CARD":
                await payment.requestPayment({
                    method: "CARD", // 카드 및 간편결제
                    amount: {
                        currency: "KRW",
                        value: 100,
                    },
                    orderId: generateRandomString(),
                    orderName: "토스 티셔츠 외 2건",
                    successUrl: window.location.origin + "/user/payment/success.html", // 결제 요청이 성공하면 리다이렉트되는 URL
                    failUrl: window.location.origin + "/fail.html", // 결제 요청이 실패하면 리다이렉트되는 URL
                    card: {
                        useEscrow: false,
                        flowMode: "DEFAULT",
                        useCardPoint: false,
                        useAppCardOnly: false,
                    },
                });
            case "TRANSFER":
                await payment.requestPayment({
                    method: "TRANSFER", // 계좌이체 결제
                    amount: {
                        currency: "KRW",
                        value: 1000,
                    },
                    orderId: generateRandomString(),
                    orderName: "토스 티셔츠 외 2건",
                    successUrl: window.location.origin + "/user/payment/success.html",
                    failUrl: window.location.origin + "/fail.html",
                    transfer: {
                        cashReceipt: {
                        type: "소득공제",
                        },
                        useEscrow: false,
                    },
                });
            case "VIRTUAL_ACCOUNT":
                await payment.requestPayment({
                    method: "VIRTUAL_ACCOUNT", // 가상계좌 결제
                    amount: {
                        currency: "KRW",
                        value: 100,
                    },
                    orderId: generateRandomString(),
                    orderName: "토스 티셔츠 외 2건",
                    successUrl: window.location.origin + "/user/payment/success.html",
                    failUrl: window.location.origin + "/fail.html",
                    virtualAccount: {
                        cashReceipt: {
                        type: "소득공제",
                        },
                        useEscrow: false,
                        validHours: 24,
                    },
                });
            }

            // 네이버페이
            // 레퍼런스 : https://developers.pay.naver.com/docs/v2/api#etc-etc_pay_reserve
            if (selectedPaymentMethod == "NAVER_PAY") {
                console.log("네이버 페이 선택")
                oPay.open({
                    "merchantPayKey": "202410179U6ds9",
                    "productName": "머플러 외",
                    "productCount": "0",
                    "totalPayAmount": "100",
                    "taxScopeAmount": "100",
                    "taxExScopeAmount": "0",
                    "returnUrl": window.location.origin + "/user/approveNaverPay"
                });
            }

            // TODO : 카카오페이
            // 레퍼런스 : https://developers.kakaopay.com/docs/payment/online/single-payment#payment-ready-sample-request
            if (selectedPaymentMethod == "KAKAO_PAY") {
                console.log("카카오 페이 선택")
                // NOTE : http 요청으로 카카오페이 서버에 직접 보내면 유저가 브라우저의 개발자 도구를 통해 cid, partner_order_id 같은 중요한 정보를 직접 확인 가능
                // 그러므로 여기서는 POST 요청으로 서버의 컨트롤러에게 대신 요청을 보내도록 함.
                // TODO : 보낼 겍체에 필요한 정보 별도로 채워넣기 (주문번호, 가격)
                let item = {
                    orderId: 1,
                    amount: 100
                }
                
                // NOTE : ajax 요청은 컨트롤러로부터 응답을 받아도 페이지를 이동시켜주지 않는다. 그래서 success 메서드를 붙어야 함 
                $.ajax({
                  type : 'POST',
                  url : "/user/kakaoPay/ready",
                  data: item,
                  dataType: "json",
                  contentType : 'application/x-www-form-urlencoded',
                  // NOTE : cotentType을 application/json으로 지정하고 스프링 서버에서 @Requestbody + DTO 객체로 받아올 수도 있지만 DTO 만들기 싫어서 이렇게 함
                  success : function(response) {
                      // console.log("response : " + response)
                      // NOTE : 성공하면 페이지 이동해서 그 페이지에서 자바스크립트를 호출하여 카카오페이 결제 팝업을 바꾸는 방식에서
                      // 페이지 이동하지 않고 그냥 주문 페이지에서 팝업 띄우는 방식으로 변경하였다.
                      console.log("카카오페이 결제 팝업 호출")
                      console.log("response : " + JSON.stringify(response))
                	  showKakaopayPaymentWindow(response.paymentURL)
                  }
                })
            }
        }
            </script>
</body>

</html>