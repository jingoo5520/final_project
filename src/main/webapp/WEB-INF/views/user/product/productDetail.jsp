<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html class="no-js" lang="zxx">
<style>

#gallery {
    display: flex;
    flex-direction: column;
    align-items: center;
}

.main-img img {
    width: 500px; /* 메인 이미지의 너비 */
    height: 500px; /* 비율을 유지하며 높이 자동 조정 */
    object-fit: cover; /* 이미지가 지정된 크기에 맞게 조정 */
}

.images {
    display: flex;
    justify-content: center;
    gap: 10px; /* 이미지 간의 간격 조절 */
    margin-top: 15px; /* 메인 이미지와 서브 이미지 사이의 간격 */
}

.images img {
    width: 100px; /* 서브 이미지의 너비 */
    height: 100px; /* 서브 이미지의 높이 */
    object-fit: cover; /* 이미지가 지정된 크기에 맞게 조정 */
    cursor: pointer; /* 이미지에 마우스를 올리면 포인터 커서로 변경 */
    transition: transform 0.3s; /* 서브 이미지에 호버 애니메이션 추가 */
}

.images img:hover {
    transform: scale(1.2); /* 서브 이미지에 호버 시 확대 효과 */
}
</style>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <title>Single Product - ShopGrids Bootstrap 5 eCommerce HTML Template.</title>
    <meta name="description" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="shortcut icon" type="image/x-icon" href="/resources/assets/user/images/favicon.svg" />

    <!-- ========================= CSS here ========================= -->
    <link rel="stylesheet" href="/resources/assets/user/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/resources/assets/user/css/LineIcons.3.0.css" />
    <link rel="stylesheet" href="/resources/assets/user/css/tiny-slider.css" />
    <link rel="stylesheet" href="/resources/assets/user/css/glightbox.min.css" />
    <link rel="stylesheet" href="/resources/assets/user/css/main.css" />

</head>

<body>

<jsp:include page="../header.jsp"></jsp:include>

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



    <!-- Start Breadcrumbs -->
    <div class="breadcrumbs">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6 col-md-6 col-12">
                    <div class="breadcrumbs-content">
                        <h1 class="page-title">상품 상세</h1>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-12">
					    <ul class="breadcrumb-nav">
					        <li><a href="/"><i class="lni lni-home"></i> Home</a></li>
					        <li><a href="/product/jewelry/all">JEWELRY</a></li>
					        <li>
					            <c:if test="${not empty products}">
					                ${products[0].category_name}
					            </c:if>
					        </li>
					    </ul>
					</div>
            </div>
        </div>
    </div>
    <!-- End Breadcrumbs -->

    <!-- Start Item Details -->
    <section class="item-details section">
        <div class="container">
            <div class="top-area">

<div class="row align-items-center">
    <div class="col-lg-6 col-md-12 col-12">
        <div class="product-images">
            <main id="gallery">
                <div class="main-img">
                    <c:forEach var="product" items="${products}">
                        <c:if test="${product.image_sub_url == 'M'}">
                            <img src="${product.image_main_url}" id="current" alt="Main Image">
                        </c:if>
                    </c:forEach>
                </div>
							    <div class="images">
							        <!-- 서브 이미지를 표시 -->
							        <c:forEach var="image" items="${products}">
							                <img src="${image.image_main_url}" class="img" alt="Sub Image">
							        </c:forEach>
							    </div>
            </main>
        </div>
    </div>

    <div class="col-lg-6 col-md-12 col-12">
        <div class="product-info">
            <!-- 첫 번째 product의 이름을 한 번만 표시 -->
            <h2 class="title">${products[0].product_name}</h2>
            
            <!-- 카테고리 표시 -->
            <p class="category">
                <a href="/product/jewelry?category=${products[0].product_category}">
                    <i class="lni lni-tag"></i> ${products[0].category_name}
                </a>
            </p>
            
						            <!-- 가격 표시 -->
						            <h3 class="price">
						                <fmt:formatNumber value="${products[0].product_price}" type="number" pattern="#,###"/> KRW
						                <c:if test="${products[0].product_cost != 0}">
						                    <span><fmt:formatNumber value="${products[0].product_cost}" type="number" pattern="#,###"/> KRW</span>
						                </c:if>
						            </h3>
						
						            <div class="row">
						                <div class="col-lg-4 col-md-4 col-12"></div>
						            </div>
									<div class="bottom-content">
									    <div class="row align-items-center">
									        <!-- 장바구니와 찜 버튼을 반반씩 배치 -->
									        <div class="col-lg-6 col-md-6 col-6">
									            <div class="button cart-button" >
									                <button onclick="addCart(${products[0].product_no})" class="btn" style="width: 100%;">장바구니</button>
									            </div>
									        </div>
									        <div class="col-lg-6 col-md-6 col-6">
									            <div class="wish-button">
									                <button class="btn" style="width: 100%;"><i class="lni lni-heart"></i> 찜</button>
									            </div>
									        </div>
									    </div>
									    <div class="row align-items-center mt-3">
									        <!-- 주문 개수 선택 드롭다운 -->
									        <div class="col-lg-12 col-md-12 col-12">
									            <div class="form-group quantity">
									                <label for="quantity">주문개수</label>
									                <select class="form-control" id="quantity">
									                    <option>1</option>
									                    <option>2</option>
									                    <option>3</option>
									                    <option>4</option>
									                    <option>5</option>
									                </select>
									            </div>
									        </div>
									    </div>
									    <div class="row align-items-center mt-3">
									        <!-- 결제 버튼을 전체 너비로 배치 -->
									        <div class="col-lg-12 col-md-12 col-12">
									            <div class="wish-button">
									                <button class="btn" style="width: 100%;"><i class="lni lni-credit-cards"></i> 결제</button>
									            </div>
									        </div>
									    </div>
									</div>
						        </div>
						    </div>
						</div>
                    </div>
                </div>
                
            <div class="container product-details-info"> <!-- Bootstrap의 container 클래스를 사용하여 중앙 정렬 -->
    <div class="single-block">
        <div class="row justify-content-center"> <!-- justify-content-center로 중앙 정렬 -->
            <div class="col-lg-8 col-12"> <!-- col-lg-8로 넓이를 제한 -->
                <div class="info-body custom-responsive-margin">
                    <h4 class="text-center">상품설명</h4> <!-- 제목 가운데 정렬 -->
                        <p class="text-center"> <!-- 텍스트 가운데 정렬 -->
                            <img alt="상품설명" src="${product_content}">
                        </p>
                </div>
            </div>
        </div>
    </div>
    <div class="row justify-content-center"> <!-- justify-content-center로 중앙 정렬 -->
        <div class="col-lg-12 col-12"> <!-- col-lg-6으로 넓이를 제한 -->
            <div class="single-block">
                <div class="reviews">
                    <h4 class="title text-center">너무 고마워서 돌아가버리실거같은 고객님들의 생생정보통 리뷰</h4> <!-- 제목 가운데 정렬 -->
                    <!-- Start Single Review -->
                    <div class="single-review text-center"> <!-- 리뷰 중앙 정렬 -->
                        <img src="https://via.placeholder.com/150x150" alt="#">
                        <div class="review-info">
                            <h4>여긴 title 이 들어가겠지
                                <span>곽다훈</span>
                            </h4>
                            <ul class="stars">
                                <li><i class="lni lni-star-filled"></i></li>
                                <li><i class="lni lni-star-filled"></i></li>
                                <li><i class="lni lni-star-filled"></i></li>
                                <li><i class="lni lni-star-filled"></i></li>
                                <li><i class="lni lni-star-filled"></i></li>
                            </ul>
                            <p>여긴 내용이 들어갈거고</p>
                        </div>
                    </div>
                    <!-- End Single Review -->


                                <!-- End Single Review -->

                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </section>
    <!-- End Item Details -->


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
    <script type="text/javascript">
        const current = document.getElementById("current");
        const opacity = 0.6;
        const imgs = document.querySelectorAll(".img");
        imgs.forEach(img => {
            img.addEventListener("click", (e) => {
                //reset opacity
                imgs.forEach(img => {
                    img.style.opacity = 1;
                });
                current.src = e.target.src;
                e.target.style.opacity = opacity;
            });
        });
    </script>
</body>

</html>