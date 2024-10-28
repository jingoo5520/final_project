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
<link rel="shortcut icon" type="image/x-icon" href="/resources/assets/user/images/logo/white-logo.svg" />

<!-- ========================= CSS here ========================= -->
<link rel="stylesheet" href="/resources/assets/user/css/bootstrap.min.css" />
<link rel="stylesheet" href="/resources/assets/user/css/LineIcons.3.0.css" />
<link rel="stylesheet" href="/resources/assets/user/css/tiny-slider.css" />
<link rel="stylesheet" href="/resources/assets/user/css/glightbox.min.css" />
<link rel="stylesheet" href="/resources/assets/user/css/main.css" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

</head>

<body>
	<!-- Preloader -->
	<div class="preloader">
		<div class="preloader-inner">
			<div class="preloader-icon">
				<span></span> <span></span>
			</div>
		</div>
	</div>
	<!-- /End Preloader -->

	<jsp:include page="/WEB-INF/views/user/pages/header.jsp"></jsp:include>

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
								<li><a href="product-grids.html">문의</a></li>
								<li><a href="product-grids.html">TV, Video & Audio</a><span>(420)</span></li>
								<li><a href="product-grids.html">Cameras, Photo & Video</a><span>(874)</span></li>
								<li><a href="product-grids.html">Headphones</a><span>(1239)</span></li>
								<li><a href="product-grids.html">Wearable Electronics</a><span>(340)</span></li>
								<li><a href="product-grids.html">Printers & Ink</a><span>(512)</span></li>
							</ul>
						</div>
						<!-- End Single Widget -->

					</div>
					<!-- End Product Sidebar -->
				</div>
				<div class="col-lg-9 col-12">
					<!-- Shopping Cart -->
						<div class="cart-list-head">
							<div class="cart-list-title">
								<h5>문의</h5>
							</div>
							<!-- Cart List Title -->
							<div class="cart-list-title">
								<div class="row">
									<div class="col-lg-1 col-md-1 col-12"></div>
									<div class="col-lg-4 col-md-3 col-12">
										<p>Product Name</p>
									</div>
									<div class="col-lg-2 col-md-2 col-12">
										<p>Quantity</p>
									</div>
									<div class="col-lg-2 col-md-2 col-12">
										<p>Subtotal</p>
									</div>
									<div class="col-lg-2 col-md-2 col-12">
										<p>Discount</p>
									</div>
									<div class="col-lg-1 col-md-2 col-12">
										<p>Remove</p>
									</div>
								</div>
							</div>
							<!-- End Cart List Title -->
							<!-- Cart Single List list -->
							<div class="cart-single-list">
								<div class="row align-items-center">
									<div class="col-lg-1 col-md-1 col-12">
										<a href="product-details.html"><img src="/220x200" alt="#"></a>
									</div>
									<div class="col-lg-4 col-md-3 col-12">
										<h5 class="product-name">
											<a href="product-details.html"> Canon EOS M50 Mirrorless Camera</a>
										</h5>
										<p class="product-des">
											<span><em>Type:</em> Mirrorless</span> <span><em>Color:</em> Black</span>
										</p>
									</div>
									<div class="col-lg-2 col-md-2 col-12">
										<div class="count-input">
											<select class="form-control">
												<option>1</option>
												<option>2</option>
												<option>3</option>
												<option>4</option>
												<option>5</option>
											</select>
										</div>
									</div>
									<div class="col-lg-2 col-md-2 col-12">
										<p>$910.00</p>
									</div>
									<div class="col-lg-2 col-md-2 col-12">
										<p>$29.00</p>
									</div>
									<div class="col-lg-1 col-md-2 col-12">
										<a class="remove-item" href="javascript:void(0)"><i class="lni lni-close"></i></a>
									</div>
								</div>
							</div>
							<!-- End Single List list -->
							<!-- Cart Single List list -->
							<div class="cart-single-list">
								<div class="row align-items-center">
									<div class="col-lg-1 col-md-1 col-12">
										<a href="product-details.html"><img src="/220x200" alt="#"></a>
									</div>
									<div class="col-lg-4 col-md-3 col-12">
										<h5 class="product-name">
											<a href="product-details.html"> Apple iPhone X 256 GB Space Gray</a>
										</h5>
										<p class="product-des">
											<span><em>Memory:</em> 256 GB</span> <span><em>Color:</em> Space Gray</span>
										</p>
									</div>
									<div class="col-lg-2 col-md-2 col-12">
										<div class="count-input">
											<select class="form-control">
												<option>1</option>
												<option>2</option>
												<option>3</option>
												<option>4</option>
												<option>5</option>
											</select>
										</div>
									</div>
									<div class="col-lg-2 col-md-2 col-12">
										<p>$1100.00</p>
									</div>
									<div class="col-lg-2 col-md-2 col-12">
										<p>—</p>
									</div>
									<div class="col-lg-1 col-md-2 col-12">
										<a class="remove-item" href="javascript:void(0)"><i class="lni lni-close"></i></a>
									</div>
								</div>
							</div>
							<!-- End Single List list -->
							<!-- Cart Single List list -->
							<div class="cart-single-list">
								<div class="row align-items-center">
									<div class="col-lg-1 col-md-1 col-12">
										<a href="product-details.html"><img src="/220x200" alt="#"></a>
									</div>
									<div class="col-lg-4 col-md-3 col-12">
										<h5 class="product-name">
											<a href="product-details.html">HP LaserJet Pro Laser Printer</a>
										</h5>
										<p class="product-des">
											<span><em>Type:</em> Laser</span> <span><em>Color:</em> White</span>
										</p>
									</div>
									<div class="col-lg-2 col-md-2 col-12">
										<div class="count-input">
											<select class="form-control">
												<option>1</option>
												<option>2</option>
												<option>3</option>
												<option>4</option>
												<option>5</option>
											</select>
										</div>
									</div>
									<div class="col-lg-2 col-md-2 col-12">
										<p>$550.00</p>
									</div>
									<div class="col-lg-2 col-md-2 col-12">
										<p>—</p>
									</div>
									<div class="col-lg-1 col-md-2 col-12">
										<a class="remove-item" href="javascript:void(0)"><i class="lni lni-close"></i></a>
									</div>
								</div>
							</div>
							<!-- End Single List list -->
						</div>
				</div>
				<!--/ End Shopping Cart -->


			</div>
		</div>
	</section>
	<!-- End Product Grids -->



	<jsp:include page="/WEB-INF/views/user/pages/footer.jsp"></jsp:include>

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
            container: '.hero-slider',
            slideBy: 'page',
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
            container: '.brands-logo-carousel',
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
                }
            }
        });

    </script>
	<script>
        const finaleDate = new Date("February 15, 2023 00:00:00").getTime();

        const timer = () => {
            const now = new Date().getTime();
            let diff = finaleDate - now;
            if (diff < 0) {
                document.querySelector('.alert').style.display = 'block';
               // index에서 topbar가 display none되지 않도록 처리
               // document.querySelector('.container').style.display = 'none';
            }

            let days = Math.floor(diff / (1000 * 60 * 60 * 24));
            let hours = Math.floor(diff % (1000 * 60 * 60 * 24) / (1000 * 60 * 60));
            let minutes = Math.floor(diff % (1000 * 60 * 60) / (1000 * 60));
            let seconds = Math.floor(diff % (1000 * 60) / 1000);

            days <= 99 ? days = `0${days}` : days;
            days <= 9 ? days = `00${days}` : days;
            hours <= 9 ? hours = `0${hours}` : hours;
            minutes <= 9 ? minutes = `0${minutes}` : minutes;
            seconds <= 9 ? seconds = `0${seconds}` : seconds;

            document.querySelector('#days').textContent = days;
            document.querySelector('#hours').textContent = hours;
            document.querySelector('#minutes').textContent = minutes;
            document.querySelector('#seconds').textContent = seconds;

        }
        timer();
        setInterval(timer, 1000);
        
        // index에서 topbar가 display none되지 않도록 처리
        $("#test").css("display", "block");
    </script>
</body>

</html>