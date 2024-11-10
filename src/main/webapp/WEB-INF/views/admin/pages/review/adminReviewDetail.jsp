<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<html lang="en" class="light-style layout-menu-fixed" dir="ltr" data-theme="theme-default" data-assets-path="/resources/assets/admin/" data-template="vertical-menu-template-free">
<head>

<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

<title>Dashboard - Analytics | Sneat - Bootstrap 5 HTML Admin Template - Pro</title>

<meta name="description" content="" />

<!-- Favicon -->
<link rel="icon" type="image/x-icon" href="/resources/assets/admin/img/favicon/favicon.ico" />

<!-- Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap" rel="stylesheet" />

<!-- Icons. Uncomment required icon fonts -->
<link rel="stylesheet" href="/resources/assets/admin/vendor/fonts/boxicons.css" />

<!-- Core CSS -->
<link rel="stylesheet" href="/resources/assets/admin/vendor/css/core.css" class="template-customizer-core-css" />
<link rel="stylesheet" href="/resources/assets/admin/vendor/css/theme-default.css" class="template-customizer-theme-css" />
<link rel="stylesheet" href="/resources/assets/admin/css/demo.css" />

<!-- Vendors CSS -->
<link rel="stylesheet" href="/resources/assets/admin/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

<link rel="stylesheet" href="/resources/assets/admin/vendor/libs/apex-charts/apex-charts.css" />

<!-- Page CSS -->

<!-- Helpers -->
<script src="/resources/assets/admin/vendor/js/helpers.js"></script>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
<!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
<script src="/resources/assets/admin/js/config.js"></script>
<script>
	// 리뷰 답글 저장
	function saveReviewReply(replyNo){
		let reviewReplyNo = 0;
		
		if((typeof replyNo) != 'undefined'){
			reviewReplyNo = replyNo;
		}
		
		$.ajax({
			url : '/admin/review/saveReviewReply',
			type : 'POST',
			dataType: 'text',
			data : {
				"reviewNo" : ${reviewDetail.review_no},
				"replyContent" : $("#replyContent").val(),
				"reviewTitle" : "${reviewDetail.review_title}",
				"reviewReplyNo" : reviewReplyNo,
				"productNo" : ${reviewDetail.product_no}
			},
			success : function(data) {
				console.log(data);
				location.href = "/admin/review/adminReviews";
			},
			error : function(error) {
				console.log(error);
			}
		});
	}
	
	// 리뷰 삭제
	function deleteReview(){
		
		$.ajax({
			url : '/admin/review/deleteReview',
			type : 'POST',
			dataType: 'text',
			data : {
				"reviewNo" : ${reviewDetail.review_no},
				"reason" : $("#reviewDeleteReason").val()
			},
			success : function(data) {
				console.log(data);
				location.href = "/admin/review/adminReviews";
			},
			error : function(error) {
				console.log(error);
			}
		});
	}
</script>
</head>

<style>
#saveInquiryReplyBtnArea {
	display: flex;
	flex-direction: row;
	justify-content: right;
}
</style>

<body>
	<!-- Layout wrapper -->
	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">
			<!-- Menu -->
			<jsp:include page="/WEB-INF/views/admin/components/sideBar.jsp">

				<jsp:param name="pageName" value="adminReviews" />

			</jsp:include>
			<!-- / Menu -->

			<!-- Layout container -->
			<div class="layout-page">
				<!-- Navbar -->
				<nav class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme" id="layout-navbar">
					<div class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none">
						<a class="nav-item nav-link px-0 me-xl-4" href="javascript:void(0)"> <i class="bx bx-menu bx-sm"></i>
						</a>
					</div>
				</nav>
				<!-- / Navbar -->

				<!-- Content wrapper -->
				<div class="content-wrapper">
					<!-- Content -->
					<div class="container-xxl flex-grow-1 container-p-y">
						<!-- body  -->
						<div class="card">
							<h5 class="card-header">리뷰</h5>
							<div class="card-body">
								<div class="mb-3 row">
									<label for="" class="col-md-2 col-form-label">리뷰 번호</label>
									<div class="col-md-10">
										<input class="form-control" type="text" value="${reviewDetail.review_no }" id="" readonly />
									</div>
								</div>
								<div class="mb-3 row">
									<label for="" class="col-md-2 col-form-label">리뷰 제목</label>
									<div class="col-md-10">
										<input class="form-control" type="text" value="${reviewDetail.review_title }" id="" readonly />
									</div>
								</div>
								<div class="mb-3 row">
									<label for="" class="col-md-2 col-form-label">리뷰 회원</label>
									<div class="col-md-10">
										<input class="form-control" type="text" value="${reviewDetail.member_id }" id="" readonly />
									</div>
								</div>
								<div class="mb-3 row">
									<label for="" class="col-md-2 col-form-label">리뷰 상품</label>
									<div class="col-md-10">
										<input class="form-control" type="text" value="${reviewDetail.product_name }" id="" readonly />
									</div>
								</div>
								<div class="mb-3 row">
									<label for="" class="col-md-2 col-form-label">작성 날짜</label>
									<div class="col-md-10">
										<input class="form-control" type="text" value="<fmt:formatDate value='${reviewDetail.register_date}' pattern='yyyy-MM-dd' />" id="" readonly />
									</div>
								</div>
								<div class="mb-3 row">
									<label for="" class="col-md-2 col-form-label">리뷰 내용</label>
									<div class="col-md-10">
										<textarea rows="15" class="form-control" id="" readonly>${reviewDetail.review_content }</textarea>
									</div>
								</div>
								<div class="mb-3 row">
									<label for="" class="col-md-2 col-form-label">리뷰 이미지</label>
									<div class="col-md-10">
										<div class="row">
											<c:forEach var="img" items="${reviewImages}">
												<div class="col-lg-6 col-md-6 col-sm-12 " style="padding: 5px;">
													<img src="${img.image_url}" class="img-fluid">
												</div>
											</c:forEach>
										</div>
									</div>
								</div>

								<hr class="mt-4">

								<div class="mb-3 row">
									<label for="" class="col-md-2 col-form-label">리뷰 답글</label>
									<div class="col-md-10">
										<c:choose>
											<c:when test="${reviewDetail.review_show == 'D'}">
												<textarea id="replyContent" rows="15" class="form-control" readonly>${reviewReply.review_content }</textarea>
											</c:when>
											<c:otherwise>
												<textarea id="replyContent" rows="15" class="form-control">${reviewReply.review_content }</textarea>
											</c:otherwise>
										</c:choose>

									</div>
								</div>

								<c:if test="${reviewDetail.review_show == 'D'}">
									<hr class="mt-4">

									<div class="mb-3 row">
										<label for="" class="col-md-2 col-form-label">삭제 사유</label>
										<div class="col-md-10">
											<textarea id="" rows="3" class="form-control" readonly>${reviewDetail.delete_reason }</textarea>
										</div>
									</div>
								</c:if>


							</div>

						</div>

						<div id="saveInquiryReplyBtnArea">
							<button id="" type="button" class="btn btn-outline-primary mt-4 me-1" onclick="location.href='/admin/review/adminReviews'">목록으로 돌아가기</button>
							<c:if test="${reviewDetail.review_show == 'S'}">
								<button id="" type="button" class="btn btn-outline-danger mt-4 me-1" data-bs-toggle="modal" data-bs-target="#deleteReviewModal" onclick="">리뷰 삭제</button>
								<button id="saveInquiryReplyBtn" type="button" class="btn btn-outline-primary mt-4" onclick="saveReviewReply(${reviewReply.review_no})">답글 저장</button>
							</c:if>


						</div>

						<!-- 리뷰 삭제 모달 -->
						<div id="deleteReviewModal" class="modal fade" tabindex="-1" aria-hidden="true">
							<div class="modal-dialog modal-sm" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="editModalTitle">쿠폰 삭제</h5>
										<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body">
										<div class="mb-3">
											<label class="form-label" for="basic-default-message">삭제 사유</label>
											<textarea id="reviewDeleteReason" class="form-control"></textarea>
										</div>
									</div>

									<div class="modal-footer">
										<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="">Close</button>
										<button type="button" class="btn btn-danger" onclick="deleteReview()">Delete</button>
									</div>
								</div>
							</div>
						</div>
						<!-- / 리뷰 삭제 모달 -->

					</div>
				</div>
				<!-- / Content -->

				<!-- Footer -->
				<footer class="content-footer footer bg-footer-theme">
					<div class="container-xxl d-flex flex-wrap justify-content-between py-2 flex-md-row flex-column">
						<div class="mb-2 mb-md-0">
							©
							<script>
								document.write(new Date().getFullYear());
							</script>
							, made with ❤️ by <a href="https://themeselection.com" target="_blank" class="footer-link fw-bolder">ThemeSelection</a>
						</div>
						<div>
							<a href="https://themeselection.com/license/" class="footer-link me-4" target="_blank">License</a> <a href="https://themeselection.com/" target="_blank" class="footer-link me-4">More Themes</a> <a href="https://themeselection.com/demo/sneat-bootstrap-html-admin-template/documentation/" target="_blank" class="footer-link me-4">Documentation</a> <a href="https://github.com/themeselection/sneat-html-admin-template-free/issues" target="_blank" class="footer-link me-4">Support</a>
						</div>
					</div>
				</footer>
				<!-- / Footer -->

				<div class="content-backdrop fade"></div>
			</div>
			<!-- Content wrapper -->

		</div>
		<!-- / Layout page -->
	</div>

	<!-- Overlay -->
	<div class="layout-overlay layout-menu-toggle"></div>

	<!-- / Layout wrapper -->



	<!-- Core JS -->
	<!-- build:js assets/vendor/js/core.js -->
	<script src="/resources/assets/admin/vendor/libs/jquery/jquery.js"></script>
	<script src="/resources/assets/admin/vendor/libs/popper/popper.js"></script>
	<script src="/resources/assets/admin/vendor/js/bootstrap.js"></script>
	<script src="/resources/assets/admin/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

	<script src="/resources/assets/admin/vendor/js/menu.js"></script>
	<!-- endbuild -->

	<!-- Vendors JS -->
	<script src="/resources/assets/admin/vendor/libs/apex-charts/apexcharts.js"></script>

	<!-- Main JS -->
	<script src="/resources/assets/admin/js/main.js"></script>

	<!-- Page JS -->
	<script src="/resources/assets/admin/js/dashboards-analytics.js"></script>

	<!-- Place this tag in your head or just before your close body tag. -->
	<script async defer src="https://buttons.github.io/buttons.js"></script>
</body>

</html>
