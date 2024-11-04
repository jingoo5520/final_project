<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html class="no-js" lang="zxx">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <title>이벤트</title>
    <meta name="description" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="shortcut icon" type="image/x-icon"
        href="/resources/assets/user/images/logo/white-logo.svg" />
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

<div class="container mt-3">
  <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">공지 /</span> 이벤트 목록</h4>
  <div class="row">
    <c:choose>
      <c:when test="${not empty events}">
        <c:forEach var="event" items="${events}">
          <div class="col-md-4 mb-4">
            <div class="card" style="width: 400px;">
              <c:choose>
                <c:when test="${not empty event.thumbnail_image}">
                <a href="userViewEventDetail/${event.notice_no}">
                  <img class="card-img-top" src="${pageContext.request.contextPath}${event.thumbnail_image}" alt="${event.notice_title} 이미지">
                </a>
                </c:when>
                <c:otherwise>
                <a href="userViewEventDetail/${event.notice_no}">
                  <img class="card-img-top" src="${pageContext.request.contextPath}/no_image.jpg" alt="기본 이미지">
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
		<p>현재 페이지: ${currentPage != null ? currentPage : 'N/A'} / 총 페이지: ${totalPages != null ? totalPages : 'N/A'}</p>
		<div class="pagination">
		    <c:if test="${currentPage > 1}">
		        <a href="?page=${currentPage - 1}">이전</a>
		    </c:if>
		    
		    <c:if test="${totalPages > 0}">
		        <c:forEach var="i" begin="1" end="${totalPages}">
		            <c:choose>
		                <c:when test="${i == currentPage}">
		                    <span>${i}</span> <!-- 현재 페이지는 그냥 숫자 표시 -->
		                </c:when>
		                <c:otherwise>
		                    <a href="?page=${i}">${i}</a>
		                </c:otherwise>
		            </c:choose>
		        </c:forEach>
		    </c:if>
		
		    <c:if test="${currentPage < totalPages}">
		        <a href="?page=${currentPage + 1}">다음</a>
		    </c:if>
		</div>
                </div>
              </div>
		 </div>
		 </div>
            </div>

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
