<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html class="no-js" lang="zxx">

<head>
<meta charset="utf-8" />
<meta http-equiv="x-ua-compatible" content="ie=edge" />
<title>카테고리</title>
<meta name="description" content="" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="shortcut icon" type="image/x-icon"
	href="/resources/assets/user/images/logo/white-logo.svg" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<!-- ========================= CSS here ========================= -->
<link rel="stylesheet"
	href="/resources/assets/user/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="/resources/assets/user/css/LineIcons.3.0.css" />
<link rel="stylesheet" href="/resources/assets/user/css/tiny-slider.css" />
<link rel="stylesheet"
	href="/resources/assets/user/css/glightbox.min.css" />
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
        // 찜 정보 DB 변경
        $.ajax({
        	url: "/member/saveWish",
        	type: "GET",
        	dataType: "json",
        	data: {product_no : product_no},
        	success: function (data) {
			},
			error: function () {
			},
			complete: function () {
			},
        });
    }
    
</script>

<body>
	<jsp:include page="../header.jsp"></jsp:include>

	<!-- Preloader -->
	<div class="preloader">
		<div class="preloader-inner">
			<div class="preloader-icon">
				<span></span> <span></span>
			</div>
		</div>
	</div>
	<!-- /End Preloader -->

	<%-- <div>찜 리스트가 모델에서 잘 불러와지나요?</div>
	<c:forEach var="wish" items="${wishList}">
		<div>${wish }</div>
	</c:forEach> --%>

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
								<input type="hidden" name="category" value="${category}">
								<input type="text" name="search" placeholder="Search Here..."
									value="${search != null ? search : ''}"> <input
									type="hidden" name="sortOrder" value="${sortOrder}">
								<button type="submit">
									<i class="lni lni-search-alt"></i>
								</button>
							</form>
						</div>
						<!-- End Single Widget -->
						<!-- Start Single Widget -->
						<div class="single-widget">
							<ul class="list">
								<li><a href="/product/jewelry?category=196">NACKLACE <span>(${necklaceCount})</span></a></li>
								<li><a href="/product/jewelry?category=195">EARRING <span>(${earringCount})</span></a></li>
								<li><a href="/product/jewelry?category=203">PIERCING <span>(${piercingCount})</span></a></li>
								<li><a href="/product/jewelry?category=197">BANGLE <span>(${bangleCount})</span></a></li>
								<li><a href="/product/jewelry?category=201">ANKLET <span>(${ankletCount})</span></a></li>
								<li><a href="/product/jewelry?category=198">RING <span>(${ringCount})</span></a></li>
								<li><a href="/product/jewelry?category=200">COUPLING <span>(${couplingCount})</span></a></li>
								<li><a href="/product/jewelry?category=202">PENDANT <span>(${pendantCount})</span></a></li>
								<li><a href="/product/jewelry?category=204">기타 <span>(${otherCount})</span></a></li>
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
											<label for="sorting">Sort by:</label> <select
												class="form-control" id="sorting" name="sortOrder"
												onchange="submitSortingForm()">
												<option value="new" ${sortOrder=='new' ? 'selected' : '' }>신상품순</option>
												<option value="popular"
													${sortOrder=='popular' ? 'selected' : '' }>인기상품순</option>
												<option value="lowPrice"
													${sortOrder=='lowPrice' ? 'selected' : '' }>낮은가격순</option>
												<option value="highPrice"
													${sortOrder=='highPrice' ? 'selected' : '' }>높은가격순</option>
											</select> <input type="hidden" name="category" value="${category}" />
											<input type="hidden" name="search" value="${search}" /> <input
												type="hidden" name="page" value="${currentPage}" /> <input
												type="hidden" name="pageSize" value="${pageSize}" />
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
							<div class="tab-pane fade active show" id="nav-grid"
								role="tabpanel" aria-labelledby="nav-grid-tab">
								<div class="row">
									<div class="col-12">
										<c:if test="${noResult}">
											<div
												style="background-color: #f0f0f0; text-align: center; color: #333; padding: 15px; border-radius: 5px;">
												<span>검색 결과가... 앙 없어띠 다시 한 번 검색해봐 ~ </span><br /> <img
													src="/resources/images/noResult.jpeg" alt="No Results"
													style="margin-top: 15px; width: auto; height: auto; max-width: 100%;" />
											</div>
										</c:if>
									</div>
									<c:forEach var="product" items="${products}">
										<div class="col-lg-4 col-md-6 col-12">
											<!-- Start Single Product -->
											<!--                                         개수 -->
											<div class="single-product">


												<div class="product-image" style="position: relative;">
													<a
														href="/product/jewelry/detail?productNo=${product.product_no}">
														<img
														src="${empty product.image_main_url ? '/resources/images/noP_image.png' : product.image_main_url}"
														alt="${product.product_name}" width="300px" height="300px">
													</a>
													<div class="button"
														style="position: absolute; bottom: 10px; left: 90px;">
														<!-- 로그인 되어있을 떄 -->
														<c:if test="${not empty sessionScope.loginMember }">
															<c:set var="wishStatus" value="false" />
															<c:forEach var="wish" items="${wishList}">
																<c:if test="${wish == product.product_no}">
																	<c:set var="wishStatus" value="true" />
																</c:if>
															</c:forEach>
															<c:if test="${wishStatus == true }">
																<a onclick="toggleHeart(this, ${product.product_no})"
																	class="btn"
																	style="display: inline-flex; align-items: center; justify-content: center; width: 100px; height: 40px; font-size: 14px;">
																	<i class="lni lni-heart-filled"></i>
																</a>
															</c:if>
															<c:if test="${wishStatus == false }">
																<a onclick="toggleHeart(this, ${product.product_no})"
																	class="btn"
																	style="display: inline-flex; align-items: center; justify-content: center; width: 100px; height: 40px; font-size: 14px;">
																	<i class="lni lni-heart"></i>
																</a>
															</c:if>
														</c:if>
														<c:if test="${empty sessionScope.loginMember }">
															<a
																href="${pageContext.request.contextPath}/member/viewLogin"
																class="btn"
																style="display: inline-flex; align-items: center; justify-content: center; width: 100px; height: 40px; font-size: 14px;">
																<i class="lni lni-heart"></i>
															</a>
														</c:if>

													</div>

													<div class="button"
														style="position: absolute; bottom: 10px; right: 140px;">
														<a onclick="addCart(${product.product_no})" class="btn"
															style="display: inline-flex; align-items: center; justify-content: center; width: 100px; height: 40px; font-size: 14px;">
															<i class="lni lni-cart"></i>
														</a>
													</div>
												</div>





												<div class="product-info">
													<!-- Category 출력 부분 -->

													<span class="category"> ${product.category_name } </span>

													<h4 class="title">
														<a
															href="/product/jewelry/detail?productNo=${product.product_no}">${product.product_name }</a>
													</h4>
													<div class="price">
														<!--     dc 타입 확인하고 P이면 계산 전 가격 출력 (취소선 적용) -->
														<c:if
															test="${product.product_dc_type == 'P' && product.product_price != product.calculatedPrice}">
															<span style="text-decoration: line-through; color: #999;">
																<fmt:formatNumber value="${product.product_price}"
																	type="number" pattern="#,###" />원
															</span>
														</c:if>

														<!--     할인율 (dc 타입이 P일 때만 표시) -->
														<c:if
															test="${product.product_dc_type == 'P' && product.dc_rate > 0}">
															<span class="sale-tag"
																style="color: #FF4D4D; font-size: 1.2em; font-weight: bold; text-decoration: none;">
																-${product.dc_rate}% </span>
														</c:if>

														<!--     최종 계산된 가격 표시 -->
														<span> <fmt:formatNumber
																value="${product.calculatedPrice}" type="number"
																pattern="#,###" /> 원
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
													<li><a
														href="<c:choose>
                                    <c:when test='${not empty search}'>
                                        /product/jewelry/result?search=${search}&page=${startPage - 1}&pageSize=${pageSize}&sortOrder=${sortOrder}
                                        <c:if test='${category != null}'> &category=${category}</c:if>
                                    </c:when>
                                    <c:otherwise>
                                        /product/jewelry?page=${startPage - 1}&pageSize=${pageSize}&sortOrder=${sortOrder}
                                        <c:if test='${category != null}'> &category=${category}</c:if>
                                    </c:otherwise>
                                </c:choose>">
															<i class="lni lni-chevron-left"></i> 이전
													</a></li>
												</c:if>

												<c:forEach var="i" begin="${startPage}" end="${endPage}">
													<c:choose>
														<c:when test="${i == currentPage}">
															<li class="active"><a href="">${i}</a></li>
														</c:when>
														<c:otherwise>
															<li><a
																href="<c:choose>
                                            <c:when test='${not empty search}'>
                                                /product/jewelry/result?search=${search}&page=${i}&pageSize=${pageSize}&sortOrder=${sortOrder}
                                                <c:if test='${category != null}'> &category=${category}</c:if>
                                            </c:when>
                                            <c:otherwise>
                                                /product/jewelry?page=${i}&pageSize=${pageSize}&sortOrder=${sortOrder}
                                                <c:if test='${category != null}'> &category=${category}</c:if>
                                            </c:otherwise>
                                         </c:choose>">${i}</a>
															</li>
														</c:otherwise>
													</c:choose>
												</c:forEach>

												<c:if test="${hasNextBlock}">
													<li><a
														href="<c:choose>
                                    <c:when test='${not empty search}'>
                                        /product/jewelry/result?search=${search}&page=${endPage + 1}&pageSize=${pageSize}&sortOrder=${sortOrder}
                                        <c:if test='${category != null}'> &category=${category}</c:if>
                                    </c:when>
                                    <c:otherwise>
                                        /product/jewelry?page=${endPage + 1}&pageSize=${pageSize}&sortOrder=${sortOrder}
                                        <c:if test='${category != null}'> &category=${category}</c:if>
                                    </c:otherwise>
                                 </c:choose>">
															다음 <i class="lni lni-chevron-right"></i>
													</a></li>
												</c:if>
											</ul>
										</div>
									</div>
								</div>

							</div>
						</div>
					</div>
					<div class="tab-pane show active fade" id="nav-list"
						role="tabpanel" aria-labelledby="nav-list-tab">
						<div class="row"></div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- End Product Grids -->

	<jsp:include page="../footer.jsp"></jsp:include>

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