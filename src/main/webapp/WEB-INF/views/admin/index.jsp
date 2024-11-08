
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

<!--                 <div class="col-lg-6 col-md-6 col-6 mb-4"> -->
<!--                       <div class="card"> -->
<!--                         <div class="card-body"> -->
<!-- 							<i class='bx bxs-wallet'> 금일 방문자수</i>  -->
<%--                           <h3 class="card-title mb-2">${visitorCount} 명</h3> --%>
<!--                         </div> -->
<!--                       </div> -->
<!--                     </div> -->
          
				<div class="container-xxl flex-grow-1 container-p-y">
				
				  <!-- Collapse -->
				  <h5>매출 통계</h5>
				  <div class="row">
				    <div class="col-12">
				      <div class="card mb-4">
				        <h5 class="card-header">매출 통계</h5>
				        <div class="card-body">
				          <p class="card-text">원하는 기간을 선택하여 매출 통계를 확인하세요.</p>
				
				          <!-- Collapse 트리거 버튼들 -->
				          <p class="demo-inline-spacing">
				            <button class="btn btn-primary me-1" type="button" data-bs-toggle="collapse" data-bs-target="#totalSales" aria-expanded="false" aria-controls="totalSales">이번 달 매출 통계</button>
				            <button class="btn btn-primary me-1" type="button" data-bs-toggle="collapse" data-bs-target="#lastMonthSales" aria-expanded="false" aria-controls="lastMonthSales">지난 달 매출 통계</button>
				            <button class="btn btn-primary me-1" type="button" data-bs-toggle="collapse" data-bs-target="#lastYearSales" aria-expanded="false" aria-controls="lastYearSales">작년 매출 통계</button>
				            <button class="btn btn-primary me-1" type="button" data-bs-toggle="collapse" data-bs-target="#firstHalfSales" aria-expanded="false" aria-controls="firstHalfSales">상반기 매출 통계</button>
				            <button class="btn btn-primary me-1" type="button" data-bs-toggle="collapse" data-bs-target="#secondHalfSales" aria-expanded="false" aria-controls="secondHalfSales">하반기 매출 통계</button>
				            <button class="btn btn-primary me-1" type="button" data-bs-toggle="collapse" data-bs-target="#thisYearSales" aria-expanded="false" aria-controls="thisYearSales">올해 매출 통계</button>
				          </p>
				
				          <!-- Collapse 내용들 -->
				
				          <div class="collapse" id="totalSales">
				            <div class="d-grid d-sm-flex p-3 border">
								<i class='bx bxs-wallet'> 이번 달 매출 통계 : </i>&nbsp;
				                <h3 class="card-title mb-2" >${totalSales} 원</h3>
				            </div>
				          </div>
				          
				          <div class="collapse" id="lastMonthSales">
				            <div class="d-grid d-sm-flex p-3 border">
				              <i class='bx bxs-wallet'> 지난 달 매출 통계 : </i>&nbsp;
				              <h3 class="card-title mb-2" id="lastMonthSales">${lastMonthSales} 원</h3>
				            </div>
				          </div>
				
				          <div class="collapse" id="lastYearSales">
				            <div class="d-grid d-sm-flex p-3 border">
				              <i class='bx bxs-wallet'> 작년 매출 통계 : </i>&nbsp;
				              <h3 class="card-title mb-2" id="lastYearSales">${lastYearSales} 원</h3>
				            </div>
				          </div>
				
				          <div class="collapse" id="firstHalfSales">
				            <div class="d-grid d-sm-flex p-3 border">
				              <i class='bx bxs-wallet'> 상반기 매출 통계 : </i>&nbsp;
				              <h3 class="card-title mb-2" id="firstHalfSales">${firstHalfSales} 원</h3>
				            </div>
				          </div>
				
				          <div class="collapse" id="secondHalfSales">
				            <div class="d-grid d-sm-flex p-3 border">
				              <i class='bx bxs-wallet'> 하반기 매출 통계 : </i>&nbsp;
				              <h3 class="card-title mb-2" id="secondHalfSales">${secondHalfSales} 원</h3>
				            </div>
				          </div>
				          
				          <div class="collapse" id="thisYearSales">
				            <div class="d-grid d-sm-flex p-3 border">
				              <i class='bx bxs-wallet'> 올해 매출 통계 : </i>&nbsp;
				              <h3 class="card-title mb-2" id="thisYearSales">${thisYearSales} 원</h3>
				            </div>
				          </div>
				
				        </div>
				      </div>
				    </div>
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
    <script src="/resources/assets/admin/js/dashboards-analytics.js"></script>

    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
	<!-- 차트 초기화 스크립트 -->
<script> 
//서버에서 XML 데이터를 받아와서 처리하는 JavaScript 코드
fetch('/admin/statistics')  // 서버에서 salesData를 가져오는 요청
    .then(response => response.text())  // XML 데이터를 텍스트 형식으로 받음
    .then(xmlString => {
        var parser = new DOMParser();
        var xmlDoc = parser.parseFromString(xmlString, "application/xml");

        // 'salesByAgeGroup'에서 'ageGroup'과 'total_sales' 추출
        var salesByAgeGroup = xmlDoc.getElementsByTagName('salesByAgeGroup');
        var ageGroups = [];
        var ageGroupSales = [];
        
        for (var i = 0; i < salesByAgeGroup.length; i++) {
            var ageGroup = salesByAgeGroup[i].getElementsByTagName('ageGroup')[0].textContent;
            var totalSales = salesByAgeGroup[i].getElementsByTagName('total_sales')[0].textContent;
            ageGroups.push(ageGroup);
            ageGroupSales.push(parseFloat(totalSales));  // 숫자로 변환해서 저장
        }

        // 'salesByPriceRange'에서 'priceRange'와 'total_sales' 추출
        var salesByPriceRange = xmlDoc.getElementsByTagName('salesByPriceRange');
        var priceRanges = [];
        var priceRangeSales = [];
        
        for (var i = 0; i < salesByPriceRange.length; i++) {
            var priceRange = salesByPriceRange[i].getElementsByTagName('priceRange')[0].textContent;
            var totalSales = salesByPriceRange[i].getElementsByTagName('total_sales')[0].textContent;
            priceRanges.push(priceRange);
            priceRangeSales.push(parseFloat(totalSales));  // 숫자로 변환해서 저장
        }

        // 'salesByCategory'에서 'category'와 'total_sales' 추출
        var salesByCategory = xmlDoc.getElementsByTagName('salesByCategory');
        var categoryNames = [];
        var categorySales = [];

        for (var i = 0; i < salesByCategory.length; i++) {
            var category = salesByCategory[i].getElementsByTagName('category')[0].textContent;
            var totalSales = salesByCategory[i].getElementsByTagName('total_sales')[0].textContent;
            categoryNames.push(category);
            categorySales.push(parseFloat(totalSales));  // 숫자로 변환해서 저장
        }
        
        // 'salesByGender'에서 성별과 총 매출을 추출
        var salesByGender = xmlDoc.getElementsByTagName('salesByGender');
        var genders = [];
        var genderSales = [];

        for (var i = 0; i < salesByGender.length; i++) {
            var gender = salesByGender[i].getElementsByTagName('gender')[0].textContent;
            var totalSales = salesByGender[i].getElementsByTagName('total_sales')[0].textContent;
            genders.push(gender);
            genderSales.push(parseFloat(totalSales));  // 숫자로 변환해서 저장
        }

        // 차트 데이터 업데이트
        var ageGroupChart = new ApexCharts(document.querySelector("#ageGroupChart"), {
            chart: {
                type: 'bar',
                height: 350
            },
            series: [{
                name: '연령매출',
                data: ageGroupSales  // ageGroupSales 배열을 사용
            }],
            xaxis: {
                categories: ageGroups  // ageGroups 배열을 사용
            },
            title: {
                text: '연령대별 매출 통계',
                align: 'left'
            }
        });

        var priceRangeChart = new ApexCharts(document.querySelector("#priceRangeChart"), {
            chart: {
                type: 'bar',
                height: 350
            },
            series: [{
                name: '가격대매출',
                data: priceRangeSales  // priceRangeSales 배열을 사용
            }],
            xaxis: {
                categories: priceRanges  // priceRanges 배열을 사용
            },
            title: {
                text: '가격대별 매출 통계',
                align: 'left'
            }
        });

        var categoryChart = new ApexCharts(document.querySelector("#categoryChart"), {
            chart: {
                type: 'bar',
                height: 400,  // 차트 높이 설정
                width: '100%',  // 차트 가로 크기 설정
            },
            series: [{
                name: '카테고리매출',
                data: categorySales  // categorySales 배열을 사용
            }],
            xaxis: {
                categories: categoryNames,  // categoryNames 배열을 사용
            },
            title: {
                text: '카테고리별 매출 통계',
                align: 'left'
            },
            grid: {
                xaxis: {
                    lines: {
                        show: true
                    }
                }
            }
        });
        
        // 성별 차트 (Pie Chart)
        var genderChart = new ApexCharts(document.querySelector("#genderChart"), {
            chart: {
                type: 'pie',
                height: 350
            },
            series: genderSales,  // genderSales 배열을 사용
            labels: genders,  // genders 배열을 사용
            title: {
                text: '성별 매출 통계',
                align: 'left'
            }
        });

        // 차트 렌더링
        ageGroupChart.render();
        priceRangeChart.render();
        categoryChart.render();
        genderChart.render();
    })
    .catch(error => {
        console.error("데이터를 가져오는 데 오류가 발생했습니다:", error);
    });

</script>

  </body>
</html>
