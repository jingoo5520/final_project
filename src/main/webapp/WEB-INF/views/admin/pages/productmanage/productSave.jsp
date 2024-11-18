<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
	function selectCategory(name, no) {
		no = parseInt(no);
		$('#selectCategory').val(no);

		// 버튼의 텍스트를 선택된 카테고리 이름으로 설정
		document.querySelector('.btn-group > button').innerText = name;

	}
	function selectOption(value, text) {

		document.getElementById('dropdownValue').value = value;

		$("#productShow").text(text);
	}
	function toggleDiscountInput() {
		let discountType = $("input[name='product_dc_type']:checked").val();
		console.log(discountType);

		if (discountType === 'P') {
			$("#discountAmountContainer").css('display', 'block');
			$("#discountAmountContainer").prop('readonly', false);
		} else {
			$("#discountAmountContainer").val(0);
			$("#discountAmountContainer").prop('readonly', true);
		}
	}
	$(
			function() {

				$('form')
						.on(
								'submit',
								function(e) {
									let isValid = true;

									// 모든 경고 메시지 제거
									$('.error-message').remove();

									// 상품명 검사
									if ($('#productName').val().trim() === '') {
										$('#productName')
												.after(
														'<span class="error-message" style="color: red;">상품명을 입력해 주세요.</span>');
										isValid = false;
									}

									if ($('#productCount').val().trim() === '') {
										$('#productCount').val(0); // 판매수량이 비어있으면 0으로 설정
									}

									// 가격 검사
									if ($('#productPrice').val().trim() === '') {
										$('#productPrice')
												.after(
														'<span class="error-message" style="color: red;">상품 가격을 입력해 주세요.</span>');
										isValid = false;
									}

									// 카테고리 검사
									if ($('#selectCategory').val().trim() === '') {
										$('#selectCategory')
												.parent()
												.parent()
												.append(
														'<div><span class="error-message" style="color: red;">카테고리를 선택해 주세요.</span></div>');
										isValid = false;
									}

									// 판매수량 검사
									if ($('#productCount').val().trim() === '') {
										$('#productCount')
												.after(
														'<span class="error-message" style="color: red;">판매 가능한 수량을 입력해 주세요.</span>');
										isValid = false;
									}	
									if ($('#productStockCount').val().trim() === '') {
										$('#productStockCount')
												.after(
														'<span class="error-message" style="color: red;">재고 수량을 입력해 주세요.</span>');
										isValid = false;
									}
									let discountType = $(
											"input[name='product_dc_type']:checked")
											.val();
									let discountAmount = document
											.getElementById('discountAmountContainer').value
											.trim();
									console.log(discountType);
									if (discountType === 'P') {
										if (discountAmount === ''
												|| isNaN(discountAmount)
												|| parseInt(discountAmount) < 0
												|| parseInt(discountAmount) > 100) {
											$('#discountAmountContainer')
													.parent()
													.parent()
													.append(
															'<span class="error-message" style="color: red;">입력 가능한 할인율(0-100%)을 입력해 주세요.</span>');
											isValid = false;
										}
									}
									if(discountType === 'N') {
										$(discountAmount).val(0);
									}
									if ($('#dropdownValue').val().trim() === '') {
										$('#productShow')
												.after(
														'<div>&nbsp;&nbsp;&nbsp;<span class="error-message" style="color: red;">공개여부를 선택해 주세요.</span></div>');
										isValid = false;
									}
									// 유효하지 않으면 폼 제출 방지
									if (!isValid) {
										e.preventDefault();
									}
								});
			})
</script>
</head>

<body>
	<!-- Layout wrapper -->
	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">
			<!-- Menu -->

			<!-- Menu -->

			<jsp:include page="/WEB-INF/views/admin/components/sideBar.jsp">

				<jsp:param name="pageName" value="productSave" />

			</jsp:include>

			<!-- / Menu -->

			<!-- Layout container -->

			<div class="layout-page">
				<!-- Navbar -->
				<nav class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme" id="layout-navbar">
					<div class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none">
						<a class="nav-item nav-link px-0 me-xl-4" href="javascript:void(0)">
							<i class="bx bx-menu bx-sm"></i>
						</a>
					</div>


				</nav>

				<!-- / Navbar -->

				<!-- Content wrapper -->
				<div class="container-xxl flex-grow-1 container-p-y">
					<h4 class="fw-bold py-3 mb-4">
						<span class="text-muted fw-light">Forms/</span> 상품 정보 입력
					</h4>

					<!-- Basic Layout & Basic with Icons -->
					<div class="row">
						<!-- Basic Layout -->
						<div class="col-xxl">
							<div class="card mb-4">
								<div class="card-header d-flex align-items-center justify-content-between">
									<h5 class="mb-0">상품 정보 입력</h5>
									<small class="text-muted float-end"></small>
								</div>
								<div class="card-body">
									<form action="/admin/productmanage/uploadProduct" enctype="multipart/form-data" method="post">
										<div class="row mb-3">
											<label class="col-sm-2 col-form-label" for="basic-default-name">상품명</label>
											<div class="col-sm-10">
												<input type="text" class="form-control" id="productName" placeholder="상품명" name="product_name">
											</div>
										</div>
										<div class="row mb-3">
											<label class="col-sm-2 col-form-label" for="basic-default-company"> 가격</label>
											<div class="col-sm-10">
												<input type="number" class="form-control" id="productPrice" placeholder="상품 가격" name="product_price">
											</div>
										</div>
										<div class="row mb-3">

											<table class="table table-striped table-borderless border-bottom mb-3">
												<thead>
													<tr>
														<th class="text-nowrap">할인 종류</th>
														<th class="text-nowrap text-center"><span>&#x0025;</span> 비율 할인</th>

														<th class="text-nowrap text-center"><span>&#x274C;</span>없음</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td class="text-nowrap mb-3">할인 타입</td>
														<td>
															<div class="form-check d-flex justify-content-center">
																<input class="form-check-input dc_type" type="radio" id="defaultCheck1" name="product_dc_type" value="P" onclick="toggleDiscountInput()">
															</div>
														</td>
														<td>
															<div class="form-check d-flex justify-content-center">
																<input class="form-check-input dc_type" type="radio" id="defaultCheck3" name="product_dc_type" value="N" onclick="toggleDiscountInput()">
															</div>
														</td>
													</tr>
												</tbody>
											</table>
											<div class="row mb-3 mt-3">
												<label class="col-sm-2 col-form-label" for="basic-default-company"> 카테고리</label>
												<div class="col-sm-10">
													<div class="btn-group">
														<button type="button" class="btn btn-outline-secondary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">카테고리 번호</button>
														<input type="number" class="form-control" id="selectCategory" placeholder="카테고리" name="category_no" readonly="readonly" value="">
														<ul class="dropdown-menu" style="">
															<c:forEach var="category" items="${categories}">
																<li>
																	<label>${category.category_no }</label>
																	<a href="javascript:void(0);" class="list-group-item list-group-item-action" onclick="selectCategory('${category.category_name}',' ${category.category_no}')"> ${category.category_name} </a>
																</li>
															</c:forEach>
														</ul>
													</div>
												</div>
											</div>
										</div>
										<div class="row mb-3">
											<label class="col-sm-2 col-form-label" for="basic-default-email">할인 퍼센트</label>
											<div class="col-sm-10">
												<div class="input-group input-group-merge">
													<input type="number" id="discountAmountContainer" class="form-control" placeholder="" name="dc_rate" value="" readonly>
												</div>

											</div>
										</div>
										<div class="row mb-3">
											<label class="col-sm-2 col-form-label" for="basic-default-phone">재고수량</label>
											<div class="col-sm-10">
												<input type="number" id="productStockCount" class="form-control phone-mask" placeholder="재고 수량을 입력" aria-label="재고 수량을 입력" name="product_stock_count">
											</div>
										</div>
										<div class="row mb-3">
											<label class="col-sm-2 col-form-label" for="basic-default-phone">판매수량</label>
											<div class="col-sm-10">
												<input type="number" id="productCount" class="form-control phone-mask" placeholder="판매가능한 수량을 입력" aria-label="판매 가능한 수량을 입력" name="product_sell_count">
											</div>
										</div>
										<div class="row mb-3">
											<label class="col-sm-2 col-form-label" for="basic-default-message">상품 설명</label>
											<div class="col-sm-10">
												<input type="file" class="form-control" id="basic-default-company" placeholder="게시할 상품 설명" name="product_content_file">
											</div>
										</div>
										<div class="row mb-3">
											<label class="col-sm-2 col-form-label" for="basic-default-message">상품 메인 이미지</label>
											<div class="col-sm-10">
												<input type="file" class="form-control" id="basic-default-company" placeholder="게시할 상품 메인 이미지" name="image_main_url">
											</div>
										</div>
										<div class="row mb-3">
											<label class="col-sm-2 col-form-label" for="basic-default-message">상품 서브 이미지 </label>
											<div class="col-sm-10">

												<input type="file" class="form-control" id="basic-default-company" placeholder="게시할 상품 서브 이미지" name="image_sub_url" multiple>
											</div>
										</div>
									
											<label class="col-sm-2 col-form-label" for="basic-default-name">공개여부</label>
											<div class="btn-group mb-3">
												<button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false" id="productShow">공개 상태 여부</button>
												<ul class="dropdown-menu">
													<li>
														<button class="dropdown-item" type="button" value="yes" onclick="selectOption('N', 'Yes')">Yes</button>
													</li>
													<li>
														<button class="dropdown-item" type="button" value="no" onclick="selectOption('Y', 'no')">no</button>
													</li>
												</ul>
							
										</div>
										<input type="hidden" name="product_show" id="dropdownValue">
										<div class="row justify-content-end">
											<div class="col-sm-10 mt-3">
												<button type="submit" class="btn btn-primary">저장</button>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
					<div class="layout-overlay layout-menu-toggle"></div>
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
							, made with ❤️ by
							<a href="https://themeselection.com" target="_blank" class="footer-link fw-bolder">ThemeSelection</a>
						</div>
						<div>
							<a href="https://themeselection.com/license/" class="footer-link me-4" target="_blank">License</a>
							<a href="https://themeselection.com/" target="_blank" class="footer-link me-4">More Themes</a>
							<a href="https://themeselection.com/demo/sneat-bootstrap-html-admin-template/documentation/" target="_blank" class="footer-link me-4">Documentation</a>
							<a href="https://github.com/themeselection/sneat-html-admin-template-free/issues" target="_blank" class="footer-link me-4">Support</a>
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

	<div class="bs-toast toast toast-placement-ex m-2 fade bg-secondary top-0 end-0 hide" role="alert" aria-live="assertive" aria-atomic="true" data-delay="2000">
		<div class="toast-header">
			<i class="bx bx-bell me-2"></i>
			<div class="me-auto fw-semibold">Bootstrap</div>
			<small>11 mins ago</small>
			<button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
		</div>
		<div class="toast-body">Fruitcake chocolate bar tootsie roll gummies gummies jelly beans cake.</div>
	</div>

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
