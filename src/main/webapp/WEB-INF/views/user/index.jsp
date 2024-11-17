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
</head>
<style>
.title a {
	display: -webkit-box !important;
	overflow: hidden !important;
	-webkit-line-clamp: 2 !important;
	line-clamp: 2 !important;
	-webkit-box-orient: vertical !important;
}

.buttonArea {
	display: flex;
	flex-direction: row;
	position: inherit;
	width: 50% !important;
	justify-content: space-between;
}

.buttonArea .btn {
	display: flex !important;
	flex-direction: row !important;
	justify-content: center !important;
}

.btn i {
	margin: 0 !important;
}

.hero-area .container {
	width: 100% !important;
	max-width: 100% !important;
	padding: 0px !important;
}

.hero-area {
	margin-top: 0 !important;
}
</style>
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

	<jsp:include page="pages/header.jsp"></jsp:include>

	<!-- Start Hero Area -->
	<section class="hero-area">
		<div class="container">
			<div class="row">
				<div class="col-12 custom-padding-right">
					<div class="slider-head">
						<!-- Start Hero Slider -->
						<div class="hero-slider">
							<!-- Start Single Slider -->
							<c:forEach var="banner" items="${mainBannerList}">
								<div class="single-slider">
									<img src="${banner.banner_image}" width="100%" height="500px" style="object-fit: cover; object-position: center;">
								</div>
							</c:forEach>
							<!-- End Single Slider -->
						</div>
						<!-- End Hero Slider -->
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- End Hero Area -->

	<!-- Start Featured Categories Area -->
	<section class="featured-categories section">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<div class="section-title">
						<h2>이벤트</h2>
					</div>
				</div>
			</div>
			<div class="row">

				<c:forEach var="banner" items="${subBannerList}">
					<div class="col-md-6 col-12">
						<!-- Start Single Category -->
						<div class="single-category" style="height: 350px">
							<img src="${banner.thumbnail_image}" width="100%" height="100%" style="object-fit: cover;">
						</div>
						<!-- End Single Category -->
					</div>
				</c:forEach>


			</div>
		</div>
	</section>
	<!-- End Features Area -->

	<!-- Start Trending Product Area -->
	<section class="trending-product section">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<div class="section-title">
						<h2>추천 아이템(신상품)</h2>
					</div>
				</div>
			</div>
			<div class="row">
				<c:forEach var="product" items="${newProducts}">
					<div class="col-lg-3 col-md-6 col-12">
						<!-- Start Single Product -->
						<div class="single-product">
							<div class="product-image" style="height: 300px;">
								<img src="${product.image_url }" onerror="this.onerror=null; this.src='/resources/images/noP_image.png';" style="height: 100%; object-fit: cover;" />
								
							</div>
							<div class="product-info">
								<span class="category">${product.category_name }</span>
								<h4 class="title">
									<a href="/product/jewelry/detail?productNo=${product.product_no }">${product.product_name }</a>
								</h4>

								<div class="price">
									<span>
										<fmt:formatNumber value="${product.product_price}" pattern="#,###" />
										원
									</span>
								</div>
							</div>
						</div>
						<!-- End Single Product -->
					</div>
				</c:forEach>
				<!-- End Single Product -->
			</div>
		</div>
	</section>
	<!-- End Trending Product Area -->

	<jsp:include page="pages/footer.jsp"></jsp:include>

	<!-- ========================= scroll-top ========================= -->
	<a href="#" class="scroll-top"> <i class="lni lni-chevron-up"></i>
	</a>

	<!-- ========================= JS here ========================= -->
	<script src="/resources/assets/user/js/bootstrap.min.js"></script>
	<script src="/resources/assets/user/js/tiny-slider.js"></script>
	<script src="/resources/assets/user/js/glightbox.min.js"></script>
	<script src="/resources/assets/user/js/main.js"></script>
	<script type="text/javascript">
            //========= Hero Slider
            tns({
                container: ".hero-slider",
                slideBy: "page",
                autoplay: true,
                autoplayButtonOutput: false,
                mouseDrag: true,
                gutter: 0,
                items: 1,
                nav: false,
                controls: true,
                controlsText: ['<i class="lni lni-chevron-left"></i>', '<i class="lni lni-chevron-right"></i>'],
            });

            //======== Brand Slider
            tns({
                container: ".brands-logo-carousel",
                autoplay: true,
                autoplayButtonOutput: false,
                mouseDrag: true,
                gutter: 15,
                nav: false,
                controls: false,
                responsive: {
                    0: {
                        items: 1,
                    },
                    540: {
                        items: 3,
                    },
                    768: {
                        items: 5,
                    },
                    992: {
                        items: 6,
                    },
                },
            });
        </script>
	<script>
            const finaleDate = new Date("February 15, 2023 00:00:00").getTime();

            const timer = () => {
                const now = new Date().getTime();
                let diff = finaleDate - now;
                if (diff < 0) {
                    document.querySelector(".alert").style.display = "block";
                    // index에서 topbar가 display none되지 않도록 처리
                    // document.querySelector('.container').style.display = 'none';
                }

                let days = Math.floor(diff / (1000 * 60 * 60 * 24));
                let hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                let minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
                let seconds = Math.floor((diff % (1000 * 60)) / 1000);

                days <= 99 ? (days = `0${days}`) : days;
                days <= 9 ? (days = `00${days}`) : days;
                hours <= 9 ? (hours = `0${hours}`) : hours;
                minutes <= 9 ? (minutes = `0${minutes}`) : minutes;
                seconds <= 9 ? (seconds = `0${seconds}`) : seconds;

                document.querySelector("#days").textContent = days;
                document.querySelector("#hours").textContent = hours;
                document.querySelector("#minutes").textContent = minutes;
                document.querySelector("#seconds").textContent = seconds;
            };
            timer();
            setInterval(timer, 1000);

            // index에서 topbar가 display none되지 않도록 처리
            $("#test").css("display", "block");
        </script>
</body>
</html>

