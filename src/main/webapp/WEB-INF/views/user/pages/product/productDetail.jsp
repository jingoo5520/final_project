<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html class="no-js" lang="zxx">

<head>
<meta charset="utf-8" />
<meta http-equiv="x-ua-compatible" content="ie=edge" />
<title>Single Product - ShopGrids Bootstrap 5 eCommerce HTML Template.</title>
<meta name="description" content="" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="shortcut icon" type="image/x-icon" href="/resources/assets/user/images/favicon.svg" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- ========================= CSS here ========================= -->
<link rel="stylesheet" href="/resources/assets/user/css/bootstrap.min.css" />
<link rel="stylesheet" href="/resources/assets/user/css/LineIcons.3.0.css" />
<link rel="stylesheet" href="/resources/assets/user/css/tiny-slider.css" />
<link rel="stylesheet" href="/resources/assets/user/css/glightbox.min.css" />
<link rel="stylesheet" href="/resources/assets/user/css/main.css" />

</head>

<script type="text/javascript">
    $(document).ready(function() {

        loadReviews(1); // 첫 페이지 로드


    });

    function loadReviews(page) {
        let productNo = $("#productNo").val(); // productNo 값을 가져옵니다

        $.ajax({
            url: '/product/review/load',
            type: 'GET',
            data: {
                productNo: productNo,
                page: page,
                size: 3 // 한 페이지에 보여줄 리뷰 수
            },
            dataType: "json",
            success: function(response) {
                const totalPages = response.pagingInfo.totalPages;

                // 리뷰 데이터를 화면에 출력
                showReview(response.seeReview);

//                 console.log(response.totalPostCnt);
                let reviewPage = response.pagingInfo;
                // 페이지네이션 업데이트
                showPaging(reviewPage);
            },
            error: function(xhr, status, error) {
                console.error('리뷰 로드 실패:', error);

            }
        });
    }

    function showReview(reviews) {
        let reviewHtml = "";

        console.log(reviews);
        reviewHtml = `<div id ="reviewInfo"> 리뷰 <div/>`;

        if (reviews.length === 0) {
            reviewHtml = `<p class="text-center">리뷰가 없습니다.</p>`;
        } else {
            // for 루프를 사용하여 리뷰 HTML 생성
            for (let i = 0; i < reviews.length; i++) {
                let review = reviews[i];
                let reviewDate = new Date(review.register_date);
                let formattedDate = `\${reviewDate.getFullYear()}-\${reviewDate.getMonth() + 1}-\${reviewDate.getDate()} \${reviewDate.getHours()}시 \${reviewDate.getMinutes()}분 \${reviewDate.getSeconds()}초`;

                if (review.review_ref == null) {
                	
                reviewHtml += `
                <div class="single-review row col-lg-12 col-12" style="padding: 20px !important">
                `
                } else {
                    reviewHtml += `
                 <div class="single-review row col-lg-12 col-12 reply">
                        `
                }
                
                reviewHtml += `
                    <div class="col-lg-1 col-12">
                        <img src="/resources/images/nobody.png">
                    </div>
                    <div class="review-info col-lg-11 col-12">
                        <div>`;

                // 리뷰 이미지가 있는 경우에만 추가
                const reviewImgs = review.reviewImgs 
                    ? review.reviewImgs.split(",")  // 문자열을 배열로 변환
                    : []; // null 또는 undefined인 경우 빈 배열 반환

                if (reviewImgs.length > 0) {
                    // 각 리뷰의 이미지를 순회하며 HTML 생성
                    reviewImgs.forEach((img) => {
                        reviewHtml += `
                            <img src="\${img}" alt="Review Image" onerror="this.onerror=null; this.src='/resources/images/noP_image.png';" style="padding: 5px; height: 150px; width: 150px !important;">
                        `;
                    });
                }

                reviewHtml += `
                        </div>
                        <h4 class="mt-4">\${review.review_title}
                            <span>\${review.nickname}</span>
                        </h4>
                        <div>작성일 : \${formattedDate}</div>
                        <ul class="stars">
            `;

				 console.log(review.review_ref);
 				if (review.review_ref == null) {
					// 별점 표시
	                for (let j = 1; j <= 5; j++) {
	                    if (j <= review.review_score) {
	                        reviewHtml += `<li><i class="lni lni-star-filled"></i></li>`;
	                    } else {
	                        reviewHtml += `<li><i class="lni lni-star"></i></li>`;
	                    }
	                }
				}    
            
            
                
                reviewHtml += `
                        </ul>
                        <p>\${review.review_content}</p>
                    </div>
                </div>
            `;
            }
        }

        // 리뷰 리스트를 HTML에 업데이트
        $(".reviews").html(reviewHtml);
    }





    function showPaging(reviewPage) {
        let $paging = $("#paging"); // 페이지네이션 리스트의 <ul> 요소를 가져옴
        $paging.empty(); // 기존의 페이지네이션 항목들을 모두 제거하여 초기화

        // 이전 페이지 버튼 추가
        if (reviewPage.currentPage > 1) {
            $paging.append(`<li><a href="javascript:void(0)" onclick="loadReviews(\${reviewPage.currentPage - 1})">< 이전</a></li>`);
        } else {
            $paging.append(`<li class="disabled">< 이전</li>`);
        }

        // 페이지 번호 버튼 추가
        for (let i = reviewPage.startPage; i <= reviewPage.endPage; i++) {
            if (i === reviewPage.currentPage) {
                $paging.append(`<li class="active"><a href="javascript:void(0)" onclick="loadReviews(\${i})">\${i}</a></li>`); // 현재 페이지 강조
            } else {
                $paging.append(`<li><a href="javascript:void(0)" onclick="loadReviews(\${i})">\${i}</a></li>`);
            }
        }

        // 다음 페이지 버튼 추가
        if (reviewPage.currentPage < reviewPage.totalPages) {
            $paging.append(`<li><a href="javascript:void(0)" onclick="loadReviews(\${reviewPage.currentPage + 1})">다음 ></a></li>`);
        } else {
            $paging.append(`<li class="disabled">다음 ></li>`);
        }
    }


    function countUp(productNo) {
        let quantity = parseInt($("#" + productNo + "_quantity").text());
        $("#" + productNo + "_quantity").text(quantity + 1);
    }

    function countDown(productNo) {
        let quantity = parseInt($("#" + productNo + "_quantity").text());

        if (quantity <= 1) {} else {
            $("#" + productNo + "_quantity").text(quantity - 1);
        }
    }

    function orderProduct(productNo) {
        let productsInfo = [];

        let quantity = parseInt($("#" + productNo + "_quantity").text());


        productsInfo.push({
            productNo: parseInt(productNo),
            quantity: quantity
        });

        $('.productInfos').val(JSON.stringify(productsInfo));

        $('.orderForm').submit();
    }

    function addCart(productNo) {
        let quantity = parseInt($("#" + productNo + "_quantity").text());

        $.ajax({
            url: '/addCartItem',
            type: 'POST',
            data: {
                productNo: productNo,
                quantity: quantity
            },
            dataType: 'json',
            success: function(data) {
//                 console.log(data);
            },
            error: function() {},
            complete: function(data) {
                if (data.status == 200) {
                    // 모달을 보여주기
                    $('#myModal').modal('show');

                    // 확인 버튼 클릭 시 장바구니 페이지로 이동
                    $('#goCart').off('click').on('click', function() {
                        location.href = "/cart";
                    });

                    $('#keepProduct').off('click').on('click', function() {
                        location.reload();
                    });
                } else if (data.responseText == 401) {
                    alert("잘못된 접근입니다.");
                }
            }
        });
    }

    function toggleHeart(element, product_no) {
        const icon = element.querySelector('i');
        icon.className = icon.className === 'lni lni-heart' ? 'lni lni-heart-filled' : 'lni lni-heart';

        // AJAX 요청
        $.ajax({
            url: "/member/saveWish",
            type: "GET",
            data: {
                product_no: product_no
            },
            dataType: "json",
            success: function(data) {
//                 console.log(data); // 서버 응답 확인
            },
            error: function() {
                console.error("AJAX 요청 실패");
            }
        });
    }
</script>
<style>
#gallery {
	display: flex;
	flex-direction: column;
	align-items: center;
}

.main-img img {
	width: 500px;
	/* 메인 이미지의 너비 */
	height: 500px;
	/* 비율을 유지하며 높이 자동 조정 */
	object-fit: cover;
	/* 이미지가 지정된 크기에 맞게 조정 */
}

.images {
	display: flex;
	justify-content: center;
	gap: 10px;
	/* 이미지 간의 간격 조절 */
	margin-top: 15px;
	/* 메인 이미지와 서브 이미지 사이의 간격 */
}

.images img {
	width: 100px;
	/* 서브 이미지의 너비 */
	height: 100px;
	/* 서브 이미지의 높이 */
	object-fit: cover;
	/* 이미지가 지정된 크기에 맞게 조정 */
	cursor: pointer;
	/* 이미지에 마우스를 올리면 포인터 커서로 변경 */
	transition: transform 0.3s;
	/* 서브 이미지에 호버 애니메이션 추가 */
}

.images img:hover {
	transform: scale(1.2);
	/* 서브 이미지에 호버 시 확대 효과 */
}

.count-input-div {
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 0;
	margin: 0;
}

.count-input-div .btn {
	background-color: #a8a691;
	color: white;
}

.count-input-div .btn:hover {
	background-color: #807e6f;
	color: white;
}

.count-input-div .countUp {
	border-radius: 0 4px 4px 0;
}

.count-input-div .countDown {
	border-radius: 4px 0 0 4px;
}

.count-input-div .count-div {
	text-align: center;
	border: 1px solid #efefef;
	height: 38px;
	line-height: 38px;
	width: 50px;
	padding: 0;
	margin: 0;
}

.full-width-image {
	width: 100%;
	height: auto;
	object-fit: cover;
	/* 이미지 비율을 유지하며 꽉 채움 */
	margin: 0;
	/* 이미지 여백 제거 */
	padding: 0;
	display: block;
	/* 기본 margin 간격 제거 */
}

.single-review img {
	position: inherit !important;
	border-radius: 25% !important;
}

.single-review {
    margin-bottom: 0px !important;
}

.reply {
	padding-top: 0px !important; 
	padding-bottom: 20px !important;
	padding-right: 20px !important;
}
</style>

<body>

	<jsp:include page="../header.jsp">
		<jsp:param name="categoryName" value="${products[0].category_name}" />
	</jsp:include>

	<!-- Preloader -->
	<div class="preloader">
		<div class="preloader-inner">
			<div class="preloader-icon">
				<span></span> <span></span>
			</div>
		</div>
	</div>
	<!-- /End Preloader -->

	<input type="hidden" id="productNo" value="${param.productNo }">

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
						<li><c:if test="${not empty products}">
                                ${products[0].category_name}
                            </c:if></li>
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


								<!-- 메인 이미지를 찾는 반복문 -->
								<div class="main-img">
									<c:forEach var="product" items="${products}">
										<!-- 이미지 타입이 'M'인 경우에만 처리 -->
										<c:if test="${product.image_type == 'M'}">
											<!-- HTTPS로 시작하는 경우 -->
											<c:if test="${fn:startsWith(product.image_url, 'https://')}">
												<img src="${product.image_url}" onerror="this.onerror=null; this.src='/resources/images/noP_image.png';" id="current" alt="${product.product_name}">
											</c:if>

											<!-- 파일 경로만 저장된 경우 -->
											<c:if test="${!fn:startsWith(product.image_url, 'https://')}">
												<img src="/resources/product/${product.image_url}" onerror="this.onerror=null; this.src='/resources/images/noP_image.png';" id="current" alt="${product.product_name}">
											</c:if>
										</c:if>
									</c:forEach>
								</div>

								<!-- 서브 이미지를 찾는 반복문 -->
								<div class="images">
									<c:forEach var="product" items="${products}">
										<!-- HTTPS로 시작하는 경우 -->
										<c:if test="${fn:startsWith(product.image_url, 'https://')}">
											<img src="${product.image_url}" onerror="this.onerror=null; this.src='/resources/images/noP_image.png';" class="img" alt="Sub Image">
										</c:if>

										<!-- 서버 경로를 사용하는 경우 -->
										<c:if test="${!fn:startsWith(product.image_url, 'https://')}">
											<img src="/resources/product/${product.image_url}" onerror="this.onerror=null; this.src='/resources/images/noP_image.png';" class="img" alt="Sub Image">
										</c:if>

										<c:set var="hasSubImage" value="true" />
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
								<a href="/product/jewelry?category=${products[0].product_category}"> <i class="lni lni-tag"></i> ${products[0].category_name}
								</a>
							</p>

							<!-- 가격 표시 -->
							<h3 class="price" style="display: flex; flex-direction: column; gap: 5px;">
								<!-- 원래 가격 표시 (할인이 있는 경우만 표시) -->
								<c:if test="${products[0].product_dc_type == 'P' && products[0].product_price != products[0].calculatedPrice}">
									<span style="text-decoration: line-through; font-size: 0.9em; color: #999;"> <fmt:formatNumber value="${products[0].product_price}" type="number" pattern="#,###" />원
									</span>
								</c:if>

								<!-- 할인율 및 할인 적용된 가격 표시 -->
								<div style="display: flex; align-items: baseline; gap: 10px;">
									<c:if test="${products[0].product_dc_type == 'P' && products[0].dc_rate > 0}">
										<span style="color: #FF4D4D; font-size: 1.2em; font-weight: bold; text-decoration: none;"> <fmt:formatNumber value="${products[0].dc_rate * 100}" type="number" maxFractionDigits="0" />%
										</span>
									</c:if>

									<span style="font-size: 1.4em; font-weight: bold; color: #000; text-decoration: none;"> <fmt:formatNumber value="${products[0].calculatedPrice}" type="number" pattern="#,###" />원
									</span>
								</div>
							</h3>


							<div class="row">
								<div class="col-lg-4 col-md-4 col-12"></div>
							</div>
							<div class="bottom-content">
								<div class="row align-items-center">
									<!-- 장바구니와 찜 버튼을 반반씩 배치 -->
									<div class="col-lg-6 col-md-6 col-6">
										<div class="button cart-button">
											<button onclick="addCart(${products[0].product_no})" class="btn" style="width: 100%;">장바구니</button>
										</div>
									</div>
									<c:set var="result" value="false" />
									<c:forEach var="wishItem" items="${wishList }">
										<c:if test="${wishItem == products[0].product_no}">
											<c:set var="result" value="true" />
										</c:if>
									</c:forEach>
									<c:if test="${wishList != null }">
										<c:if test="${result == 'true' }">
											<!-- 찜목록에 있을 경우 하트 -->
											<div class="col-lg-6 col-md-6 col-6">
												<div class="wish-button">
													<button onclick="toggleHeart(this, ${products[0].product_no});" class="btn" style="width: 100%;">
														<i class="lni lni-heart-filled"></i> 찜
													</button>
												</div>
											</div>
										</c:if>
										<c:if test="${result == 'false' }">
											<!-- 찜목록에 없을 경우 빈하트 -->
											<div class="col-lg-6 col-md-6 col-6">
												<div class="wish-button">
													<button onclick="toggleHeart(this, ${products[0].product_no});" class="btn" style="width: 100%;">
														<i class="lni lni-heart"></i> 찜
													</button>
												</div>
											</div>
										</c:if>
									</c:if>
									<c:if test="${wishList == null }">
										<div class="col-lg-6 col-md-6 col-6">
											<div class="wish-button">
												<button onclick="location.href='${pageContext.request.contextPath}/member/viewLogin'" class="btn" style="width: 100%;">
													<i class="lni lni-heart"></i> 찜
												</button>
											</div>
										</div>
									</c:if>
								</div>
								<div class="row align-items-center mt-3">
									<!-- 주문 개수 선택 드롭다운 -->
									<div class="col-lg-12 col-md-12 col-12">
										<div class="count-input-div col-lg-2 col-md-1 col-12">
											<button class="btn countDown" onclick="countDown(${products[0].product_no})">-</button>
											<div class="count-div" id="${products[0].product_no}_quantity">1</div>
											<button class="btn countUp" onclick="countUp(${products[0].product_no})">+</button>
										</div>
									</div>
								</div>
								<div class="row align-items-center mt-3">
									<!-- 결제 버튼을 전체 너비로 배치 -->
									<div class="col-lg-12 col-md-12 col-12">
										<form action="/order" method="post" class="orderForm">
											<div class="wish-button">
												<input type="hidden" class="productInfos" name="productInfos">
												<button class="btn" style="width: 100%;" onclick="orderProduct(${products[0].product_no});">
													<i class="lni lni-credit-cards"></i> 결제
												</button>
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="container product-details-info">
			<!-- Bootstrap의 container 클래스를 사용하여 중앙 정렬 -->
			<div class="single-block">
				<div class="row justify-content-center">
					<!-- justify-content-center로 중앙 정렬 -->
					<div class="col-lg-8 col-12">
						<!-- col-lg-8로 넓이를 제한 -->
						<div class="info-body custom-responsive-margin">
							<p class="text-center">
								<c:if test="${fn:startsWith(product_content, 'https://')}">
									<img alt="${product_name} 설명 이미지" src="${product_content}" onerror="this.onerror=null; this.src='/resources/images/noP_image.png';" />
								</c:if>

								<c:if test="${!fn:startsWith(product_content, 'https://')}">
									<img alt="${product_name} 설명 이미지" src="/resources/product/${product_content}" onerror="this.onerror=null; this.src='/resources/images/noP_image.png';" />
								</c:if>
							</p>

						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-12 col-12">
				<div class="single-block">
					<div class="reviews"></div>

					<!-- 					페이지 네이션 -->
					<div class="pagination center">
						<ul class="pagination-list" id="paging">

						</ul>
					</div>

				</div>
			</div>
		</div>
	</section>
	<!-- End Item Details -->

	<jsp:include page="../cart/cartAddModal.jsp"></jsp:include>

	<jsp:include page="../cart/cartModal.jsp"></jsp:include>

	<jsp:include page="../footer.jsp"></jsp:include>

	<!-- ========================= scroll-top ========================= -->
	<a href="#" class="scroll-top"> <i class="lni lni-chevron-up"></i>
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