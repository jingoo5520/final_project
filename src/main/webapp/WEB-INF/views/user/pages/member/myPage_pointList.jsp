<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html class="no-js" lang="zxx">

<head>
<meta charset="utf-8" />
<meta http-equiv="x-ua-compatible" content="ie=edge" />
<title>ELOLIA</title>
<meta name="description" content="" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="shortcut icon" type="image/x-icon" href="/resources/assets/user/images/logo/favicon.png" />

<!-- ========================= CSS here ========================= -->
<link rel="stylesheet" href="/resources/assets/user/css/bootstrap.min.css" />
<link rel="stylesheet" href="/resources/assets/user/css/LineIcons.3.0.css" />
<link rel="stylesheet" href="/resources/assets/user/css/tiny-slider.css" />
<link rel="stylesheet" href="/resources/assets/user/css/glightbox.min.css" />
<link rel="stylesheet" href="/resources/assets/user/css/main.css" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script>
	$(document).ready(function() {
		getPointInfo();
		getPagingInfo("earned");
	});

	function getPointInfo() {
		
		$.ajax({
			async: false,
			type: 'GET',
			url: '/member/myPage/getPointInfo',
			dataType: 'json',
	        success : function(response) {
	        	showMemberPoints(response);
	        },
	        error : function(response) {
	        }
		})
		
	}
	
	function showMemberPoints(data) {
		console.log(data);
		let memberPoint = data.memberPoint.toLocaleString('ko-KR');
		let usePoint = data.usePoint.toLocaleString('ko-KR');
		
		let memberPointOutput = `<h3>총 보유 포인트 : \${memberPoint } P</h3>`;
		let usePointOutput = `<h3>총 사용한 포인트 : \${usePoint } P</h3>`;
		
		$("#memberPoint").html(memberPointOutput);
		$("#usePoint").html(usePointOutput);
	}
	
	function getPagingInfo(pointType) {
		if (pointType == "earned") {
			
			$.ajax({
				async: false,
				type: 'POST',
				contentType: 'text/plain',
				data: pointType, 
				url: '/member/myPage/getPointPagingInfo',
				dataType: 'json',
		        success : function(response) {
		        	makePaging(response.totalPageCount);
		        },
		        error : function(response) {
		        }
			});
		}
	}
	
	function makePaging(totalPage) {
		console.log(totalPage);
		let output = "";
		
		for (let i = 0; i < totalPage; i++) {
			if (i == 0) {
				output += `<div class="pages active">\${i + 1}</div>`;
			} else {
				output += `<div class="pages">\${i + 1}</div>`;
			}
		}
		$("#earnedPagination").html(output);
	}

</script>

</head>

<style>
	

	.tab-content {
		max-width: 800px;
		margin-left: 50px;
	}

	.pointHeader {
		font-size : 18px;
		height:50px;
		padding: 14px;
		margin:12px;
	}
	
	#usePoint h3 {
		color: #FD5A67;
	}
	
	#usePoint, #memberPoint {
		display: flex;
		justify-content: center;
	}
	
	#nav-tab, .nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active {
		border:none;
	}
	
	#nav-tab, .nav-tabs {
		margin-left: 50px;
	}
	
	.pointList {
		padding: 14px;
		border: 1px solid #eee;
		border-radius: 4px;
		padding-bottom: 50px;
	}
	
	#nav-tab {
		height: 51px;
		padding: 9px;
	}
	
	#nav-tab button {
		font-size: 18px;
		padding: 0;
	}
	
	#nav-tab .active{
		color: #222222 !important;
	}
	
	#nav-tab .nav-link {
		color: #888888;
		font-weight: bold;
	}
	
	#earnedPointList-tab {
		margin-right: 10px;
	}
	
	#usedPointList-tab {
		margin-left: 10px;
	}
	
	#nav-tabContent {
		border-top: 1px solid #e6e6e6;
		padding-top: 20px;
	}
	
	.pointList {
		background-color: #FFFFFF !important;
	}
	
	.sortButton .sortBtn {
		padding: 0;
		height: 30px;
		line-height: 30px;
		cursor: pointer;
		display:flex;
		justify-content: center;
		border: 1px solid #e6e6e6;
		border-radius: 4px;
	}
	
	.sortButton {
		display: flex;
		justify-content: right;
		margin: 20px 20px !important;
	}
	
	.pagination {
		display: flex !important;
		flex-direction: row !important;
		gap: 10px !important;
		justify-content: center !important;
		align-items:center !important;
	}
	
	.pages {
		width: 40px;
		height: 21px;
		background-color: #FFFFFF;
		color: #222222;
		cursor: pointer;
		display: flex;
		align-items: center;
		justify-content: center;
		transition: background-color 0.3s;
		border-radius: 4px;
	}
	
	.pages.active,
	.sortButton .sortBtn.active {
		background-color: #A8A691;
		color: #FFFFFF;
	}
	
	.pointInfo {
		display: flex !important;
		flex-direction: row !important;
		justify-content: space-between !important;
		margin: 0 20px;
	}
	
	.earnedReason, .earnedPoint, .eranedDate {
	}
	
	.pointInfoHead {
		margin: 20px 10px;
		color: #222222;
		font-weight: bold;
		padding: 8px 26px;
		font-size: 18px;
		display:flex;
		display: flex;
		flex-direction: row;
		justify-content: space-between;
	}
	
	.sortButton {
		margin: 10px 0;
	}
	
</style>

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
						<h1 class="page-title">포인트 내역</h1>
					</div>
				</div>
				<div class="col-lg-6 col-md-6 col-12">
					<ul class="breadcrumb-nav">
						<li><a href="/"><i class="lni lni-home"></i> Home</a></li>
						<li><a href="/member/myPage/viewOrder">MyPage</a></li>
						<li>포인트 내역</li>
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
				<jsp:include page="/WEB-INF/views/user/pages/myPageSideBar.jsp">

					<jsp:param name="pageName" value="pointList" />

				</jsp:include>
				<!-- / sideBar -->

				<div class="col-lg-9 col-12">
					<div class="pointList">
						<nav>
							<div class="nav nav-tabs" id="nav-tab" role="tablist">
								<button class="nav-link active" id="earnedPointList-tab" data-bs-toggle="tab" data-bs-target="#earnedPointList" type="button" role="tab" aria-controls="earnedPointList" aria-selected="true" onclick="getEarnedPointList()">적립포인트 내역</button>
								<button class="nav-link" id="usedPointList-tab" data-bs-toggle="tab" data-bs-target="#usedPointList" type="button" role="tab" aria-controls="usedPointList" aria-selected="false" onclick="getUsedPointList()">사용포인트 내역</button>
							</div>
						</nav>
						<div class="tab-content" id="nav-tabContent">
							<div class="tab-pane fade show active" id="earnedPointList" role="tabpanel" aria-labelledby="earnedPointList-tab" tabindex="0">
								<div class="pointInfoHead">
									<div>포인트 (지급사유)</div>
									<div>지급날짜</div>
								</div>
								<div class="row sortButton">
									<div class="sortBtn active col-lg-1 col-md-1 col-12">최신순</div>
									<div class="sortBtn col-lg-1 col-md-1 col-12">적립일순</div>
								</div>
								<div class="earnedPointList-body">
									<div class="pointInfoBody">
										<ul class="list-group list-group-flush">
											<li class="list-group-item pointInfo">
												<div class="earnedPoint">+29,349P (상품구매)</div>
												<div class="eranedDate">2024-11-13</div>
											</li>
											<li class="list-group-item pointInfo">
												<div class="earnedPoint">+29,349P (상품구매)</div>
												<div class="eranedDate">2024-11-13</div>
											</li>
											<li class="list-group-item pointInfo">
												<div class="earnedPoint">+29,349P (상품구매)</div>
												<div class="eranedDate">2024-11-13</div>
											</li>
											<li class="list-group-item pointInfo">
												<div class="earnedPoint">+29,349P (상품구매)</div>
												<div class="eranedDate">2024-11-13</div>
											</li>
											<li class="list-group-item pointInfo">
												<div class="earnedPoint">+29,349P (상품구매)</div>
												<div class="eranedDate">2024-11-13</div>
											</li>
											<li class="list-group-item pointInfo">
												<div class="earnedPoint">+29,349P (상품구매)</div>
												<div class="eranedDate">2024-11-13</div>
											</li>
											<li class="list-group-item pointInfo">
												<div class="earnedPoint">+29,349P (상품구매)</div>
												<div class="eranedDate">2024-11-13</div>
											</li>
											<li class="list-group-item pointInfo">
												<div class="earnedPoint">+29,349P (상품구매)</div>
												<div class="eranedDate">2024-11-13</div>
											</li>
											<li class="list-group-item pointInfo">
												<div class="earnedPoint">+29,349P (상품구매)</div>
												<div class="eranedDate">2024-11-13</div>
											</li>
											<li class="list-group-item pointInfo">
												<div class="earnedPoint">+29,349P (상품구매)</div>
												<div class="eranedDate">2024-11-13</div>
											</li>
										</ul>
									</div>
								</div>
								<div class="earnedPointList-footer">
									<div class="pagination" id="earnedPagination">
										<div class="pages active">1</div>
										<div class="pages">2</div>
										<div class="pages">3</div>
										<div class="pages">3</div>
										<div class="pages">3</div>
										<div class="pages">3</div>
										<div class="pages">3</div>
										<div class="pages">3</div>
										<div class="pages">3</div>
									</div>
								</div>
							</div>
							<div class="tab-pane fade" id="usedPointList" role="tabpanel" aria-labelledby="usedPointList-tab" tabindex="0">
								<div class="pointInfoHead">
									<div>포인트</div>
									<div>사용날짜</div>
								</div>
								<div class="row sortButton">
									<div class="sortBtn active col-lg-1 col-md-1 col-12">최신순</div>
									<div class="sortBtn col-lg-1 col-md-1 col-12">사용일순</div>
								</div>
								<div class="usedPointList-body">
									<div class="pointInfoBody">
										<ul class="list-group list-group-flush">
											<li class="list-group-item pointInfo">
												<div class="usedPoint">-29,349P</div>
												<div class="eranedDate">2024-11-13</div>
											</li>
											<li class="list-group-item pointInfo">
												<div class="usedPoint">-29,349P</div>
												<div class="usedDate">2024-11-13</div>
											</li>
											<li class="list-group-item pointInfo">
												<div class="usedPoint">-29,349P</div>
												<div class="usedDate">2024-11-13</div>
											</li>
											<li class="list-group-item pointInfo">
												<div class="usedPoint">-29,349P</div>
												<div class="usedDate">2024-11-13</div>
											</li>
											<li class="list-group-item pointInfo">
												<div class="usedPoint">-29,349P</div>
												<div class="usedDate">2024-11-13</div>
											</li>
											<li class="list-group-item pointInfo">
												<div class="usedPoint">-29,349P</div>
												<div class="usedDate">2024-11-13</div>
											</li>
											<li class="list-group-item pointInfo">
												<div class="usedPoint">-29,349P</div>
												<div class="usedDate">2024-11-13</div>
											</li>
											<li class="list-group-item pointInfo">
												<div class="usedPoint">-29,349P</div>
												<div class="usedDate">2024-11-13</div>
											</li>
											<li class="list-group-item pointInfo">
												<div class="usedPoint">-29,349P</div>
												<div class="usedDate">2024-11-13</div>
											</li>
											<li class="list-group-item pointInfo">
												<div class="usedPoint">-29,349P</div>
												<div class="usedDate">2024-11-13</div>
											</li>
										</ul>
									</div>
								</div>
								<div class="usedPointList-footer">
									<div class="pagination">
										<div class="pages active">1</div>
										<div class="pages">2</div>
										<div class="pages">3</div>
										<div class="pages">3</div>
										<div class="pages">3</div>
										<div class="pages">3</div>
										<div class="pages">3</div>
										<div class="pages">3</div>
										<div class="pages">3</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row pointHeader">
						<div id="memberPoint" class="col-lg-6 col-md-6 col-12">보유 포인트 1000000</div>
						<div id="usePoint" class="col-lg-6 col-md-6 col-12">사용한 포인트 60000</div>
					</div>
				</div>
				
			</div>
		</div>
	</section>

	<jsp:include page="/WEB-INF/views/user/pages/footer.jsp"></jsp:include>
	
	<!-- ========================= scroll-top ========================= -->
	<a href="#" class="scroll-top"> <i class="lni lni-chevron-up"></i></a>

	<!-- ========================= JS here ========================= -->
	<script src="/resources/assets/user/js/bootstrap.min.js"></script>
	<script src="/resources/assets/user/js/tiny-slider.js"></script>
	<script src="/resources/assets/user/js/glightbox.min.js"></script>
	<script src="/resources/assets/user/js/main.js"></script>
</body>

</html>