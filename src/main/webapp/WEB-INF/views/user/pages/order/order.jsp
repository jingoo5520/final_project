<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="x-ua-compatible" content="ie=edge" />
<title>ELOLIA</title>
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
                        <h1 class="page-title">checkout</h1>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-12">
                    <ul class="breadcrumb-nav">
                        <li><a href="index.html"><i class="lni lni-home"></i> Home</a></li>
                        <li><a href="index.html">Shop</a></li>
                        <li>결제하기</li>
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
                        <ul id="accordionExample">
                            <li>
                                <h6 class="title" data-bs-toggle="collapse" data-bs-target="#collapseThree"
                                    aria-expanded="true" aria-controls="collapseThree">Your Personal Details </h6>
                                <section class="checkout-steps-form-content collapse show" id="collapseThree"
                                    aria-labelledby="headingThree" data-bs-parent="#accordionExample">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="single-form form-default">
                                                <label>User Name</label>
                                                <div class="row">
                                                    <div class="col-md-6 form-input form">
                                                        <input type="text" placeholder="First Name">
                                                    </div>
                                                    <div class="col-md-6 form-input form">
                                                        <input type="text" placeholder="Last Name">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="single-form form-default">
                                                <label>Email Address</label>
                                                <div class="form-input form">
                                                    <input type="text" placeholder="Email Address">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="single-form form-default">
                                                <label>Phone Number</label>
                                                <div class="form-input form">
                                                    <input type="text" placeholder="Phone Number">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="single-form form-default">
                                                <label>Mailing Address</label>
                                                <div class="form-input form">
                                                    <input type="text" placeholder="Mailing Address">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="single-form form-default">
                                                <label>City</label>
                                                <div class="form-input form">
                                                    <input type="text" placeholder="City">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="single-form form-default">
                                                <label>Post Code</label>
                                                <div class="form-input form">
                                                    <input type="text" placeholder="Post Code">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="single-form form-default">
                                                <label>Country</label>
                                                <div class="form-input form">
                                                    <input type="text" placeholder="Country">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="single-form form-default">
                                                <label>Region/State</label>
                                                <div class="select-items">
                                                    <select class="form-control">
                                                        <option value="0">select</option>
                                                        <option value="1">select option 01</option>
                                                        <option value="2">select option 02</option>
                                                        <option value="3">select option 03</option>
                                                        <option value="4">select option 04</option>
                                                        <option value="5">select option 05</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="single-checkbox checkbox-style-3">
                                                <input type="checkbox" id="checkbox-3">
                                                <label for="checkbox-3"><span></span></label>
                                                <p>My delivery and mailing addresses are the same.</p>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="single-form button">
                                                <button class="btn" data-bs-toggle="collapse"
                                                    data-bs-target="#collapseFour" aria-expanded="false"
                                                    aria-controls="collapseFour">next
                                                    step</button>
                                            </div>
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
                            <li>
                                <h6 class="title collapsed" data-bs-toggle="collapse" data-bs-target="#collapsefive"
                                    aria-expanded="false" aria-controls="collapsefive">Payment Info</h6>
                                <section class="checkout-steps-form-content collapse" id="collapsefive"
                                    aria-labelledby="headingFive" data-bs-parent="#accordionExample">
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="checkout-payment-form">
                                                <div class="single-form form-default">
                                                    <label>Cardholder Name</label>
                                                    <div class="form-input form">
                                                        <input type="text" placeholder="Cardholder Name">
                                                    </div>
                                                </div>
                                                <div class="single-form form-default">
                                                    <label>Card Number</label>
                                                    <div class="form-input form">
                                                        <input id="credit-input" type="text"
                                                            placeholder="0000 0000 0000 0000">
                                                        <img src="/resources/assets/user/images/payment/card.png" alt="card">
                                                    </div>
                                                </div>
                                                <div class="payment-card-info">
                                                    <div class="single-form form-default mm-yy">
                                                        <label>Expiration</label>
                                                        <div class="expiration d-flex">
                                                            <div class="form-input form">
                                                                <input type="text" placeholder="MM">
                                                            </div>
                                                            <div class="form-input form">
                                                                <input type="text" placeholder="YYYY">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="single-form form-default">
                                                        <label>CVC/CVV <span><i
                                                                    class="mdi mdi-alert-circle"></i></span></label>
                                                        <div class="form-input form">
                                                            <input type="text" placeholder="***">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="single-form form-default button">
                                                    <button class="btn">pay now</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </section>
                            </li>
                            <p>orderId : <input type="text" id="testOrderIdInput"></input><button onclick="sendOrderIdForTest()">전송</button></p>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="checkout-sidebar">
                        <div class="checkout-sidebar-coupon">
                            <p>Appy Coupon to get discount!</p>
                            <form action="#">
                                <div class="single-form form-default">
                                    <div class="form-input form">
                                        <input type="text" placeholder="Coupon Code">
                                    </div>
                                    <div class="button">
                                        <button class="btn">apply</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="checkout-sidebar-price-table mt-30">
                            <h5 class="title">Pricing Table</h5>

                            <div class="sub-total-price">
                                <div class="total-price">
                                    <p class="value">Subotal Price:</p>
                                    <p class="price">$144.00</p>
                                </div>
                                <div class="total-price shipping">
                                    <p class="value">Subotal Price:</p>
                                    <p class="price">$10.50</p>
                                </div>
                                <div class="total-price discount">
                                    <p class="value">Subotal Price:</p>
                                    <p class="price">$10.00</p>
                                </div>
                            </div>

                            <div class="total-payable">
                                <div class="payable-price">
                                    <p class="value">Subotal Price:</p>
                                    <p class="price">$164.50</p>
                                </div>
                            </div>
                            <div class="price-table-btn button">
                                <a href="javascript:void(0)" class="btn btn-alt" onclick="tryPayment()">
                                결제하기</a>
                            </div>
                        </div>
                        <div class="checkout-sidebar-banner mt-30">
                            <a href="product-grids.html">
                                <img src="https://via.placeholder.com/400x330" alt="#">
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <!-- 모달 (네이버페이 용)-->
        <!-- Button trigger modal -->
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
            Launch demo modal
        </button>
        
        <!-- 임시 실험-->
        <!-- Button trigger modal -->
        <button type="button" class="btn btn-primary" onclick="myTest()">
            다른 페이지로 이동하기
        </button>
    
        <!-- Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <iframe src="https://www.naver.com"></iframe>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Save changes</button>
                </div>
                </div>
            </div>
        </div>
    




    </section>
    <!--====== Checkout Form Steps Part Ends ======-->

	<jsp:include page="../footer.jsp"></jsp:include>


    <div id="overlay" style="display: none;"></div>

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
        let amount = {
            currency: "KRW",
            value: 0,
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
        
        function tryPayment() {
        	// 토스와 연결된 세가지 결제방법이라면
        	if (selectedPaymentMethod == "CARD" || selectedPaymentMethod == "TRANSFER" || selectedPaymentMethod == "VIRTUAL_ACCOUNT"
        			|| selectedPaymentMethod == "NAVER_PAY" || selectedPaymentMethod == "KAKAO_PAY") {
        		// TODO : 총 결제금액을 view에서 얻어오기, 여기서는 100원으로 임의로 설정
        		amount.value = 200
        		
        		let response = sendAmountToServer(amount)
        		if (response == null) {
        			return;
        		} else if (response.result == "fail") {
        			// TODO : 잚못된 요청입니다 페이지 날리기
        			alert("잘못된 요청입니다")
        			return;
        		}
            	// TODO : 뷰에서 상품목록 조립해서 이름 만들기
            	let orderName = "어쩌고저쩌고"
            	requestPayment(response.orderId, orderName, amount)
        	}
/*         	// working... 네이버페이하고 카카오페이는 아직 테스트 안함
        	// TODO : 뷰에서 상품목록 조립해서 이름 만들기
        	let orderName = "어쩌고저쩌고"
        	requestPayment(null, orderName, amount) */
        }

        // TODO : orders 테이블에 행을 삽입하는 시점에서 orderId가 서버의 session에 저장되어 있어야 함.
        // 일단 여기서는 테스트를 위해 입력폼으로 orderId를 전송, **테스트가 끝나면 컨트롤러의 메소드를 삭제해야 함!!**
        function sendOrderIdForTest() {
            let orderId = $("#testOrderIdInput").val()
            console.log("서버 세션에 저장할 orderId : " + orderId)
            $.ajax({
                async : false,
            	type : 'POST',
                url : "/payment/test/saveOrderId",
                data: {
                    "orderId": orderId
                },
                dataType: "text",
                success : function(res) {
                	console.log("saveOrderId 성공");
                },
                error : function(request, status, error) {
            		console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                    console.log("saveOrderId 실패")       
            	}
            })
        }

        // 결제 과정에서 악의적으로 결제 금액이 바뀌는 것을 확인하기 위해 서버에 저장
        // orders 테이블에 insert가 이미 일어났으므로 orderId는 이미 서버에 저장되어 있음
        function sendAmountToServer(amount) {
        	let response = null
            $.ajax({
                async : false,
            	type : 'POST',
                url : "/payment/saveExpectedTotalPrice",
                data: amount, // amount 객체의 예시 : {currency : "KRW", value : 100}
                dataType: "json",
                contentType : 'application/x-www-form-urlencoded',
                // NOTE : cotentType을 application/json으로 지정하고 스프링 서버에서 @Requestbody + DTO 객체로 받아올 수도 있지만 DTO 만들기 싫어서 이렇게 함
                success : function(res) {
                	console.log("sendAmountToServer response : " + JSON.stringify(res));
                	response = res
                },
                error : function(request, status, error) {
            		console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);       
            	}
        	})
        	return response
        }
        
        
        // ------ '결제하기' 버튼 누르면 결제창 띄우기 ------
        // @docs https://docs.tosspayments.com/sdk/v2/js#paymentrequestpayment
        async function requestPayment(orderId = null, orderName, amount) {            
            switch (selectedPaymentMethod) {
            case "CARD":
                await payment.requestPayment({
                    method: "CARD", // 카드 및 간편결제
                    amount: amount,
                    orderId: orderId,
                    orderName: orderName,
                    successUrl: window.location.origin + "/payment/success.html", // 결제 요청이 성공하면 리다이렉트되는 URL
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
                    amount: amount,
                    orderId: orderId,
                    orderName: orderName,
                    successUrl: window.location.origin + "/payment/success.html",
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
                    amount: amount,
                    orderId: orderId,
                    orderName: orderName,
                    successUrl: window.location.origin + "/payment/success.html",
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
                    "productName": orderName,
                    "productCount": "0",
                    "totalPayAmount": "" + amount.value,
                    "taxScopeAmount": "" + amount.value,
                    "taxExScopeAmount": "0",
                    "returnUrl": window.location.origin + "/approveNaverPay"
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
                    amount: amount.value
                }
                
                // NOTE : ajax 요청은 컨트롤러로부터 응답을 받아도 페이지를 이동시켜주지 않는다. 그래서 success 메서드를 붙어야 함 
                $.ajax({
                  type : 'POST',
                  url : "/kakaoPay/ready",
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
                  },
                  error : function(request, status, error) {
              		console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);       
              	  }
                })
            }
        }

        function generateRandomString() {
            return window.btoa(Math.random()).slice(0, 20);
        }
        
        // TODO : 실험용 임시 function, 삭제 요망 
        function myTest() {
        	alert("테스트 중")
        	$.ajax({
        		url : "/myTest",
        		type: "GET"
        	})
        }
    </script>
</body>
</html>