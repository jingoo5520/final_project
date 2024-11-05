<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html class="no-js" lang="zxx">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <title>리뷰</title>
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
<div>${reviews }</div>

	<!-- Start Breadcrumbs -->
	<div class="breadcrumbs">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-lg-6 col-md-6 col-12">
					<div class="breadcrumbs-content">
						<h1 class="page-title">Shop Grid</h1>
					</div>
				</div>
				<div class="col-lg-6 col-md-6 col-12">
					<ul class="breadcrumb-nav">
						<li><a href="index.html"><i class="lni lni-home"></i> Home</a></li>
						<li><a href="javascript:void(0)">Shop</a></li>
						<li>Shop Grid</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- End Breadcrumbs -->

	<section class="product-grids section">
		<div class="container">
			<div class="row">
				<div class="col-lg-3 col-12">
					<!-- Start Product Sidebar -->
					<div class="product-sidebar">
						<!-- Start Single Widget -->
						<div class="single-widget">
							<h3>고객센터</h3>
							<ul class="list">



								<li><a href="product-grids.html">공지사항 </a></li>
								<li><a href="product-grids.html">이벤트 </a></li>
								<li><a href="product-grids.html">문의</a></li>
								<li><a href="product-grids.html">멤버십 혜택</a></li>
							</ul>
						</div>
						<!-- End Single Widget -->

					</div>
					<!-- End Product Sidebar -->
				</div>
				<div class="col-lg-9 col-12">
					<!-- Shopping Cart -->
					<div class="cart-list-head" style="border: none">
						<div class="cart-list-title">
							<h5 style = "text-align : center;"> <a href = "/review/writableReview">작성 가능 리뷰</a>  / <a href = "/review/writtenByReview">작성 한 리뷰</a></h5>
						</div>
						<!-- Cart List Title -->
						<div class="cart-list-title">
							<div class="row">
								<div class="col-lg-2 col-md-2 col-12">
									<p>상품 사진</p>
								</div>
								<div class="col-lg-6 col-md-6 col-12">
									<p>상품 이름</p>
								</div>
								<div class="col-lg-2 col-md-2 col-12">
									<p>배송 완료일</p>
								</div>
								<div class="col-lg-2 col-md-2 col-12">
									<p>작업</p>
								</div>
							</div>
						</div>
						<!-- End Cart List Title -->

<c:forEach var="review" items="${reviews}">
    <div class="cart-single-list">
        <div class="row align-items-center">
            <div class="col-lg-2 col-md-2 col-12">
                <c:choose>
                    <c:when test="${not empty review.image_main_url}">
                        <img src="${review.image_main_url}" alt="Product Image" class="img-fluid">
                    </c:when>
                    <c:otherwise>
                        <img src="/images/noP_image.png" alt="Default Image" class="img-fluid">
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="col-lg-6 col-md-6 col-12">${review.product_name}</div>
            <div class="col-lg-2 col-md-2 col-12">
                <fmt:formatDate value="${review.product_reg_date}" pattern="yyyy-MM-dd" />
            </div>
            <div class="col-lg-2 col-md-2 col-12">
                <a href="/review/writeReview?product_no=${review.product_no}">리뷰작성</a>
            </div>
        </div>
    </div>
</c:forEach>


						<div class="pagination center">
							<ul class="pagination-list">
								<li><a href="javascript:void(0)">1</a></li>
								<li class="active"><a href="javascript:void(0)">2</a></li>
								<li><a href="javascript:void(0)">3</a></li>
								<li><a href="javascript:void(0)">4</a></li>
								<li><a href="javascript:void(0)"><i class="lni lni-chevron-right"></i></a></li>
							</ul>
						</div>


					</div>

				</div>
				<!--/ End Shopping Cart -->
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