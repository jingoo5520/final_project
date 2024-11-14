<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
	let selectedEventNo;
	let selectedBannerNo;
	
	$(function() {

		// 모달이 닫힐 때 이벤트를 처리
		$('#addBannerModal').on('hidden.bs.modal', function() {
			resetAddBannerModal();
			console.log("모달 닫힘");
		});

		getEventList();
	});

	// 배너 목록 가져오기
	function getBannerList() {
		$.ajax({
			url : '/admin/homepage/getBannerList',
			type : 'GET',
			dataType : 'json',
			success : function(data) {
				console.log(data);

				let mainBannerOutput = '';
				let subBannerOutput = '';
				
				data.forEach(function(banner) {
					
					if(banner.banner_type == 'M'){
						mainBannerOutput += `<tr>`;
						mainBannerOutput += `<td>\${banner.banner_no}</td>`;
						mainBannerOutput += `<td>\${banner.notice_title}</td>`;
						mainBannerOutput += `<td>\${banner.banner_image}</td>`;
						mainBannerOutput += `<td>\${banner.url}</td>`;
						mainBannerOutput += `<td><button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteBannerModal" onclick="openDeleteBannerModal(\${banner.banner_no})">삭제</button></td>`;
						mainBannerOutput += `</tr>`;
					} else {
						subBannerOutput += `<tr>`;
						subBannerOutput += `<td>\${banner.banner_no}</td>`;
						subBannerOutput += `<td>\${banner.notice_title}</td>`;
						subBannerOutput += `<td>\${banner.thumbnail_image}</td>`;
						subBannerOutput += `<td>\${banner.url}</td>`;
						subBannerOutput += `<td><button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteBannerModal" onclick="openDeleteBannerModal(\${banner.banner_no})">삭제</button></td>`;
						subBannerOutput += `</tr>`;
					}
				});
				
				
				$("#mainBannerListTableBody").html(mainBannerOutput);
				$("#subBannerListTableBody").html(subBannerOutput);
			},
			error : function(error) {
				console.log(error);
			}
		});
	}

	// 이벤트 리스트 가져오기
	function getEventList() {
		$.ajax({
			url : '/admin/homepage/getEventList',
			type : 'GET',
			dataType : 'json',
			success : function(data) {
				console.log(data);
	
				let output = '';
				
				data.forEach(function(event) {
					let json = JSON.stringify(event);
					output += `<li><a class="dropdown-item" href="javascript:void(0);" onclick='setEvent(\${json})'>\${event.notice_title}</a></li>`
				});
				$("#eventList").html(output);
			},
			error : function(error) {
				console.log(error);
			}
		});
	}

	//배너 타입 설정
	function setBannerType(type) {
		document.getElementById('bannerTypeBtn').textContent = type.textContent;
		checkFormCompletion();
	}

	// 이벤트 선택 
	function setEvent(event) {
		document.getElementById('selectEventBtn').textContent = event.notice_title;
		selectedEventNo = event.notice_no;
		checkFormCompletion();
	}

	// 모든 폼에 입력값이 있는지 체크
	function checkFormCompletion() {
		let bannerTypeCheck = bannerTypeVaild();
		let eventCheck = eventVaild();

		if (bannerTypeCheck && eventCheck) {
			$("#bannerAddBtn").prop('disabled', false);
		} else {
			$("#bannerAddBtn").prop('disabled', true);
		}
	}

	function bannerTypeVaild() {
		let valid = false;

		if ($('#bannerTypeBtn').text() != "배너 타입") {
			valid = true;
		}
		return valid;
	}

	function eventVaild() {
		let valid = false;

		if ($('#selectEventBtn').text() != "이벤트 선택") {
			valid = true;
		}
		return valid;
	}

	// 모달 초기화
	function resetAddBannerModal() {
		$('#bannerTypeBtn').text('배너 타입');
		$('#selectEventBtn').text('이벤트 선택');
		$("#bannerAddBtn").prop('disabled', true);
	}

	// 배너 추가(Add 버튼 클릭)
	function addBanner() {
		let bannerType = $('#bannerTypeBtn').text() == "메인 배너" ? 'M' : 'S';

		$.ajax({
			url : '/admin/homepage/addBanner',
			type : 'POST',
			data : {
				"eventNo" : selectedEventNo,
				"bannerType" : bannerType
			},
			dataType : 'text',
			success : function(data) {
				console.log(data);
				$('#addBannerModal').modal('hide');
				getBannerList();
			},
			error : function(error) {
				console.log(error);
			}
		});
	}
	
	// 배너 삭제 모달 열기(삭제 버튼 클릭)
	function openDeleteBannerModal(bannerNo){
		selectedBannerNo = bannerNo;
	}
	
	// 배너 삭제
	function deleteBanner(){
		$.ajax({
			url : '/admin/homepage/deleteBanner',
			type : 'POST',
			data : {
				"bannerNo" : selectedBannerNo
			},
			dataType : 'text',
			success : function(data) {
				console.log(data);
				$('#deleteBannerModal').modal('hide');
				getBannerList();
			},
			error : function(error) {
				console.log(error);
			}
		});
	}
</script>
</head>

<style>
#addBannerBtnArea {
	display: flex;
	flex-direction: row;
	justify-content: right;
}

.table>thead {
	vertical-align: middle;
}
</style>

<body>
	<!-- Layout wrapper -->
	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">
			<!-- Menu -->
			<jsp:include page="/WEB-INF/views/admin/components/sideBar.jsp">

				<jsp:param name="pageName" value="banners" />

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
							<h5 class="card-header">메인 배너 목록</h5>
							<div class="table-responsive text-nowrap">
								<table class="table">
									<thead class="table-light">
										<tr>
											<th class="col-2">배너 번호</th>
											<th class="col-2">이벤트</th>
											<th class="col-5">이미지 경로</th>
											<th class="col-2">이동 경로</th>
											<th class="col-1">삭제</th>
										</tr>
									</thead>
									<tbody id="mainBannerListTableBody" class="table-border-bottom-0">

										<c:forEach var="banner" items="${mainBannerList}">
											<tr>
												<td>${banner.banner_no}</td>
												<td>${banner.notice_title}</td>
												<td>${banner.banner_image}</td>
												<td>${banner.url}</td>
												<td><button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteBannerModal" onclick="openDeleteBannerModal(${banner.banner_no})">삭제</button></td>
											</tr>
										</c:forEach>

									</tbody>
								</table>
							</div>
						</div>

						<div class="card mt-4">
							<h5 class="card-header">서브 배너 목록</h5>
							<div class="table-responsive text-nowrap">
								<table class="table">
									<thead class="table-light">
										<tr>
											<th class="col-2">배너 번호</th>
											<th class="col-2">이벤트</th>
											<th class="col-5">이미지 경로</th>
											<th class="col-2">이동 경로</th>
											<th class="col-1">삭제</th>
										</tr>
									</thead>
									<tbody id="subBannerListTableBody" class="table-border-bottom-0">
										<c:forEach var="banner" items="${subBannerList}">
											<tr>
												<td>${banner.banner_no}</td>
												<td>${banner.notice_title}</td>
												<td>${banner.thumbnail_image}</td>
												<td>${banner.url}</td>
												<td><button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteBannerModal" onclick="openDeleteBannerModal(${banner.banner_no})">삭제</button></td>
											</tr>
										</c:forEach>

									</tbody>
								</table>
							</div>
						</div>

						<!-- 배너 추가 버튼 -->
						<div id="addBannerBtnArea">
							<button id="addBannerBtn" type="button" class="btn btn-outline-primary mt-4" data-bs-toggle="modal" data-bs-target="#addBannerModal" onclick="">배너 추가</button>
						</div>

						<!-- 배너 추가 모달 -->
						<div id="addBannerModal" class="modal fade" tabindex="-1" aria-hidden="true">
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="editModalTitle">배너 추가</h5>
										<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body">
										<div class="row mb-3">
											<label id="couponNameLabel" class="col-sm-3 col-form-label" for="">배너 타입</label>
											<div class="col-sm-9">
												<button id="bannerTypeBtn" type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">배너 타입</button>
												<ul class="dropdown-menu">
													<li><a class="dropdown-item" href="javascript:void(0);" onclick="setBannerType(this)">메인 배너</a></li>
													<li><a class="dropdown-item" href="javascript:void(0);" onclick="setBannerType(this)">서브 배너</a></li>
												</ul>
											</div>
										</div>

										<div class="row mb-3">
											<label id="" class="col-sm-3 col-form-label" for="">이벤트</label>
											<div class="col-sm-9">
												<button id="selectEventBtn" type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">이벤트 선택</button>
												<ul id="eventList" class="dropdown-menu">
													<li><a class="dropdown-item" href="javascript:void(0);" onclick="setEvent(this)">1번 이벤트</a></li>
													<li><a class="dropdown-item" href="javascript:void(0);" onclick="setEvent(this)">2번 이벤트</a></li>
												</ul>
											</div>
										</div>
									</div>


									<div class="modal-footer">
										<button id="bannerAddModalCloseBtn" type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="">Close</button>
										<button id="bannerAddBtn" type="button" class="btn btn-primary" onclick="addBanner()" disabled>Add</button>
									</div>
								</div>
							</div>
						</div>
						<!-- / 배너 생성 모달 -->
						
						<!-- 배너 삭제 모달 -->
						<div id="deleteBannerModal" class="modal fade" tabindex="-1" aria-hidden="true">
							<div class="modal-dialog modal-sm" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="editModalTitle">배너 삭제</h5>
										<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body">배너를 삭제하시겠습니까?</div>


									<div class="modal-footer">
										<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="">Close</button>
										<button type="button" class="btn btn-danger" onclick="deleteBanner()">Delete</button>
									</div>
								</div>
							</div>
						</div>
						<!-- / 배너 삭제 모달 -->
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
