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
	let pageNo = 1;
	let pagingSize = 10;
	let pageCntPerBlock = 10;
	
	$(function(){
		$('[name="regDate_end"]').val(dateFormat(new Date()));
		
		showReviewList(pageNo);
	});
	
	// 리뷰 리스트 출력
	function showReviewList(pageNo) {
		event.preventDefault();
		
		let formData = $("#searchFilter").serializeArray();
		
		formData.forEach(function(item){
			if (item.name == 'regDate_start') {
				if (item.value == '') {
					item.value = "1900-01-01 00:00:00";
				} else {
					item.value += " 00:00:00";
				}
			} else if (item.name == 'regDate_end'){
				if (item.value == '') {
					item.value = dateFormat(new Date());
				} else {
					item.value += " 23:59:59";
				}
			} else if(item.name == 'product_no'){
				if (item.value == '') {
					item.value = 0;
				} else {
					item.value = parseInt(item.value);
				}
			}
			
			
		});
		
		formData.push({name: 'pageNo',value: pageNo });
		formData.push({name: 'pagingSize',value: pagingSize });
		formData.push({name: 'pageCntPerBlock',value: pageCntPerBlock });
		
		formData.forEach(function(item){
			console.log(item);
		});
		
		$.ajax({
			url : '/admin/review/getReviewList',
			type : 'POST',
			data : formData,
			dataType : 'json',
			success : function(data) {
				console.log(data);
	
				let listOutput = '';
				let paginationOutput = '';
				let noDataTableBody = `<tr id="noDataTableBody">
			        <td colspan="100%" class="text-center p-3">
		            	<div class="d-flex justify-content-center">검색된 리뷰가 없습니다.</div>
			        </td>
			    </tr>`;
	
			    if(data.list.length != 0){
					$.each(data.list, function(index, review) {
						let regDate = dateFormat(review.register_date);
						let hasReply = review.has_reply ? "O" : "";
						let isDelete = review.review_show == 'S' ? "" : "O";
						
						listOutput += `<tr onclick="location.href='/admin/review/adminReviewDetail?reviewNo=\${review.review_no}'">` 
								+ '<td>' + review.review_no + '</td>'
								+ '<td>' + review.product_no + '</td>' 
								+ `<td>\${review.member_id}(\${review.member_name})</td>` 
								+ '<td>' + review.review_title + '</td>'
								+ '<td>' + regDate + '</td>'
								+ '<td>' + hasReply + '</td>'
								+ '<td>' + isDelete + '</td>'
								+ '</tr>';
					});
		
					$('#reviewTableBody').html(listOutput);
					
					if(data.pi.pageNo == 1){
						paginationOutput += `<li class="page-item prev disabled"><a class="page-link" href="javascript:void(0);"><i class="tf-icon bx bx-chevrons-left"></i></a></li>`;	
					} else {
						paginationOutput += `<li class="page-item prev"><a class="page-link" href="javascript:void(0);" onclick="showReviewList(\${data.pi.pageNo} - 1)"><i class="tf-icon bx bx-chevrons-left"></i></a></li>`;
					}
					
					
					for(let i = data.pi.startPageNoCurBloack; i < data.pi.endPageNoCurBlock + 1; i++){
						if(i == data.pi.pageNo) {
							paginationOutput += `<li class="page-item active"><a class="page-link" href="javascript:void(0);" onclick="showReviewList(\${i},)">\${i}</a></li>`;
						} else {
							paginationOutput += `<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick="showReviewList(\${i})">\${i}</a></li>`;	
						}
					}
					
					
					if(data.pi.pageNo == data.pi.totalPageCnt){
						paginationOutput +=	`<li class="page-item next disabled"><a class="page-link" href="javascript:void(0);"><i class="tf-icon bx bx-chevrons-right"></i></a></li>`;
					} else {
						paginationOutput +=	`<li class="page-item next"><a class="page-link" href="javascript:void(0);" onclick="showReviewList(\${data.pi.pageNo} + 1)"><i class="tf-icon bx bx-chevrons-right"></i></a></li>`;
					}
					
					$('.pagination').html(paginationOutput);
			    } else {
			    	$('#reviewTableBody').html(noDataTableBody);
					$('.pagination').html("");
			    }
			},
			error : function(error) {
				console.log(error);
			}
		});
	}
	
	// 타임스탬프 to date
	function dateFormat(timestamp){
		let date = new Date(timestamp);
		
		let year = date.getFullYear();
		let month = String(date.getMonth() + 1).padStart(2, '0'); 
		let day = String(date.getDate()).padStart(2, '0'); 

	    date = `\${year}-\${month}-\${day}`; // YYYY-MM-DD 형식으로 반환
	    
	    return date;
	}
</script>
</head>
<style>
table tr:hover {
	background-color: rgba(0, 123, 255, 0.1);
	transition: background-color 0.3s ease;
	cursor: pointer;
}


</style>
<body>
	<!-- Layout wrapper -->
	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">
			<!-- Menu -->

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
						<div class="card accordion-item active">
							<h2 class="accordion-header" id="headingOne">
								<button type="button" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#accordionOne" aria-expanded="false" aria-controls="accordionOne">
									<h5>필터</h5>
								</button>
							</h2>

							<div id="accordionOne" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
								<div class="accordion-body">
									<form id="searchFilter">
										<div class="row mb-3">
											<label class="col-sm-2 col-form-label" for="product_no">상품 번호</label>
											<div class="col-sm-10">
												<input type="number" name="product_no" id="" class="form-control" placeholder="product_no" aria-label="" aria-describedby="" />
											</div>
										</div>
										<div class="row mb-3">
											<label class="col-sm-2 col-form-label" for="member_id">회원 ID</label>
											<div class="col-sm-10">
												<input type="text" name="member_id" id="" class="form-control" placeholder="member_id" aria-label="" aria-describedby="" />
											</div>
										</div>
										<div class="row mb-3">
											<label class="col-sm-2 col-form-label" for="member_name">회원 이름</label>
											<div class="col-sm-10">
												<input type="text" name="member_name" id="" class="form-control" placeholder="member_name" aria-label="" aria-describedby="" />
											</div>
										</div>
										<div class="row mb-3">
											<label class="col-sm-2 col-form-label" for="basic-default-name">작성 시간</label>
											<div class="col-sm-10 d-flex align-items-center">
												<div class="form-check-inline">
													<input name="regDate_start" class="form-control" type="date" value="" id="">
												</div>
												<div class="form-check-inline">
													<span class="mx-2">-</span>
												</div>
												<div class="form-check-inline">
													<input name="regDate_end" class="form-control" type="date" value="" id="">
												</div>
											</div>
										</div>
										<div class="row justify-content-end">
											<div class="col-sm-10">
												<button type="submit" class="btn btn-primary" onclick="showReviewList(pageNo)">Search</button>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
						
						
						<div class="card mt-4">
							<h5 class="card-header">리뷰 목록</h5>
							<div class="table-responsive text-nowrap">
								<table class="table">
									<thead class="table-light">
										<tr>
											<th class="col-1">리뷰 번호</th>
											<th class="col-1">상품 번호</th>
											<th class="col-2">회원</th>
											<th class="col-4">리뷰 제목</th>
											<th class="col-2">작성 날짜</th>
											<th class="col-1">답변 상태</th>
											<th class="col-1">삭제 여부</th>
										</tr>
									</thead>
									<tbody id="reviewTableBody" class="table-border-bottom-0">
									</tbody>
								</table>
							</div>

							<!-- 페이지 네이션 -->
							<div class="mt-4">
								<nav aria-label="Page navigation">
									<ul class="pagination justify-content-center">
									</ul>
								</nav>
							</div>
							<!-- / 페이지 네이션 -->

						</div>

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
