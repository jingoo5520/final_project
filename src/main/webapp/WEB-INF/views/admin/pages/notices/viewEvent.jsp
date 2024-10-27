<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html lang="en" class="light-style layout-menu-fixed" dir="ltr" data-theme="theme-default" data-assets-path="/resources/assets/admin/" data-template="vertical-menu-template-free">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
    <title>이벤트 상세</title>
    <link rel="icon" type="image/x-icon" href="/resources/assets/admin/img/favicon/favicon.ico" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="/resources/assets/admin/vendor/fonts/boxicons.css" />
    <link rel="stylesheet" href="/resources/assets/admin/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="/resources/assets/admin/vendor/css/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="/resources/assets/admin/css/demo.css" />
    <script src="/resources/assets/admin/vendor/js/helpers.js"></script>
    <script src="https://code.jquery.com/jquery-latest.min.js"></script>
    <script src="/resources/assets/admin/js/config.js"></script>
</head>
<style>
	#menuType{
		display: flex;
	    gap: 10px;
	}
</style>

<body>
    <div class="layout-wrapper layout-content-navbar">
        <div class="layout-container">

            <jsp:include page="/WEB-INF/views/admin/components/sideBar.jsp">
                <jsp:param name="viewEvent" value="viewEvent" />
            </jsp:include>

            <div class="layout-page">
                <nav class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme" id="layout-navbar">
                    <div class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none">
                        <a class="nav-item nav-link px-0 me-xl-4" href="javascript:void(0)"> <i class="bx bx-menu bx-sm"></i></a>
                    </div>
                </nav>

                <div class="content-wrapper">
                    <div class="container-xxl flex-grow-1 container-p-y">
                        <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">공지 /</span> 이벤트 상세</h4>

                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title">${event.notice_title}</h5>
                                <p class="card-text">작성자: ${event.admin_id} | 작성일: ${event.reg_date}</p>
                            </div>
                            <div class="card-body">
                                <p class="card-text">${event.notice_content}</p>
                            </div>
                            <div class="card-footer" name="menuType">
								<a class="btn rounded-pill btn-outline-warning" href="/admin/notices/editEvent/${event.notice_no}">수정</a>
								<a class="btn rounded-pill btn-outline-danger" onclick="confirmDelete(${event.notice_no});">삭제</a>
                            </div>
                            <div style="transform: translate(15px, -10px);">
					        	<a class="btn rounded-pill btn-outline-secondary" href="/admin/notices/event">목록으로 돌아가기</a>
					    	</div>
                        </div>

                    </div>

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
                                <a href="https://themeselection.com/license/" class="footer-link me-4" target="_blank">License</a>
                                <a href="https://themeselection.com/" target="_blank" class="footer-link me-4">More Themes</a>
                                <a href="https://themeselection.com/demo/sneat-bootstrap-html-admin-template/documentation/" target="_blank" class="footer-link me-4">Documentation</a>
                                <a href="https://github.com/themeselection/sneat-html-admin-template-free/issues" target="_blank" class="footer-link me-4">Support</a>
                            </div>
                        </div>
                    </footer>
                </div>
            </div>
        </div>
    </div>

    <script async defer src="https://buttons.github.io/buttons.js"></script>
	<script type="text/javascript">
	function confirmDelete(noticeNo) {
	    if (confirm("정말 삭제하시겠습니까?")) {
	        deleteEvent(noticeNo);
	    }
	}

	function deleteEvent(noticeNo) {
	    $.ajax({
	        type: "POST",
	        url: "/admin/notices/deleteEvent",
	        data: { notice_no: noticeNo },
	        success: function(response) {
	            $("#event-row-" + noticeNo).remove(); // 이벤트 행 제거
	            alert("이벤트 삭제 완료");
	            window.location.href = "/admin/notices/event";
	        },
	        error: function(xhr, status, error) {
	            alert("이벤트 삭제 실패");
	            console.error(xhr.responseText);
	        }
	    });
	}
	</script>
</body>
</html>
