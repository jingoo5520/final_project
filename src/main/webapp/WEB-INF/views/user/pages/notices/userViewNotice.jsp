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
						<h1 class="page-title">공지사항</h1>
					</div>
				</div>
				<div class="col-lg-6 col-md-6 col-12">
					<ul class="breadcrumb-nav">
						<li><a href="/"><i class="lni lni-home"></i> Home</a></li>
						<li><a href="/serviceCenter/inquiries">Service Center</a></li>
						<li>공지사항</li>
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
						
                <div id="noticeTableBody" class="row cart-list-title">
                    <c:choose>
                        <c:when test="${not empty notices}">
                            <c:forEach var="notice" items="${notices}">
                                <div class="col-lg-12 col-md-12 col-12 mb-4">
                                    <div id="notice-row-${notice.notice_no}" class="card border-primary">
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-lg-2 col-md-2 col-12">
                                                    <p class="card-text">${notice.notice_no}</p>
                                                </div>
                                                <div class="col-lg-6 col-md-6 col-12">
                                                    <h5 class="card-title">
                                                        <a href="/serviceCenter/noticeDetail/${notice.notice_no}">${notice.notice_title}</a>
                                                    </h5>
                                                </div>
                                                <div class="col-lg-2 col-md-2 col-12">
                                                    <p class="card-text">${notice.admin_id}</p>
                                                </div>
                                                <div class="col-lg-2 col-md-2 col-12">
                                                   <p class="card-text regDate" data-reg-date="${notice.reg_date}"></p>
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
<div class="pagination center">
    <ul class="pagination-list d-flex justify-content-center">
    <!-- 이전 페이지 버튼 -->
        <c:choose>
            <c:when test="${pi.pageNo == 1}">
                <li class="page-item prev disabled"><a class="page-link" href="javascript:void(0)"><i class="lni lni-chevron-left"></i></a></li>
            </c:when>
            <c:otherwise>
                <li class="page-item prev"><a class="page-link" href="javascript:void(0)" onclick="showUserNoticeList(${pi.pageNo - 1})"><i class="lni lni-chevron-left"></i></a></li>
            </c:otherwise>
        </c:choose>
<!-- 페이지 번호 출력 -->
        <c:forEach var="i" begin="${pi.startPageNoCurBlock}" end="${pi.endPageNoCurBlock}">
            <c:choose>
                <c:when test="${pi.pageNo == i}">
                    <li class="page-item active"><a class="page-link" href="javascript:void(0)">${i}</a></li>
                </c:when>
                <c:otherwise>
                    <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="showUserNoticeList(${i})">${i}</a></li>
                </c:otherwise>
            </c:choose>
        </c:forEach>
<!-- 다음 페이지 버튼 -->
        <c:choose>
            <c:when test="${pi.pageNo == pi.totalPageCnt}">
                <li class="page-item disabled"><a class="page-link" href="javascript:void(0)"><i class="lni lni-chevron-right"></i></a></li>
            </c:when>
            <c:otherwise>
                <li class="page-item next"><a class="page-link" href="javascript:void(0)" onclick="showUserNoticeList(${pi.pageNo + 1})"><i class="lni lni-chevron-right"></i></a></li>
            </c:otherwise>
        </c:choose>
    </ul>
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
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {
    const dateElements = document.querySelectorAll(".regDate");
    
    dateElements.forEach(function(element) {
        const originalDate = element.getAttribute("data-reg-date");
        
        if (originalDate) {
            // 날짜만 추출
            const formattedDate = originalDate.split("T")[0]; // 형식: "2024-11-14"
            element.textContent = formattedDate;
        }
    });
});

function showUserNoticeList(pageNo, pagingSize){
	$.ajax({
        url: '/serviceCenter/notice/getNotices',
        type: 'GET',
        dataType : 'json',
        data: {
            pageNo: pageNo
        },
        success: function(response) {
        	console.log(response);
        	
            // 공지사항 목록 업데이트
			let tableRows = '';
			$.each(response.list, function(index, notice) {
				console.log(response.list);
        	console.log(`\${notice.notice_no}`);
        	console.log(`\${notice.notice_title}`);
        	console.log(`\${notice.admin_id}`);
        	console.log(`\${notice.formatted_reg_date}`);
        	console.log(`notice-row-\${notice.notice_no}`);
            tableRows += `
                <div id="notice-row-\${notice.notice_no}" class="card border-primary mb-3">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-lg-2 col-md-2 col-12">
                                <p class="card-text">\${notice.notice_no}</p>
                            </div>
                            <div class="col-lg-6 col-md-6 col-12">
                                <h5 class="card-title">
                                    <a href="/serviceCenter/noticeDetail/\${notice.notice_no}">\${notice.notice_title}</a>
                                </h5>
                            </div>
                            <div class="col-lg-2 col-md-2 col-12">
                                <p class="card-text">\${notice.admin_id}</p>
                            </div>
                            <div class="col-lg-2 col-md-2 col-12">
                                <p class="card-text regDate">\${notice.formatted_reg_date}</p>
                            </div>
                        </div>
                    </div>
                </div>
            `;
        });
//             console.log(response.list[0]);
            console.log(tableRows);
            
            $("#noticeTableBody").html(tableRows);
            // 페이지네이션 업데이트
            updatePagination(response.pi);
        },
        error: function() {
            alert('공지사항 목록을 불러오는 데 실패했습니다.');
        }
    });
}

function updatePagination(pi) {
	console.log(pi);
    // 페이지네이션 업데이트 처리 (응답에 따른 페이지 버튼 생성)
    let pagination = '';
    
	// 이전 버튼
	if (pi.pageNo > 1) {
	    pagination += `
	        <li class="page-item prev">
	            <a class="page-link" href="javascript:void(0);" onclick="showUserNoticeList('${pi.pageNo - 1}', '${pi.viewDataCntPerPage}')">
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
		console.log(pi.pageNo === i);
		console.log(`\${i}`);
	    if (pi.pageNo === i) {
	        pagination += `
	            <li class="page-item active">
	                <a class="page-link" href="javascript:void(0);">\${i}</a>
	            </li>`;
	    } else {
	        pagination += `
	            <li class="page-item">
	                <a class="page-link" href="javascript:void(0);" onclick="showUserNoticeList(\${i}, '${pi.viewDataCntPerPage}')">\${i}</a>
	            </li>`;
	    }
	}
	
	// 다음 버튼
	if (pi.pageNo < pi.totalPageCnt) {
	    pagination += `
	        <li class="page-item next">
	            <a class="page-link" href="javascript:void(0);" onclick="showUserNoticeList('${pi.pageNo + 1}', '${pi.viewDataCntPerPage}')">
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
    console.log(pagination);
    $(".pagination-list").html(pagination);
}

</script>
</html>