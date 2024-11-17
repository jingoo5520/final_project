<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html class="no-js" lang="zxx">

<head>
<meta charset="utf-8" />
<meta http-equiv="x-ua-compatible" content="ie=edge" />
<title>ELOLIA</title>
<meta name="description" content="" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="shortcut icon" type="image/x-icon" href="/resources/assets/user/images/logo/favicon.png" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- ========================= CSS here ========================= -->
<link rel="stylesheet"
	href="/resources/assets/user/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="/resources/assets/user/css/LineIcons.3.0.css" />
<link rel="stylesheet" href="/resources/assets/user/css/tiny-slider.css" />
<link rel="stylesheet"
	href="/resources/assets/user/css/glightbox.min.css" />
<link rel="stylesheet" href="/resources/assets/user/css/main.css" />

</head>
<body>
    <jsp:include page="../header.jsp"></jsp:include>
    
    <!-- Start Breadcrumbs -->
	<div class="breadcrumbs">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-lg-6 col-md-6 col-12">
					<div class="breadcrumbs-content">
						<h1 class="page-title">이벤트</h1>
					</div>
				</div>
				<div class="col-lg-6 col-md-6 col-12">
					<ul class="breadcrumb-nav">
						<li><a href="/"><i class="lni lni-home"></i> Home</a></li>
						<li><a href="/event">이벤트</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- End Breadcrumbs -->

<section class="product-grids section">
    <div class="layout-page">
        <nav class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme" id="layout-navbar">
            <div class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none">
                <a class="nav-item nav-link px-0 me-xl-4" href="javascript:void(0)">
                    <i class="bx bx-menu bx-sm"></i>
                </a>
            </div>
        </nav>

        <div class="content-wrapper">
            <div class="container-xxl flex-grow-1 container-p-y">

				<c:if test="${not empty event}">
				    <div class="card">
				        <div class="card-header">
				            <h5 class="card-title"><c:out value="${event.notice_title}"/></h5>
				            <p class="card-text">작성자: <c:out value="${event.admin_id}"/> | 
				                <c:choose>
							        <c:when test="${not empty event.event_start_date and not empty event.event_end_date}">
							            이벤트 기간 : ${fn:replace(event.event_start_date, 'T', ' ')} ~ ${fn:replace(event.event_end_date, 'T', ' ')}
							        </c:when>
							        <c:otherwise>
							            이벤트 기간 : 상시
							        </c:otherwise>
							    </c:choose>
							    </p>
				        </div>
				        <div class="card-body">
				            <p class="card-text">${event.notice_content}</p>
				        </div>
				        <div style="transform: translate(15px, -10px);">
				            <a class="btn rounded-pill btn-outline-secondary" href="/event">목록으로 돌아가기</a>
				        </div>
				    </div>
				</c:if>
				<c:if test="${empty event}">
				    <p>이벤트를 찾을 수 없습니다.</p>
				</c:if>

            </div>
        </div>
    </div>
    </section>

    <!-- Start Breadcrumbs -->
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