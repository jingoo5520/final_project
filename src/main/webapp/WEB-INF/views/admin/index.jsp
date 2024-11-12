<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


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
<script>
	let cardColor, headingColor, axisColor, shadeColor, borderColor;

	cardColor = config.colors.white;
	headingColor = config.colors.headingColor;
	axisColor = config.colors.axisColor;
	borderColor = config.colors.borderColor;

	$(function() {
		
		$('#regDate_end').val(dateFormat(new Date()));
		
		
		$.ajax({
			url : '/admin/getStatisticData',
			type : 'GET',
			dataType : 'json',
			success : function(data) {
				console.log(data);

				setData(data);
			},
			error : function(error) {
				console.log(error);
			}
		});
		
	});

	function setData(data) {
		setNumberOfMembers(data.memberCnt, data.memberGrowthRate.toFixed(2));
		setNumberOfMembersByGender(data.memberCnt, data.genderList);
		setNumberOfMembersByLevel(data.memberCnt, data.levelList);
	}
	
	// Number of Members
	function setNumberOfMembers(memberCnt, memberGrowthRate){
		$("#memberTotalCnt").text(memberCnt);
		$("#memberGrowthRate").text(memberGrowthRate);
		$("#memberRegCnt").text(memberCnt);
	}
	
	// Number of members by gender
	function setNumberOfMembersByGender(memberCnt, genderList){
		drawNumberOfMembersGragh(memberCnt, genderList, "gender");
		
		let output = ``;
		genderList.forEach(function(item){
			let gender;
			if(item.gender == 'M') {
				gender = 'Male';
			} else if(item.gender == 'F'){
				gender = 'Female';
			} else {
				gender = 'None';
			}
			
			output += `<li class="d-flex mb-4 pb-1">
							<div class="avatar flex-shrink-0 me-3">
							<span class="avatar-initial rounded bg-label-success">
								<i class="bx bx-closet"></i>
							</span>
						</div>
						<div class="d-flex w-100 flex-wrap align-items-center justify-content-between gap-2">
							<div class="me-2">
								<h6 class="mb-0">\${gender}</h6>
							</div>
							<div class="user-progress">
								<small class="fw-semibold">\${item.count}</small>
							</div>
						</div>
					</li>`
		});
		
		$("#genderList").html(output);
	}
	
	// Number of members by level
	function setNumberOfMembersByLevel(memberCnt, levelList){
		drawNumberOfMembersGragh(memberCnt, levelList, "level");
		
		let output = ``;
		levelList.forEach(function(item){
			let level;
			if(item.member_level == 1) {
				level = 'Bronze';
			} else if(item.member_level == 2){
				level = 'Silver';
			} else if(item.member_level == 3){
				level = 'Gold';
			} else {
				level = 'Diamond';
			}
			
			output += `<li class="d-flex mb-4 pb-1">
							<div class="avatar flex-shrink-0 me-3">
							<span class="avatar-initial rounded bg-label-success">
								<i class="bx bx-closet"></i>
							</span>
						</div>
						<div class="d-flex w-100 flex-wrap align-items-center justify-content-between gap-2">
							<div class="me-2">
								<h6 class="mb-0">\${level}</h6>
							</div>
							<div class="user-progress">
								<small class="fw-semibold">\${item.count}</small>
							</div>
						</div>
					</li>`
		});
		
		$("#levelList").html(output);
	}
	
	// Number of members by gender 그래프 그리기
	function drawNumberOfMembersGragh(memberCnt, list, type) {
		let chart;
		let labels = [];
		let series = [];
		
		if(type == 'gender'){
			chart = document.querySelector('#numberOfMembersByGenderChart');
			
			list.forEach(function(item){
				labels.push(item.gender);	
				series.push(parseFloat((item.count / memberCnt * 100).toFixed(2)));
			});
		} else if(type == 'level'){
			chart = document.querySelector('#numberOfMembersByLevelChart');
			
			list.forEach(function(item){
				labels.push(item.member_level);	
				series.push(parseFloat((item.count / memberCnt * 100).toFixed(2)));
			});
		}
		
		
		console.log(labels);
		console.log(series);
			
		console.log(chart);
		
		const chartOrderStatistics = chart, orderChartConfig = {
			chart : {
				height : 165,
				width : 130,
				type : 'donut'
			},
			labels : labels,
			series : series,
			colors : [ config.colors.primary, config.colors.secondary,
					config.colors.info, config.colors.success ],
			stroke : {
				width : 5,
				colors : cardColor
			},
			dataLabels : {
				enabled : false,
				formatter : function(val, opt) {
					return parseInt(val) + '%';
				}
			},
			legend : {
				show : false
			},
			grid : {
				padding : {
					top : 0,
					bottom : 0,
					right : 15
				}
			},
			plotOptions : {
				pie : {
					donut : {
						size : '75%',
						labels : {
							show : true,
							value : {
								fontSize : '1.5rem',
								fontFamily : 'Public Sans',
								color : headingColor,
								offsetY : -15,
								formatter : function(val) {
									return parseInt(val) + '%';
								}
							},
							name : {
								offsetY : 20,
								fontFamily : 'Public Sans'
							},
							total : {
								show : true,
								fontSize : '0.8125rem',
								color : axisColor,
								label : 'select',
								formatter : function(w) {
									return '0%';
								}
							}
						}
					}
				}
			}
		};
		if (typeof chartOrderStatistics !== undefined
				&& chartOrderStatistics !== null) {
			const statisticsChart = new ApexCharts(chartOrderStatistics,
					orderChartConfig);
			statisticsChart.render();
		}
	}
	
	// 가입 회원 수 조회
	function getMemberRegCnt(){
		let regDate_start = $('#regDate_start').val();
		let regDate_end = $('#regDate_end').val();
		
		if(regDate_start == ''){
			regDate_start = "1900-01-01 00:00:00";
		} else {
			regDate_start += " 00:00:00";
		}
		
		if(regDate_end == ''){
			regDate_end = dateFormat(new Date());
			regDate_end += " 23:59:59"; 
		} else {
			regDate_end += " 23:59:59";
		}
		
		console.log(regDate_start);
		console.log(regDate_end);
		
		$.ajax({
			url : '/admin/getMemberRegCnt',
			type : 'GET',
			dataType : 'json',
			data : {
				"regDate_start" : regDate_start,
				"regDate_end" : regDate_end 
			},
			success : function(data) {
				console.log(data);
				
				$("#memberRegCnt").html(data);

			},
			error : function(error) {
				console.log(error);
			}
		});
	}
	
	// 타임스탬프 to date
	function dateFormat(timestamp){
		let date = new Date(timestamp);
		
		let year = date.getFullYear();
		let month = String(date.getMonth() + 1).padStart(2, '0'); 
		let day = String(date.getDate()).padStart(2, '0'); 

	    date = `\${year}-\${month}-\${day}`; // YYYY-MM-DD 형식으로 반환
	    
	    return date;
	}
	
</script>
</head>
<style>

	.card-body {
		max-width: 100% !important; 
	    overflow: hidden !important; 
	}
</style>


<body>
	<!-- Layout wrapper -->
	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">


			<!-- Menu -->

			<jsp:include page="/WEB-INF/views/admin/components/sideBar.jsp">

				<jsp:param name="pageName" value="dashboard" />

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
						<div class="col-lg-6 col-md-6 col-12 mb-4">
							<div class="card">
								<div class="card-body">
									<div class="card-title d-flex align-items-start justify-content-between">
										<div class="avatar flex-shrink-0">
											<img src="/resources/assets/admin/img/icons/unicons/icon_members.png" alt="chart success" class="rounded">
										</div>

										<!-- <div class="dropdown">
											<button class="btn p-0" type="button" id="cardOpt3" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
												<i class="bx bx-dots-vertical-rounded"></i>
											</button>
											<div class="dropdown-menu dropdown-menu-end" aria-labelledby="cardOpt3" style="">
												<a class="dropdown-item" href="javascript:void(0);">View More</a> <a class="dropdown-item" href="javascript:void(0);">Delete</a>
											</div>
										</div> -->
									</div>
									<span class="fw-semibold d-block mb-1">Number of Members</span>
									<h3 id="memberTotalCnt" class="card-title mb-2"></h3>
									<small class="text-success fw-semibold"><i class="bx bx-up-arrow-alt"></i> <span id="memberGrowthRate"></span></small>

									<span class="fw-semibold d-block mt-4">Register date range</span>
									<div class="col align-items-center">
										<div class="form-check-inline">
											<input id="regDate_start" class="form-control regDate" type="date" value="" id="">
										</div>
										<div class="form-check-inline">
											<span class="mx-2">-</span>
										</div>
										<div class="form-check-inline">
											<input id="regDate_end" class="form-control regDate" type="date" value="" id="">
										</div>
										<button id="" type="button" class="btn btn-outline-primary" onclick="getMemberRegCnt()">확인</button>
									</div>

									<span class="fw-semibold d-block mt-2 mb-1">Number of Registered Members</span>
									<h3 id="memberRegCnt" class="card-title mb-2"></h3>
								</div>
							</div>
						</div>

						<!-- Number of members by gender -->
						<div class="col-md-6 col-lg-2 order-0 mb-4">
							<div class="card">
								<div class="card-header d-flex align-items-center justify-content-between pb-0 mb-2">
									<div class="card-title mb-0">
										<h5 class="m-0 me-2">Number of members by gender</h5>
									</div>
								</div>
								<div class="card-body">
									<div class="d-flex justify-content-center align-items-center mb-3">
										<!-- <div class="d-flex flex-column align-items-center gap-1">
											<h2 id="memberTotalCnt2" class="mb-2"></h2>
											<span>Total Members</span>
										</div> -->
										<div id="numberOfMembersByGenderChart"></div>
									</div>
									<ul id="genderList" class="p-0 m-0">

									</ul>
								</div>
							</div>
						</div>
						<!--/ Number of members by gender -->

						<!-- Number of members by level -->
						<div class="col-md-6 col-lg-2 order-0 mb-4">
							<div class="card">
								<div class="card-header d-flex align-items-center justify-content-between pb-0 mb-2">
									<div class="card-title mb-0">
										<h5 class="m-0 me-2">Number of members by level</h5>
									</div>
								</div>
								<div class="card-body">
									<div class="d-flex justify-content-center align-items-center mb-3">
										<!-- <div class="d-flex flex-column align-items-center gap-1">
											<h2 id="memberTotalCnt2" class="mb-2"></h2>
											<span>Total Members</span>
										</div> -->
										<div id="numberOfMembersByLevelChart"></div>
									</div>
									<ul id="levelList" class="p-0 m-0">

									</ul>
								</div>
							</div>
						</div>
						<!--/ Number of members by level -->

					</div>


				</div>
				                    
				<div class="container-xxl flex-grow-1 container-p-y">
				 <!-- Collapse -->
				  <h5>주문 수</h5>
				  <div class="row">
				    <div class="col-12">
				      <div class="card mb-4">
				        <h5 class="card-header">주문 수 통계</h5>
				        <div class="card-body">
				          <p class="card-text">원하는 옵션을 선택하여 주문 수 통계를 확인하세요.</p>
				
				          <!-- Collapse 트리거 버튼들 -->
				          <p class="demo-inline-spacing">
				            <button class="btn btn-primary me-1" type="button" data-bs-toggle="collapse" data-bs-target="#todayOrderCount" aria-expanded="false" aria-controls="todayOrderCount">오늘의 주문 수</button>
				            <button class="btn btn-primary me-1" type="button" data-bs-toggle="collapse" data-bs-target="#totalOrders" aria-expanded="false" aria-controls="totalOrders">이번 달 주문 수</button>
				          </p>
				
				          <!-- Collapse 내용들 -->
				
				          <div class="collapse" id="todayOrderCount">
				            <div class="d-grid d-sm-flex p-3 border">
								<i class='bx bxs-wallet'> 오늘의 주문 수 : </i>&nbsp;
				                <h3 class="card-title mb-2" id="todayOrderCount">${todayOrderCount} 개</h3>
				            </div>
				          </div>
				          
				          <div class="collapse" id="totalOrders">
				            <div class="d-grid d-sm-flex p-3 border">
				              <i class='bx bxs-wallet'> 이번 달 주문 수 : </i>&nbsp;
				              <h3 class="card-title mb-2" id="totalOrders">${totalOrders} 개</h3>
				            </div>
				          </div>
				
				        </div>
				      </div>
				    </div>
				  </div>
				</div>
				
				<div class="container-xxl flex-grow-1 container-p-y">
				 <!-- Collapse -->
				  <h5>취소 및 반품</h5>
				  <div class="row">
				    <div class="col-12">
				      <div class="card mb-4">
				        <h5 class="card-header">취소 및 반품 통계</h5>
				        <div class="card-body">
				          <p class="card-text">원하는 옵션을 선택하여 취소 및 반품 통계를 확인하세요.</p>
				
				          <!-- Collapse 트리거 버튼들 -->
				          <p class="demo-inline-spacing">
				            <button class="btn btn-primary me-1" type="button" data-bs-toggle="collapse" data-bs-target="#cancelRate" aria-expanded="false" aria-controls="cancelRate">이번 달 취소율</button>
				            <button class="btn btn-primary me-1" type="button" data-bs-toggle="collapse" data-bs-target="#returnRate" aria-expanded="false" aria-controls="returnRate">이번 달 반품율</button>
				          </p>
				
				          <!-- Collapse 내용들 -->
				
				          <div class="collapse" id="cancelRate">
				            <div class="d-grid d-sm-flex p-3 border">
								<i class='bx bxs-wallet'> 이번 달 취소율 : </i>&nbsp;
				                <h3 class="card-title mb-2" id="cancelRate">${cancelRate} %</h3>
				            </div>
				          </div>
				          
				          <div class="collapse" id="returnRate">
				            <div class="d-grid d-sm-flex p-3 border">
				              <i class='bx bxs-wallet'> 이번 달 반품율 : </i>&nbsp;
				              <h3 class="card-title mb-2" id="returnRate">${returnRate} %</h3>
				            </div>
				          </div>
				
				        </div>
				      </div>
				    </div>
				  </div>
				</div>
                    
                  </div>
                </div>
                <!-- Total Revenue -->
              </div>
              <div class="row">
				<div class="col-12 col-lg-8 mb-4">
				    <div class="card mx-0">
				        <div class="row g-0">
				            <div class="col-md-12">
				                <h5 class="card-header m-0 me-2 pb-3">카테고리별 매출 통계</h5>
				                <div id="categoryChart" class="px-2"></div>
				            </div>
				        </div>
				    </div>
				</div>
				<div class="col-12 col-lg-8 mb-4">
				    <div class="card mx-0">
				        <div class="row g-0">
				            <div class="col-md-12">
				                <h5 class="card-header m-0 me-2 pb-3">가격대 별 통계</h5>
				                <div id="priceRangeChart" class="px-2"></div>
				            </div>
				        </div>
				    </div>
				</div>
				<div class="col-12 col-lg-8 mb-4">
				    <div class="card mx-0">
				        <div class="row g-0">
				            <div class="col-md-12">
				                <h5 class="card-header m-0 me-2 pb-3">회원 연령 별 주문 통계</h5>
				                <div id="ageGroupChart" class="px-2"></div>
				            </div>
				        </div>
				    </div>
				</div>
                <!-- Order Statistics -->
                <div class="col-12 col-md-12 col-lg-6 order-3 order-md-2">
                  <div class="row">
					<div class="col-12 mb-4">
                      <div class="card">
                        <div class="card-body">
                          <div class="card-title d-flex align-items-start justify-content-between">
                          </div>
                          <div class="col-md-12">
	                          <span class="d-block mb-1">회원 성별 별 주문 통계</span>
	                          <div id="genderChart" class="px-2"></div>
                          </div>
                          <h3 class="card-title text-nowrap mb-2"></h3>
                        </div>
                      </div>
                    </div>
                   </div>
                  </div>
                <!--/ Order Statistics -->
              </div>
            </div>
			</div>
				<!-- / Content -->

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
	<!-- <script src="/resources/assets/admin/js/dashboards-analytics.js"></script> -->

	<!-- Place this tag in your head or just before your close body tag. -->
	<script async defer src="https://buttons.github.io/buttons.js"></script>
</body>


</html>
