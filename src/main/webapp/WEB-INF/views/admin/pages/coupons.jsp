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
	let couponEditType = 'create';
	let selectedCouponNo = 0;

	$(function() {
		$('#couponName').on('input', function() {
			$('#couponNameErrorTag').html("");
			$('#couponNameErrorTag').css("color", "#697a8d");
			$('#couponName').css("border-color", "#d9dee3");
			checkFormCompletion();
		});

		$('#couponDc').on('input', function() {
			$('#couponDcErrorTag').html("");
			$('#couponDcErrorTag').css("color", "#697a8d");
			$('#couponDc').css("border-color", "#d9dee3");
			checkFormCompletion();
		});

		// 쿠폰 생성 취소(Close 버튼 클릭)
		$('#couponCreateCloseBtn').on('click', function() {
			$('#editCouponModal').modal('hide');
			resetCouponEditModal();
		})
	})

	// 모달 초기화
	function resetCouponEditModal(){
		$('#couponName').val('');
		$('#couponTypeBtn').text('쿠폰 타입');
		$('#couponTypeBtn').removeData('selected');
		$('#couponDc').val('');
		$("#couponCreateBtn").prop('disabled', true);
	}
	
	
	// 생성 버튼 클릭(쿠폰 생성 모달 open)
	function openCreateCouponModal(coupon) {
		couponEditType = "create"
		resetCouponEditModal();
		$('#editModalTitle').html("쿠폰 생성");
		$('#couponCreateBtn').html("Create");
	}
	
	
	// 수정 버튼 클릭(쿠폰 수정 모달 open)
	function openUpdateCouponModal(coupon) {
		couponEditType = "update"
		let parentTd = $(coupon).closest('td');
		selectedCouponNo = parentTd.siblings('.couponNoCell').html();
		
		console.log("update");
		console.log(selectedCouponNo);
		
		let couponName = parentTd.siblings('.couponNameCell').html();
		let couponType = parentTd.siblings('.couponTypeCell').html();
		let couponDc = couponType == 'A' ? parentTd.siblings('.couponDcAmountCell').html() : parentTd.siblings('.couponDcRateCell').html()
		
		console.log(couponName);
		console.log(couponType);
		console.log(couponDc);
		
		$('#couponCreateBtn').html("Update");
		$('#editModalTitle').html("쿠폰 수정");
		$('#couponName').val(couponName);
		
		if(couponType == 'A'){
			$('#couponTypeBtn').text("할인 금액"); 
		    $('#couponTypeBtn').data('selected', "할인 금액");
		    $('#couponDc').val(couponDc);
		} else {
			$('#couponTypeBtn').text("할인률"); 
		    $('#couponTypeBtn').data('selected', "할인률");
		    $('#couponDc').val(couponDc * 100);
		}
	}
	

	// 모든 폼에 입력값이 있는지 체크
	function checkFormCompletion() {
		let couponNameCheck = couponNameValid();
		let couponTypeCheck = couponTypeValid();
		let couponDcValueCheck = couponDcValueValud();

		if (couponNameCheck && couponTypeCheck && couponDcValueCheck) {
			$("#couponCreateBtn").prop('disabled', false);
		} else {
			$("#couponCreateBtn").prop('disabled', true);
		}
	}

	// 쿠폰 이름 검사
	function couponNameValid() {
		let valid = false;

		if ($('#couponName').val().length > 0) {
			valid = true;
		}

		console.log(valid);
		return valid;
	}

	// 쿠폰 타입 선택 검사
	function couponTypeValid() {
		let valid = false;

		if ($('#couponTypeBtn').text() != "쿠폰 타입") {
			valid = true;
		}
		console.log(valid);
		return valid;
	}

	// 쿠폰 할인률/할인 금액 검사
	function couponDcValueValud() {
		let valid = false;

		if ($('#couponDc').val() > 0) {
			valid = true;
		}

		if ($('#couponTypeBtn').text() == '할인률' && $('#couponDc').val() > 99) {
			valid = false;
			$('#couponDcErrorTag').html("할인률은 99를 넘길 수 없습니다.");
			$('#couponDcErrorTag').css("color", "red");
			$('#couponDc').css("border-color", "red");
		}

		console.log(valid);
		return valid;
	}

	// 쿠폰 리스트 출력
	function showCouponList() {
		$.ajax({
			url : '/admin/coupons/getCouponList',
			type : 'POST',
			dataType : 'json',
			success : function(data) {
				console.log(data);

				let output = '';

				$.each(data, function(index, coupon) {
					output += '<tr>' 
							+ '<td class="couponNoCell">' + coupon.coupon_no + '</td>'
							+ '<td class="couponNameCell">' + coupon.coupon_name + '</td>' 
							+ '<td class="couponTypeCell">' + coupon.coupon_dc_type + '</td>' 
							+ '<td class="couponDcAmountCell">' + coupon.coupon_dc_amount + '</td>' 
							+ '<td class="couponDcRateCell">' + coupon.coupon_dc_rate + '</td>'
							+ `<td>
								<button id="couponUpdateBtn" type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#editCouponModal" onclick="openUpdateCouponModal(this)">수정</button>
								<button id="couponDeleteBtn" type="button" class="btn btn-danger">삭제</button>
								</td>`
							+ '</tr>';
				});

				$('#couponTableBody').html(output);
			},
			error : function(error) {
				console.log(error);
			}
		});
	}

	// 쿠폰 타입 설정
	function setCouponType(type) {
		document.getElementById('couponTypeBtn').textContent = type.textContent;
		$('#couponDcErrorTag').html("");
		$('#couponDcErrorTag').css("color", "#697a8d");
		$('#couponDc').css("border-color", "#d9dee3");
		checkFormCompletion();
	}

	// 쿠폰 생성, 수정
	function editCoupon() {
		let couponName = document.getElementById('couponName').value;
		let couponType;
		let couponDcAmount = 0;
		let couponDcRate = 0;

		if (document.getElementById('couponTypeBtn').textContent == '할인률') {
			couponType = 'R';
			couponDcRate = parseFloat(document.getElementById('couponDc').value) / 100;
		} else if (document.getElementById('couponTypeBtn').textContent == '할인 금액') {
			couponType = 'A';
			couponDcAmount = parseInt(document.getElementById('couponDc').value);
		}

		console.log(couponEditType);
		
		if(couponEditType == "create"){
			$.ajax({
				url : '/admin/coupons/createCoupon',
				type : 'POST',
				data : {
					"couponName" : couponName,
					"couponType" : couponType,
					"couponDcAmount" : couponDcAmount,
					"couponDcRate" : couponDcRate
				},
				success : function(data) {
					if (data == 'duplicated') {
						$('#couponNameErrorTag').html("중복된 쿠폰 이름입니다.");
						$('#couponNameErrorTag').css("color", "red");
						$('#couponName').css("border-color", "red");
					} else if (data == 'success') {
						$('#editCouponModal').modal('hide');
						$('#couponTypeBtn').text('쿠폰 타입');
						$('#couponDc').val('');
						showCouponList();
					}

					$('#couponName').val('');
					$("#couponCreateBtn").prop('disabled', true);
				},
				error : function(error) {
					console.log(error);
				}
			});
		} else if(couponEditType == "update"){
			let coupon_no = document.getElementById('couponName')
			
			$.ajax({
				url : '/admin/coupons/updateCoupon',
				type : 'POST',
				data : {
					"couponNo" : selectedCouponNo,
					"couponName" : couponName,
					"couponType" : couponType,
					"couponDcAmount" : couponDcAmount,
					"couponDcRate" : couponDcRate
				},
				success : function(data) {
					if (data == 'duplicated') {
						$('#couponNameErrorTag').html("중복된 쿠폰 이름입니다.");
						$('#couponNameErrorTag').css("color", "red");
						$('#couponName').css("border-color", "red");
					} else if (data == 'success') {
						$('#editCouponModal').modal('hide');
						$('#couponTypeBtn').text('쿠폰 타입');
						$('#couponDc').val('');
						showCouponList();
					}

					$('#couponName').val('');
					$("#couponCreateBtn").prop('disabled', true);
				},
				error : function(error) {
					console.log(error);
				}
			});
		}
	}
</script>
</head>

<style>
#createCouponBtnSapce {
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

				<jsp:param name="pageName" value="coupons" />

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
							<h5 class="card-header">쿠폰 목록</h5>
							<div class="table-responsive text-nowrap">
								<table class="table">
									<thead class="table-light">
										<tr>
											<th>번호</th>
											<th>쿠폰 이름</th>
											<th>할인 타입</th>
											<th>할인 금액</th>
											<th>할인률</th>
											<th>수정 및 삭제</th>
										</tr>
									</thead>
									<tbody id="couponTableBody" class="table-border-bottom-0">

										<c:forEach var="coupon" items="${couponList}">
											<!-- couponList에서 쿠폰 반복 -->
											<tr>
												<td class="couponNoCell">${coupon.coupon_no}</td>
												<td class="couponNameCell">${coupon.coupon_name}</td>
												<td class="couponTypeCell">${coupon.coupon_dc_type}</td>
												<td class="couponDcAmountCell">${coupon.coupon_dc_amount}</td>
												<td class="couponDcRateCell">${coupon.coupon_dc_rate}</td>
												<td>
													<button id="couponUpdateBtn" type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#editCouponModal" onclick="openUpdateCouponModal(this)">수정</button>
													<button id="couponDeleteBtn" type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteCouponModal" onclick="">삭제</button>
												</td>
											</tr>
										</c:forEach>

									</tbody>
								</table>
							</div>
						</div>

						<!-- 쿠폰 생성 버튼 -->
						<div id="createCouponBtnSapce">
							<button type="button" class="btn btn-primary mt-4" data-bs-toggle="modal" data-bs-target="#editCouponModal" onclick="openCreateCouponModal()">쿠폰 생성</button>
						</div>

						<!-- 쿠폰 생성 모달 -->
						<div id="editCouponModal" class="modal fade" tabindex="-1" aria-hidden="true">
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="editModalTitle">쿠폰 생성</h5>
										<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body">
										<div class="row">
											<div class="col mb-3">
												<label id="couponNameLabel" for="nameBasic" class="form-label">쿠폰 이름</label> <input type="text" id="couponName" class="form-control" placeholder="Enter Name" name="couponName" />
												<div id="couponNameErrorTag"></div>
											</div>
										</div>


										<div class="row g-2">
											<div class="col mb-0">
												<button id="couponTypeBtn" type="button" class="btn btn-outline-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">쿠폰 타입</button>
												<ul class="dropdown-menu">
													<li><a class="dropdown-item" href="javascript:void(0);" onclick="setCouponType(this)">할인률</a></li>
													<li><a class="dropdown-item" href="javascript:void(0);" onclick="setCouponType(this)">할인 금액</a></li>
												</ul>
											</div>
											<div class="col-8 mb-0">
												<input type="number" id="couponDc" class="form-control" placeholder="Enter Number" name="couponDc" />
												<div id="couponDcErrorTag"></div>
											</div>
										</div>
									</div>


									<div class="modal-footer">
										<button id="couponCreateCloseBtn" type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal" onclick="">Close</button>
										<button id="couponCreateBtn" type="button" class="btn btn-primary" onclick="editCoupon()" disabled>Create</button>
									</div>
								</div>
							</div>
						</div>
						<!-- / 쿠폰 생성 모달 -->

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
