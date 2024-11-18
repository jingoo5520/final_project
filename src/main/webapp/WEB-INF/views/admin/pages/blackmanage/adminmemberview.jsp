<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<script>
function showToast(title, content) {
	$('#toastTitle').text(title); // 토스트 메시지 제목
    $('#toastBody').text(content); // 토스트 메시지 내용
    
    var toastElement = $('#toastMessage');
    toastElement.removeClass('hide').addClass('show');

	 setTimeout(function() {
		 toastElement.hide();
       }, 2000);
} 
let pageNo = 1;
let pagingSize =10;
let checkedMemberIdList = [];
function PageNation(data) {
	if (data.MemberList && data.MemberList.length != 0) {
 let paginationOutput = "";
    if (data.PagingInfo.pageNo == 1) {
        paginationOutput += `<li class="page-item prev disabled"><a class="page-link" href="javascript:void(0);"><i class="tf-icon bx bx-chevrons-left"></i></a></li>`;
    } else {
        paginationOutput += `<li class="page-item prev"><a class="page-link" href="javascript:void(0);"onclick="showMemberList(\${data.PagingInfo.pageNo - 1})"><i class="tf-icon bx bx-chevrons-left"></i></a></li>`;
    }

    for (let i = data.PagingInfo.startPageNoCurBlock; i <= data.PagingInfo.endPageNoCurBlock; i++) {
    	console.log(i);
        if (i == data.PagingInfo.pageNo) {
            paginationOutput += `<li class="page-item active"><a class="page-link" href="javascript:void(0);" onclick="showMemberList(\${i})">\${i}</a></li>`;
        } else {
            paginationOutput += `<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick="showMemberList(\${i})">\${i}</a></li>`;
        }
    }

    if (data.PagingInfo.pageNo == data.PagingInfo.totalPageCnt) {
        paginationOutput += `<li class="page-item next disabled"><a class="page-link" href="javascript:void(0);"><i class="tf-icon bx bx-chevrons-right"></i></a></li>`;
    } else {
        paginationOutput += `<li class="page-item next"><a class="page-link" href="javascript:void(0);" onclick="showMemberList(\${data.PagingInfo.pageNo + 1})"><i class="tf-icon bx bx-chevrons-right"></i></a></li>`;
    }

    $('.pagination').html(paginationOutput);

} else {
    $('#memberTableBody').html("");
    $('.pagination').html("");
}
}
function openBlackCancelModal(memberId) {
    // 모달의 특정 요소에 member_id 표시
    $("#modalMemberId").text(memberId);

    // 확인 버튼에 member_id 저장
    $("#confirmCancelBlack").data("member-id", memberId);
}
$(function () {
	
	// 확인 버튼 클릭 시 블랙 취소 요청
	$("#confirmCancelBlack").click(function() {
	    const memberId = $(this).data("member-id");
		console.log(memberId);
	    // AJAX 요청으로 블랙 취소
	    $.ajax({
	        url: '/admin/memberView/cancelBlack',
	        type: 'POST',
	        contentType: 'application/json',
	        data: JSON.stringify({ member_id: memberId }),
	        success: function(response) {
	      
	            showMemberList(pageNo); // 테이블 갱신
	        	$('#toastTitle').text("성공"); // 토스트 메시지 제목
	            $('#toastBody').text("회원 블랙취소에 성공하였습니다"); // 토스트 메시지 내용
	            $("#blackCancelModal").modal('hide');
	            var toastElement = $('#toastMessage');
	            toastElement.removeClass('hide').addClass('show');
	            setTimeout(function() {
	       		 toastElement.hide();
	              }, 2000);
	        },
	        error: function(error) {
	            console.log("AJAX 에러:", error);
	            $('#toastTitle').text("실패"); // 토스트 메시지 제목
	            $('#toastBody').text("회원 블랙취소에 실패하였습니다"); // 토스트 메시지 내용
	            $("#blackCancelModal").modal('hide');
	            var toastElement = $('#toastMessage');
	            toastElement.removeClass('hide').addClass('show');
	            setTimeout(function() {
	       		 toastElement.hide();
	              }, 2000);
	         
	        }
	    });
	});
	
	$(document).on('click','.memberCheckBox' , function() {
		let value = $(this).val();
		if($(this).is(':checked')) {
			if(!checkedMemberIdList.includes(value)){
				checkedMemberIdList.push(value);
			}
		} else {
			checkedMemberIdList = checkedMemberIdList.filter(function(item) {
	            return item !== value;
	        });
		}
		console.log(checkedMemberIdList); 
})
	$(document).on('click', '#blackMember' , function () {
		$('#selectedIds').empty();
		const idListElement = $('#selectedIds');
		$.each(checkedMemberIdList, function (i,id) {
		   idListElement.append(`<li class="list-group-item">\${id}</li>`);
		   
		   
	});	
		
		
});
	 
	$("#confirmDeleteBtn").on('click', function() {
		let list = [];
		$.each(checkedMemberIdList, function(i,id) {
			list.push(id);
			
		});

		$.ajax({
			url : '/admin/memberView/blackMembers' ,
			type :'POST' ,
			 contentType: 'application/json; charset=UTF-8',
			 data: JSON.stringify({ MemberIdList: list }), 
	
			success: function(data) {
				$("#blackMemberModal").modal('hide');
				 showToast("성공", "회원을 블랙 했습니다");
			} ,
			error: function(error) {
			    console.log("AJAX 에러:", error);
			    showToast("실패", "회원을 블랙 실패");
			}	
		});
	});

	$("#searchMember").on('click', function() {
		pageNo =1;
	var genderList = $('input[name="genders"]:checked').map(function() {
		return $(this).val();
	}).get();
	var levelList = $('input[name="levels"]:checked').map(function() {
		return $(this).val();
	}).get();
	var memberId = $('input[name="member_id"]').val();
	var member_name = $('input[name="member_name"]').val();
	var isBlack = $('input[name="isBlack"]:checked').val();
	var regDateStart = $('input[name="reg_date_start"]').val();
	var regDateEnd = $('input[name="reg_date_end"]').val();
	if(regDateEnd != "" && regDateEnd != null) {
		regDateEnd += " 23:59:59";
		}
	
	$.ajax({
		url : '/admin/memberView/searchMembers' ,	
		type : 'POST' ,
		contentType : 'application/json; charset=UTF-8',
		data : JSON.stringify({
			gender_list : genderList,
			level_list : levelList,
			black : isBlack, 
			member_id : memberId,
			member_name : member_name ,
		
			reg_date_start : regDateStart,
			reg_date_end : regDateEnd,
			pageNo : pageNo ,
			pagingSize : pagingSize 
		}) ,
			success: function(data) {
		
			        let output = "";
			        let cancelBlackButtonHtml = "";

			        $.each(data.MemberList, function(index, member) {
			        	 let checkBoxHtml = '';
			                if (member.member_status != 'black') {
			                    checkBoxHtml = `<input name="checkMember" class="form-check-input memberCheckBox" type="checkbox" value="\${member.member_id}" \${checkedMemberIdList.includes(member.member_id) ? "checked" : ""}/>`;
			                } else {
			                    checkBoxHtml = `<input name="checkMember" class="form-check-input memberCheckBox" type="checkbox" value="\${member.member_id}" disabled/>`; // 블랙 멤버는 체크박스를 비활성화
			                    cancelBlackButtonHtml = `
			                        <button class="btn btn-outline-danger cancel_black"
			                            onclick="openBlackCancelModal('\${member.member_id}')" 
			                            data-bs-toggle="modal" 
			                            data-bs-target="#blackCancelModal">
			                            블랙 취소
			                        </button>`;
			                }

						
			            const formattedDate = new Date(member.reg_date).toISOString().slice(0, 10);
			            /* <input name="checkMember" class="form-check-input memberCheckBox" type="checkbox" value="'+member.member_id+'"' + 
		                    (checkedMemberIdList.includes(member.member_id) ? "checked" : "") + '/> */
			            output += '<tr>' +
			                '<td>'+checkBoxHtml+ '</td>' +
			                '<td>' + member.member_id + '</td>' +
			                '<td>' + member.member_name + '</td>' +
			                '<td>' + member.phone_number + '</td>' +
			                '<td>' + member.birthday + '</td>' +
			                '<td>' + member.gender + '</td>' +
			                '<td>' + member.member_level + '</td>' +
			                '<td>' + formattedDate + '</td>' +
			                '<td>' + cancelBlackButtonHtml + '</td>' +
			                '</tr>';
			        });

			        $("#memberTableBody").html(output);

			        PageNation(data)
			},
			error: function(error) {
			    console.log("AJAX 에러:", error);
			}

	});
	
	});
	
});  // $(function 끝)
function showMemberList(pageNumber) {
	
	var genderList = $('input[name="genders"]:checked').map(function() {
		return $(this).val();
	}).get();
	var levelList = $('input[name="levels"]:checked').map(function() {
		return $(this).val();
	}).get();
	var memberId = $('input[name="member_id"]').val();
	var member_name = $('input[name="member_name"]').val();
	var isBlack = $('input[name="isBlack"]:checked').val();
	
	var regDateStart = $('input[name="reg_date_start"]').val();
	var regDateEnd = $('input[name="reg_date_end"]').val();
	pageNo = pageNumber;

	$.ajax({
		url : '/admin/memberView/searchMembers' ,	
		type : 'POST' ,
		contentType : 'application/json; charset=UTF-8',
		data : JSON.stringify({
			gender_list : genderList,
			level_list : levelList,
			member_id : memberId,
			member_name : member_name ,
			black : isBlack, 
		
			reg_date_start : regDateStart,
			reg_date_end : regDateEnd,
			pageNo : pageNo ,
			pagingSize : pagingSize 
		}) ,
			success: function(data) {
				   let output = "";
				   let cancelBlackButtonHtml = "";
			        $.each(data.MemberList, function(index, member) {
			       	 let checkBoxHtml = '';
		                if (member.member_status != 'black') {
		                    checkBoxHtml = `<input name="checkMember" class="form-check-input memberCheckBox" type="checkbox" value="\${member.member_id}" \${checkedMemberIdList.includes(member.member_id) ? "checked" : ""}/>`;
		                } else {
		                    checkBoxHtml = `<input name="checkMember" class="form-check-input memberCheckBox" type="checkbox" value="\${member.member_id}" disabled/>`; // 블랙 멤버는 체크박스를 비활성화
		                  cancelBlackButtonHtml = `
		                        <button class="btn btn-outline-danger cancel_black"
		                            onclick="openBlackCancelModal('\${member.member_id}')" 
		                            data-bs-toggle="modal" 
		                            data-bs-target="#blackCancelModal">
		                            블랙 취소
		                        </button>`;
		                }
				     
			            const formattedDate = new Date(member.reg_date).toISOString().slice(0, 10);

			            output += '<tr>' +
		                '<td>'+checkBoxHtml+'</td>' +
			                '<td>' + member.member_id + '</td>' +
			                '<td>' + member.member_name + '</td>' +
			                '<td>' + member.phone_number + '</td>' +
			                '<td>' + member.birthday + '</td>' +
			                '<td>' + member.gender + '</td>' +
			                '<td>' + member.member_level + '</td>' +
			                '<td>' + formattedDate + '</td>' +
			                '<td>' + cancelBlackButtonHtml + '</td>' +
			                '</tr>';
			        });

			        $("#memberTableBody").html(output);

			        PageNation(data);
			},
			error: function(error) {
			    console.log("AJAX 에러:", error);
			}
			
	});
	
	}

</script>
<body>
	<!-- Layout wrapper -->
	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">
			<!-- Menu -->

			<!-- Menu -->

			<jsp:include page="/WEB-INF/views/admin/components/sideBar.jsp">

				<jsp:param name="pageName" value="adminmemberview" />

			</jsp:include>
			<!-- / Layout wrapper -->

			<div class="layout-page">
				<!-- Navbar -->
				<nav class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme" id="layout-navbar">
					<div class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none">
						<a class="nav-item nav-link px-0 me-xl-4" href="javascript:void(0)">
							<i class="bx bx-menu bx-sm"></i>
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
										<label class="col-sm-2 col-form-label" for="basic-default-black">블랙 조회 여부</label>
										<div class="col-sm-10 d-flex align-items-center">
											<div class="form-check-inline">
												<input name="isBlack" class="form-check-input" type="radio" value="Yes" id="black" /> <label class="form-check-label" for="level_bronze"> Y </label>
											</div>
											<div class="form-check-inline">
												<input name="isBlack" class="form-check-input" type="radio" value="No" id="noneblacks" checked /> <label class="form-check-label" for="level_silver"> N </label>
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
										<label class="col-sm-2 col-form-label" for="basic-default-name">가입일</label>
										<div class="col-sm-10 d-flex align-items-center">
											<div class="form-check-inline">
												<input name="reg_date_start" class="form-control" type="date" value="" id="html5-date-input">
											</div>
											<div class="form-check-inline">
												<span class="mx-2">-</span>
											</div>
											<div class="form-check-inline">
												<input name="reg_date_end" class="form-control" type="date" value="" id="html5-date-input">
											</div>
										</div>
									</div>
									<div class="row justify-content-end">
										<div class="col-sm-10">
											<button type="button" class="btn btn-primary" id="searchMember">Search</button>
										</div>
									</div>

								</div>
							</div>
						</div>

						<div class="card mt-4">
							<h5 class="card-header">회원 목록</h5>
							<div class="table-responsive text-nowrap">
								<table class="table">
									<thead class="table-light">
										<tr>
											<th>선택</th>
											<th>회원 id</th>
											<th>회원 이름</th>
											<th>휴대폰번호</th>
											<th>생년월일</th>
											<th>성별</th>
											<th>레벨</th>
											<th>가입일</th>

										</tr>
									</thead>
									<tbody id="memberTableBody" class="table-border-bottom-0">
										<c:forEach var="member" items="${memberList}">
											<tr>
												<td><input name="checkMember" class="form-check-input memberCheckBox" type="checkbox" value="${member.member_id}" <c:if test="${fn:contains(checkedMemberIdList , member.member_id)}">checked</c:if> /></td>
												<td>${member.member_id}</td>
												<td>${member.member_name}</td>
												<td>${member.phone_number}</td>
												<td>${member.birthday}</td>
												<td>${member.gender}</td>
												<td>${member.member_level}</td>
												<td><fmt:formatDate value="${member.reg_date}" pattern="yyyy-MM-dd" /></td>

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
											<c:when test="${PagingInfo.pageNo == 1}">
												<li class="page-item prev disabled">
													<a class="page-link" href="javascript:void(0);">
														<i class="tf-icon bx bx-chevrons-left"></i>
													</a>
												</li>
											</c:when>
											<c:otherwise>
												<li class="page-item prev">
													<a class="page-link" href="javascript:void(0);">
														<i class="tf-icon bx bx-chevrons-left"></i>
													</a>
												</li>
											</c:otherwise>
										</c:choose>

										<c:forEach var="i" begin="${PagingInfo.startPageNoCurBlock}" end="${PagingInfo.endPageNoCurBlock}">
											<c:choose>
												<c:when test="${PagingInfo.pageNo == i}">
													<li class="page-item active">
														<a class="page-link" href="javascript:void(0);" onclick="showMemberList(${PagingInfo.pageNo})">${i}</a>
													</li>
												</c:when>
												<c:otherwise>
													<li class="page-item">
														<a class="page-link" href="javascript:void(0);" onclick="showMemberList(${i})">${i}</a>
													</li>
												</c:otherwise>
											</c:choose>

										</c:forEach>

										<c:choose>
											<c:when test="${PagingInfo.pageNo == PagingInfo.totalPageCnt}">
												<li class="page-item disabled">
													<a class="page-link" href="javascript:void(0);">
														<i class="tf-icon bx bx-chevrons-right"></i>
													</a>
												</li>
											</c:when>
											<c:otherwise>
												<li class="page-item next">
													<a class="page-link" href="javascript:void(0);">
														<i class="tf-icon bx bx-chevrons-right"></i>
													</a>
												</li>
											</c:otherwise>
										</c:choose>

									</ul>
								</nav>
							</div>
							<div align="center" class="mb-3">
								<button id="blackMember" type="button" class="btn btn-outline-danger mt-3" data-bs-toggle="modal" data-bs-target="#blackMemberModal">선택한 회원 블랙</button>
							</div>
						</div>

					</div>



					<!-- 
					
					블랙 회원 조회할 수 있는 모달창
					
					 -->


					<div class="modal fade" id="blackMemberModal" aria-labelledby="modalToggleLabel" tabindex="-1" style="display: none;" aria-hidden="true">
						<div class="modal-dialog modal-dialog-centered">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="modalToggleLabel">회원 블랙</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								</div>

								<div class="modal-body">
									<p>선택한 회원 아이디:</p>
									<ul id="selectedIds" class="list-group"></ul>

								</div>
								<div class="modal-footer justify-content-center">
									<h5>정말로 이 회원들을 블랙 처리하시겠습니까?</h5>
									<div>
										<button class="btn btn-primary" id="confirmDeleteBtn">확인</button>
										<button class="btn btn-danger" data-bs-dismiss="modal">취소</button>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="modal fade" id="blackCancelModal" tabindex="-1" aria-labelledby="blackCancelModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="blackCancelModalLabel">블랙 취소</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<p>해당 회원의 블랙 상태를 취소하시겠습니까?</p>
									<p>
										회원 ID: <span id="modalMemberId"></span>
									</p>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
									<button type="button" class="btn btn-danger" id="confirmCancelBlack">확인</button>
								</div>
							</div>
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
							, made with ❤️ by
							<a href="https://themeselection.com" target="_blank" class="footer-link fw-bolder">ThemeSelection</a>
						</div>
						<div>
							<a href="https://themeselection.com/license/" class="footer-link me-4" target="_blank">License</a>
							<a href="https://themeselection.com/" target="_blank" class="footer-link me-4">More Themes</a>
							<a href="https://themeselection.com/demo/sneat-bootstrap-html-admin-template/documentation/" target="_blank" class="footer-link me-4">Documentation</a>
							<a href="https://github.com/themeselection/sneat-html-admin-template-free/issues" target="_blank" class="footer-link me-4">Support</a>
						</div>
					</div>
				</footer>
			</div>
		</div>
		<div class="bs-toast toast toast-placement-ex m-2 fade bg-secondary top-0 end-0 hide" role="alert" aria-live="assertive" aria-atomic="true" data-delay="2000" id="toastMessage">
			<div class="toast-header">
				<i class="bx bx-bell me-2"></i>
				<div class="me-auto fw-semibold" id="toastTitle"></div>
				<small></small>
				<button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
			</div>
			<div class="toast-body" id="toastBody"></div>
		</div>
		<!-- / Footer -->
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
