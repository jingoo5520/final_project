<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html class="no-js" lang="zxx">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <title>Shop List - ShopGrids Bootstrap 5 eCommerce HTML Template.</title>
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
		
		$.ajax({
		    url: '/addCartItem',
		    type: 'POST',
		    data: {
		    	productNo : productNo
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

    <!-- Start Breadcrumbs -->
    <div class="breadcrumbs">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6 col-md-6 col-12">
                    <div class="breadcrumbs-content">
                        <h1 class="page-title">Shop List</h1>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-12">
                    <ul class="breadcrumb-nav">
                        <li><a href="index.html"><i class="lni lni-home"></i> Home</a></li>
                        <li><a href="index.html">Shop</a></li>
                        <li>Shop List</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!-- End Breadcrumbs -->

    <!-- Start Product Grids -->
    <section class="product-grids section">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-12">
                    <!-- Start Product Sidebar -->
                    <div class="product-sidebar">
                        <!-- Start Single Widget -->
                        <div class="single-widget search">
                            <h3>Search Product</h3>
                            <form action="#">
                                <input type="text" placeholder="Search Here...">
                                <button type="submit"><i class="lni lni-search-alt"></i></button>
                            </form>
                        </div>
                        <!-- End Single Widget -->
                        <!-- Start Single Widget -->
                        <div class="single-widget">
                            <h3>All Categories</h3>
                            <ul class="list">
                                <li>
                                    <a href="product-grids.html">Computers & Accessories </a><span>(1138)</span>
                                </li>
                                <li>
                                    <a href="product-grids.html">Smartphones & Tablets</a><span>(2356)</span>
                                </li>
                                <li>
                                    <a href="product-grids.html">TV, Video & Audio</a><span>(420)</span>
                                </li>
                                <li>
                                    <a href="product-grids.html">Cameras, Photo & Video</a><span>(874)</span>
                                </li>
                                <li>
                                    <a href="product-grids.html">Headphones</a><span>(1239)</span>
                                </li>
                                <li>
                                    <a href="product-grids.html">Wearable Electronics</a><span>(340)</span>
                                </li>
                                <li>
                                    <a href="product-grids.html">Printers & Ink</a><span>(512)</span>
                                </li>
                            </ul>
                        </div>
                        <!-- End Single Widget -->
                        <!-- Start Single Widget -->
                        <div class="single-widget range">
                            <h3>Price Range</h3>
                            <input type="range" class="form-range" name="range" step="1" min="100" max="10000"
                                value="10" onchange="rangePrimary.value=value">
                            <div class="range-inner">
                                <label>$</label>
                                <input type="text" id="rangePrimary" placeholder="100" />
                            </div>
                        </div>
                        <!-- End Single Widget -->
                        <!-- Start Single Widget -->
                        <div class="single-widget condition">
                            <h3>Filter by Price</h3>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault1">
                                <label class="form-check-label" for="flexCheckDefault1">
                                    $50 - $100L (208)
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault2">
                                <label class="form-check-label" for="flexCheckDefault2">
                                    $100L - $500 (311)
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault3">
                                <label class="form-check-label" for="flexCheckDefault3">
                                    $500 - $1,000 (485)
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault4">
                                <label class="form-check-label" for="flexCheckDefault4">
                                    $1,000 - $5,000 (213)
                                </label>
                            </div>
                        </div>
                        <!-- End Single Widget -->
                        <!-- Start Single Widget -->
                        <div class="single-widget condition">
                            <h3>Filter by Brand</h3>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault11">
                                <label class="form-check-label" for="flexCheckDefault11">
                                    Apple (254)
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault22">
                                <label class="form-check-label" for="flexCheckDefault22">
                                    Bosh (39)
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault33">
                                <label class="form-check-label" for="flexCheckDefault33">
                                    Canon Inc. (128)
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault44">
                                <label class="form-check-label" for="flexCheckDefault44">
                                    Dell (310)
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault55">
                                <label class="form-check-label" for="flexCheckDefault55">
                                    Hewlett-Packard (42)
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault66">
                                <label class="form-check-label" for="flexCheckDefault66">
                                    Hitachi (217)
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault77">
                                <label class="form-check-label" for="flexCheckDefault77">
                                    LG Electronics (310)
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault88">
                                <label class="form-check-label" for="flexCheckDefault88">
                                    Panasonic (74)
                                </label>
                            </div>
                        </div>
                        <!-- End Single Widget -->
                    </div>
                    <!-- End Product Sidebar -->
                </div>
                <div class="col-lg-9 col-12">
                    <div class="product-grids-head">
                        <div class="product-grid-topbar">
                            <div class="row align-items-center">
                                <div class="col-lg-7 col-md-8 col-12">
                                    <div class="product-sorting">
                                        <label for="sorting">Sort by:</label>
                                        <select class="form-control" id="sorting">
                                            <option>Popularity</option>
                                            <option>Low - High Price</option>
                                            <option>High - Low Price</option>
                                            <option>Average Rating</option>
                                            <option>A - Z Order</option>
                                            <option>Z - A Order</option>
                                        </select>
                                        <h3 class="total-show-product">Showing: <span>1 - 12 items</span></h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-content" id="nav-tabContent">
                            <div class="tab-pane fade active show" id="nav-grid" role="tabpanel" aria-labelledby="nav-grid-tab">
                                <div class="row">
                                    <div class="col-lg-4 col-md-6 col-12">
                                        <!-- Start Single Product -->
                                        <div class="single-product" id="1">
                                            <div class="product-image">
                                                <img src="https://webimg.jestina.co.kr/UpData2/item/G2000024045/20210304143541ZM.png" alt="#">
                                                <div class="button">
                                                    <a onclick="addCart(this);" class="btn" style="width:100%;"><i
                                                            class="lni lni-cart"></i>장바구니</a>
                                                </div>
                                            </div>
                                            <div class="product-info">
                                                <span class="category">etc</span>
                                                <h4 class="title">
                                                    <a href="/product/productDetail?productNo=1">14K 보조체인 3cm (JJZ1N01BS571R4030)</a>
                                                </h4>
                                                <div class="price">
                                                    <span>85500 원</span>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- End Single Product -->
                                    </div>
									<div class="col-lg-4 col-md-6 col-12">
                                        <!-- Start Single Product -->
                                        <div class="single-product" id="2">
                                            <div class="product-image">
                                                <img src="https://webimg.jestina.co.kr/UpData2/item/G2000024044/20210304143521ZM.png" alt="#">
                                                <div class="button">
                                                    <a onclick="addCart(this);" class="btn" style="width:100%;"><i
                                                            class="lni lni-cart"></i>장바구니</a>
                                                </div>
                                            </div>
                                            <div class="product-info">
                                                <span class="category">etc</span>
                                                <h4 class="title">
                                                    <a href="/product/productDetail?productNo=2">14K 보조체인 3cm (JJZ1N01BS570R4030)</a>
                                                </h4>
                                                <div class="price">
                                                    <span>85500 원</span>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- End Single Product -->
                                    </div>
									<div class="col-lg-4 col-md-6 col-12">
                                        <!-- Start Single Product -->
                                        <div class="single-product" id="3">
                                            <div class="product-image">
                                                <img src="https://webimg.jestina.co.kr/UpData2/item/G2000023811/20210119164247ZM.png" alt="#">
                                                <div class="button">
                                                    <a onclick="addCart(this);" class="btn" style="width:100%;"><i
                                                            class="lni lni-cart"></i>장바구니</a>
                                                </div>
                                            </div>
                                            <div class="product-info">
                                                <span class="category">etc</span>
                                                <h4 class="title">
                                                    <a href="/product/productDetail?productNo=3">실버 보조체인 7cm (JJZ1N07AS076SR070)</a>
                                                </h4>
                                                <div class="price">
                                                    <span>12750 원</span>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- End Single Product -->
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-12">
                                        <!-- Pagination -->
                                        <div class="pagination left">
                                            <ul class="pagination-list">
                                                <li><a href="javascript:void(0)">1</a></li>
                                                <li class="active"><a href="javascript:void(0)">2</a></li>
                                                <li><a href="javascript:void(0)">3</a></li>
                                                <li><a href="javascript:void(0)">4</a></li>
                                                <li><a href="javascript:void(0)"><i
                                                            class="lni lni-chevron-right"></i></a></li>
                                            </ul>
                                        </div>
                                        <!--/ End Pagination -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- End Product Grids -->

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