<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
<!-- <script src="https://code.jquery.com/jquery-latest.min.js"></script> -->
<!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
<!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
<script src="/resources/assets/admin/js/config.js"></script>
<html>
<head>
<script>

function showRefundList(pageNo) {
	console.log(pageNo);
	let pagingSize =10;
	let refund_type = $('input[name="refund_type"]:checked').map(function () {
		return $(this).val();
	}).get();
	let cancel_apply_date_start = $('input[name="refund_start_date"]').val();
	let cancel_apply_date_end = $('input[name="refund_end_date"]').val();
	if(data == null) {
	Pagingdata = {
	        pageNo: pageNo,
	        pagingSize: pagingSize,
	        refund_type: refund_type,
	        refund_start_date: cancel_apply_date_start,
	        refund_end_date: cancel_apply_date_end
	    };
	} else {
		Pagingdata = {
		        pageNo: pageNo,
		        pagingSize: pagingSize,
		        refund_type: data.refund_type,
		        refund_start_date: data.cancel_apply_date_start,
		        refund_end_date: data.cancel_apply_date_end
		    };
	}
	$.ajax({
		 url: '/admin/order/searchRefundFilter',
	        type: 'POST',
	        contentType: 'application/json' ,
	        data: JSON.stringify(Pagingdata),
	    	success: function(data) {
	    	let output = "";
		    

	        $.each(data.refundList, function(index, refund) {

	            output += '<tr>' +
	                
	                '<td>' + refund.refund_no + '</td>' +
	                '<td id="cancelOrderId">' + refund.cancel_no + '</td>' +
	                '<td>' + refund.payment_num + '</td>' +
	                '<td>' + (refund.refund_receive_date ? new Date(refund.refund_receive_date).toLocaleString() : ' ')  + '</td>' +
	                '<td>' + refund.refund_type + '</td>' +
	                '<td>' + refund.cancel_amount + '</td>' +	          
	                '</tr>';
	        });

	        $("#refundTableBody").html(output);

	        PageNation(data)
	    },
	    error: function(error) {
	        console.error(error); // 에러가 발생한 경우 콘솔에 에러 출력
	    }
	});
  
    
 }
function PageNation(data) {
    if (data.refundList && data.refundList.length !== 0) {
        let paginationOutput = "";
        
        if (data.PagingInfo.pageNo == 1) {
            paginationOutput += `<li class="page-item prev disabled"><a class="page-link" href="javascript:void(0);"><i class="tf-icon bx bx-chevrons-left"></i></a></li>`;
        } else {
            paginationOutput += `<li class="page-item prev"><a class="page-link" href="javascript:void(0);" onclick="showRefundList(\${data.PagingInfo.pageNo - 1})"><i class="tf-icon bx bx-chevrons-left"></i></a></li>`;
        }

        for (let i = data.PagingInfo.startPageNoCurBlock; i <= data.PagingInfo.endPageNoCurBlock; i++) {
            console.log(i);
            if (i == data.PagingInfo.pageNo) {
                paginationOutput += `<li class="page-item active"><a class="page-link" href="javascript:void(0);" onclick="showRefundList(\${i})">\${i}</a></li>`;
            } else {
                paginationOutput += `<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick="showRefundList(\${i})">\${i}</a></li>`;
            }
        }

        if (data.PagingInfo.pageNo == data.PagingInfo.totalPageCnt) {
            paginationOutput += `<li class="page-item next disabled"><a class="page-link" href="javascript:void(0);"><i class="tf-icon bx bx-chevrons-right"></i></a></li>`;
        } else {
            paginationOutput += `<li class="page-item next"><a class="page-link" href="javascript:void(0);" onclick="showRefundList(\${data.PagingInfo.pageNo + 1})"><i class="tf-icon bx bx-chevrons-right"></i></a></li>`;
        }

        $('.pagination').html(paginationOutput);
    } else {
    	$('.pagination').html("");
    }
}
$(function() {
	
	$("#searchRefund").on('click', function() {
		 let pageNo = 1;
		 let pagingSize = 10;
		let refund_type = $('input[name="refund_type"]:checked').map(function () {
				return $(this).val();
		}).get();
		console.log(refund_type);
		let cancel_apply_date_start = $('input[name="refund_start_date"]').val();
		let cancel_apply_date_end = $('input[name="refund_end_date"]').val();
		data = {
			    pageNo: pageNo,
		        pagingSize: pagingSize,
		        refund_type: refund_type,
		        refund_start_date: cancel_apply_date_start,
		        refund_end_date: cancel_apply_date_end
		    };
		$.ajax({
			 url: '/admin/order/searchRefundFilter',
		        type: 'POST',
		        contentType: 'application/json' ,
		        data: JSON.stringify(data),
		    	success: function(data) {
		    	let output = "";
			    

		        $.each(data.refundList, function(index, refund) {

		       
		            
		            output += '<tr>' +
		                
		                '<td>' + refund.refund_no + '</td>' +
		                '<td id="cancelOrderId">' + refund.cancel_no + '</td>' +
		                '<td>' + refund.payment_num + '</td>' +
		                '<td>' + (refund.refund_receive_date ? new Date(refund.refund_receive_date).toLocaleString() : ' ')  + '</td>' +
		                '<td>' + refund.refund_type + '</td>' +
		                '<td>' + refund.cancel_amount + '</td>' +	          
		                '</tr>';
		        });

		        $("#refundTableBody").html(output);

		        PageNation(data)
		    },
		    error: function(error) {
		        console.error(error); // 에러가 발생한 경우 콘솔에 에러 출력
		    }
		});
})
})
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- Layout wrapper -->
	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">
			<!-- Menu -->

			<!-- Menu -->

			<jsp:include page="/WEB-INF/views/admin/components/sideBar.jsp">

				<jsp:param name="pageName" value="adminorderrefundview" />

			</jsp:include>
			<!-- / Layout wrapper -->

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
				<div class="content-wrapper">
					<!-- Content -->
					<div class="container-xxl flex-grow-1 container-p-y">
						<h4 class="fw-bold py-3 mb-4"></h4>

						<!-- Basic Layout -->
						<div class="row">
							<h5 class="fw-bold py-3 mb-4">환불 내역</h5>

							<div class="card mb-4">
								<div class="container-xxl flex-grow-1 container-p-y mb-3">
									<div class="card accordion-item active mb-3">
										<h2 class="accordion-header" id="headingOne">
											<button type="button" class="accordion-button collapsed"
												data-bs-toggle="collapse" data-bs-target="#accordionOne"
												aria-expanded="false" aria-controls="accordionOne">
												<h5>검색</h5>
											</button>
										</h2>


										<div id="accordionOne"
											class="accordion-collapse collapse show"
											data-bs-parent="#accordionExample">
											<div class="accordion-body">

												<div class="row mb-3" style="border-top: 1px solid">
													<label class="col-sm-2 col-form-label"
														for="basic-default-name">취소 타입</label>
													<div class="col-sm-10 d-flex align-items-center">
														<div class="form-check-inline" id=>
															<input name="refund_type" class="form-check-input"
																type="checkbox" value="cancel" id="refund_type_c"
																checked="checked" /> <label class="form-check-label"
																for="product_m"> 취소 </label>
														</div>
														<div class="form-check-inline">
															<input name="refund_type" class="form-check-input"
																type="checkbox" value="return" id="refund_type_r"
																checked="checked" /> <label class="form-check-label"
																for="product_p"> 반품 </label>
														</div>

													</div>
												</div>


												<div class="row mb-3">
													<label class="col-sm-2 col-form-label"
														for="basic-default-name">환불 완료 날짜</label>
													<div class="col-sm-10 d-flex align-items-center">
														<div class="form-check-inline">
															<input name="refund_start_date" class="form-control"
																type="date" value="" id="html5-date-input">
														</div>
														<div class="form-check-inline">
															<span class="mx-2">-</span>
														</div>
														<div class="form-check-inline">
															<input name="refund_end_date" class="form-control"
																type="date" value="" id="html5-date-input">
														</div>
													</div>
												</div>
												<div class="row justify-content-end">
													<div class="col-sm-10">
														<button type="button" class="btn btn-primary"
															id="searchRefund">검색</button>
													</div>
												</div>

											</div>
										</div>
									</div>
									<h5 class="card-header">환불 내역</h5>
									<div class="table-responsive text-nowrap">
										<table class="table">
											<thead class="table-light">
												<tr>
													<th>환불 번호</th>
													<th>취소 번호</th>
													<th>결제 번호</th>
													<th>환불 날짜</th>
													<th>환불 타입</th>
													<th>환불 금액</th>
												</tr>
											</thead>
											<tbody id="refundTableBody" class="table-border-bottom-0">
												<c:forEach var="refund" items="${refundList}">
													<tr>

														<td>${refund.refund_no }</td>
														<td>${refund.cancel_no}</td>
														<td>${refund.payment_num }</td>
														<td><fmt:formatDate
																value="${refund.refund_receive_date}"
																pattern="yyyy-MM-dd" /></td>
														<td>${refund.refund_type}</td>
														<td>${refund.refund_amount}</td>
														<td><div class="mt-3"></div></td>
														<td>
													</tr>
												</c:forEach>

											</tbody>
										</table>
									</div>
									<div class="mt-4">
										<nav aria-label="Page navigation">
											<ul class="pagination justify-content-center" id="paging">
												<c:choose>
													<c:when test="${PagingInfo.pageNo == 1}">
														<li class="page-item prev disabled"><a
															class="page-link" href="javascript:void(0);"> <i
																class="tf-icon bx bx-chevrons-left"></i>
														</a></li>
													</c:when>
													<c:otherwise>
														<li class="page-item prev"><a class="page-link"
															href="javascript:void(0);"> <i
																class="tf-icon bx bx-chevrons-left"></i>
														</a></li>
													</c:otherwise>
												</c:choose>

												<c:forEach var="i" begin="${PagingInfo.startPageNoCurBlock}"
													end="${PagingInfo.endPageNoCurBlock}">
													<c:choose>
														<c:when test="${PagingInfo.pageNo == i}">
															<li class="page-item active"><a class="page-link"
																href="javascript:void(0);"
																onclick="showRefundList(${PagingInfo.pageNo})">${i}</a>
															</li>
														</c:when>
														<c:otherwise>
															<li class="page-item"><a class="page-link"
																href="javascript:void(0);"
																onclick="showRefundList(${i})">${i}</a></li>
														</c:otherwise>
													</c:choose>

												</c:forEach>

												<c:choose>
													<c:when
														test="${PagingInfo.pageNo == PagingInfo.totalPageCnt}">
														<li class="page-item disabled"><a class="page-link"
															href="javascript:void(0);"> <i
																class="tf-icon bx bx-chevrons-right"></i>
														</a></li>
													</c:when>
													<c:otherwise>
														<li class="page-item next"><a class="page-link"
															href="javascript:void(0);"
															onclick="showRefundList(${i+1})"> <i
																class="tf-icon bx bx-chevrons-right"></i>
														</a></li>
													</c:otherwise>
												</c:choose>

											</ul>
										</nav>
									</div>
								</div>



								<!-- Footer -->

							</div>
							<footer class="content-footer footer bg-footer-theme">
								<div
									class="container-xxl d-flex flex-wrap justify-content-between py-2 flex-md-row flex-column">
									<div class="mb-2 mb-md-0">
										©
										<script>
										document
												.write(new Date().getFullYear());
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
						</div>

					</div>

				</div>
			</div>
			<div class="modal fade" id="modalToggle2" tabindex="-1"
				style="display: none;" aria-hidden="true">
				<div class="modal-dialog modal-xl" role="document">

					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="modalOrderNo">목록</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<!-- 취소 항목 리스트가 동적으로 여기에 삽입됩니다 -->
							<div id="cancelListContainer"></div>
							<div>정말로 취소 완료하시겠습니까?</div>
						</div>
						<div class="modal-footer">
							<button class="btn btn-primary" id="confirmDeleteBtn">확인</button>
							<button class="btn btn-danger" data-bs-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>




			<div class="modal fade" id="modifyCancel" tabindex="-1"
				style="display: none;" aria-hidden="true">
				<div class="modal-dialog modal-xl" role="document">

					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="modalOrderNo2">목록</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<!-- 취소 항목 리스트가 동적으로 여기에 삽입됩니다 -->
							<div id="ListContainer"></div>
							<div>정말로 취소 완료하시겠습니까?</div>
						</div>
						<div class="modal-footer">
							<button class="btn btn-primary" id="confirmDeleteBtn2">확인</button>
							<button class="btn btn-danger" data-bs-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>
			<div
				class="bs-toast toast toast-placement-ex m-2 fade bg-secondary top-0 end-0 hide"
				role="alert" aria-live="assertive" aria-atomic="true"
				data-delay="2000" id="toastMessage">
				<div class="toast-header">
					<i class="bx bx-bell me-2"></i>
					<div class="me-auto fw-semibold" id="toastTitle"></div>
					<small></small>
					<button type="button" class="btn-close" data-bs-dismiss="toast"
						aria-label="Close"></button>
				</div>
				<div class="toast-body" id="toastBody"></div>
			</div>
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