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

	let isDrawedSaleGragh = false;
	let isDrawedRevenueGragh = false;
	
	let totalRevenueChart;
	let totalSaleChart;
	
	
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
		setOverView(data);
		setNumberOfMembers(data.memberCnt, data.memberGrowthRate.toFixed(2));
		setNumberOfMembersByGender(data.memberCnt, data.genderList);
		setNumberOfMembersByLevel(data.memberCnt, data.levelList);
		setSaleData(data.saleCountDTOList);
		setRevenueData(data.revenueDTOList);
	}
	
	// SetOverview
	function setOverView(data){
		
		let regGrowthRate = data.regGrowthRate.toFixed(2);
		let saleGrowthRate = data.saleGrowthRate.toFixed(2);
		let revenueGrowthRate = data.revenueGrowthRate.toFixed(2);
		
		$("#todayRegMemberCnt").text(data.todayRegMemberCnt);
		$("#daySaleCnt").text(data.daySaleCnt);
		$("#dayRevenue").text(data.dayRevenue.toLocaleString());
		$("#waitInquiryCnt").text(data.waitInquiryCnt);
		
		if(regGrowthRate >= 0){
			$("#regGrowthRate").html(`<small class="text-success fw-semibold"><i class="bx bx-up-arrow-alt"></i>\${regGrowthRate}%</small>`);	
		} else {
			$("#regGrowthRate").html(`<small class="text-danger fw-semibold"><i class="bx bx-down-arrow-alt"></i>\${regGrowthRate}%</small>`);
		}
		
		if(saleGrowthRate >= 0){
			$("#saleGrowthRate").html(`<small class="text-success fw-semibold"><i class="bx bx-up-arrow-alt"></i>\${saleGrowthRate}%</small>`);	
		} else {
			$("#saleGrowthRate").html(`<small class="text-danger fw-semibold"><i class="bx bx-down-arrow-alt"></i>\${saleGrowthRate}%</small>`);
		}
		
		if(revenueGrowthRate >= 0){
			$("#revenueGrowthRate").html(`<small class="text-success fw-semibold"><i class="bx bx-up-arrow-alt"></i>\${revenueGrowthRate}%</small>`);	
		} else {
			$("#revenueGrowthRate").html(`<small class="text-danger fw-semibold"><i class="bx bx-down-arrow-alt"></i>\${revenueGrowthRate}%</small>`);
		}
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
		let icon = ``;
		genderList.forEach(function(item){
			let gender;
			if(item.gender == 'M') {
				gender = 'Male';
				icon = `<span class="avatar-initial rounded bg-label-info">
					<i class='bx bx-male-sign'></i>
					</span>`;
			} else if(item.gender == 'F'){
				gender = 'Female';
				icon = `<span class="avatar-initial rounded bg-label-danger">
					<i class='bx bx-female-sign' ></i>
				</span>`;
			} else {
				gender = 'None';
				icon = `<span class="avatar-initial rounded bg-label-success">
					<i class='bx bx-question-mark'></i>
				</span>`;
			}
			
			output += `<li class="d-flex mb-4 pb-1">
							<div class="avatar flex-shrink-0 me-3">
							\${icon}
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
		let imgSrc = ``;
		levelList.forEach(function(item){
			let level;
			if(item.member_level == 1) {
				level = 'Bronze';
				imgSrc = 'bronze.png';
			} else if(item.member_level == 2){
				level = 'Silver';
				imgSrc = 'silver.png';
			} else if(item.member_level == 3){
				level = 'Gold';
				imgSrc = 'gold.png';
			} else {
				level = 'Diamond';
				imgSrc = 'diamond.png';
			}
			
			output += `<li class="d-flex mb-4 pb-1">
							<div class="avatar flex-shrink-0 me-3">
								<img src="/resources/images/\${imgSrc}">
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
	
	function setSaleData(list){
		drawSaleAndRevenueGragh(list, "sale");
	}
	
	function setRevenueData(list){
		drawSaleAndRevenueGragh(list, "revenue");
	}
	
	
	
	// Number of members (gender, level) 그래프 그리기
	function drawNumberOfMembersGragh(memberCnt, list, type) {
		let chart;
		let labels = [];
		let series = [];
		let colors = [];
		
		if(type == 'gender'){
			chart = document.querySelector('#numberOfMembersByGenderChart');
			
			list.forEach(function(item){
				labels.push(item.gender);	
				series.push(parseFloat((item.count / memberCnt * 100).toFixed(2)));
				
			});
			
			colors = [config.colors.info, config.colors.danger,
				config.colors.success];
		} else if(type == 'level'){
			chart = document.querySelector('#numberOfMembersByLevelChart');
			
			list.forEach(function(item){
				labels.push(item.member_level);	
				series.push(parseFloat((item.count / memberCnt * 100).toFixed(2)));
			});
			
			colors = [config.colors.bronzeColor, config.colors.silverColor,
				config.colors.goldColor, config.colors.diamondColor];
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
			colors : colors,
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
	function selectRangedMemberRegCnt(){
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
			url : '/admin/selectRangedMemberRegCnt',
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
	
	// 특정 달의 판매량 가져오기
	function getSalesByMonth(){
		$.ajax({
			url : '/admin/getSalesByMonth',
			type : 'GET',
			dataType : 'json',
			data : {
				"month" : $("#selectMonthOfSale").val()
			},
			success : function(data) {
				console.log(data);
				drawSaleAndRevenueGragh(data, "sale");

			},
			error : function(error) {
				console.log(error);
			}
		});
	}
	
	// 특정 달의 매출 가져오기
	function getRevenueByMonth(){
		$.ajax({
			url : '/admin/getRevenuesByMonth',
			type : 'GET',
			dataType : 'json',
			data : {
				"month" : $("#selectMonthOfRevenue").val()
			},
			success : function(data) {
				console.log(data);
				drawSaleAndRevenueGragh(data, "revenue");

			},
			error : function(error) {
				console.log(error);
			}
		});
	}
	
	
	// 판매량, 매출 그래프 그리기
	function drawSaleAndRevenueGragh(list, type){
		let categories = [];
		let series = [];
		let chart;
		let name;
		
		let totalSale = 0;
		let totalRevenue = 0;
		
		if(type == "sale"){
			chart = document.querySelector('#totalSaleChart');
			name = "volume"
			list.forEach(function(item){
				categories.push(item.category_name);
				series.push(item.count);
				totalSale += item.count;
			});
			
			$("#totalSaleCnt").text(totalSale);
			
		} else if(type == "revenue"){
			chart = document.querySelector('#totalRevenueChart');
			name = "amount"
			list.forEach(function(item){
				categories.push(item.category_name);
				series.push(item.revenue);
				totalRevenue += item.revenue;
			});
			
			$("#totalRevenue").text(totalRevenue.toLocaleString());
		}
		
		
		
		
		
		const totalRevenueChartEl = chart,
	    totalRevenueChartOptions = {
	      series: [
	        {
	          name: name,
	          data: series
	        }
	      ],
	      chart: {
	        height: 300,
	        stacked: true,
	        type: 'bar',
	        toolbar: { show: false }
	      },
	      plotOptions: {
	        bar: {
	          horizontal: false,
	          columnWidth: '33%',
	          borderRadius: 12,
	          startingShape: 'rounded',
	          endingShape: 'rounded'
	        }
	      },
	      colors: [config.colors.primary, config.colors.info],
	      dataLabels: {
	        enabled: false
	      },
	      stroke: {
	        curve: 'smooth',
	        width: 6,
	        lineCap: 'round',
	        colors: [cardColor]
	      },
	      legend: {
	        show: true,
	        horizontalAlign: 'left',
	        position: 'top',
	        markers: {
	          height: 8,
	          width: 8,
	          radius: 12,
	          offsetX: -3
	        },
	        labels: {
	          colors: axisColor
	        },
	        itemMargin: {
	          horizontal: 10
	        }
	      },
	      grid: {
	        borderColor: borderColor,
	        padding: {
	          top: 0,
	          bottom: -8,
	          left: 20,
	          right: 20
	        }
	      },
	      xaxis: {
	        categories: categories,
	        labels: {
	          style: {
	            fontSize: '13px',
	            colors: axisColor
	          }
	        },
	        axisTicks: {
	          show: false
	        },
	        axisBorder: {
	          show: false
	        }
	      },
	      yaxis: {
	        labels: {
	          style: {
	            fontSize: '13px',
	            colors: axisColor
	          }
	        }
	      },
	      responsive: [
	        {
	          breakpoint: 1700,
	          options: {
	            plotOptions: {
	              bar: {
	                borderRadius: 10,
	                columnWidth: '32%'
	              }
	            }
	          }
	        },
	        {
	          breakpoint: 1580,
	          options: {
	            plotOptions: {
	              bar: {
	                borderRadius: 10,
	                columnWidth: '35%'
	              }
	            }
	          }
	        },
	        {
	          breakpoint: 1440,
	          options: {
	            plotOptions: {
	              bar: {
	                borderRadius: 10,
	                columnWidth: '42%'
	              }
	            }
	          }
	        },
	        {
	          breakpoint: 1300,
	          options: {
	            plotOptions: {
	              bar: {
	                borderRadius: 10,
	                columnWidth: '48%'
	              }
	            }
	          }
	        },
	        {
	          breakpoint: 1200,
	          options: {
	            plotOptions: {
	              bar: {
	                borderRadius: 10,
	                columnWidth: '40%'
	              }
	            }
	          }
	        },
	        {
	          breakpoint: 1040,
	          options: {
	            plotOptions: {
	              bar: {
	                borderRadius: 11,
	                columnWidth: '48%'
	              }
	            }
	          }
	        },
	        {
	          breakpoint: 991,
	          options: {
	            plotOptions: {
	              bar: {
	                borderRadius: 10,
	                columnWidth: '30%'
	              }
	            }
	          }
	        },
	        {
	          breakpoint: 840,
	          options: {
	            plotOptions: {
	              bar: {
	                borderRadius: 10,
	                columnWidth: '35%'
	              }
	            }
	          }
	        },
	        {
	          breakpoint: 768,
	          options: {
	            plotOptions: {
	              bar: {
	                borderRadius: 10,
	                columnWidth: '28%'
	              }
	            }
	          }
	        },
	        {
	          breakpoint: 640,
	          options: {
	            plotOptions: {
	              bar: {
	                borderRadius: 10,
	                columnWidth: '32%'
	              }
	            }
	          }
	        },
	        {
	          breakpoint: 576,
	          options: {
	            plotOptions: {
	              bar: {
	                borderRadius: 10,
	                columnWidth: '37%'
	              }
	            }
	          }
	        },
	        {
	          breakpoint: 480,
	          options: {
	            plotOptions: {
	              bar: {
	                borderRadius: 10,
	                columnWidth: '45%'
	              }
	            }
	          }
	        },
	        {
	          breakpoint: 420,
	          options: {
	            plotOptions: {
	              bar: {
	                borderRadius: 10,
	                columnWidth: '52%'
	              }
	            }
	          }
	        },
	        {
	          breakpoint: 380,
	          options: {
	            plotOptions: {
	              bar: {
	                borderRadius: 10,
	                columnWidth: '60%'
	              }
	            }
	          }
	        }
	      ],
	      states: {
	        hover: {
	          filter: {
	            type: 'none'
	          }
	        },
	        active: {
	          filter: {
	            type: 'none'
	          }
	        }
	      }
	    };
	  if (typeof totalRevenueChartEl !== undefined && totalRevenueChartEl !== null) {
		if(type == "sale"){
			 if(isDrawedSaleGragh) {
				 totalSaleChart.updateSeries([
		    		{
		    			name: "volume",
		                data: series
		    		}
		    	]);
		    	
	    	 	totalSaleChart.updateOptions({
	    	        xaxis: {
	    	            categories: categories
	    	        }
	    	    });
		    } else {
		    	totalSaleChart = new ApexCharts(totalRevenueChartEl, totalRevenueChartOptions);
		    	
		    	totalSaleChart.render();
		    	isDrawedSaleGragh = true;
		    }	
		} else if(type == "revenue") {
			console.log("렌더링");
			
			if(isDrawedRevenueGragh) {
				
				console.log("재 렌더링");
				
		    	totalRevenueChart.updateSeries([
		    		{
		    			name: "revenue",
		                data: series
		    		}
		    	]);
		    	
	    	 	totalRevenueChart.updateOptions({
	    	        xaxis: {
	    	            categories: categories
	    	        }
	    	    });
		    } else {
		    	
		    	console.log("최초 렌더링");
		    	
		    	totalRevenueChart = new ApexCharts(totalRevenueChartEl, totalRevenueChartOptions);
		    	
		    	totalRevenueChart.render();
		    	isDrawedRevenueGragh = true;
		    }	
		}
	  }
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
						<div class="row">
							<div class="col-lg-3 col-md-6 col-6 mb-4">
								<div class="card">
									<div class="card-body">
										<div class="card-title d-flex align-items-start justify-content-between">
											<div class="avatar flex-shrink-0">
												<img src="/resources/assets/admin/img/icons/member_icon.png" alt="chart success" class="rounded">
											</div>
										</div>
										<span class="fw-semibold d-block mb-1">Register members today </span>
										<h3 id="todayRegMemberCnt" class="card-title mb-2"></h3>
										<div id="regGrowthRate"></div>
									</div>
								</div>
							</div>
							<div class="col-lg-3 col-md-6 col-6 mb-4">
								<div class="card">
									<div class="card-body">
										<div class="card-title d-flex align-items-start justify-content-between">
											<div class="avatar flex-shrink-0">
												<img src="/resources/assets/admin/img/icons/sale_icon.png" alt="chart success" class="rounded">
											</div>
										</div>
										<span class="fw-semibold d-block mb-1">Sale count today</span>
										<h3 id="daySaleCnt" class="card-title mb-2"></h3>
										<div id="saleGrowthRate"></div>
									</div>
								</div>
							</div>
							<div class="col-lg-3 col-md-6 col-6 mb-4">
								<div class="card">
									<div class="card-body">
										<div class="card-title d-flex align-items-start justify-content-between">
											<div class="avatar flex-shrink-0">
												<img src="/resources/assets/admin/img/icons/revenue_icon.png" alt="chart success" class="rounded">
											</div>
										</div>
										<span class="fw-semibold d-block mb-1">Revenue today</span>
										<h3 id="dayRevenue" class="card-title mb-2"></h3>
										<div id="revenueGrowthRate"></div>
									</div>
								</div>
							</div>
							<div class="col-lg-3 col-md-6 col-6 mb-4">
								<div class="card">
									<div class="card-body">
										<div class="card-title d-flex align-items-start justify-content-between">
											<div class="avatar flex-shrink-0">
												<img src="/resources/assets/admin/img/icons/inquiry_icon.png" alt="chart success" class="rounded">
											</div>
										</div>
										<span class="fw-semibold d-block mb-1">Wait Inquiries</span>
										<h3 id="waitInquiryCnt" class="card-title mb-2"></h3>
									</div>
								</div>
							</div>
						</div>


						<div class="row">
							<div class="col-lg-6 col-md-12 col-12 mb-4">
								<div class="card h-100">
									<div class="card-body">
										<div class="card-title d-flex align-items-start justify-content-between">
											<div class="avatar flex-shrink-0">
												<img src="/resources/assets/admin/img/icons/members_icon.png" alt="chart success" class="rounded">
											</div>
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
											<button id="" type="button" class="btn btn-outline-primary" onclick="selectRangedMemberRegCnt()">확인</button>
										</div>

										<span class="fw-semibold d-block mt-2 mb-1">Number of Registered Members</span>
										<h3 id="memberRegCnt" class="card-title mb-2"></h3>
									</div>
								</div>
							</div>

							<!-- Number of members by gender -->
							<div class="col-12 col-md-6 col-lg-3 order-0 mb-4">
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
							<div class="col-12 col-md-6 col-lg-3 order-0 mb-4">
								<div class="card h-100">
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
						<div class="row">
							<div class="col-12 col-lg-6 order-2 order-md-3 order-lg-2 mb-4">
								<div class="card">
									<div class="row row-bordered g-0">
										<div class="col-md-12">
											<div class="card-body">
												<div class="card-title d-flex align-items-start justify-content-between">
													<div class="avatar flex-shrink-0">
														<img src="/resources/assets/admin/img/icons/sale_icon.png" alt="chart success" class="rounded">
													</div>
												</div>
												<span class="fw-semibold d-block mb-1">Total Sales volume</span>
												<h3 id="totalSaleCnt" class="card-title mb-2"></h3>

												<span class="fw-semibold d-block mt-4">Select Month</span>
												<div class="col align-items-center">
													<div class="form-check-inline">
														<input id="selectMonthOfSale" class="form-control regDate" type="month" value="" id="">
													</div>
													<button id="" type="button" class="btn btn-outline-primary" onclick="getSalesByMonth()">확인</button>
												</div>
											</div>
											<!-- <h5 class="card-header m-0 me-2 pb-3">Total Revenue</h5> -->
											<div id="totalSaleChart" class="px-2"></div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-12 col-lg-6 order-2 order-md-3 order-lg-2 mb-4">
								<div class="card">
									<div class="row row-bordered g-0">
										<div class="col-md-12">
											<div class="card-body">
												<div class="card-title d-flex align-items-start justify-content-between">
													<div class="avatar flex-shrink-0">
														<img src="/resources/assets/admin/img/icons/revenue_icon.png" alt="chart success" class="rounded">
													</div>
												</div>
												<span class="fw-semibold d-block mb-1">Total Revenue</span>
												<h3 id="totalRevenue" class="card-title mb-2"></h3>

												<span class="fw-semibold d-block mt-4">Select Month</span>
												<div class="col align-items-center">
													<div class="form-check-inline">
														<input id="selectMonthOfRevenue" class="form-control regDate" type="month" value="" id="">
													</div>
													<button id="" type="button" class="btn btn-outline-primary" onclick="getRevenueByMonth()">확인</button>
												</div>
											</div>
											<!-- <h5 class="card-header m-0 me-2 pb-3">Total Revenue</h5> -->
											<div id="totalRevenueChart" class="px-2"></div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!--/ body  -->
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
</body>


</html>
