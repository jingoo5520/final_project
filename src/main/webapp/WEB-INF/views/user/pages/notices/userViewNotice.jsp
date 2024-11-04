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

	<jsp:include page="../header.jsp"></jsp:include>
				<!-- / Content -->

               <div class="container-xxl flex-grow-1 container-p-y">
              <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">공지 /</span> 공지사항 목록</h4>

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
                          <th>제목</th>
                          <th>작성자</th>
                          <th>작성일자</th>
                        </tr>
                      </thead>
                      <tbody>
	                      <c:choose>
	                        <c:when test="${not empty notices}">
								<c:forEach var="notice" items="${notices}">
								    <tr id="notice-row-${notice.notice_no}">
								        <td>${notice.notice_no}</td>
								        <td><a href="userViewNoticeDetail/${notice.notice_no}">${notice.notice_title}</a></td>
								        <td>${notice.admin_id}</td>
								        <td>${notice.reg_date}</td>
									</tr>
								</c:forEach>
	                        </c:when>
	                        <c:otherwise>
	                        	<tr>
	                            	<td colspan="4">등록된 공지사항이 없습니다.</td>
	                            </tr>
							</c:otherwise>
	                      </c:choose>
                      </tbody>
                    </table>
                    
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
            <!-- / Content -->
<!--     <h2>공지사항</h2> -->
<!--     <form action="/notice" method="get"> -->
<!--         <table border="1"> -->
<!--             <thead> -->
<!--                 <tr> -->
<!--                     <th>번호</th> -->
<!--                     <th>제목</th> -->
<!--                     <th>작성일</th> -->
<!--                     <th>상세보기</th> -->
<!--                 </tr> -->
<!--             </thead> -->
<!--             <tbody> -->
<%-- 				<c:forEach var="notice" items="${noticeList}"> --%>
<!-- 				    <div> -->
<%-- 				        <h3>${notice.notice_title}</h3> --%>
<%-- 				        <div>${notice.notice_content}</div> --%>
<%-- 				        <p>등록일: ${notice.reg_date}</p> --%>
<%-- 				        <p>관리자: ${notice.admin_id}</p> --%>
<!-- 				    </div> -->
<%-- 				</c:forEach> --%>
<!--             </tbody> -->
<!--         </table> -->
<!--     </form> -->

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