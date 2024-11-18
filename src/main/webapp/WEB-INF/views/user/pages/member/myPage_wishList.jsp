<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
.product-name {
	display: -webkit-box;
	-webkit-line-clamp: 2; /* 최대 줄 수를 2로 설정 */
	-webkit-box-orient: vertical;
	overflow: hidden;
	text-overflow: ellipsis; /* 글자가 넘치는 경우 ... 표시 */
	white-space: normal;
}
</style>
</head>

<body>
	<!-- header -->
	<jsp:include page="../header.jsp"></jsp:include>
	<!-- / header -->

	<!-- 찜목록 잘 받아오는지 확인 -->
	<%-- <c:forEach var="item" items="${wishList}">
		<div>${item}</div>
	</c:forEach> --%>
	<!-- Start Breadcrumbs -->
	<div class="breadcrumbs">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-lg-6 col-md-6 col-12">
					<div class="breadcrumbs-content">
						<h1 class="page-title">내 관심상품</h1>
					</div>
				</div>
				<div class="col-lg-6 col-md-6 col-12">
					<ul class="breadcrumb-nav">
						<li><a href="/"><i class="lni lni-home"></i> Home</a></li>
						<li><a href="/member/myPage/viewOrder">MyPage</a></li>
						<li>내 관심상품</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- End Breadcrumbs -->
	<section class="product-grids section">
		<div class="contentContainer container">
			<div class="row">
				<!-- sideBar -->
				<jsp:include page="../myPageSideBar.jsp">
					<jsp:param name="pageName" value="wishList" />
				</jsp:include>
				<!-- / sideBar -->
				<!-- contents -->
				<div class="col-lg-9 col-12" id="modiInfoView">
					<div class="tab-content" id="nav-tabContent">
						<div class="tab-pane fade active show" id="nav-grid"
							role="tabpanel" aria-labelledby="nav-grid-tab">
							<div class="row">
								<div class="col-12"></div>
								<c:forEach var="product" items="${products}">
									<c:set var="result" value="false" />
									<c:forEach var="wishItem" items="${wishList }">
										<c:if test="${wishItem == product.product_no}">
											<c:set var="result" value="true" />
										</c:if>
									</c:forEach>

									<c:if test="${wishList != null }">
										<c:if test="${result == 'true' }">
											<div class="col-lg-4 col-md-6 col-12">
												<div class="single-product">
													<div class="product-image" style="height: 300px;">

														<a
															href="/product/jewelry/detail?productNo=${product.product_no}">
															<img
															src="${empty product.image_url ? '/resources/images/noP_image.png' : product.image_url}"
															alt="${product.product_name}"
															style="height: 100%; object-fit: cover;">
														</a>

														<div class="button"
															style="position: absolute; bottom: 10px; left: 90px;">
															<!-- 찜목록에 있을 경우 하트 -->
															<a onclick="toggleHeart(this, ${product.product_no})"
																class="btn"
																style="display: inline-flex; align-items: center; justify-content: center; width: 100px; height: 40px; font-size: 14px;">
																<i class="lni lni-heart-filled"></i>
															</a>
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
																href="/product/jewelry/detail?productNo=${product.product_no}"
																class="product-name">${product.product_name }</a>
														</h4>
														<div class="price">
															<!--     dc 타입 확인하고 P이면 계산 전 가격 출력 (취소선 적용) -->
															<c:if
																test="${product.product_dc_type == 'P' && product.product_price != product.calculatedPrice}">
																<span
																	style="text-decoration: line-through; color: #999;">
																	<fmt:formatNumber value="${product.product_price}"
																		type="number" pattern="#,###" />원
																</span>
															</c:if>

															<!-- 할인율 (dc 타입이 P일 때만 표시) -->
															<c:if
																test="${product.product_dc_type == 'P' && product.dc_rate > 0}">
																<span class="sale-tag"
																	style="color: #FF4D4D; font-size: 1.2em; font-weight: bold; text-decoration: none;">
																	- <fmt:formatNumber value="${product.dc_rate * 100}"
																		type="number" maxFractionDigits="0" />%
																</span>
															</c:if>


															<!--     최종 계산된 가격 표시 -->
															<span> <fmt:formatNumber
																	value="${product.calculatedPrice}" type="number"
																	pattern="#,###" /> 원
															</span>
														</div>


													</div>
												</div>
											</div>
										</c:if>
									</c:if>
								</c:forEach>
							</div>
						</div>
					</div>
					<!-- 찜한 상품이 없다면 -->
					<c:if test="${fn:length(wishList) == 0}">
						<div
							style="display: flex; flex-direction: column; justify-content: center; align-items: center; height: 620px;">
							<div style="text-align: center;">
								<img alt=""
									src="/resources/assets/user/images/error/emptyCart.png"
									style="width: 100px;">
							</div>
							<div style="text-align: center; margin-top: 20px;">
								<b>관심상품이 없습니다</b>
							</div>
						</div>
					</c:if>
				</div>
				<!-- / contents -->

			</div>
		</div>
	</section>

	<jsp:include page="../footer.jsp"></jsp:include>

	<jsp:include page="../cart/cartAddModal.jsp"></jsp:include>


</body>
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
            console.log(data); // 서버 응답 확인
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
</html>