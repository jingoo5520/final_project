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
  <tbody id="eventTableBody">
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
  </tbody>
</div>
<div class="pagination center">
    <ul class="pagination-list d-flex justify-content-center">
    <!-- 이전 페이지 버튼 -->
        <c:choose>
            <c:when test="${pi.pageNo == 1}">
                <li class="disabled"><a href="javascript:void(0)"><i class="lni lni-chevron-left"></i></a></li>
            </c:when>
            <c:otherwise>
                <li><a href="javascript:void(0)" onclick="showUserEventList(${pi.pageNo - 1})"><i class="lni lni-chevron-left"></i></a></li>
            </c:otherwise>
        </c:choose>
<!-- 페이지 번호 출력 -->
        <c:forEach var="i" begin="${pi.startPageNoCurBlock}" end="${pi.endPageNoCurBlock}">
            <c:choose>
                <c:when test="${pi.pageNo == i}">
                    <li class="active"><a href="javascript:void(0)">${i}</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="javascript:void(0)" onclick="showUserEventList(${i})">${i}</a></li>
                </c:otherwise>
            </c:choose>
        </c:forEach>
<!-- 다음 페이지 버튼 -->
        <c:choose>
            <c:when test="${pi.pageNo == pi.totalPageCnt}">
                <li class="disabled"><a href="javascript:void(0)"><i class="lni lni-chevron-right"></i></a></li>
            </c:when>
            <c:otherwise>
                <li><a href="javascript:void(0)" onclick="showUserEventList(${pi.pageNo + 1})"><i class="lni lni-chevron-right"></i></a></li>
            </c:otherwise>
        </c:choose>
    </ul>
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
<script type="text/javascript">
function showUserEventList(pageNo, pagingSize) {
    $.ajax({
        url: "/event/getEvents",
        type: "GET",
        dataType : 'json',
        data: { pageNo: pageNo },
        success: function(response) {
            // 이벤트 목록 업데이트
            console.log(response);
            
            let eventList = '';
            $.each(response.list, function(index, event){
                let imgSrc = event.thumbnail_image 
                ? `${event.thumbnail_image}` 
                : "/resources/images/noP_image.png";  // 기본 이미지
                // 이벤트 카드 HTML 구성
                eventList += `
                    <div id="eventList-row-${event.notice_no}" class="col-md-4 mb-4">
                        <div class="card" style="width: 400px;">
                            <a href="/eventDetail/${event.notice_no}">
                                <img class="card-img-top" src="${event.thumbnail_image}" alt="${event.notice_title} 이미지">
                            </a>
                            <div class="card-body">
                                <h5 class="card-title">${event.notice_title}</h5>
                                <p class="card-text">${event.notice_description || "설명이 없습니다."}</p>
                            </div>
                        </div>
                    </div>
                `;
            });
            console.log(response.list[0]);
            console.log(eventList);
            
            $("#eventTableBody").html(eventList);
            // 페이지네이션 업데이트
            updatePagination(response.pi);
        },
        error: function() {
            alert("이벤트 목록을 가져오는 데 실패했습니다.");
        }
    });
}

function updatePagination(pi) {
    // 페이지네이션 업데이트 처리
	let pagination = '';
	
	// 이전 버튼
	if (pi.pageNo > 1) {
	    pagination += `
	        <li class="page-item prev">
	            <a class="page-link" href="javascript:void(0);" onclick="showUserEventList('${pi.pageNo - 1}', '${pi.viewDataCntPerPage}')">
	                <i class="lni lni-chevron-left"></i>
	            </a>
	        </li>`;
	} else {
	    pagination += `
	        <li class="page-item prev disabled">
	            <a class="page-link" href="javascript:void(0);">
	                <i class="lni lni-chevron-left"></i>
	            </a>
	        </li>`;
	}
	
	// 페이지 번호
	for (let i = pi.startPageNoCurBlock; i <= pi.endPageNoCurBlock; i++) {
	    if (pi.pageNo === i) {
	        pagination += `
	            <li class="page-item active">
	                <a class="page-link" href="javascript:void(0);">${i}</a>
	            </li>`;
	    } else {
	        pagination += `
	            <li class="page-item">
	                <a class="page-link" href="javascript:void(0);" onclick="showUserEventList('${i}', '${pi.viewDataCntPerPage}')">${i}</a>
	            </li>`;
	    }
	}
	
	// 다음 버튼
	if (pi.pageNo < pi.totalPageCnt) {
	    pagination += `
	        <li class="page-item next">
	            <a class="page-link" href="javascript:void(0);" onclick="showUserEventList('${pi.pageNo + 1}', '${pi.viewDataCntPerPage}')">
	                <i class="lni lni-chevron-right"></i>
	            </a>
	        </li>`;
	} else {
	    pagination += `
	        <li class="page-item next disabled">
	            <a class="page-link" href="javascript:void(0);">
	                <i class="lni lni-chevron-right"></i>
	            </a>
	        </li>`;
	}
    console.log(pi.pageNo);
    console.log(pi.startPageNoCurBlock);
    console.log(pi.endPageNoCurBlock);
    console.log(pi.totalPageCnt);
    
    // 페이지네이션 HTML을 .pagination에 삽입
    $(".pagination-list").html(pagination);
}

</script>
</html>
