<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html class="no-js" lang="zxx">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <title>Single Product - ShopGrids Bootstrap 5 eCommerce HTML Template.</title>
    <meta name="description" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="shortcut icon" type="image/x-icon" href="/resources/assets/user/images/logo/white-logo.svg" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- ========================= CSS here ========================= -->
    <link rel="stylesheet" href="/resources/assets/user/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/resources/assets/user/css/LineIcons.3.0.css" />
    <link rel="stylesheet" href="/resources/assets/user/css/tiny-slider.css" />
    <link rel="stylesheet" href="/resources/assets/user/css/glightbox.min.css" />
    <link rel="stylesheet" href="/resources/assets/user/css/main.css" />

</head>

<script type="text/javascript">

function addCart(productNo) {
	let quantity = $("#quantity").val();
	
	$.ajax({
	    url: '/addCartItem',
	    type: 'POST',
	    data: {
	    	productNo : productNo,
	    	quantity : quantity
	    	},
	    dataType: 'json',
	    success: function(data) {
	        console.log(data);
	    },
	    error: function() {
	    },
	    complete: function(data) {
	    	if (data.status == 200) {
	    		let isConfirmed = confirm("장바구니 페이지로 가시겠습니까?");
	    		
	    		if (isConfirmed) {
	    			location.href="/cart";
	    		}
	        } else if (data.responseText == 401){
	        	alert("로그인 안했는데요?");
	        }
	    }
	});
	
	
	
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
    
<jsp:include page="../header.jsp"></jsp:include>
    <section class="item-details section">
        <div class="container">
            <div class="top-area">
                <div class="row align-items-center">
                    <div class="col-lg-6 col-md-12 col-12">
                        <div class="product-info">
                            <h2 class="title">GoPro Karma Camera Drone</h2>
                            <h3>Product No : <span id="productNo">${productNo }</span></h3>
                            <h3 class="price">$850<span>$945</span></h3>
                            <form action="/order" method="post">
	                            <div class="row">
	                                <div class="col-lg-4 col-md-4 col-12">
	                                    <div class="form-group quantity">
	                                        <label for="color">수량</label>
	                                        <input type="hidden" name="productNo" value="${productNo }">
	                                        <input type="text" placeholder="수량" id="quantity" name="quantity" value="1">
	                                    </div>
	                                </div>
	                            </div>
	                            <div class="bottom-content">
	                                <div class="row align-items-end">
	                                    <div class="col-lg-4 col-md-4 col-12">
	                                        <div class="button cart-button">
	                                            <button type="submit" class="btn" style="width: 100%;">주문하기</button>
	                                        </div>
	                                    </div>
	                                    <div class="col-lg-4 col-md-4 col-12">
	                                        <div class="wish-button">
	                                            <button class="btn" onclick="addCart(${productNo })"><i class="lni lni-heart"></i>장바구니 넣기</button>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

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