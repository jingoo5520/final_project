<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html class="no-js" lang="zxx">

<head>
<meta charset="utf-8" />
<meta http-equiv="x-ua-compatible" content="ie=edge" />
<title>ELOLIA</title>
<meta name="description" content="" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="shortcut icon" type="image/x-icon" href="/resources/assets/user/images/logo/favicon.png" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- ========================= CSS here ========================= -->
<link rel="stylesheet" href="/resources/assets/user/css/bootstrap.min.css" />
<link rel="stylesheet" href="/resources/assets/user/css/LineIcons.3.0.css" />
<link rel="stylesheet" href="/resources/assets/user/css/tiny-slider.css" />
<link rel="stylesheet" href="/resources/assets/user/css/glightbox.min.css" />
<link rel="stylesheet" href="/resources/assets/user/css/main.css" />

</head>
<script type="text/javascript">
    function submitSortingForm() {
        var sortingSelect = document.getElementById('sorting');
        sortingSelect.value = sortingSelect.value.trim(); // 선택된 값에서 공백 제거
        document.getElementById('sortingForm').submit();
    }

    // 현재 URL에 따라 action 동적 변경 및 폼 제출
    function submitSortingForm() {
        const form = document.getElementById("sortingForm");
        const currentUrl = window.location.href;

        // 현재 URL에 'result'가 포함되어 있는지 확인
        if (currentUrl.includes("result")) {
            form.action = "/product/jewelry/result";
        } else {
            form.action = "/product/jewelry";
        }

        // 폼 제출
        form.submit();
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
            success: function (data) {
//                 console.log(data); // 서버 응답 확인
            },
            error: function () {
                console.error("AJAX 요청 실패");
            }
        });
    }
    
	function addCart(productNo) {
		$.ajax({
			url: '/addCartItem',
			type: 'POST',
			data: {
				productNo : productNo
			},
			dataType: 'json',
			success: function(data) {
			},
			error: function() {
			},
			complete: function(data) {
				if (data.status == 200) {
					$('#myModal').modal('show');
					
					// 헤더의 장바구니 수량 최신화
					cartCountUpdate();
					
					// 확인 버튼 클릭 시 장바구니 페이지로 이동
					$('#goCart').off('click').on('click', function() {
						location.href = "/cart";
					});
					
					$('#keepProduct').off('click').on('click', function() {
						$('#myModal').modal('hide');
					});
				}
			}
		});
	}
	
	function cartCountUpdate() {
		$.ajax({
			url: '/cartCountUpdate',
			type: 'POST',
			dataType: 'json',
			success: function(data) {
				if (data !== undefined) {
					$('.cart-items .total-items').text(data);
				}
			},
			error: function(data) {
			},
			complete: function(data) {
			}
		});
	}
</script>
<style>
.active {
	font-weight: bold;
	color: #9D968F !important; /* 강조 색상 */
	text-decoration: underline;
}

.product-name {
	display: -webkit-box;
	-webkit-line-clamp: 2; /* 최대 줄 수를 2로 설정 */
	-webkit-box-orient: vertical;
	overflow: hidden;
	text-overflow: ellipsis; /* 글자가 넘치는 경우 ... 표시 */
	white-space: normal;
}

.stars {
	display: flex;
	justify-content: right;
	align-items: center;
}

.stars i {
	color: #ffa000;
}

.product-image {
	position: relative;
	padding-top: 100%; /* 정사각형 비율 (원하는 비율로 조정 가능) */
	overflow: hidden;
}

.product-image img {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	object-fit: cover;
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



	<!-- Start Breadcrumbs -->
	<div class="breadcrumbs">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-lg-6 col-md-6 col-12">
					<div class="breadcrumbs-content">
						<h1 class="page-title">
							<a href="/product/jewelry/all">JEWELRY</a>
						</h1>
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

	<!-- Start Product Grids -->
	<section class="product-grids section">
		<div class="container">
			<div class="row">
				<div class="col-lg-3 col-12">
					<!-- Start Product Sidebar -->
					<div class="product-sidebar">
						<!-- Start Single Widget -->
						<div class="single-widget search">
							<h3>찾으실 상품을 검색해주세요.</h3>
							<form action="/product/jewelry/result" method="get">
								<input type="hidden" name="category" value="${category}"> <input type="text" name="search" placeholder="Search Here..." value="${search != null ? search : ''}"> <input type="hidden" name="sortOrder" value="${sortOrder}">
								<button type="submit">
									<i class="lni lni-search-alt"></i>
								</button>
							</form>
						</div>
						<!-- End Single Widget -->
						<!-- Start Single Widget -->
						<div class="single-widget">
							<ul class="list">
								<li><a href="/product/jewelry?category=196" class="category-link ${param.category == '196' ? 'active' : ''}">NACKLACE <span>(${necklaceCount})</span></a></li>
								<li><a href="/product/jewelry?category=195" class="category-link ${param.category == '195' ? 'active' : ''}">EARRING <span>(${earringCount})</span></a></li>
								<li><a href="/product/jewelry?category=203" class="category-link ${param.category == '203' ? 'active' : ''}">PIERCING <span>(${piercingCount})</span></a></li>
								<li><a href="/product/jewelry?category=197" class="category-link ${param.category == '197' ? 'active' : ''}">BANGLE <span>(${bangleCount})</span></a></li>
								<li><a href="/product/jewelry?category=201" class="category-link ${param.category == '201' ? 'active' : ''}">ANKLET <span>(${ankletCount})</span></a></li>
								<li><a href="/product/jewelry?category=198" class="category-link ${param.category == '198' ? 'active' : ''}">RING <span>(${ringCount})</span></a></li>
								<li><a href="/product/jewelry?category=200" class="category-link ${param.category == '200' ? 'active' : ''}">COUPLING <span>(${couplingCount})</span></a></li>
								<li><a href="/product/jewelry?category=202" class="category-link ${param.category == '202' ? 'active' : ''}">PENDANT <span>(${pendantCount})</span></a></li>
								<li><a href="/product/jewelry?category=204" class="category-link ${param.category == '204' ? 'active' : ''}">기타 <span>(${otherCount})</span></a></li>
							</ul>
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
										<!-- 정렬 기준 유지 -->
										<form id="sortingForm" action="" method="get">
											<label for="sorting">Sort by:</label> <select class="form-control" id="sorting" name="sortOrder" onchange="submitSortingForm()">
												<option value="new" ${sortOrder=='new' ? 'selected' : '' }>신상품순</option>
												<option value="popular" ${sortOrder=='popular' ? 'selected' : '' }>인기상품순</option>
												<option value="lowPrice" ${sortOrder=='lowPrice' ? 'selected' : '' }>낮은가격순</option>
												<option value="highPrice" ${sortOrder=='highPrice' ? 'selected' : '' }>높은가격순</option>
												<option value="manyReview" ${sortOrder=='manyReview' ? 'selected' : '' }>리뷰많은순</option>
											</select> <input type="hidden" name="category" value="${category}" /> <input type="hidden" name="search" value="${search}" /> <input type="hidden" name="page" value="${currentPage}" /> <input type="hidden" name="pageSize" value="${pageSize}" />
										</form>
									</div>
								</div>
							</div>
						</div>
						<br>
						<div>
							총 개수:
							<c:choose>
								<c:when test="${not empty search}">
                                    ${searchProductCount}
                                </c:when>
								<c:when test="${not empty category}">
                                    ${totalProducts}
                                </c:when>
								<c:otherwise>
                                    ${totalProductCount}
                                </c:otherwise>
							</c:choose>
						</div>
						<div class="tab-content" id="nav-tabContent">
							<div class="tab-pane fade active show" id="nav-grid" role="tabpanel" aria-labelledby="nav-grid-tab">
								<div class="row">
									<div class="col-12">
										<c:if test="${noResult}">
											<div style="background-color: #f0f0f0; text-align: center; color: #333; padding: 15px; border-radius: 5px;">
												<span>검색 결과가 없습니다. 다시 검색해주세요.</span><br /> <img src="/resources/images/noResult.jpg" alt="No Results" style="margin-top: 15px; width: auto; height: auto; max-width: 100%;" />
											</div>
										</c:if>
									</div>
									<c:forEach var="product" items="${products}">
										<div class="col-lg-4 col-md-6 col-12">
											<div class="single-product">
												<div class="product-image">
													<a href="/product/jewelry/detail?productNo=${product.product_no}"> 
														<c:if test="${fn:startsWith(product.image_url, 'https://')}">
															<img src="${product.image_url}" onerror="this.onerror=null; this.src='/resources/images/noP_image.png';" alt="${product.product_name}" style="height: 100%; object-fit: cover;">
														</c:if> 
														<c:if test="${!fn:startsWith(product.image_url, 'https://')}">
															<img src="/resources/product/${product.image_url}" onerror="this.onerror=null; this.src='/resources/images/noP_image.png';" alt="${product.product_name}" style="height: 100%; object-fit: cover;">
														</c:if>
													</a>
													
													
													
													

													<div class="button buttonArea">
														<c:set var="result" value="false" />
														<c:forEach var="wishItem" items="${wishList }">
															<c:if test="${wishItem == product.product_no}">
																<c:set var="result" value="true" />
															</c:if>
														</c:forEach>
														<c:if test="${wishList != null }">
															<c:if test="${result == 'true' }">
																<!-- 찜목록에 있을 경우 하트 -->
																<a onclick="toggleHeart(this, ${product.product_no})" class="btn" style="display: inline-flex; align-items: center; justify-content: center; width: 100px; height: 40px; font-size: 14px;"> <i class="lni lni-heart-filled"></i>
																</a>
															</c:if>
															<c:if test="${result == 'false' }">
																<!-- 찜목록에 없을 경우 빈하트 -->
																<a onclick="toggleHeart(this, ${product.product_no})" class="btn" style="display: inline-flex; align-items: center; justify-content: center; width: 100px; height: 40px; font-size: 14px;"> <i class="lni lni-heart"></i>
																</a>
															</c:if>
														</c:if>
														<c:if test="${wishList == null }">
															<a href="${pageContext.request.contextPath}/member/viewLogin" class="btn" style="display: inline-flex; align-items: center; justify-content: center; width: 100px; height: 40px; font-size: 14px;"> <i class="lni lni-heart"></i>
															</a>
														</c:if>
														<a onclick="addCart(${product.product_no})" class="btn" style="display: inline-flex; align-items: center; justify-content: center; width: 100px; height: 40px; font-size: 14px;"> <i class="lni lni-cart"></i>
														</a>
													</div>
												</div>

												<div class="product-info">
													<div class="row scoreDiv">
														<span class="category col-md-6 col-lg-6 col-12">${product.category_name}</span>
														<c:if test="${product.review_count > 0}">
															<div class="starScore col-md-6 col-lg-6 col-12">
																<ul class="stars">
																	<c:forEach var="index" begin="1" end="5">
																		<c:if test="${index <= product.average_score}">
																			<li><i class="lni lni-star-filled"></i></li>
																		</c:if>
																		<c:if test="${index > product.average_score}">
																			<li><i class="lni lni-star"></i></li>
																		</c:if>
																	</c:forEach>
																	<li><i><fmt:formatNumber value="${product.average_score}" type="number" maxFractionDigits="2" /></i></li>
																</ul>
															</div>
														</c:if>
													</div>


													<h4 class="title">
														<a href="/product/jewelry/detail?productNo=${product.product_no}" class="product-name">${product.product_name }</a>
													</h4>
													<div class="price">
														<!--     dc 타입 확인하고 P이면 계산 전 가격 출력 (취소선 적용) -->
														<c:if test="${product.product_dc_type == 'P' && product.product_price != product.calculatedPrice}">
															<span style="text-decoration: line-through; color: #999;"> <fmt:formatNumber value="${product.product_price}" type="number" pattern="#,###" />원
															</span>
														</c:if>

														<!-- 할인율 (dc 타입이 P일 때만 표시) -->
														<c:if test="${product.product_dc_type == 'P' && product.dc_rate > 0}">
															<span class="sale-tag" style="color: #FF4D4D; font-size: 1.2em; font-weight: bold; text-decoration: none;"> - <fmt:formatNumber value="${product.dc_rate * 100}" type="number" maxFractionDigits="0" />%
															</span>
														</c:if>


														<!--     최종 계산된 가격 표시 -->
														<span> <fmt:formatNumber value="${product.calculatedPrice}" type="number" pattern="#,###" /> 원
														</span>
													</div>

												</div>
											</div>
											<!-- End Single Product -->
										</div>
									</c:forEach>
								</div>

								<!-- 페이지네이션 -->
								<div class="row">
									<div class="col-12">
										<div class="pagination left">
											<ul class="pagination-list">
												<c:if test="${hasPrevBlock}">
													<li><a href="<c:choose>
						                                    <c:when test='${not empty search}'>
						                                        /product/jewelry/result?search=${search}&page=${startPage - 1}&pageSize=${pageSize}&sortOrder=${sortOrder}
						                                        <c:if test='${category != null}'> &category=${category}</c:if>
						                                    </c:when>
						                                    <c:otherwise>
						                                        /product/jewelry?page=${startPage - 1}&pageSize=${pageSize}&sortOrder=${sortOrder}
						                                        <c:if test='${category != null}'> &category=${category}</c:if>
						                                    </c:otherwise>
						                                </c:choose>"> <i class="lni lni-chevron-left"></i> 이전
													</a></li>
												</c:if>

												<c:forEach var="i" begin="${startPage}" end="${endPage}">
													<c:choose>
														<c:when test="${i == currentPage}">
															<li class="active"><a href="">${i}</a></li>
														</c:when>
														<c:otherwise>
															<li><a href="<c:choose>
                                            <c:when test='${not empty search}'>
                                                /product/jewelry/result?search=${search}&page=${i}&pageSize=${pageSize}&sortOrder=${sortOrder}
                                                <c:if test='${category != null}'> &category=${category}</c:if>
                                            </c:when>
                                            <c:otherwise>
                                                /product/jewelry?page=${i}&pageSize=${pageSize}&sortOrder=${sortOrder}
                                                <c:if test='${category != null}'> &category=${category}</c:if>
                                            </c:otherwise>
                                         </c:choose>">${i}</a></li>
														</c:otherwise>
													</c:choose>
												</c:forEach>

												<c:if test="${hasNextBlock}">
													<li><a href="<c:choose>
						                                    <c:when test='${not empty search}'>
						                                        /product/jewelry/result?search=${search}&page=${endPage + 1}&pageSize=${pageSize}&sortOrder=${sortOrder}
						                                        <c:if test='${category != null}'> &category=${category}</c:if>
						                                    </c:when>
						                                    <c:otherwise>
						                                        /product/jewelry?page=${endPage + 1}&pageSize=${pageSize}&sortOrder=${sortOrder}
						                                        <c:if test='${category != null}'> &category=${category}</c:if>
						                                    </c:otherwise>
						                                 </c:choose>"> 다음 <i class="lni lni-chevron-right"></i>
													</a></li>
												</c:if>
											</ul>
										</div>
									</div>
								</div>

							</div>
						</div>
					</div>
					<div class="tab-pane show active fade" id="nav-list" role="tabpanel" aria-labelledby="nav-list-tab">
						<div class="row"></div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- End Product Grids -->

	<jsp:include page="../footer.jsp"></jsp:include>

	<jsp:include page="../cart/cartAddModal.jsp"></jsp:include>

	<!-- ========================= scroll-top ========================= -->
	<a href="#" class="scroll-top"> <i class="lni lni-chevron-up"></i>
	</a>

	<!-- ========================= JS here ========================= -->
	<script src="/resources/assets/user/js/bootstrap.min.js"></script>
	<script src="/resources/assets/user/js/tiny-slider.js"></script>
	<script src="/resources/assets/user/js/glightbox.min.js"></script>
	<script src="/resources/assets/user/js/main.js"></script>
</body>

</html>