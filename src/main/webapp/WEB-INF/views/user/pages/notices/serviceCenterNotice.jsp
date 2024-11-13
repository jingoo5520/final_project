<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html class="no-js" lang="zxx">

<head>
<meta charset="utf-8" />
<meta http-equiv="x-ua-compatible" content="ie=edge" />
<title>공지사항</title>
<meta name="description" content="" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="shortcut icon" type="image/x-icon"
	href="/resources/assets/user/images/logo/white-logo.svg" />
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
	<!-- Preloader -->
	<div class="preloader">
		<div class="preloader-inner">
			<div class="preloader-icon">
				<span></span>
				<span></span>
			</div>
		</div>
	</div>
	<!-- /End Preloader -->

	<jsp:include page="/WEB-INF/views/user/pages/header.jsp"></jsp:include>

	<!-- Start Breadcrumbs -->
	<div class="breadcrumbs">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-lg-6 col-md-6 col-12">
					<div class="breadcrumbs-content">
						<h1 class="page-title">Shop Grid</h1>
					</div>
				</div>
				<div class="col-lg-6 col-md-6 col-12">
					<ul class="breadcrumb-nav">
						<li><a href="index.html"><i class="lni lni-home"></i> Home</a></li>
						<li><a href="javascript:void(0)">Shop</a></li>
						<li>Shop Grid</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- End Breadcrumbs -->
	
		<section class="product-grids section">
		<div class="container">
			<div class="row">
				<!-- sideBar -->
				<jsp:include page="/WEB-INF/views/user/pages/serviceCenterSideBar.jsp">

					<jsp:param name="pageName" value="notices" />

				</jsp:include>
				<!-- / sideBar -->

				<div class="col-lg-9 col-12">
					<!-- Shopping Cart -->
					<div class="cart-list-head" style="border: none">
						<div class="cart-list-title">
							<h5>공지사항</h5>
						</div>
						<!-- Cart List Title -->
						<div class="cart-list-title">
							<div class="row">
								<div class="col-lg-2 col-md-2 col-12">
									<p>번호</p>
								</div>
								<div class="col-lg-6 col-md-6 col-12">
									<p>제목</p>
								</div>
								<div class="col-lg-2 col-md-2 col-12">
									<p>작성자</p>
								</div>
								<div class="col-lg-2 col-md-2 col-12">
									<p>작성일자</p>
								</div>
							</div>
						</div>
						<!-- End Cart List Title -->
						
<div id="noticeList" class="row">
                            <c:choose>
                                <c:when test="${not empty notices}">
                                    <c:forEach var="notice" items="${notices}">
                                        <div class="col-lg-12 col-md-12 col-12 mb-4">
                                            <div class="card border-primary">
                                                <div class="card-body">
                                                    <div class="row">
                                                        <div class="col-lg-2 col-md-2 col-12">
                                                            <p class="card-text">${notice.notice_no}</p>
                                                        </div>
                                                        <div class="col-lg-6 col-md-6 col-12">
                                                            <h5 class="card-title">
                                                                <a href="userViewNoticeDetail/${notice.notice_no}">${notice.notice_title}</a>
                                                            </h5>
                                                        </div>
                                                        <div class="col-lg-2 col-md-2 col-12">
                                                            <p class="card-text">${notice.admin_id}</p>
                                                        </div>
                                                        <div class="col-lg-2 col-md-2 col-12">
                                                            <p class="card-text">${notice.reg_date}</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="col-lg-12 col-md-12 col-12">
                                        <div class="alert alert-warning" role="alert">
                                            등록된 공지사항이 없습니다.
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- 페이지네이션 -->
                        <div class="pagination center">
                            <ul class="pagination-list d-flex justify-content-center">
                                <c:choose>
                                    <c:when test="${inquiryData.pi.pageNo == 1}">
                                        <li class="disabled"><a href="javascript:void(0)"><i class="lni lni-chevron-left"></i></a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li><a href="javascript:void(0)" onclick="showInquiryList(${inquiryData.pi.pageNo - 1})"><i class="lni lni-chevron-left"></i></a></li>
                                    </c:otherwise>
                                </c:choose>

                                <c:forEach var="i" begin="${inquiryData.pi.startPageNoCurBloack}" end="${inquiryData.pi.endPageNoCurBlock}">
                                    <c:choose>
                                        <c:when test="${inquiryData.pi.pageNo == i}">
                                            <li class="active"><a href="javascript:void(0)">${i}</a></li>
                                        </c:when>
                                        <c:otherwise>
                                            <li><a href="javascript:void(0)" onclick="showInquiryList(${i})">${i}</a></li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>

                                <c:choose>
                                    <c:when test="${inquiryData.pi.pageNo == inquiryData.pi.totalPageCnt}">
                                        <li class="disabled"><a href="javascript:void(0)"><i class="lni lni-chevron-right"></i></a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li><a href="javascript:void(0)" onclick="showInquiryList(${inquiryData.pi.pageNo + 1})"><i class="lni lni-chevron-right"></i></a></li>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>


	<jsp:include page="/WEB-INF/views/user/pages/footer.jsp"></jsp:include>

	<!-- ========================= scroll-top ========================= -->
	<a href="#" class="scroll-top"> <i class="lni lni-chevron-up"></i>
	</a>

	<!-- ========================= JS here ========================= -->
	<script src="/resources/assets/user/js/bootstrap.min.js"></script>
	<script src="/resources/assets/user/js/tiny-slider.js"></script>
	<script src="/resources/assets/user/js/glightbox.min.js"></script>
	<script src="/resources/assets/user/js/main.js"></script>
</body>

</html>