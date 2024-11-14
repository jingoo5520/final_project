<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

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
<title>Insert title here</title>
</head>
<body>
	<div class="row">
		<div class="card h-100">
			<div class="card-header">
				<ul class="nav nav-pills" role="tablist">
					<li class="nav-item">
						<button type="button" class="nav-link active" role="tab" data-bs-toggle="tab" data-bs-target="#navs-tabs-line-card-income" aria-controls="navs-tabs-line-card-income" aria-selected="true">Income</button>
					</li>
					<li class="nav-item">
						<button type="button" class="nav-link" role="tab">Expenses</button>
					</li>
					<li class="nav-item">
						<button type="button" class="nav-link" role="tab">Profit</button>
					</li>
				</ul>
			</div>
			<div class="card-body px-0">
				<div class="tab-content p-0">
					<div class="tab-pane fade show active" id="navs-tabs-line-card-income" role="tabpanel" style="position: relative;">
						<div class="d-flex p-4 pt-3">
							<div class="avatar flex-shrink-0 me-3">
								<img src="../assets/img/icons/unicons/wallet.png" alt="User">
							</div>
							<div>
								<small class="text-muted d-block">Total Balance</small>
								<div class="d-flex align-items-center">
									<h6 class="mb-0 me-1">$459.10</h6>
									<small class="text-success fw-semibold"> <i class="bx bx-chevron-up"></i> 42.9%
									</small>
								</div>
							</div>
						</div>
						<div id="incomeChart" style="min-height: 215px;">
							<div id="apexchartsgu2r951k" class="apexcharts-canvas apexchartsgu2r951k apexcharts-theme-light" style="width: 356px; height: 215px;">
								<svg id="SvgjsSvg6064" width="356" height="215" xmlns="http://www.w3.org/2000/svg" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:svgjs="http://svgjs.dev" class="apexcharts-svg apexcharts-zoomable" xmlns:data="ApexChartsNS" transform="translate(0, 0)" style="background: transparent;">
								<g id="SvgjsG6066" class="apexcharts-inner apexcharts-graphical" transform="translate(0, 10)">
								<defs id="SvgjsDefs6065">
								<clipPath id="gridRectMaskgu2r951k">
								<rect id="SvgjsRect6071" width="344.635009765625" height="175.73" x="-3" y="-1" rx="0" ry="0" opacity="1" stroke-width="0" stroke="none" stroke-dasharray="0" fill="#fff"></rect></clipPath>
								<clipPath id="forecastMaskgu2r951k"></clipPath>
								<clipPath id="nonForecastMaskgu2r951k"></clipPath>
								<clipPath id="gridRectMarkerMaskgu2r951k">
								<rect id="SvgjsRect6072" width="366.635009765625" height="201.73" x="-14" y="-14" rx="0" ry="0" opacity="1" stroke-width="0" stroke="none" stroke-dasharray="0" fill="#fff"></rect></clipPath>
								<linearGradient id="SvgjsLinearGradient6092" x1="0" y1="0" x2="0" y2="1">
								<stop id="SvgjsStop6093" stop-opacity="0.5" stop-color="rgba(105,108,255,0.5)" offset="0"></stop>
								<stop id="SvgjsStop6094" stop-opacity="0.25" stop-color="rgba(195,196,255,0.25)" offset="0.95"></stop>
								<stop id="SvgjsStop6095" stop-opacity="0.25" stop-color="rgba(195,196,255,0.25)" offset="1"></stop></linearGradient></defs>
								<line id="SvgjsLine6070" x1="0" y1="0" x2="0" y2="173.73" stroke="#b6b6b6" stroke-dasharray="3" stroke-linecap="butt" class="apexcharts-xcrosshairs" x="0" y="0" width="1" height="173.73" fill="#b1b9c4" filter="none" fill-opacity="0.9" stroke-width="1"></line>
								<g id="SvgjsG6098" class="apexcharts-xaxis" transform="translate(0, 0)">
								<g id="SvgjsG6099" class="apexcharts-xaxis-texts-g" transform="translate(0, -4)">
								<text id="SvgjsText6101" font-family="Helvetica, Arial, sans-serif" x="0" y="202.73" text-anchor="middle" dominant-baseline="auto" font-size="13px" font-weight="400" fill="#a1acb8" class="apexcharts-text apexcharts-xaxis-label " style="font-family: Helvetica, Arial, sans-serif;">
								<tspan id="SvgjsTspan6102"></tspan>
								<title></title></text>
								<text id="SvgjsText6104" font-family="Helvetica, Arial, sans-serif" x="48.37642996651785" y="202.73" text-anchor="middle" dominant-baseline="auto" font-size="13px" font-weight="400" fill="#a1acb8" class="apexcharts-text apexcharts-xaxis-label " style="font-family: Helvetica, Arial, sans-serif;">
								<tspan id="SvgjsTspan6105">Jan</tspan>
								<title>Jan</title></text>
								<text id="SvgjsText6107" font-family="Helvetica, Arial, sans-serif" x="96.75285993303571" y="202.73" text-anchor="middle" dominant-baseline="auto" font-size="13px" font-weight="400" fill="#a1acb8" class="apexcharts-text apexcharts-xaxis-label " style="font-family: Helvetica, Arial, sans-serif;">
								<tspan id="SvgjsTspan6108">Feb</tspan>
								<title>Feb</title></text>
								<text id="SvgjsText6110" font-family="Helvetica, Arial, sans-serif" x="145.12928989955358" y="202.73" text-anchor="middle" dominant-baseline="auto" font-size="13px" font-weight="400" fill="#a1acb8" class="apexcharts-text apexcharts-xaxis-label " style="font-family: Helvetica, Arial, sans-serif;">
								<tspan id="SvgjsTspan6111">Mar</tspan>
								<title>Mar</title></text>
								<text id="SvgjsText6113" font-family="Helvetica, Arial, sans-serif" x="193.50571986607144" y="202.73" text-anchor="middle" dominant-baseline="auto" font-size="13px" font-weight="400" fill="#a1acb8" class="apexcharts-text apexcharts-xaxis-label " style="font-family: Helvetica, Arial, sans-serif;">
								<tspan id="SvgjsTspan6114">Apr</tspan>
								<title>Apr</title></text>
								<text id="SvgjsText6116" font-family="Helvetica, Arial, sans-serif" x="241.8821498325893" y="202.73" text-anchor="middle" dominant-baseline="auto" font-size="13px" font-weight="400" fill="#a1acb8" class="apexcharts-text apexcharts-xaxis-label " style="font-family: Helvetica, Arial, sans-serif;">
								<tspan id="SvgjsTspan6117">May</tspan>
								<title>May</title></text>
								<text id="SvgjsText6119" font-family="Helvetica, Arial, sans-serif" x="290.2585797991071" y="202.73" text-anchor="middle" dominant-baseline="auto" font-size="13px" font-weight="400" fill="#a1acb8" class="apexcharts-text apexcharts-xaxis-label " style="font-family: Helvetica, Arial, sans-serif;">
								<tspan id="SvgjsTspan6120">Jun</tspan>
								<title>Jun</title></text>
								<text id="SvgjsText6122" font-family="Helvetica, Arial, sans-serif" x="338.63500976562494" y="202.73" text-anchor="middle" dominant-baseline="auto" font-size="13px" font-weight="400" fill="#a1acb8" class="apexcharts-text apexcharts-xaxis-label " style="font-family: Helvetica, Arial, sans-serif;">
								<tspan id="SvgjsTspan6123">Jul</tspan>
								<title>Jul</title></text></g></g>
								<g id="SvgjsG6126" class="apexcharts-grid">
								<g id="SvgjsG6127" class="apexcharts-gridlines-horizontal">
								<line id="SvgjsLine6129" x1="0" y1="0" x2="338.635009765625" y2="0" stroke="#eceef1" stroke-dasharray="3" stroke-linecap="butt" class="apexcharts-gridline"></line>
								<line id="SvgjsLine6130" x1="0" y1="43.4325" x2="338.635009765625" y2="43.4325" stroke="#eceef1" stroke-dasharray="3" stroke-linecap="butt" class="apexcharts-gridline"></line>
								<line id="SvgjsLine6131" x1="0" y1="86.865" x2="338.635009765625" y2="86.865" stroke="#eceef1" stroke-dasharray="3" stroke-linecap="butt" class="apexcharts-gridline"></line>
								<line id="SvgjsLine6132" x1="0" y1="130.29749999999999" x2="338.635009765625" y2="130.29749999999999" stroke="#eceef1" stroke-dasharray="3" stroke-linecap="butt" class="apexcharts-gridline"></line>
								<line id="SvgjsLine6133" x1="0" y1="173.73" x2="338.635009765625" y2="173.73" stroke="#eceef1" stroke-dasharray="3" stroke-linecap="butt" class="apexcharts-gridline"></line></g>
								<g id="SvgjsG6128" class="apexcharts-gridlines-vertical"></g>
								<line id="SvgjsLine6135" x1="0" y1="173.73" x2="338.635009765625" y2="173.73" stroke="transparent" stroke-dasharray="0" stroke-linecap="butt"></line>
								<line id="SvgjsLine6134" x1="0" y1="1" x2="0" y2="173.73" stroke="transparent" stroke-dasharray="0" stroke-linecap="butt"></line></g>
								<g id="SvgjsG6073" class="apexcharts-area-series apexcharts-plot-series">
								<g id="SvgjsG6074" class="apexcharts-series" seriesName="seriesx1" data:longestSeries="true" rel="1" data:realIndex="0">
								<path id="SvgjsPath6096" d="M 0 173.73L 0 112.92450000000001C 16.93175048828125 112.92450000000001 31.444679478236612 125.95425 48.37642996651786 125.95425C 65.30818045479911 125.95425 79.82110944475447 86.86500000000001 96.75285993303572 86.86500000000001C 113.68461042131698 86.86500000000001 128.19753941127234 121.611 145.12928989955358 121.611C 162.06104038783482 121.611 176.5739693777902 34.74600000000001 193.50571986607144 34.74600000000001C 210.43747035435268 34.74600000000001 224.95039934430807 104.238 241.8821498325893 104.238C 258.8139003208706 104.238 273.32682931082593 65.14875 290.25857979910717 65.14875C 307.1903302873884 65.14875 321.70325927734376 91.20825 338.635009765625 91.20825C 338.635009765625 91.20825 338.635009765625 91.20825 338.635009765625 173.73M 338.635009765625 91.20825z" fill="url(#SvgjsLinearGradient6092)" fill-opacity="1" stroke-opacity="1" stroke-linecap="butt" stroke-width="0" stroke-dasharray="0" class="apexcharts-area" index="0"
										clip-path="url(#gridRectMaskgu2r951k)" pathTo="M 0 173.73L 0 112.92450000000001C 16.93175048828125 112.92450000000001 31.444679478236612 125.95425 48.37642996651786 125.95425C 65.30818045479911 125.95425 79.82110944475447 86.86500000000001 96.75285993303572 86.86500000000001C 113.68461042131698 86.86500000000001 128.19753941127234 121.611 145.12928989955358 121.611C 162.06104038783482 121.611 176.5739693777902 34.74600000000001 193.50571986607144 34.74600000000001C 210.43747035435268 34.74600000000001 224.95039934430807 104.238 241.8821498325893 104.238C 258.8139003208706 104.238 273.32682931082593 65.14875 290.25857979910717 65.14875C 307.1903302873884 65.14875 321.70325927734376 91.20825 338.635009765625 91.20825C 338.635009765625 91.20825 338.635009765625 91.20825 338.635009765625 173.73M 338.635009765625 91.20825z"
										pathFrom="M -1 217.1625L -1 217.1625L 48.37642996651786 217.1625L 96.75285993303572 217.1625L 145.12928989955358 217.1625L 193.50571986607144 217.1625L 241.8821498325893 217.1625L 290.25857979910717 217.1625L 338.635009765625 217.1625"></path>
								<path id="SvgjsPath6097" d="M 0 112.92450000000001C 16.93175048828125 112.92450000000001 31.444679478236612 125.95425 48.37642996651786 125.95425C 65.30818045479911 125.95425 79.82110944475447 86.86500000000001 96.75285993303572 86.86500000000001C 113.68461042131698 86.86500000000001 128.19753941127234 121.611 145.12928989955358 121.611C 162.06104038783482 121.611 176.5739693777902 34.74600000000001 193.50571986607144 34.74600000000001C 210.43747035435268 34.74600000000001 224.95039934430807 104.238 241.8821498325893 104.238C 258.8139003208706 104.238 273.32682931082593 65.14875 290.25857979910717 65.14875C 307.1903302873884 65.14875 321.70325927734376 91.20825 338.635009765625 91.20825" fill="none" fill-opacity="1" stroke="#696cff" stroke-opacity="1" stroke-linecap="butt" stroke-width="2" stroke-dasharray="0" class="apexcharts-area" index="0" clip-path="url(#gridRectMaskgu2r951k)"
										pathTo="M 0 112.92450000000001C 16.93175048828125 112.92450000000001 31.444679478236612 125.95425 48.37642996651786 125.95425C 65.30818045479911 125.95425 79.82110944475447 86.86500000000001 96.75285993303572 86.86500000000001C 113.68461042131698 86.86500000000001 128.19753941127234 121.611 145.12928989955358 121.611C 162.06104038783482 121.611 176.5739693777902 34.74600000000001 193.50571986607144 34.74600000000001C 210.43747035435268 34.74600000000001 224.95039934430807 104.238 241.8821498325893 104.238C 258.8139003208706 104.238 273.32682931082593 65.14875 290.25857979910717 65.14875C 307.1903302873884 65.14875 321.70325927734376 91.20825 338.635009765625 91.20825" pathFrom="M -1 217.1625L -1 217.1625L 48.37642996651786 217.1625L 96.75285993303572 217.1625L 145.12928989955358 217.1625L 193.50571986607144 217.1625L 241.8821498325893 217.1625L 290.25857979910717 217.1625L 338.635009765625 217.1625"></path>
								<g id="SvgjsG6075" class="apexcharts-series-markers-wrap" data:realIndex="0">
								<g id="SvgjsG6077" class="apexcharts-series-markers" clip-path="url(#gridRectMarkerMaskgu2r951k)">
								<circle id="SvgjsCircle6078" r="6" cx="0" cy="112.92450000000001" class="apexcharts-marker no-pointer-events wxq7y5m1u" stroke="transparent" fill="transparent" fill-opacity="1" stroke-width="4" stroke-opacity="0.9" rel="0" j="0" index="0" default-marker-size="6"></circle>
								<circle id="SvgjsCircle6079" r="6" cx="48.37642996651786" cy="125.95425" class="apexcharts-marker no-pointer-events w6xnmu7s2" stroke="transparent" fill="transparent" fill-opacity="1" stroke-width="4" stroke-opacity="0.9" rel="1" j="1" index="0" default-marker-size="6"></circle></g>
								<g id="SvgjsG6080" class="apexcharts-series-markers" clip-path="url(#gridRectMarkerMaskgu2r951k)">
								<circle id="SvgjsCircle6081" r="6" cx="96.75285993303572" cy="86.86500000000001" class="apexcharts-marker no-pointer-events w11nsw9n8" stroke="transparent" fill="transparent" fill-opacity="1" stroke-width="4" stroke-opacity="0.9" rel="2" j="2" index="0" default-marker-size="6"></circle></g>
								<g id="SvgjsG6082" class="apexcharts-series-markers" clip-path="url(#gridRectMarkerMaskgu2r951k)">
								<circle id="SvgjsCircle6083" r="6" cx="145.12928989955358" cy="121.611" class="apexcharts-marker no-pointer-events wf8h5vpf8" stroke="transparent" fill="transparent" fill-opacity="1" stroke-width="4" stroke-opacity="0.9" rel="3" j="3" index="0" default-marker-size="6"></circle></g>
								<g id="SvgjsG6084" class="apexcharts-series-markers" clip-path="url(#gridRectMarkerMaskgu2r951k)">
								<circle id="SvgjsCircle6085" r="6" cx="193.50571986607144" cy="34.74600000000001" class="apexcharts-marker no-pointer-events w1i24xg15" stroke="transparent" fill="transparent" fill-opacity="1" stroke-width="4" stroke-opacity="0.9" rel="4" j="4" index="0" default-marker-size="6"></circle></g>
								<g id="SvgjsG6086" class="apexcharts-series-markers" clip-path="url(#gridRectMarkerMaskgu2r951k)">
								<circle id="SvgjsCircle6087" r="6" cx="241.8821498325893" cy="104.238" class="apexcharts-marker no-pointer-events wtqj6f0k1" stroke="transparent" fill="transparent" fill-opacity="1" stroke-width="4" stroke-opacity="0.9" rel="5" j="5" index="0" default-marker-size="6"></circle></g>
								<g id="SvgjsG6088" class="apexcharts-series-markers" clip-path="url(#gridRectMarkerMaskgu2r951k)">
								<circle id="SvgjsCircle6089" r="6" cx="290.25857979910717" cy="65.14875" class="apexcharts-marker no-pointer-events w6guck20e" stroke="transparent" fill="transparent" fill-opacity="1" stroke-width="4" stroke-opacity="0.9" rel="6" j="6" index="0" default-marker-size="6"></circle></g>
								<g id="SvgjsG6090" class="apexcharts-series-markers" clip-path="url(#gridRectMarkerMaskgu2r951k)">
								<circle id="SvgjsCircle6091" r="6" cx="338.635009765625" cy="91.20825" class="apexcharts-marker no-pointer-events wno9mv1mn" stroke="#696cff" fill="#ffffff" fill-opacity="1" stroke-width="4" stroke-opacity="0.9" rel="7" j="7" index="0" default-marker-size="6"></circle></g></g></g>
								<g id="SvgjsG6076" class="apexcharts-datalabels" data:realIndex="0"></g></g>
								<line id="SvgjsLine6136" x1="0" y1="0" x2="338.635009765625" y2="0" stroke="#b6b6b6" stroke-dasharray="0" stroke-width="1" stroke-linecap="butt" class="apexcharts-ycrosshairs"></line>
								<line id="SvgjsLine6137" x1="0" y1="0" x2="338.635009765625" y2="0" stroke-dasharray="0" stroke-width="0" stroke-linecap="butt" class="apexcharts-ycrosshairs-hidden"></line>
								<g id="SvgjsG6138" class="apexcharts-yaxis-annotations"></g>
								<g id="SvgjsG6139" class="apexcharts-xaxis-annotations"></g>
								<g id="SvgjsG6140" class="apexcharts-point-annotations"></g>
								<rect id="SvgjsRect6141" width="0" height="0" x="0" y="0" rx="0" ry="0" opacity="1" stroke-width="0" stroke="none" stroke-dasharray="0" fill="#fefefe" class="apexcharts-zoom-rect"></rect>
								<rect id="SvgjsRect6142" width="0" height="0" x="0" y="0" rx="0" ry="0" opacity="1" stroke-width="0" stroke="none" stroke-dasharray="0" fill="#fefefe" class="apexcharts-selection-rect"></rect></g>
								<rect id="SvgjsRect6069" width="0" height="0" x="0" y="0" rx="0" ry="0" opacity="1" stroke-width="0" stroke="none" stroke-dasharray="0" fill="#fefefe"></rect>
								<g id="SvgjsG6124" class="apexcharts-yaxis" rel="0" transform="translate(-8, 0)">
								<g id="SvgjsG6125" class="apexcharts-yaxis-texts-g"></g></g>
								<g id="SvgjsG6067" class="apexcharts-annotations"></g></svg>
								<div class="apexcharts-legend" style="max-height: 107.5px;"></div>
								<div class="apexcharts-tooltip apexcharts-theme-light">
									<div class="apexcharts-tooltip-title" style="font-family: Helvetica, Arial, sans-serif; font-size: 12px;"></div>
									<div class="apexcharts-tooltip-series-group" style="order: 1;">
										<span class="apexcharts-tooltip-marker" style="background-color: rgb(105, 108, 255);"></span>
										<div class="apexcharts-tooltip-text" style="font-family: Helvetica, Arial, sans-serif; font-size: 12px;">
											<div class="apexcharts-tooltip-y-group">
												<span class="apexcharts-tooltip-text-y-label"></span><span class="apexcharts-tooltip-text-y-value"></span>
											</div>
											<div class="apexcharts-tooltip-goals-group">
												<span class="apexcharts-tooltip-text-goals-label"></span><span class="apexcharts-tooltip-text-goals-value"></span>
											</div>
											<div class="apexcharts-tooltip-z-group">
												<span class="apexcharts-tooltip-text-z-label"></span><span class="apexcharts-tooltip-text-z-value"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="apexcharts-xaxistooltip apexcharts-xaxistooltip-bottom apexcharts-theme-light">
									<div class="apexcharts-xaxistooltip-text" style="font-family: Helvetica, Arial, sans-serif; font-size: 12px;"></div>
								</div>
								<div class="apexcharts-yaxistooltip apexcharts-yaxistooltip-0 apexcharts-yaxistooltip-left apexcharts-theme-light">
									<div class="apexcharts-yaxistooltip-text"></div>
								</div>
							</div>
						</div>
						<div class="d-flex justify-content-center pt-4 gap-2">
							<div class="flex-shrink-0" style="position: relative;">
								<div id="expensesOfWeek" style="min-height: 57.7px;">
									<div id="apexcharts5bbdpvjy" class="apexcharts-canvas apexcharts5bbdpvjy apexcharts-theme-light" style="width: 60px; height: 57.7px;">
										<svg id="SvgjsSvg5888" width="60" height="57.7" xmlns="http://www.w3.org/2000/svg" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:svgjs="http://svgjs.dev" class="apexcharts-svg" xmlns:data="ApexChartsNS" transform="translate(0, 0)" style="background: transparent;">
										<g id="SvgjsG5890" class="apexcharts-inner apexcharts-graphical" transform="translate(-10, -10)">
										<defs id="SvgjsDefs5889">
										<clipPath id="gridRectMask5bbdpvjy">
										<rect id="SvgjsRect5892" width="86" height="87" x="-3" y="-1" rx="0" ry="0" opacity="1" stroke-width="0" stroke="none" stroke-dasharray="0" fill="#fff"></rect></clipPath>
										<clipPath id="forecastMask5bbdpvjy"></clipPath>
										<clipPath id="nonForecastMask5bbdpvjy"></clipPath>
										<clipPath id="gridRectMarkerMask5bbdpvjy">
										<rect id="SvgjsRect5893" width="84" height="89" x="-2" y="-2" rx="0" ry="0" opacity="1" stroke-width="0" stroke="none" stroke-dasharray="0" fill="#fff"></rect></clipPath></defs>
										<g id="SvgjsG5894" class="apexcharts-radialbar">
										<g id="SvgjsG5895">
										<g id="SvgjsG5896" class="apexcharts-tracks">
										<g id="SvgjsG5897" class="apexcharts-radialbar-track apexcharts-track" rel="1">
										<path id="apexcharts-radialbarTrack-0" d="M 40 18.098170731707313 A 21.901829268292687 21.901829268292687 0 1 1 39.99617740968999 18.098171065291247" fill="none" fill-opacity="1" stroke="rgba(236,238,241,0.85)" stroke-opacity="1" stroke-linecap="round" stroke-width="2.0408536585365864" stroke-dasharray="0" class="apexcharts-radialbar-area" data:pathOrig="M 40 18.098170731707313 A 21.901829268292687 21.901829268292687 0 1 1 39.99617740968999 18.098171065291247"></path></g></g>
										<g id="SvgjsG5899">
										<g id="SvgjsG5903" class="apexcharts-series apexcharts-radial-series" seriesName="seriesx1" rel="1" data:realIndex="0">
										<path id="SvgjsPath5904" d="M 40 18.098170731707313 A 21.901829268292687 21.901829268292687 0 1 1 22.2810479140526 52.873572242130095" fill="none" fill-opacity="0.85" stroke="rgba(105,108,255,0.85)" stroke-opacity="1" stroke-linecap="round" stroke-width="4.081707317073173" stroke-dasharray="0" class="apexcharts-radialbar-area apexcharts-radialbar-slice-0" data:angle="234" data:value="65" index="0" j="0" data:pathOrig="M 40 18.098170731707313 A 21.901829268292687 21.901829268292687 0 1 1 22.2810479140526 52.873572242130095"></path></g>
										<circle id="SvgjsCircle5900" r="18.881402439024395" cx="40" cy="40" class="apexcharts-radialbar-hollow" fill="transparent"></circle>
										<g id="SvgjsG5901" class="apexcharts-datalabels-group" transform="translate(0, 0) scale(1)" style="opacity: 1;">
										<text id="SvgjsText5902" font-family="Helvetica, Arial, sans-serif" x="40" y="45" text-anchor="middle" dominant-baseline="auto" font-size="13px" font-weight="400" fill="#697a8d" class="apexcharts-text apexcharts-datalabel-value" style="font-family: Helvetica, Arial, sans-serif;">$65</text></g></g></g></g>
										<line id="SvgjsLine5905" x1="0" y1="0" x2="80" y2="0" stroke="#b6b6b6" stroke-dasharray="0" stroke-width="1" stroke-linecap="butt" class="apexcharts-ycrosshairs"></line>
										<line id="SvgjsLine5906" x1="0" y1="0" x2="80" y2="0" stroke-dasharray="0" stroke-width="0" stroke-linecap="butt" class="apexcharts-ycrosshairs-hidden"></line></g>
										<g id="SvgjsG5891" class="apexcharts-annotations"></g></svg>
										<div class="apexcharts-legend"></div>
									</div>
								</div>
								<div class="resize-triggers">
									<div class="expand-trigger">
										<div style="width: 61px; height: 59px;"></div>
									</div>
									<div class="contract-trigger"></div>
								</div>
							</div>
							<div>
								<p class="mb-n1 mt-1">Expenses This Week</p>
								<small class="text-muted">$39 less than last week</small>
							</div>
						</div>
						<div class="resize-triggers">
							<div class="expand-trigger">
								<div style="width: 357px; height: 377px;"></div>
							</div>
							<div class="contract-trigger"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
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