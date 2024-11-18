<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
	let pageNo = 1;
	let pagingSize = 10;
	let pageCntPerBlock = 10;
	let filteredData;
	let checkedMemberIdList = [];
	let selectedCouponNo; 
	
	$(function() {
		$('[name="birthday_end"]').val(
				new Date().toISOString().substring(0, 10));

		$('[name="reg_date_end"]').val(
				new Date().toISOString().substring(0, 10));

		$('#searchFilter').on(
				'submit',
				function(event) {
					event.preventDefault(); // 기본 폼 제출 방지

					let formData = $(this).serializeArray();

					formData.forEach(function(item) {
						// date(string) to Timestamp
						if (item.name == 'birthday_start') {
							if (item.value == '') {
								item.value = 19000101;
							} else {
								item.value =  parseInt(item.value.replaceAll("-", ''));
							}
						}
						
						if(item.name == 'birthday_end'){
							if (item.value == '') {
								item.value = new Date().toISOString().substring(0, 10); 
							} 
							item.value =  parseInt(item.value.replaceAll("-", ''));
						}

						if (item.name == 'reg_date_start') {
							if (item.value == '') {
								item.value += "1900-01-01 00:00:00";
							} else {
								item.value += " 00:00:00";
							}
						}
						
						if(item.name == 'reg_date_end') {
							if (item.value == '') {
								item.value = new Date().toISOString().substring(0, 10);
							}
							
							item.value += " 23:59:59";
						}
						
					});
					
					filteredData = formData;
					
					showFilterdMemberList(1);
					
				});
		
		// 체크 박스 설정
		$(document).on('change', '[name="checkMember"]', function() {
			let checkBoxId = $(this).attr("id");
	        let memberId = checkBoxId.replace("checkbox-", "");
	        	        
	        if($(this).is(':checked')) {
	        	checkedMemberIdList.push(memberId);	
	        } else {
	        	let indexToRemove = checkedMemberIdList.indexOf(memberId);
	        	
	        	if (indexToRemove !== -1) {
	        		checkedMemberIdList.splice(indexToRemove, 1);
	        	}
	        }
	        
	        console.log(checkedMemberIdList);
	        
	        if(checkedMemberIdList.length == 0){
	        	$('#payCouponAllBtn').prop('disabled', false);
	        	$('#payCouponBtn').prop('disabled', true);
	        } else {
	        	$('#payCouponAllBtn').prop('disabled', true);
	        	$('#payCouponBtn').prop('disabled', false)
	        }
	    });
		
		// 쿠폰 지급 취소(Close 버튼 클릭)
		$('#couponPayModalCloseBtn').on('click', function() {
			$('#couponPayModal').modal('hide');
			resetCouponEditModal();
		});
		
		
		// 모달이 닫힐 때 이벤트를 처리
	    $('#couponPayModal').on('hidden.bs.modal', function () {
	    	let indexToRemove = checkedMemberIdList.indexOf("All");
        	
        	if (indexToRemove !== -1) {
        		checkedMemberIdList.splice(indexToRemove, 1);
        	}
	    	
	    	resetCouponEditModal();
	    });
		
		// 성별 체크박스 최소 한개 선택
	    $('input[name="genders"]').change(function() {
	        // 체크된 체크박스 수 확인
	        var checkedCount = $('input[name="genders"]:checked').length;
	        
	        // 체크박스가 하나도 체크되어 있지 않을 경우, 체크를 해제하지 않음
	        if (checkedCount === 0) {
	            $(this).prop('checked', true); // 체크를 유지
	        }
	    });
		
		// 레벨 체크박스 최소 한개 선택
	    $('input[name="levels"]').change(function() {
	        // 체크된 체크박스 수 확인
	        var checkedCount = $('input[name="levels"]:checked').length;
	        
	        // 체크박스가 하나도 체크되어 있지 않을 경우, 체크를 해제하지 않음
	        if (checkedCount === 0) {
	            $(this).prop('checked', true); // 체크를 유지
	        }
	    });
		
		
		getCouponList();
	});
	
	// 쿠폰 리스트 가져오기
	function getCouponList(){
		$.ajax({
			url : '/admin/coupon/getCouponList',
			type : 'GET',
			dataType: 'json',
			success : function(data) {
				console.log(data);
				
				let output = '';
				
				data.forEach(function(coupon){
					console.log(coupon);
					let json = JSON.stringify(coupon);
					console.log(json);
					
					output += `<li><a class="dropdown-item" href="javascript:void(0);" onclick='selectCoupon(\${json})'>\${coupon.coupon_name}</a></li>`
				})
				
				$("#couponListDropdown").html(output);
				
			},
			error : function(error) {
				console.log(error);
			}
		
		});
	}
	
	// 멤버 리스트 보여주기
	function showMemberList(pageNo) {
		$.ajax({
			url : '/admin/member/getAllMembers',
			type : 'GET',
			dataType: 'json',
			data : {
				"pageNo" : pageNo,
				"pagingSize" : pagingSize,
				"pageCntPerBlock" : pageCntPerBlock
			},
			success : function(data) {
				console.log(data);

				let listOutput = '';
				let paginationOutput = '';
				
				$.each(data.list, function(index, member) {
					let timestamp = member.reg_date;
					let date = new Date(timestamp);
					
					let year = date.getFullYear();
					let month = String(date.getMonth() + 1).padStart(2, '0'); 
					let day = String(date.getDate()).padStart(2, '0'); 

				    date = `\${year}-\${month}-\${day}`; // YYYY-MM-DD 형식으로 반환
					
					listOutput += '<tr>' 
							+ `<td>\${member.member_id}</td>`
							+ `<td>\${member.member_name}</td>` 
							+ `<td>\${member.phone_number}</td>` 
							+ `<td>\${member.birthday}</td>`
							+ `<td>\${member.gender}</td>`
							+ `<td>\${member.member_level}</td>`
							+ `<td>\${date}</td>`;
							
							if(checkedMemberIdList.includes(`\${member.member_id}`)) {
								listOutput += `<td><input name="checkMember" class="form-check-input" type="checkbox" value="" id="checkbox-\${member.member_id}" checked /></td>`	
							} else {
								listOutput += `<td><input name="checkMember" class="form-check-input" type="checkbox" value="" id="checkbox-\${member.member_id}" /></td>`
							}
							
							listOutput += '</tr>';
							
					
				});

				$('#memberTableBody').html(listOutput);
				
				if(data.pi.pageNo == 1){
					paginationOutput += `<li class="page-item prev disabled"><a class="page-link" href="javascript:void(0);"><i class="tf-icon bx bx-chevrons-left"></i></a></li>`;	
				} else {
					paginationOutput += `<li class="page-item prev"><a class="page-link" href="javascript:void(0);" onclick="showMemberList(\${data.pi.pageNo} - 1)"><i class="tf-icon bx bx-chevrons-left"></i></a></li>`;
				}
				
				
				for(let i = data.pi.startPageNoCurBloack; i < data.pi.endPageNoCurBlock + 1; i++){
					if(i == data.pi.pageNo) {
						paginationOutput += `<li class="page-item active"><a class="page-link" href="javascript:void(0);" onclick="showMemberList(\${i})">\${i}</a></li>`;
					} else {
						paginationOutput += `<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick="showMemberList(\${i})">\${i}</a></li>`;	
					}
				}
				
				
				if(data.pi.pageNo == data.pi.totalPageCnt){
					paginationOutput +=	`<li class="page-item next disabled"><a class="page-link" href="javascript:void(0);"><i class="tf-icon bx bx-chevrons-right"></i></a></li>`;
				} else {
					paginationOutput +=	`<li class="page-item next"><a class="page-link" href="javascript:void(0);" onclick="showMemberList(\${data.pi.pageNo} + 1)"><i class="tf-icon bx bx-chevrons-right"></i></a></li>`;
				}
				
				$('.pagination').html(paginationOutput);
				
				
			},
			error : function(error) {
				console.log(error);
			}
		});
	}
	
	// 멤버 리스트 보여주기(필터)
	function showFilterdMemberList(pageNo){
		let found = false;
		
		filteredData.forEach(function(item) {
	        if (item.name === "pageNo") {
	            item.value = pageNo; // 값을 업데이트
	            found = true;
	        }
	        
	        if (!found) {
	        	filteredData.push({name: 'pageNo',value: pageNo })
	    		filteredData.push({name: 'pagingSize',value: pagingSize })
	    		filteredData.push({name: 'pageCntPerBlock',value: pageCntPerBlock })
	        }
	        
	        console.log(item);
	    });
		
		$.ajax({
			url : '/admin/member/getFilteredMembers',
			type : 'POST',
			data : filteredData,
			dataType: 'json',
			success : function(data) {
				

				let listOutput = '';
				let paginationOutput = '';
				let noDataTableBody = `<tr id="noDataTableBody">
			        <td colspan="100%" class="text-center p-3">
		            	<div class="d-flex justify-content-center">검색된 회원이 없습니다.</div>
			        </td>
			    </tr>`;
					
			    if(data.list.length != 0){
					$.each(data.list, function(index, member) {
						let timestamp = member.reg_date;
						let date = new Date(timestamp);
						
						let year = date.getFullYear();
						let month = String(date.getMonth() + 1).padStart(2, '0'); 
						let day = String(date.getDate()).padStart(2, '0'); 

					    date = `\${year}-\${month}-\${day}`; // YYYY-MM-DD 형식으로 반환
						
						listOutput += '<tr>' 
								+ `<td>\${member.member_id}`
								+ `<td>\${member.member_name}</td>` 
								+ `<td>\${member.phone_number}</td>` 
								+ `<td>\${member.birthday}</td>`
								+ `<td>\${member.gender}</td>`
								+ `<td>\${member.member_level}</td>`
								+ `<td>\${date}</td>`;
								
								if(checkedMemberIdList.includes(`\${member.member_id}`)) {
									listOutput += `<td><input name="checkMember" class="form-check-input" type="checkbox" value="" id="checkbox-\${member.member_id}" checked /></td>`	
								} else {
									listOutput += `<td><input name="checkMember" class="form-check-input" type="checkbox" value="" id="checkbox-\${member.member_id}" /></td>`
								}		
								
								
						listOutput += '</tr>';
					});

					$('#memberTableBody').html(listOutput);
					
					if(data.pi.pageNo == 1){
						paginationOutput += `<li class="page-item prev disabled"><a class="page-link" href="javascript:void(0);"><i class="tf-icon bx bx-chevrons-left"></i></a></li>`;	
					} else {
						paginationOutput += `<li class="page-item prev"><a class="page-link" href="javascript:void(0);" onclick="showFilterdMemberList(\${data.pi.pageNo} - 1)"><i class="tf-icon bx bx-chevrons-left"></i></a></li>`;
					}
					
					
					for(let i = data.pi.startPageNoCurBloack; i < data.pi.endPageNoCurBlock + 1; i++){
						if(i == data.pi.pageNo) {
							paginationOutput += `<li class="page-item active"><a class="page-link" href="javascript:void(0);" onclick="showFilterdMemberList(\${i})">\${i}</a></li>`;
						} else {
							paginationOutput += `<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick="showFilterdMemberList(\${i})">\${i}</a></li>`;	
						}
					}
					
					
					if(data.pi.pageNo == data.pi.totalPageCnt){
						paginationOutput +=	`<li class="page-item next disabled"><a class="page-link" href="javascript:void(0);"><i class="tf-icon bx bx-chevrons-right"></i></a></li>`;
					} else {
						paginationOutput +=	`<li class="page-item next"><a class="page-link" href="javascript:void(0);" onclick="showFilterdMemberList(\${data.pi.pageNo} + 1)"><i class="tf-icon bx bx-chevrons-right"></i></a></li>`;
					}
					
					$('.pagination').html(paginationOutput);
					$('#payCouponAllBtn').prop('disabled', false);
				} else {
					$('#memberTableBody').html(noDataTableBody);
					$('.pagination').html("");
					$('#payCouponAllBtn').prop('disabled', true);
				}
			},
			error : function(error) {
				console.log(error);
			}
		
		})
	}
	
	// 쿠폰 지급 버튼 클릭(모달창 열기)
	function openPayCouponModal(member){
		if(member == 'all'){
			$('#numberOfMembers').val("All");
			checkedMemberIdList = ["All"];
			console.log(checkedMemberIdList);
		} else {
			$('#numberOfMembers').val(checkedMemberIdList.length);	
		}
	}
	
	// 쿠폰 설정
	function selectCoupon(coupon) {
		$('#selectCouponBtn').text(coupon.coupon_name);
		
		let couponType = coupon.coupon_dc_type;
		$('#couponType').val(couponType);
		
		if(couponType == 'A'){
			$('#couponDc').val(coupon.coupon_dc_amount);	
		} else {
			$('#couponDc').val(coupon.coupon_dc_rate);
		}
		
		$('#couponUseDays').val(coupon.coupon_use_days);
		
		selectedCouponNo = coupon.coupon_no;
		$("#couponPayBtn").prop("disabled", false);
	}
	
	// 쿠폰 지급
	function payCoupon(){
		$.ajax({
			url : '/admin/coupon/payCoupon',
			type : 'POST',
			contentType: 'application/json',
			data: JSON.stringify({
				"memberIdList" : checkedMemberIdList,
				"couponNo" :  selectedCouponNo
			}),
			success : function(data) {
				console.log(data);
				$('#couponPayModal').modal('hide');
				checkedMemberIdList = [];
				console.log(checkedMemberIdList);
				showMemberList(pageNo);
				
			},
			error : function(error) {
				console.log(error);
			}
		
		})
	}
	
	// 모달 초기화
	function resetCouponEditModal(){
		$('#selectCouponBtn').text('쿠폰 선택');
		$('#couponType').val('');
		$('#couponDc').val('');
		$('#couponUseDays').val('');
		$("#couponPayBtn").prop('disabled', true);
	}
	
	
</script>
</head>
<style>
table tr:not(#noDataTableBody) {
	font-size: 0.75rem;
}

#payCouponBtnSapce {
	display: flex;
	flex-direction: row;
	justify-content: right;
}

#couponListDropdown {
	max-height: 30vh;
	overflow-y: auto;
}
</style>
<body>
	<!-- Layout wrapper -->
	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">
			<!-- Menu -->

			<!-- Menu -->

			<jsp:include page="/WEB-INF/views/admin/components/sideBar.jsp">

				<jsp:param name="pageName" value="couponPay" />

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
						<div class="card accordion-item active">
							<h2 class="accordion-header" id="headingOne">
								<button type="button" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#accordionOne" aria-expanded="false" aria-controls="accordionOne">
									<h5>필터</h5>
								</button>
							</h2>

							<div id="accordionOne" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
								<div class="accordion-body">
									<form id="searchFilter">
										<div class="row mb-3">
											<label class="col-sm-2 col-form-label" for="basic-default-name">성별</label>
											<div class="col-sm-10 d-flex align-items-center">
												<div class="form-check-inline">
													<input name="genders" class="form-check-input" type="checkbox" value="N" id="gender_none" checked /> <label class="form-check-label" for="gender_none"> None </label>
												</div>
												<div class="form-check-inline">
													<input name="genders" class="form-check-input" type="checkbox" value="M" id="gender_male" checked /> <label class="form-check-label" for="gender_male"> Male </label>
												</div>
												<div class="form-check-inline">
													<input name="genders" class="form-check-input" type="checkbox" value="F" id="gender_feMale" checked /> <label class="form-check-label" for="gender_feMale"> Female </label>
												</div>
											</div>
										</div>
										<div class="row mb-3">
											<label class="col-sm-2 col-form-label" for="basic-default-name">등급</label>
											<div class="col-sm-10 d-flex align-items-center">
												<div class="form-check-inline">
													<input name="levels" class="form-check-input" type="checkbox" value="1" id="level_bronze" checked /> <label class="form-check-label" for="level_bronze"> Bronze </label>
												</div>
												<div class="form-check-inline">
													<input name="levels" class="form-check-input" type="checkbox" value="2" id="level_silver" checked /> <label class="form-check-label" for="level_silver"> Silver </label>
												</div>
												<div class="form-check-inline">
													<input name="levels" class="form-check-input" type="checkbox" value="3" id="level_gold" checked /> <label class="form-check-label" for="level_gold"> Gold </label>
												</div>
												<div class="form-check-inline">
													<input name="levels" class="form-check-input" type="checkbox" value="4" id="level_diamond" checked /> <label class="form-check-label" for="level_diamond"> Diamond </label>
												</div>
											</div>
										</div>
										<div class="row mb-3">
											<label class="col-sm-2 col-form-label" for="member_id">회원 ID</label>
											<div class="col-sm-10">
												<input type="text" name="member_id" id="" class="form-control" placeholder="member_id" aria-label="" aria-describedby="" />
											</div>
										</div>
										<div class="row mb-3">
											<label class="col-sm-2 col-form-label" for="member_name">회원 이름</label>
											<div class="col-sm-10">
												<input type="text" name="member_name" id="" class="form-control" placeholder="member_name" aria-label="" aria-describedby="" />
											</div>
										</div>
										<div class="row mb-3">
											<label class="col-sm-2 col-form-label" for="basic-default-name">생년월일</label>
											<div class="col-sm-10 d-flex align-items-center">
												<div class="form-check-inline">
													<input name="birthday_start" class="form-control" type="date" value="" id="">
												</div>
												<div class="form-check-inline">
													<span class="mx-2">-</span>
												</div>
												<div class="form-check-inline">
													<input name="birthday_end" class="form-control" type="date" value="" id="">
												</div>
											</div>
										</div>
										<div class="row mb-3">
											<label class="col-sm-2 col-form-label" for="basic-default-name">가입일</label>
											<div class="col-sm-10 d-flex align-items-center">
												<div class="form-check-inline">
													<input name="reg_date_start" class="form-control" type="date" value="" id="">
												</div>
												<div class="form-check-inline">
													<span class="mx-2">-</span>
												</div>
												<div class="form-check-inline">
													<input name="reg_date_end" class="form-control" type="date" value="" id="">
												</div>
											</div>
										</div>
										<div class="row justify-content-end">
											<div class="col-sm-10">
												<button type="submit" class="btn btn-primary">Search</button>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>

						<div class="card mt-4">
							<h5 class="card-header">회원 목록</h5>
							<div class="table-responsive text-nowrap">
								<table class="table">
									<thead class="table-light">
										<tr>
											<th>회원 id</th>
											<th>회원 이름</th>
											<th>휴대폰번호</th>
											<th>생년월일</th>
											<th>성별</th>
											<th>레벨</th>
											<th>가입일</th>
											<th>선택</th>
										</tr>
									</thead>
									<tbody id="memberTableBody" class="table-border-bottom-0">
										<c:forEach var="member" items="${memberData.list}">
											<tr>
												<td>${member.member_id}</td>
												<td>${member.member_name}</td>
												<td>${member.phone_number}</td>
												<td>${member.birthday}</td>
												<td>${member.gender}</td>
												<td>${member.member_level}</td>
												<td><fmt:formatDate value="${member.reg_date}" pattern="yyyy-MM-dd" /></td>
												<td><input name="checkMember" class="form-check-input" type="checkbox" value="" id="checkbox-${member.member_id}" /></td>
											</tr>
										</c:forEach>

									</tbody>
								</table>
							</div>

							<!-- 페이지 네이션 -->
							<div class="mt-4">
								<nav aria-label="Page navigation">
									<ul class="pagination justify-content-center">
										<c:choose>
											<c:when test="${memberData.pi.pageNo == 1}">
												<li class="page-item prev disabled"><a class="page-link" href="javascript:void(0);"><i class="tf-icon bx bx-chevrons-left"></i></a></li>
											</c:when>
											<c:otherwise>
												<li class="page-item prev"><a class="page-link" href="javascript:void(0);"><i class="tf-icon bx bx-chevrons-left"></i></a></li>
											</c:otherwise>
										</c:choose>

										<c:forEach var="i" begin="${memberData.pi.startPageNoCurBloack}" end="${memberData.pi.endPageNoCurBlock}">
											<c:choose>
												<c:when test="${memberData.pi.pageNo == i}">
													<li class="page-item active"><a class="page-link" href="javascript:void(0);" onclick="showMemberList(${memberData.pi.pageNo})">${i}</a></li>
												</c:when>
												<c:otherwise>
													<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick="showMemberList(${i})">${i}</a></li>
												</c:otherwise>
											</c:choose>

										</c:forEach>

										<c:choose>
											<c:when test="${memberData.pi.pageNo == memberData.pi.totalPageCnt}">
												<li class="page-item disabled"><a class="page-link" href="javascript:void(0);"><i class="tf-icon bx bx-chevrons-right"></i></a></li>
											</c:when>
											<c:otherwise>
												<li class="page-item next"><a class="page-link" href="javascript:void(0);"><i class="tf-icon bx bx-chevrons-right"></i></a></li>
											</c:otherwise>
										</c:choose>

									</ul>
								</nav>
							</div>
							<!-- / 페이지 네이션 -->

						</div>

						<!-- 회원 체크 리스트 -->


						<!-- 쿠폰 지급 버튼 -->
						<div id="payCouponBtnSapce">
							<button id="payCouponAllBtn" type="button" class="btn btn-outline-primary mt-4 me-1" data-bs-toggle="modal" data-bs-target="#couponPayModal" onclick="openPayCouponModal('all')">전체 지급</button>
							<button id="payCouponBtn" type="button" class="btn btn-outline-primary mt-4" data-bs-toggle="modal" data-bs-target="#couponPayModal" onclick="openPayCouponModal()" disabled>쿠폰 지급</button>
						</div>
						<!-- / 쿠폰 지급 버튼 -->

						<!-- 쿠폰 지급 확인 모달 -->
						<div id="couponPayModal" class="modal fade" tabindex="-1" aria-hidden="true">
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="editModalTitle">쿠폰 지급</h5>
										<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body">
										<div class="row mb-3">
											<label class="col-sm-3 col-form-label" for="member_id">쿠폰 지급 인원 수</label>
											<div class="col-sm-9">
												<input id=numberOfMembers type="text" name="" id="" class="form-control" placeholder="member_id" aria-label="" aria-describedby="" readonly />
											</div>
										</div>

										<div class="row mb-3">
											<label class="col-sm-3 col-form-label" for="basic-default-name">쿠폰</label>
											<div class="col-sm-9 d-flex align-items-center">
												<div class="col mb-0">
													<button id="selectCouponBtn" type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">쿠폰 선택</button>
													<ul id="couponListDropdown" class="dropdown-menu">
													</ul>
												</div>
											</div>
										</div>

										<div class="row mb-3">
											<label class="col col-form-label" for="">쿠폰 타입</label>
											<div class="col-sm-9">
												<input id="couponType" type="text" name="" id="" class="form-control" placeholder="Type" aria-label="" aria-describedby="" readonly />
											</div>
										</div>

										<div class="row mb-3">
											<label class="col col-form-label" for="">할인 금액 / 할인률</label>
											<div class="col-sm-9">
												<input id="couponDc" type="text" name="" id="" class="form-control" placeholder="Amount / Rate" aria-label="" aria-describedby="" readonly />
											</div>
										</div>

										<div class="row mb-3">
											<label class="col col-form-label" for="">사용 기한</label>
											<div class="col-sm-9">
												<input id="couponUseDays" type="text" name="" id="" class="form-control" placeholder="Use Days" aria-label="" aria-describedby="" readonly />
											</div>
										</div>
									</div>

									<div class="modal-footer">
										<button id="couponPayModalCloseBtn" type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="">Close</button>
										<button id="couponPayBtn" type="button" class="btn btn-primary" onclick="payCoupon()" disabled>Pay</button>
									</div>

								</div>
							</div>
							<!-- / 쿠폰 지급 확인 모달 -->
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
