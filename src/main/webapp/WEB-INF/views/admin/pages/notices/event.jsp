<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
	
</script>
</head>

 <body>
    <!-- Layout wrapper -->
    <div class="layout-wrapper layout-content-navbar">
      <div class="layout-container">
        <!-- Menu -->

        <!-- Menu -->

			<jsp:include page="/WEB-INF/views/admin/components/sideBar.jsp">

				<jsp:param name="pageName" value="event" />

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
				<!-- / Content -->
	
               <div class="container-xxl flex-grow-1 container-p-y">
              <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">공지 /</span> 이벤트 목록</h4>

              <div class="row">
              <!-- Bordered Table -->
              <div class="card">
                <h5 class="card-header"></h5>
                <div class="card-body">
                  <div class="table-responsive text-nowrap">
                    <table class="table table-bordered">
                      <thead>
                        <tr>
                          <th>번호</th>
                          <th>구분</th>
                          <th>제목</th>
                          <th>작성자</th>
                          <th>작성일자</th>
                          <th>이벤트 시작일</th>
                          <th>이벤트 종료일</th>
                          <th>관리</th>
                        </tr>
                      </thead>
                      <tbody id="eventTableBody" class="table-border-bottom-0">
	                      <c:choose>
	                        <c:when test="${not empty events}">
								<c:forEach var="event" items="${events}">
								    <tr id="event-row-${event.notice_no}">
								        <td>${event.notice_no}</td>
								        <td>${event.notice_type}</td>
								        <td><a href="viewEvent/${event.notice_no}">${event.notice_title}</a></td>
								        <td>${event.admin_id}</td>
								        <td>${event.reg_date}</td>
								        <td>
										    <c:choose>
										        <c:when test="${not empty event.event_start_date}">
										            ${event.event_start_date}
										        </c:when>
										        <c:otherwise>
										            미정
										        </c:otherwise>
										    </c:choose>
										</td>
										<td>
										    <c:choose>
										        <c:when test="${not empty event.event_end_date}">
										            ${event.event_end_date}
										        </c:when>
										        <c:otherwise>
										            미정
										        </c:otherwise>
										    </c:choose>
										</td>

								        <td>
											<div>${event.notice_content}</div>
											<a class="btn rounded-pill btn-outline-warning" href="editEvent/${event.notice_no}">수정</a>
										    <a class="btn rounded-pill btn-outline-danger" onclick="confirmDelete(${event.notice_no});">삭제</a>
										</td>
									</tr>
								</c:forEach>
	                        </c:when>
	                        <c:otherwise>
	                        	<tr>
	                            	<td colspan="8">등록된 이벤트가 없습니다.</td>
	                            </tr>
							</c:otherwise>
	                      </c:choose>
                      </tbody>
                    </table>
                    
      <!-- 이벤트 작성 버튼 -->
      <div class="text-end mt-3">
        <a class="btn rounded-pill btn-outline-primary" href="/admin/notices/createEvent">이벤트 작성</a>
                  </div>
                </div>
              </div>
									<!-- 페이지 네이션 -->
									<div class="mt-4">
										<nav aria-label="Page navigation">
											<ul class="pagination justify-content-center">
												<!-- 이전 페이지 버튼 -->
												<c:choose>
													<c:when test="${pi.pageNo == 1}">
														<li class="page-item prev disabled"><a class="page-link" href="javascript:void(0);"> <i class="tf-icon bx bx-chevrons-left"></i>
														</a></li>
													</c:when>
													<c:otherwise>
														<li class="page-item prev"><a class="page-link" href="javascript:void(0);" onclick="showEventList(${pi.pageNo - 1}, ${pi.viewDataCntPerPage})"> <i class="tf-icon bx bx-chevrons-left"></i>
														</a></li>
													</c:otherwise>
												</c:choose>

												<!-- 페이지 번호 출력 -->
												<c:forEach var="i" begin="${pi.startPageNoCurBlock}" end="${pi.endPageNoCurBlock}">
													<c:choose>
														<c:when test="${pi.pageNo == i}">
															<li class="page-item active"><a class="page-link" href="javascript:void(0);" onclick="showEventList(${pi.pageNo}, ${pi.viewDataCntPerPage})">${i}</a></li>
														</c:when>
														<c:otherwise>
															<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick="showEventList(${i}, ${pi.viewDataCntPerPage})">${i}</a></li>
														</c:otherwise>
													</c:choose>
												</c:forEach>

												<!-- 다음 페이지 버튼 -->
												<c:choose>
													<c:when test="${pi.pageNo == pi.totalPageCnt}">
														<li class="page-item disabled"><a class="page-link" href="javascript:void(0);"> <i class="tf-icon bx bx-chevrons-right"></i>
														</a></li>
													</c:when>
													<c:otherwise>
														<li class="page-item next"><a class="page-link" href="javascript:void(0);" onclick="showEventList(${pi.pageNo + 1}, ${pi.viewDataCntPerPage})"> <i class="tf-icon bx bx-chevrons-right"></i>
														</a></li>
													</c:otherwise>
												</c:choose>

											</ul>
										</nav>
									</div>
									<!-- / 페이지 네이션 -->
 
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
	            </div>
            </div>
            </div>
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
<script type="text/javascript">
    // 이미지 업로드 함수
    function uploadImage(url, noticeNo, type) {
        const form = document.getElementById(`upload${type}Form_${noticeNo}`);
        const formData = new FormData(form);
        
        fetch(url, {
            method: 'POST',
            body: formData,
        })
        .then(response => {
            if (!response.ok) {
                return response.text().then(text => { throw new Error(text); });
            }
            return response.json();
        })
        .then(data => {
            console.log(`${type} 업로드 성공:`, data);
            const imgPreview = document.getElementById(`${type}Preview_${noticeNo}`);
            imgPreview.src = `C:/spring/temp/${data.fileName}`; // 업로드한 파일 경로
            imgPreview.style.display = 'block'; // 미리보기 표시
        })
        .catch(error => {
            console.error(`${type} 업로드 오류:`, error);
            alert(`${type} 업로드 중 오류가 발생했습니다: ${error.message}`);
        });
    }

    // 삭제 확인 함수
    function confirmDelete(noticeNo) {
        if (confirm("정말 삭제하시겠습니까?")) {
            deleteEvent(noticeNo);
        }
    }

    // 이벤트 삭제 함수
    function deleteEvent(noticeNo) {
        $.ajax({
            type: "POST",
            url: "/admin/notices/deleteEvent",
            data: { notice_no: noticeNo },
            success: function(response) {
                $("#event-row-" + noticeNo).remove(); // 공지사항 행 제거
                alert("이벤트 삭제 완료");
            },
            error: function(xhr) {
                alert("이벤트 삭제 실패");
                console.error(xhr.responseText);
            }
        });
    }

    document.addEventListener("DOMContentLoaded", function() {
        const forms = document.querySelectorAll("form[id^='uploadForm_']");

        forms.forEach(form => {
            const noticeNo = form.querySelector("input[name='notice_no']").value; 
            console.log('Notice No:', noticeNo); // 디버깅: notice_no 값 출력

            // 파일 입력 요소에 change 이벤트 리스너 추가
            const bannerInput = form.querySelector(`input[id='bannerInput_${noticeNo}']`);
            const thumbnailInput = form.querySelector(`input[id='thumbnailInput_${noticeNo}']`);

            // 이미지 미리보기 설정
            if (bannerInput) {
                bannerInput.addEventListener('change', event => handleImagePreview(event, noticeNo, 'banner'));
            }
            if (thumbnailInput) {
                thumbnailInput.addEventListener('change', event => handleImagePreview(event, noticeNo, 'thumbnail'));
            }

            // 폼 제출 이벤트 리스너 추가
            form.addEventListener("submit", event => {
                event.preventDefault(); // 기본 제출 방지
                console.log("폼 제출 이벤트 발생"); // 디버깅 로그 추가

                const uploadPromises = [];
                if (bannerInput) {
                    uploadPromises.push(uploadImage(`/admin/notices/event/${noticeNo}/banner`, noticeNo, '배너'));
                }
                if (thumbnailInput) {
                    uploadPromises.push(uploadImage(`/admin/events/uploadThumbnail`, noticeNo, '썸네일'));
                }

                // 모든 업로드가 완료된 후 페이지 새로 고침
                Promise.all(uploadPromises).then(() => location.reload());
            });
        });
    });

    // 이미지 미리보기 처리 함수
    function handleImagePreview(event, noticeNo, type) {
        const file = event.target.files[0];
        const reader = new FileReader();
        
        reader.onload = function(e) {
            const imgPreview = document.getElementById(`${type}Preview_${noticeNo}`);
            imgPreview.src = e.target.result; // 미리보기 이미지 경로 설정
            imgPreview.style.display = 'block'; // 이미지 표시
        };

        if (file) {
            reader.readAsDataURL(file);
        }
    }
    
	function showEventList(pageNo, pagingSize) {
// 		if (pageNo <= 0) pageNo = 1; 
		$.ajax({
	        url: '/admin/notices/getEvents',
	        type: 'GET',
	        dataType : 'json',
	        data: {
	            pageNo: pageNo
	        },
	        success: function(response) {
	        	console.log(response);
	        	
	            // 이벤트 목록 업데이트
	            let tableRows = '';
	            $.each(response.list, function(index, event) {
	                tableRows += '<tr id="event-row-' + event.notice_no + '">' +
	                          '<td>' + event.notice_no + '</td>' +
	                          '<td>' + event.notice_type + '</td>' +
	                          '<td><a href="viewEvent/' + event.notice_no + '">' + event.notice_title + '</a></td>' +
	                          '<td>' + event.admin_id + '</td>' +
	                          '<td>' + event.formatted_reg_date + '</td>' +
	                          '<td>' + event.formatted_event_start_date + '</td>' +
	                          '<td>' + event.formatted_event_end_date + '</td>' +
	                          '<td>' +
	                          '<a class="btn rounded-pill btn-outline-warning" href="editEvent/' + event.notice_no + '">수정</a>' +
	                          '<a class="btn rounded-pill btn-outline-danger" onclick="confirmDelete(' + event.notice_no + ');">삭제</a>' +
	                          '</td>' +
	                          '</tr>';
	            });
	            console.log(response.list[0]);
	            console.log(tableRows);
	            
	            $("#eventTableBody").html(tableRows);
	            // 페이지네이션 업데이트
	            updatePagination(response.pi);
	        },
	        error: function() {
	            alert('이벤트 목록을 불러오는 데 실패했습니다.');
	        }
	    });
	}

	function updatePagination(pi) {
	    // 페이지네이션 업데이트 처리 (응답에 따른 페이지 버튼 생성)
	    let pagination = '';
	    
	    if (pi.pageNo > 1) {
	        pagination += '<li class="page-item prev">' + 
	        '<a class="page-link" href="javascript:void(0);" onclick="showEventList(' + (pi.pageNo - 1) + ',' + pi.viewDataCntPerPage + ')">' +
	        '<i class="tf-icon bx bx-chevrons-left"></i>' +
	        '</a></li>';
	    } else {
	        pagination += '<li class="page-item prev disabled"><a class="page-link" href="javascript:void(0);"><i class="tf-icon bx bx-chevrons-left"></i></a></li>';
	    }
	    
	    for (let i = pi.startPageNoCurBlock; i <= pi.endPageNoCurBlock; i++) {
	        if (pi.pageNo === i) {
	            pagination += '<li class="page-item active">' + 
	            '<a class="page-link" href="javascript:void(0);" onclick="showEventList(' + i + ',' + pi.viewDataCntPerPage + ')">' + i +
	            '</a></li>';
	        } else {
	            pagination += '<li class="page-item">' + 
	            '<a class="page-link" href="javascript:void(0);" onclick="showEventList(' + i + ',' + pi.viewDataCntPerPage + ')">' + i +
	            '</a></li>';
	        }
	    }
	    
	    if (pi.pageNo < pi.totalPageCnt) {
	        pagination += '<li class="page-item next">' + '<a class="page-link" href="javascript:void(0);" onclick="showEventList(' + (pi.pageNo + 1) + ',' + pi.viewDataCntPerPage + ')"><i class="tf-icon bx bx-chevrons-right"></i></a></li>';
	    } else {
	        pagination += '<li class="page-item next disabled">' +
	        '<a class="page-link" href="javascript:void(0);">' + 
	        '<i class="tf-icon bx bx-chevrons-right"></i>' + 
	        '</a></li>';
	    }
	    
	    console.log(pi.pageNo);
	    console.log(pi.startPageNoCurBlock);
	    console.log(pi.endPageNoCurBlock);
	    console.log(pi.totalPageCnt);
	    
	    $(".pagination").html(pagination);
	}
    
</script>

  </body>

</html>
