<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html lang="en" class="light-style layout-menu-fixed" dir="ltr"
	data-theme="theme-default" data-assets-path="/resources/assets/admin/"
	data-template="vertical-menu-template-free">
<head>

<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

<title>Dashboard - Analytics | Sneat - Bootstrap 5 HTML Admin
	Template - Pro</title>

<meta name="description" content="" />

<!-- Favicon -->
<link rel="icon" type="image/x-icon"
	href="/resources/assets/admin/img/favicon/favicon.ico" />

<!-- Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
	rel="stylesheet" />

<!-- Icons. Uncomment required icon fonts -->
<link rel="stylesheet"
	href="/resources/assets/admin/vendor/fonts/boxicons.css" />

<!-- Core CSS -->
<link rel="stylesheet"
	href="/resources/assets/admin/vendor/css/core.css"
	class="template-customizer-core-css" />
<link rel="stylesheet"
	href="/resources/assets/admin/vendor/css/theme-default.css"
	class="template-customizer-theme-css" />
<link rel="stylesheet" href="/resources/assets/admin/css/demo.css" />

<!-- Vendors CSS -->
<link rel="stylesheet"
	href="/resources/assets/admin/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

<link rel="stylesheet"
	href="/resources/assets/admin/vendor/libs/apex-charts/apex-charts.css" />

<!-- Page CSS -->

<!-- Helpers -->
<script src="/resources/assets/admin/vendor/js/helpers.js"></script>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
<!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
<script src="/resources/assets/admin/js/config.js"></script>
<script>
$(function(){
	   $("#update").click(function() {

		   $("#modalToggle").show();
	   })
$('#modalToggle2').on('show.bs.modal', function(event) {
            var button = $(event.relatedTarget); // 클릭한 버튼
            var productId = button.val(); // 버튼의 value 속성 값
            var modalTitle = '상품 ID: ' + productId; // 제목 설정

            var modal = $(this);
            modal.find('.modal-title').text(modalTitle); // 모달 제목 업데이트
        });

        // 삭제 확인 버튼 클릭 시 처리
        $('#confirmDeleteBtn').click(function() {
            var productId = $('#modalToggle2 .modal-title').text().split(': ')[1]; // 제목에서 상품 ID 추출
            console.log('삭제할 상품 ID:', productId);
            // 추가적인 삭제 로직을 여기에 추가
        });
	   function deleteBtn() {
	    	
           // Ajax 요청으로 삭제
           $.ajax({
               url: '/productDelete', // 삭제 요청을 보낼 URL
               type: 'DELETE', // HTTP 메소드
               data: { productId: productId }, // 제품 ID 데이터 전송
               success: function(response) {
                   alert('상품이 삭제되었습니다.');
                   // 페이지를 새로고침하여 삭제된 제품 목록을 업데이트
                   window.location.reload();
               },
               error: function(xhr, status, error) {
                   console.error('Error:', error);
                   alert('삭제 중 오류가 발생했습니다.');
               }
           });
       
   }
});
function toggleSelectAll(source) {
    const checkboxes = document.getElementsByName('productCheckbox');
    checkboxes.forEach(checkbox => {
        checkbox.checked = source.checked;
    });
    
 
}

</script>
</head>

<body>
	<!-- Layout wrapper -->
	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">
			<!-- Menu -->

			<!-- Menu -->

			<jsp:include page="/WEB-INF/views/admin/components/sideBar.jsp">

				<jsp:param name="pageName" value="productView" />

			</jsp:include>

			<!-- / Menu -->

			<!-- Layout container -->

			<div class="layout-page">
				<!-- Navbar -->
				<nav
					class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme"
					id="layout-navbar">
					<div
						class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none">
						<a class="nav-item nav-link px-0 me-xl-4"
							href="javascript:void(0)">
							<i class="bx bx-menu bx-sm"></i>
						</a>
					</div>


				</nav>

				<!-- / Navbar -->

				<!-- Content wrapper -->
				<div class="content-wrapper">
					<!-- Content -->

					<div class="container-xxl flex-grow-1 container-p-y">


						<div class="card">
							<h5 class="card-header">
								상품 목록
								<div class="btn-group" style="float: right;">
									<button type="button"
										class="btn btn-outline-primary dropdown-toggle"
										data-bs-toggle="dropdown" aria-expanded="false">정렬</button>
									<ul class="dropdown-menu" style="">
										<li><a class="dropdown-item" href="javascript:void(0);">가격
												높은 순으로 정렬</a></li>
										<li><a class="dropdown-item" href="javascript:void(0);">가격
												낮은 순으로 정렬</a></li>
										<li><a class="dropdown-item" href="javascript:void(0);">번호순으로
												정렬 </a></li>
										<li><a class="dropdown-item" href="javascript:void(0);">할인
												금액 순</a></li>
										<li><a class="dropdown-item" href="javascript:void(0);">할인
												퍼센트 순 </a></li>
									</ul>
								</div>
							</h5>
							<div
								class="d-flex justify-content-between align-items-center mb-3">




							</div>
							<div class="table-responsive text-nowrap">
								<table class="table">
									<thead class="table-light">
										<tr>
											<th><input type="checkbox" id="selectAll"
												onclick="toggleSelectAll(this)"> 전체 선택</th>
											<th>상품 번호</th>
											<th>상품 이름</th>
											<th>상품 가격</th>
											<th>상품 설명</th>
											<th>상품 할인 타입</th>
											<th>상품 할인 금액</th>
											<th>상품 메인 이미지</th>
											<th>상품 서브 이미지</th>

										</tr>
									</thead>
									<tbody id="productTableBody" class="table-border-bottom-0">
										<c:forEach var="product" items="${productList}">
											<tr>
												<td><input type="checkbox" name="productCheckbox"
													value="${product.product_id}"></td>
												<!-- 체크박스 추가 -->
												<td>${product.product_id}</td>
												<td>${product.product_name}</td>
												<td>${product.product_price}</td>
												<td>${product.product_content}</td>
												<td>${product.product_dc_type}</td>
												<td>${product.product_dc_amount}</td>

												<td><c:forEach var="img" items="${product.list}">
														<c:if test="${img.image_type == 'M'}">
															<img src='/resources/product/${img.image_url}'
																alt="Main Image">
															<!-- 메인 이미지 URL 출력 -->
														</c:if>
													</c:forEach></td>
												<td><c:forEach var="img" items="${product.list}">
														<c:if test="${img.image_type == 'S'}">
															<img src='/resources/product/${img.image_url}'
																alt="Sub Image">
															<!-- 서브 이미지 URL 출력 -->
														</c:if>
													</c:forEach></td>
												<td><div class="mt-3">
														<button type="button"
															class="btn rounded-pill btn-outline-primary"
															value="${product.product_id}" data-bs-toggle="modal"
															data-bs-target="#modalToggle">수정</button>
													</div></td>
												<td><div class="mt-3">
														<button type="button"
															class="btn rounded-pill btn-outline-danger"
															data-bs-toggle="modal" data-bs-target="#modalToggle2"
															value="${product.product_id}">삭제</button>
													</div></td>

											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
						<!-- body  -->


					</div>
				</div>
				<!-- / Content -->

				<!-- Footer -->
				<footer class="content-footer footer bg-footer-theme">
					<div
						class="container-xxl d-flex flex-wrap justify-content-between py-2 flex-md-row flex-column">
						<div class="mb-2 mb-md-0">
							©
							<script>
								document.write(new Date().getFullYear());
							</script>
							, made with ❤️ by
							<a href="https://themeselection.com" target="_blank"
								class="footer-link fw-bolder">ThemeSelection</a>
						</div>
						<div>
							<a href="https://themeselection.com/license/"
								class="footer-link me-4" target="_blank">License</a>
							<a href="https://themeselection.com/" target="_blank"
								class="footer-link me-4">More Themes</a>
							<a
								href="https://themeselection.com/demo/sneat-bootstrap-html-admin-template/documentation/"
								target="_blank" class="footer-link me-4">Documentation</a>
							<a
								href="https://github.com/themeselection/sneat-html-admin-template-free/issues"
								target="_blank" class="footer-link me-4">Support</a>
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
	<script
		src="/resources/assets/admin/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

	<script src="/resources/assets/admin/vendor/js/menu.js"></script>
	<!-- endbuild -->

	<!-- Vendors JS -->
	<script
		src="/resources/assets/admin/vendor/libs/apex-charts/apexcharts.js"></script>

	<!-- Main JS -->
	<script src="/resources/assets/admin/js/main.js"></script>

	<!-- Page JS -->
	<script src="/resources/assets/admin/js/dashboards-analytics.js"></script>

	<!-- Place this tag in your head or just before your close body tag. -->
	<script async defer src="https://buttons.github.io/buttons.js"></script>

	<!-- Modal 1-->
	<div class="modal fade" id="modalToggle"
		aria-labelledby="modalToggleLabel" tabindex="-1"
		style="display: none;" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modalToggleLabel">Modal 1</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">Show a second modal and hide this one
					with the button below.</div>
				<div class="modal-footer">
					<button class="btn btn-primary">확인</button>
					<button class="btn btn-danger">취소</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="modalToggle2"
		aria-labelledby="modalToggleLabel" tabindex="-1"
		style="display: none;" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modalToggleLabel"></h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">정말로 삭제하시겠습니까</div>
				<div class="modal-footer">
					<button class="btn btn-primary" id="confirmDeleteBtn">확인</button>
					<button class="btn btn-danger" data-bs-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
</body>

</html>
