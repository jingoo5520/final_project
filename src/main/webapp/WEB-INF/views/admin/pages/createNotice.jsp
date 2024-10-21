<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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

    <style>
        /* 전체 페이지 스타일 */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f4f4f4;
        }

        /* 폼 스타일 */
        form {
            width: 100%; /* 폼이 페이지의 80%를 차지하도록 설정 */
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        /* 라벨과 입력 필드 스타일 */
        label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
        }

        input[type="text"], select, textarea, input[type="file"] {
            width: 100%; /* 입력 필드, 드롭다운, 텍스트 영역의 너비를 100%로 설정 */
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }

        /* 텍스트 영역 크기 */
        textarea {
            height: 150px; /* 내용 입력 영역의 높이 */
        }

        /* 버튼 스타일 */
        button {
            width: 100%; /* 버튼도 페이지에 꽉 차게 */
            padding: 12px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }
    </style>

</head>


<body>
	<!-- Layout wrapper -->
	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">
			
			
			<!-- Menu -->

			<jsp:include page="/WEB-INF/views/admin/components/sideBar.jsp">

				<jsp:param name="pageName" value="notice" />

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
공지
				<!-- / Content -->
	<h1>공지사항 작성 페이지</h1>
	
    <form action="/admin/pages/createNotice" method="post" enctype="multipart/form-data">
        <!-- 제목 입력 -->
        <div>
            <label for="title">제목:</label>
            <input type="text" id="title" name="noticeTitle" required />
        </div>

        <!-- 작성자 선택 (드롭다운) -->
        <div>
            <label for="adminId">작성자:</label>
            <select id="adminId" name="adminId" required>
                <option value="전체" disabled selected>전체</option>
                <option value="admin1">admin1</option>
                <option value="admin2">admin2</option>
                <option value="superAdmin">superAdmin</option>
            </select>
        </div>

        <!-- 그룹 선택 (드롭다운, 기본값: 전체) -->
        <div>
            <label for="group">그룹:</label>
            <select id="group" name="noticeType" required>
                <!-- <option value="전체" disabled selected>전체</option> -->
                <option value="N" selected>공지</option>
                <option value="E">이벤트</option>
            </select>
        </div>

        <!-- 내용 (첨부파일 포함) -->
        <div>
            <label for="content">내용:</label>
            <textarea id="content" name="noticeContent" rows="5" cols="40" required></textarea>
        </div>

        <!-- 파일 첨부 -->
         <div>
             <label for="file">파일 첨부:</label>
             <input type="file" id="file" name="file" multiple>
         </div>

        <!-- 등록 버튼 -->
        <div>
            <button type="submit">공지 등록</button>
        </div>
        
        <!-- 등록 날짜, 숨김 처리-->
<%--         <input type="hidden" id="regDate" name="regDate" value="${pageContext.request.time}"> --%>
        
    </form>
    
    
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