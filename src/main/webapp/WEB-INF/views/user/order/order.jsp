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

</head>

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
                                <section class="checkout-steps-form-content collapse" id="collapseThree"
                                    aria-labelledby="headingThree" data-bs-parent="#accordionExample">
                                    <div class="col-md-6">
										<div class="single-form form-default">
											<div class="form-input form">
												<label>상품 수량</label>
												<input type="text" placeholder="quantity" name="orderProductQuantity">
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="single-form form-default">
											<div class="form-input form">
												<img alt="productImg" src="" width="67px;" height="67px;">
												<label>상품 이름</label>
											</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="single-form form-default">
											<div class="form-input form">
												<label>상품 가격</label>
												<h3>0 원</h3>
											</div>
										</div>
									</div>
                                </section>
                            </li>
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
                                <section>
                                	<div>
                                		<div class="single-form form-default button">
                                        	<button class="btn" type="submit">정보 적용</button>
                                        </div>
                                	</div>
                                </section>
                            </li>
                            <li>
                                <h5 class="title collapsed" data-bs-toggle="collapse" data-bs-target="#collapseSeven"
                                    aria-expanded="false" aria-controls="collapseSeven">결제 수단</h5>
                                <section class="checkout-steps-form-content collapse" id="collapseSeven"
                                    aria-labelledby="headingSeven" data-bs-parent="#accordionExample">
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
                                    <p class="price">0 원</p>
                                </div>
                                 <div class="total-price discount">
                                    <p class="value">총 할인금액</p>
                                    <p class="price">-0원</p>
                                </div>
                                <div class="total-price shipping">
                                    <p class="value">총 배송비</p>
                                    <p class="price">0원</p>
                                </div>
                            </div>

                            <div class="total-payable">
                                <div class="payable-price">
                                    <h6 class="value bold" style="color: black;">총 결제금액</h6>
                                    <h6 class="price" style="color: red;">0 원</h6>
                                </div>
	                                <div class="sub-total-price">
	                                	<div class="total-price point mb-30">
	                                    	<p class="value">총 적립예정 포인트</p>
	                                    	<p class="price">0 P</p>
	                                    </div>
	                                </div>
                            </div>
                            <div class="price-table-btn button">
                                <a href="javascript:void(0)" class="btn btn-alt">(총 1개) 0 원 결제하기</a>
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
</body>

</html>