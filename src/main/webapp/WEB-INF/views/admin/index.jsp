
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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

</head>


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
						<!-- body  -->
            <div class="container-xxl flex-grow-1 container-p-y">
              <div class="row">
                <div class="col-lg-8 col-md-8 order-1">
                  <div class="row">
                    <div class="col-lg-6 col-md-6 col-6 mb-4">
                      <div class="card">
                        <div class="card-body">
							<i class='bx bxs-wallet'> 총 매출 통계</i> 
                          <h3 class="card-title mb-2" id="totalSales">${totalSales} 원</h3>
                          <small class="text-success fw-semibold"><i class="bx bx-up-arrow-alt"></i></small>
                        </div>
                      </div>
                    </div>
                <div class="col-lg-6 col-md-6 col-6 mb-4">
                      <div class="card">
                        <div class="card-body">
							<i class='bx bxs-wallet'> 방문자수</i> 
                          <h3 class="card-title mb-2"></h3>
                          <small class="text-success fw-semibold"><i class="bx bx-up-arrow-alt"></i></small>
                        </div>
                      </div>
                    </div>
                    <div class="col-lg-6 col-md-6 col-6 mb-4">
                      <div class="card">
                        <div class="card-body">
							<i class='bx bxs-wallet'> 오늘의 주문 수</i> 
                          <h3 class="card-title mb-2">${todayOrderCount} 개</h3>
                          <small class="text-success fw-semibold"><i class="bx bx-up-arrow-alt"></i></small>
                        </div>
                      </div>
                    </div>
                    <div class="col-lg-6 col-md-6 col-6 mb-4">
                      <div class="card">
                        <div class="card-body">
							<i class='bx bxs-wallet'> 이번 달 주문 수</i> 
                          <h3 class="card-title mb-2">${totalOrders} 개</h3>
                          <small class="text-success fw-semibold"><i class="bx bx-up-arrow-alt"></i></small>
                        </div>
                      </div>
                    </div>
					<div class="col-lg-6 col-md-6 col-6 mb-4">
                      <div class="card">
                        <div class="card-body">
							<i class='bx bxs-wallet'> 이번 달 취소율</i>
                          <h3 class="card-title mb-2">${cancelRate} %</h3>
                          <small class="text-success fw-semibold"><i class="bx bx-up-arrow-alt"></i></small>
                        </div>
                      </div>
                    </div>
                    <div class="col-lg-6 col-md-6 col-6 mb-4">
                      <div class="card">
                        <div class="card-body">
							<i class='bx bxs-wallet'> 이번 달 반품율</i>
                          <h3 class="card-title mb-2">${returnRate} %</h3>
                          <small class="text-success fw-semibold"><i class="bx bx-up-arrow-alt"></i></small>
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
				            <div class="col-md-8">
				                <h5 class="card-header m-0 me-2 pb-3">카테고리별 매출 통계</h5>
				                <div id="categoryStatisticsChart" class="px-2"></div>
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
                          <span class="d-block mb-1">가격대 별 통계</span>
                          <div id="priceStatisticsChart"></div>
                          <h3 class="card-title text-nowrap mb-2"></h3>
                          <small class="text-danger fw-semibold"><i class="bx bx-down-arrow-alt"></i></small>
                        </div>
                      </div>
                    </div>
                    <div class="col-12 mb-4">
                      <div class="card">
                        <div class="card-body">
                          <div class="card-title d-flex align-items-start justify-content-between">
                          </div>
                          <span class="d-block mb-1">회원 연령 별 주문 통계</span>
                          <div id="ageStatisticsChart"></div>
                          <h3 class="card-title text-nowrap mb-2"></h3>
                          <small class="text-danger fw-semibold"><i class="bx bx-down-arrow-alt"></i></small>
                        </div>
                      </div>
                    </div>
                    <div class="col-12 mb-4">
                      <div class="card">
                        <div class="card-body">
                          <div class="card-title d-flex align-items-start justify-content-between">
                          </div>
                          <span class="d-block mb-1">회원 성별 별 주문 통계</span>
                          <div id="orderStatisticsChart2"></div>
                          <h3 class="card-title text-nowrap mb-2"></h3>
                          <small class="text-danger fw-semibold"><i class="bx bx-down-arrow-alt"></i></small>
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
    <script src="/resources/assets/admin/js/dashboards-analytics.js"></script>

    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
	<!-- 차트 초기화 스크립트 -->
	<script>
	$(document).ready(function() {
	    // 모든 통계 데이터를 서버에서 가져오는 AJAX 요청
	    $.ajax({
	        url: "/admin", // 요청하는 URL
	        type: 'GET',
	        success: function(data) {
	            console.log(data);
	            // 데이터가 null 또는 undefined인지 확인
	            if (data) {
	                // 연령대별 매출 데이터 처리 (필요에 따라 주석 해제)
	                const salesData = [
	                    { ageGroup: '10대', totalSales: 40 },
	                    { ageGroup: '20대', totalSales: 60 },
	                    { ageGroup: '30대', totalSales: 100 },
	                    { ageGroup: '40대', totalSales: 150 },
	                    { ageGroup: '50대', totalSales: 190 },
	                    { ageGroup: '60대', totalSales: 220 },
	                    { ageGroup: '70대', totalSales: 30 },
	                    { ageGroup: '80대', totalSales: 50 },
	                    { ageGroup: '90대 이상', totalSales: 70 }
	                ];

	                const ageCategories = salesData.map(item => item.ageGroup); // 연령대
	                const ageSeriesData = salesData.map(item => item.totalSales); // 매출 데이터

	                // 연령대별 매출 차트 옵션 설정
	                var ageOptions = {
	                    series: [{
	                        name: '매출',
	                        data: ageSeriesData
	                    }],
	                    chart: {
	                        type: 'bar',
	                        height: 350
	                    },
	                    plotOptions: {
	                        bar: {
	                            horizontal: false,
	                        }
	                    },
	                    dataLabels: {
	                        enabled: true
	                    },
	                    xaxis: {
	                        categories: ageCategories,
	                    },
	                    yaxis: {
	                        title: {
	                            text: '매출 (원)'
	                        }
	                    },
	                    title: {
	                        text: '연령대별 매출 통계',
	                        align: 'left'
	                    },
	                    grid: {
	                        xaxis: {
	                            lines: {
	                                show: true
	                            }
	                        }
	                    }
	                };

	                // 연령대별 매출 차트 렌더링
	                var ageStatisticsChart = new ApexCharts(document.querySelector("#ageStatisticsChart"), ageOptions);
	                ageStatisticsChart.render();

	                // 카테고리별 매출 데이터 처리
	                const categorySalesData = data.categorySales; // 서버에서 가져온 카테고리별 매출 데이터
	                if (categorySalesData) {
	                    const categories = categorySalesData.map(item => item.category);
	                    const sales = categorySalesData.map(item => item.totalSales);

	                    // ApexCharts를 사용하여 차트 그리기
	                    const options = {
	                        chart: {
	                            type: 'bar',
	                            height: 350
	                        },
	                        series: [{
	                            name: '매출',
	                            data: sales
	                        }],
	                        xaxis: {
	                            categories: categories,
	                            title: {
	                                text: '카테고리'
	                            }
	                        },
	                        yaxis: {
	                            title: {
	                                text: '매출 (원)'
	                            }
	                        },
	                        title: {
	                            text: '카테고리별 매출 통계',
	                            align: 'left'
	                        }
	                    };

	                    // 차트 렌더링
	                    const chart = new ApexCharts(document.querySelector("#categoryStatisticsChart"), options);
	                    chart.render();
	                }
	            } else {
	                console.error("서버에서 받은 데이터가 유효하지 않습니다.");
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error("AJAX 요청 오류:", error);
	        }
	    });

	    // 가격대 별 통계 차트 데이터 설정
	    var priceStatisticsOptions = {
	        chart: {
	            type: 'bar',
	            height: 350
	        },
	        series: [{
	            name: '가격대',
	            data: [10, 20, 30, 40, 50, 60, 70, 80, 90, 100] // 각 가격대에 대한 데이터
	        }],
	        xaxis: {
	            categories: ['0-10', '11-20', '21-30', '31-40', '41-50', '51-60', '61-70', '71-80', '81-90', '100 이상'],
	            title: {
	                text: '가격대'
	            }
	        },
	        yaxis: {
	            title: {
	                text: '매출'
	            }
	        },
	        title: {
	            text: '가격대 별 통계',
	            align: 'left'
	        }
	    };

	    // 가격대별 차트 렌더링
	    var priceStatisticsChart = new ApexCharts(document.querySelector("#priceStatisticsChart"), priceStatisticsOptions);
	    priceStatisticsChart.render();

	    // 성별 별 주문 통계 차트 설정
	    let orderStatisticsOptions2 = {
	        chart: {
	            type: 'pie',
	            height: 300
	        },
	        series: [44, 55], // 예시 데이터
	        labels: ['남성', '여성']
	    };

	    // 성별 차트 렌더링
	    let orderStatisticsChart2 = new ApexCharts(document.querySelector("#orderStatisticsChart2"), orderStatisticsOptions2);
	    orderStatisticsChart2.render();
	});
	</script>
  </body>
</html>
