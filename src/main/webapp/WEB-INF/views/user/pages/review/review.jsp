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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<!-- ========================= CSS here ========================= -->
<link rel="stylesheet" href="/resources/assets/user/css/bootstrap.min.css" />
<link rel="stylesheet" href="/resources/assets/user/css/LineIcons.3.0.css" />
<link rel="stylesheet" href="/resources/assets/user/css/tiny-slider.css" />
<link rel="stylesheet" href="/resources/assets/user/css/glightbox.min.css" />
<link rel="stylesheet" href="/resources/assets/user/css/main.css" />

</head>
<style>
.review-content span {
	display: -webkit-box;
	-webkit-line-clamp: 2;
	/* 2줄로 제한 */
	-webkit-box-orient: vertical;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: normal;
	/* 말줄임표가 여러 줄에 적용되도록 설정 */
}

i.fas, i.far {
	color: #f5c518;
	/* 별 색상 (노란색) */
	font-size: 15px;
	/* 별 크기 */
	margin-right: 2px;
	/* 별 간격 */
}
</style>


<body>
	<!-- Preloader -->
	<div class="preloader">
		<div class="preloader-inner">
			<div class="preloader-icon">
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
						<h1 class="page-title">나의 리뷰</h1>
					</div>
				</div>
				<div class="col-lg-6 col-md-6 col-12">
					<ul class="breadcrumb-nav">
						<li><a href="index.html"><i class="lni lni-home"></i> Home</a></li>
						<li><a href="javascript:void(0)">Shop</a></li>
						<li>나의 리뷰</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- End Breadcrumbs -->

	<section class="product-grids section">
		<div class="container">
			<div class="row">

				<jsp:include page="/WEB-INF/views/user/pages/myPageSideBar.jsp">
					<jsp:param name="pageName" value="writableReview" />
				</jsp:include>

				<div class="col-lg-9 col-12">
					<!-- Shopping Cart -->
					<div class="cart-list-head" style="border: none">

						<div class="cart-list-title">
							<h5 style="text-align: center;">
								<a href="/review/writableReview" style="${currentPath == '/review/writableReview' ? 'color: gray;' : ''}"> 작성 가능 리뷰 </a> / <a href="/review/writtenByReview" style="${currentPath == '/review/writtenByReview' ? 'color: gray;' : ''}"> 작성 한 리뷰 </a>
							</h5>
						</div>
						<!-- Cart List Title -->
						<c:if test="${currentPath  == '/review/writableReview'}">
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
						</c:if>

						<c:if test="${currentPath  == '/review/writtenByReview'}">
							<div class="cart-list-title">
								<div class="row">
									<div class="col-lg-2 col-md-2 col-12">
										<p>상품 사진</p>
									</div>
									<div class="col-lg-4 col-md-4 col-12">
										<p>상품 이름</p>
									</div>
									<div class="col-lg-2 col-md-2 col-12">
										<p>리뷰 제목</p>
									</div>
									<div class="col-lg-2 col-md-2 col-12">
										<p>별점</p>
									</div>
									<div class="col-lg-2 col-md-2 col-12">
										<p>리뷰 작성일</p>
									</div>
								</div>
							</div>
						</c:if>
						<!-- End Cart List Title -->

						<c:if test="${currentPath == '/review/writableReview'}">
							<c:choose>
								<c:when test="${not empty writtenReviews}">
									<c:forEach var="review" items="${writtenReviews}">
										<div class="cart-single-list">
											<div class="row align-items-center">
												<div class="col-lg-2 col-md-2 col-12">
													<a href="/product/jewelry/detail?productNo=${review.product_no}" style="text-decoration: none; color: inherit;"> <img src="${review.image_url}" onerror="this.onerror=null; this.src='/resources/images/noP_image.png';" style="height: 90px; width: 90px; object-fit: cover;" />
													</a>
												</div>
												<div class="col-lg-6 col-md-6 col-12">
													<a href="/product/jewelry/detail?productNo=${review.product_no}" style="text-decoration: none; color: inherit;">${review.product_name}</a>
												</div>
												<div class="col-lg-2 col-md-2 col-12">
													<fmt:formatDate value="${review.delivered_date}" pattern="yyyy-MM-dd (EEE)" />
												</div>
												<div class="col-lg-2 col-md-2 col-12">
													<a href="/review/writeReview?product_no=${review.product_no}&product_name=${review.product_name}">리뷰작성</a>
												</div>
											</div>
										</div>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<p>작성 가능한 리뷰가 없습니다.</p>
								</c:otherwise>
							</c:choose>
						</c:if>

						<c:if test="${currentPath == '/review/writtenByReview'}">
							<c:choose>
								<c:when test="${not empty writableReviews}">
									<c:forEach var="review" items="${writableReviews}">
										<div class="cart-single-list">
											<div class="row align-items-center">
												<div class="col-lg-2 col-md-2 col-12">
													<a href="/product/jewelry/detail?productNo=${review.product_no}" style="text-decoration: none; color: inherit;"> <img src="${review.image_url}" onerror="this.onerror=null; this.src='/resources/images/noP_image.png';" style="height: 90px; width: 90px; object-fit: cover;" />
													</a>
												</div>
												<div class="col-lg-4 col-md-4 col-12">
													<a href="/product/jewelry/detail?productNo=${review.product_no}" style="text-decoration: none; color: inherit;">${review.product_name}</a>
												</div>
												<div class="col-lg-2 col-md-2 col-12 review-content">
													<a href="/review/reviewDetail?reviewNo=${review.review_no}"> <span>${review.review_title}</span>
													</a>
												</div>
												<div class="col-lg-2 col-md-2 col-12">
													<span> <c:forEach var="i" begin="1" end="5">
															<i class="${i <= review.review_score ? 'fas fa-star' : 'far fa-star'}"></i>
														</c:forEach>
													</span>
												</div>

												<div class="col-lg-2 col-md-2 col-12">
													<fmt:formatDate value="${review.register_date}" pattern="yyyy-MM-dd (EEE)" />
													<br>
												</div>
											</div>
										</div>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<p>작성한 리뷰가 없습니다.</p>
								</c:otherwise>
							</c:choose>
						</c:if>






						<div class="pagination center">
							<ul class="pagination-list">
								<c:choose>
									<c:when test="${pagingInfo.currentPage > pagingInfo.pageBlockSize}">
										<!-- 이전 페이지 블록 버튼 -->
										<li><a href="?page=${pagingInfo.startPage - pagingInfo.pageBlockSize}"><i class="lni lni-chevron-left"></i></a></li>
									</c:when>
								</c:choose>

								<c:forEach var="i" begin="${pagingInfo.startPage}" end="${pagingInfo.endPage}">
									<li class="${i == pagingInfo.currentPage ? 'active' : ''}"><a href="?page=${i}">${i}</a></li>
								</c:forEach>

								<c:choose>
									<c:when test="${pagingInfo.endPage < pagingInfo.totalPages}">
										<!-- 다음 페이지 블록 버튼 -->
										<li><a href="?page=${pagingInfo.startPage + pagingInfo.pageBlockSize}"><i class="lni lni-chevron-right"></i></a></li>
									</c:when>
								</c:choose>
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
	<a href="#" class="scroll-top"> <i class="lni lni-chevron-up"></i>
	</a>

	<!-- ========================= JS here ========================= -->
	<script src="/resources/assets/user/js/bootstrap.min.js"></script>
	<script src="/resources/assets/user/js/tiny-slider.js"></script>
	<script src="/resources/assets/user/js/glightbox.min.js"></script>
	<script src="/resources/assets/user/js/main.js"></script>
</body>

</html>