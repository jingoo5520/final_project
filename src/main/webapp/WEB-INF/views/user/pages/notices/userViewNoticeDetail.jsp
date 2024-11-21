<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <title>공지사항 상세페이지</title>
    <meta name="description" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="shortcut icon" type="image/x-icon" href="/resources/assets/user/images/logo/favicon.png" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- ========================= CSS here ========================= -->
    <link rel="stylesheet" href="/resources/assets/user/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/resources/assets/user/css/LineIcons.3.0.css" />
    <link rel="stylesheet" href="/resources/assets/user/css/tiny-slider.css" />
    <link rel="stylesheet" href="/resources/assets/user/css/glightbox.min.css" />
    <link rel="stylesheet" href="/resources/assets/user/css/main.css" />
</head>

<body>
    <!-- Header -->
    <jsp:include page="../header.jsp"></jsp:include>

    <!-- Start Breadcrumbs -->
    <div class="breadcrumbs">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6 col-md-6 col-12">
                    <div class="breadcrumbs-content">
                        <h1 class="page-title">공지사항</h1>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-12">
                    <ul class="breadcrumb-nav">
                        <li><a href="/"><i class="lni lni-home"></i> Home</a></li>
                        <li><a href="/serviceCenter/inquiries">Service Center</a></li>
                        <li><a href="/serviceCenter/notice">공지사항</a><li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!-- End Breadcrumbs -->

    <section class="product-grids section">
        <div class="container">
            <div class="row">
                <!-- Sidebar -->
                    <jsp:include page="/WEB-INF/views/user/pages/serviceCenterSideBar.jsp">
                        <jsp:param name="pageName" value="notices" />
                    </jsp:include>
                <!-- /Sidebar -->

                <!-- Main Content -->
                <div class="col-lg-9 col-md-8">
                    <div class="layout-page">
                        <!-- Navbar -->
                        <nav class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme" id="layout-navbar">
                            <div class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none">
                                <a class="nav-item nav-link px-0 me-xl-4" href="javascript:void(0)">
                                    <i class="bx bx-menu bx-sm"></i>
                                </a>
                            </div>
                        </nav>

                        <!-- Content -->
                        <div class="content-wrapper">
                            <div class="container-xxl flex-grow-1 container-p-y">
                                <!-- 공지사항 데이터가 있을 경우 -->
                                <c:if test="${not empty notices}">
                                    <div class="card">
                                        <div class="card-header">
                                            <h5 class="card-title">${notices.notice_title}</h5>
                                            <p class="card-text">
                                                작성자: <c:out value="${notices.admin_id}" /> |
                                                작성일: <c:out value="${fn:replace(notices.reg_date, 'T', ' ')}" />
                                            </p>
                                        </div>
                                        <div class="card-body">
                                            <p class="card-text">${notices.notice_content}</p>
                                        </div>
                                        <div style="transform: translate(15px, -10px);">
                                            <a class="btn rounded-pill btn-outline-secondary" href="/serviceCenter/notice">목록으로 돌아가기</a>
                                        </div>
                                    </div>
                                </c:if>

                                <!-- 공지사항 데이터가 없을 경우 -->
                                <c:if test="${empty notices}">
                                    <p>현재 조회 가능한 공지사항이 없습니다.</p>
                                </c:if>
                            </div>
                        </div>
                        <!-- /Content -->
                    </div>
                </div>
                <!-- /Main Content -->
            </div>
        </div>
    </section>

    <!-- Footer -->
    <jsp:include page="../footer.jsp"></jsp:include>

    <!-- ========================= scroll-top ========================= -->
    <a href="#" class="scroll-top">
        <i class="lni lni-chevron-up"></i>
    </a>

    <!-- ========================= JS here ========================= -->
    <script src="/resources/assets/user/js/bootstrap.min.js"></script>
    <script src="/resources/assets/user/js/tiny-slider.js"></script>
    <script src="/resources/assets/user/js/glightbox.min.js"></script>
    <script src="/resources/assets/user/js/main.js"></script>
</body>

</html>
