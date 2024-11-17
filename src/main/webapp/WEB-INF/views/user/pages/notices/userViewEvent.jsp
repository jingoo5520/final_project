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
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- ========================= CSS here ========================= -->
    <link rel="stylesheet"
        href="/resources/assets/user/css/bootstrap.min.css" />
    <link rel="stylesheet"
        href="/resources/assets/user/css/LineIcons.3.0.css" />
    <link rel="stylesheet" href="/resources/assets/user/css/tiny-slider.css" />
    <link rel="stylesheet"
        href="/resources/assets/user/css/glightbox.min.css" />
    <link rel="stylesheet" href="/resources/assets/user/css/main.css" />
  <style>
    .card-img-top {
      width: 400px;
      height: 400px; /* 이미지 높이 설정 */
      object-fit: cover; /* 이미지 비율 유지하면서 잘림 */
    }
  </style>
</head>

<body>

    <jsp:include page="../header.jsp"></jsp:include>
    <!-- / Content -->
    
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
						<li>이벤트</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- End Breadcrumbs -->

<section class="product-grids section">
<div class="container mt-3">
  <div class="row">
    <c:choose>
      <c:when test="${not empty events}">
        <c:forEach var="event" items="${events}">
          <div class="col-md-4 mb-4">
            <div class="card" style="width: 400px;">
              <c:choose>
                <c:when test="${not empty event.thumbnail_image}">
                <a href="eventDetail/${event.notice_no}">
                  <img class="card-img-top" src="${pageContext.request.contextPath}${event.thumbnail_image}" alt="${event.notice_title} 이미지">
                </a>
                </c:when>
                <c:otherwise>
                <a href="/eventDetail/${event.notice_no}">
                  <img class="card-img-top" src="${pageContext.request.contextPath}/resources/images/noP_image.png" alt="기본 이미지">
                </a>
                </c:otherwise>
              </c:choose>
            </div>
          </div>
        </c:forEach>
      </c:when>
      <c:otherwise>
        <div class="col-12">
          <div class="alert alert-warning" role="alert">등록된 이벤트가 없습니다.</div>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
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
            </div>
            </section>

    <!-- Start Breadcrumbs -->
    <jsp:include page="../footer.jsp"></jsp:include>

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
