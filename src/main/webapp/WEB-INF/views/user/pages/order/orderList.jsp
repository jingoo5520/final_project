<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <!-- <div class="preloader">
        <div class="preloader-inner">
            <div class="preloader-icon">
                <span></span>
                <span></span>
            </div>
        </div>
    </div> -->
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
            <div class="row">
                <div class="col-lg-9">
                    <div class="checkout-steps-form-style-1">
                        <!--NOTE : cart list는 아니지만 UI가 적합하여 템플릿을 사용-->
                        <!-- TODO : 아래의 내용은 예시로 입력해놓은 것으로 동적으로 html 태그 작성해야 함 -->
                    	<div class="cart-list-head">
                    		<div class="cart-list-title">
                    			<div class="row align-items-center">
                    				<div class="col-lg-1 col-md-1 col-12"></div>
                    				<div class="col-lg-4 col-md-4 col-12"><p>상품정보</p></div>
                    				<div class="col-lg-2 col-md-2 col-12"><p>주문일자/주문번호</p></div>
                    				<div class="col-lg-2 col-md-2 col-12"><p>처리상태</p></div>
                    				<div class="col-lg-3 col-md-3 col-12"><p>변경/처리</p></div>
                    			</div>
                    		</div>
                            <span id="product-insert"></span>
                    		<div class="cart-single-list grid-container">
                    			<div class="row align-items-center">
                    				<div class="col-lg-1 col-md-1 col-12">
                    					<a href=""></a> <!-- 상품 상세페이지 이동 -->
                    						<img src="https://webimg.jestina.co.kr/UpData2/item/G2000027380/20240903180236ZM.png" alt="#">
                    					</a>
                    				</div>
                    				<div class="col-lg-4 col-md-4 col-12">
                    					<p>[아이유 PICK] J.Livera 14K 체인 목걸이 (JJJTN04BF010R4420)'</p>
                    				</div>
                    				<div class="col-lg-2 col-md-2 col-12">
                    					<p>2024.10.28</p>
                    					<p>239194</p>
                    				</div>
                    				<div class="col-lg-2 col-md-2 col-12">
                    					<p>결제완료</p>
                    				</div>
                    				<div class="col-lg-3 col-md-3 col-12 action-column">
                    					<p>주문취소</p>
                    				</div>
                    			</div>
                    		</div>               
                    		<div class="cart-single-list">
                    			<div class="row align-items-center">
                    				<div class="col-lg-1 col-md-1 col-12">
                    					<a href=""></a> <!-- 상품 상세페이지 이동 -->
                    						<img src="https://webimg.jestina.co.kr/UpData2/item/G2000027377/20240903175828ZM.png" alt="#">
                    					</a>
                    				</div>
                    				<div class="col-lg-4 col-md-4 col-12">
                    					<p>J.Fenella 14K 목걸이 (JJJTNQ4BF008R4420)</p>
                    				</div>
                    				<div class="col-lg-2 col-md-2 col-12">
                    					<p>2024.10.30</p>
                    					<p>212144</p>
                    				</div>
                    				<div class="col-lg-2 col-md-2 col-12">
                    					<p>배송완료</p>
                    				</div>
                                    <div class="col-lg-3 col-md-3 col-12">
                    					<form action="/cancelOrder" method="POST">
                    						<input type="text" name="orderNo" value="425346" style="display:none">
                    						<input type="submit" value="반품/환불">
                    					</form>
                    				</div>
                    			</div>
                    		</div>

                            <div class="cart-single-list">
                    			<div class="row align-items-center">
                    				<div class="col-lg-1 col-md-1 col-12">
                    					<a href=""></a> <!-- 상품 상세페이지 이동 -->
                    						<img src="https://webimg.jestina.co.kr/UpData2/item/G2000027377/20240903175828ZM.png" alt="#">
                    					</a>
                    				</div>
                    				<div class="col-lg-4 col-md-4 col-12">
                    					<p>J.Fenella 14K 목걸이 (JJJTNQ4BF008R4420)</p>
                    				</div>
                    				<div class="col-lg-2 col-md-2 col-12">
                    					<p>2024.10.30</p>
                    					<p>212144</p>
                    				</div>
                    				<div class="col-lg-2 col-md-2 col-12">
                    					<p>배송완료</p>
                    				</div>
                    				<div class="col-lg-3 col-md-3 col-12">
                    					<form action="/cancelOrder" method="POST">
                    						<input type="text" name="orderNo" value="425346" style="display:none">
                    						<input type="submit" value="반품/환불">
                    					</form>
                    				</div>
                    			</div>
                    		</div>
 
                    	</div>    
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
    
    <script>
        let items = null
        let memberId = null
        window.onload = function() {
            requestProductInfo()
        }

        function requestProductInfo() {
            $.ajax({
                async: false,
                type : 'GET',
                url : "/getLoginedId",
                dataType : "text",
                success : function(response) {
                    memberId = response
                },
                error : function(request, status, error) {
                    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);       
                }
            })

            $.ajax({
                type : "GET",
                url : "/orderProducts?memberId=" + memberId,
                dataType : "json",
                success : function(response) {
                    console.log("페이지에 뿌릴 정보 : ")
                    console.log(response)
                },
            })
        }
    </script>
    
    
    
</body>
</html>