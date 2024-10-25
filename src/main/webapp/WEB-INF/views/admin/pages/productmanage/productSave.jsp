<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
				<nav
					class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme"
					id="layout-navbar">
					<div
						class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none">
						<a class="nav-item nav-link px-0 me-xl-4"
							href="javascript:void(0)"> <i class="bx bx-menu bx-sm"></i>
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
								<div
									class="card-header d-flex align-items-center justify-content-between">
									<h5 class="mb-0">상품 정보 입력</h5>
									<small class="text-muted float-end"></small>
								</div>
								<div class="card-body">
									<form action="/admin/productmanage/uploadProduct" enctype="multipart/form-data"
										method="post">
										<div class="row mb-3">
											<label class="col-sm-2 col-form-label"
												for="basic-default-name">상품명</label>
											<div class="col-sm-10">
												<input type="text" class="form-control"
													id="basic-default-name" placeholder="상품명"
													name="product_name">
											</div>
										</div>
										<div class="row mb-3">
											<label class="col-sm-2 col-form-label"
												for="basic-default-company"> 가격</label>
											<div class="col-sm-10">
												<input type="number" class="form-control"
													id="basic-default-company" placeholder="상품 가격"
													name="product_price">
											</div>
										</div>
										<div class="row mb-3">

											<table
												class="table table-striped table-borderless border-bottom">
												<thead>
													<tr>
														<th class="text-nowrap">할인 종류</th>
														<th class="text-nowrap text-center">✉️ 비율 할인</th>
														<th class="text-nowrap text-center">🖥 고정 금액 할인</th>
														<th class="text-nowrap text-center">👩🏻‍💻 없음</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td class="text-nowrap">할인 타입</td>
														<td>
															<div class="form-check d-flex justify-content-center">
																<input class="form-check-input" type="radio"
																	id="defaultCheck1" name="product_dc_type" value="P">
															</div>
														</td>
														<td>
															<div class="form-check d-flex justify-content-center">
																<input class="form-check-input" type="radio"
																	id="defaultCheck2" name="product_dc_type" value="M">
															</div>
														</td>
														<td>
															<div class="form-check d-flex justify-content-center">
																<input class="form-check-input" type="radio"
																	id="defaultCheck3" checked="checked"
																	name="product_dc_type" value="N">
															</div>
														</td>
													</tr>
												</tbody>
											</table>
										</div>
										<div class="row mb-3">
											<label class="col-sm-2 col-form-label"
												for="basic-default-email">할인타입이 선택된 값에 따라 보여지는html이
												다르게 동적으로 설정</label>
											<div class="col-sm-10">
												<div class="input-group input-group-merge">
													<input type="number" id="basic-default-email"
														class="form-control" placeholder=""
														name="product_dc_amount">
												</div>

											</div>
										</div>
										<div class="row mb-3">
											<label class="col-sm-2 col-form-label"
												for="basic-default-phone">판매수량</label>
											<div class="col-sm-10">
												<input type="number" id="basic-default-phone"
													class="form-control phone-mask" placeholder="판매가능한 수량을 입력"
													aria-label="판매 가능한 수량을 입력" name="product_sell_count">
											</div>
										</div>
										<div class="row mb-3">
											<label class="col-sm-2 col-form-label"
												for="basic-default-message">상품 설명</label>
											<div class="col-sm-10">
												<textarea id="basic-default-message" class="form-control"
													placeholder="상품 설명" aria-label="상품 설명을 입력하세요..."
													name="product_content"></textarea>
											</div>
										</div>
										<div class="row mb-3">
											<label class="col-sm-2 col-form-label"
												for="basic-default-message">상품 메인 이미지</label>
											<div class="col-sm-10">
												<input type="file" class="form-control"
													id="basic-default-company" placeholder="게시할 상품 메인 이미지"
													name="image_main_url">
											</div>
										</div>
										<div class="row mb-3">
											<label class="col-sm-2 col-form-label"
												for="basic-default-message">상품 서브 이미지 + 버튼 추가 해서 더
												추가 할 수 있게 처리 </label>
											<div class="col-sm-10">

												<input type="file" class="form-control"
													id="basic-default-company" placeholder="게시할 상품 서브 이미지"
													name="image_sub_url" multiple>
											</div>
										</div>
										<div class="row justify-content-end">
											<div class="col-sm-10">
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
					<div
						class="container-xxl d-flex flex-wrap justify-content-between py-2 flex-md-row flex-column">
						<div class="mb-2 mb-md-0">
							©
							<script>
								document.write(new Date().getFullYear());
							</script>
							, made with ❤️ by <a href="https://themeselection.com"
								target="_blank" class="footer-link fw-bolder">ThemeSelection</a>
						</div>
						<div>
							<a href="https://themeselection.com/license/"
								class="footer-link me-4" target="_blank">License</a> <a
								href="https://themeselection.com/" target="_blank"
								class="footer-link me-4">More Themes</a> <a
								href="https://themeselection.com/demo/sneat-bootstrap-html-admin-template/documentation/"
								target="_blank" class="footer-link me-4">Documentation</a> <a
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
</body>

</html>
