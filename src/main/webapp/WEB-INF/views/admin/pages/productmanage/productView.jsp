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
	$("#modalToggle").modal('hide'); // 모달이름
	 setTimeout(function() {
		 toastElement.hide();
       }, 2000);
} 
let selectedValues = [];
	$(function() {
	
		  const errorMessages = {
			        mainImage: $("<div style='color: red;'></div>").insertAfter("#image_main_url"),
			        subImage: $("<div style='color: red;'></div>").insertAfter("#image_sub_url"),
			        contentImage: $("<div style='color: red;'></div>").insertAfter("#product_content_img")
			    };

			    // 이미지 파일 유효성 검사 함수
			    function validateImageInput($input, $errorMessageElement) {
			        const files = $input[0].files;
			        let isValid = true;

			        // 파일 타입 검사
			        $.each(files, function (index, file) {
			            if (!file.type.startsWith("image/")) {
			                isValid = false;
			                return false; // 이미지 파일이 아닌 경우 루프 종료
			            }
			        });

			        // 유효하지 않으면 경고 메시지 표시
			        if (!isValid) {
			            $errorMessageElement.text("이미지 파일이 아닙니다.");
			            $input.val(""); // 파일 선택 해제
			        } else {
			            $errorMessageElement.text(""); // 유효한 경우 메시지 제거
			        }
			    }
			let mainImageInput = $("#image_main_url");
			let subImageInput  = $("#image_sub_url");
			let productContentImgInput  = $("#product_content_img");
			console.log(mainImageInput);
			console.log(subImageInput);
			console.log(productContentImgInput);
		
			mainImageInput.on('change', function() {
				 validateImageInput($(this), errorMessages.mainImage);
			})
			subImageInput.on('change', function() {
				 validateImageInput($(this), errorMessages.subImage);
			})
			productContentImgInput.on('change', function() {
				 validateImageInput($(this), errorMessages.contentImage);
			}) 
		  $('.previewImg').on('click', function() {
		        // 클릭된 이미지의 src 가져오기
		        var imageSrc = $(this).attr('src');
		        console.log(imageSrc);
		        // 모달에 이미지 src 설정
		        $('#bigImage').attr('src', imageSrc);
		        
		    });
		
		$('#modalToggle').on('show.bs.modal', function(event) {
			var button = $(event.relatedTarget); // 클릭한 버튼
			var row = button.closest('tr'); // 버튼이 있는 행을 찾음

			// 테이블에서 데이터 가져오기
			var productId = button.val(); // 제품 ID
			var productName = row.find('td:eq(2)').text(); // 제품 이름 (3번째 열)
			var productPrice = row.find('td:eq(3)').text(); // 제품 가격 (4번째 열)
			var productContent = row.find('td:eq(4)').find('img').attr('src'); // 제품 설명 (5번째 열) 
			var productDcType = row.find('td:eq(5)').text();
			var productDcAmount = parseFloat(row.find('td:eq(6)').text().replace('%', '').trim());
			console.log(productDcAmount);
			console.log(productDcType);
			var productSellCount = row.find('td:eq(7)').text();
			var mainImageUrl =row.find('td:eq(8)').find('img').attr('src');
			console.log(mainImageUrl);
			console.log(productContent);
			var subImageUrl =  [];
			  row.find('td:eq(9)').find('img').each(function() {
		            subImageUrl.push($(this).attr('src'));
		        });
			var modal = $(this);
			modal.find('#productNo').val(productId); // 제품 ID 입력란
			modal.find('#productName').val(productName); // 제품 이름 입력란
			modal.find('#productPrice').val(productPrice); // 제품 가격 입력란
			modal.find('#productContent').val(productContent); // 제품 설명 입력란 */
			modal.find('#productSellCount').val(productSellCount);
			// 할인 타입 라디오 버튼 설정
			if (productDcType === "P") {
				modal.find('#percentDiscount').prop('checked', true);
			} else if(productDcType === "N"){
				modal.find('#noDiscount').prop('checked', true);
			}

			modal.find('#productDcAmount').val(productDcAmount); // 할인 금액 입력란
			
			 updateDiscountAmountInput();
			if(typeof productContent != 'undefined'){
				$('#contentImgPreview').attr('src',productContent).show();
				$('#deletecontentImage').show();
			} else {
				$('#contentImgPreview').hide();
				$('#deletecontentImage').hide();
			}
			  if (typeof mainImageUrl != 'undefined') {
			        $('#mainImagePreview').attr('src',mainImageUrl).show();
			        $('#deleteImage').show();
			    } else {
			        $('#mainImagePreview').hide();
			        $('#deleteImage').hide();
			    }
			  $('#subImagePreview').empty(); // 기존 미리보기 초기화
			    if (subImageUrl.length > 0) {
			        subImageUrl.forEach(function(url, index) {
			            $('#subImagePreview').append( '<div style="position: relative; display: inline-block;">' +
			                    '<img src="' + url + '" alt="Sub Image" width="100px" height="100px">' +
			                    '<button type="button" class="deleteSubImage btn btn-danger btn-sm " style="position: absolute; top: 0; right: 0;" data-index="' + index + '">X</button>' +
			                    '</div>');
			        });
			        $('#subImagePreviewContainer').show(); // 미리보기 영역 보이기
			    } else {
			        $('#subImagePreviewContainer').hide(); // 선택된 파일이 없으면 미리보기 숨기기
			    }
		});

		// 할인 타입 라디오 버튼의 상태에 따라 입력을 조절
		 $('input[name="discountType"]').change(updateDiscountAmountInput);
	$("#deleteImage").on('click' , function() {
		console.log("메인이미지 삭제하기");
		$(this).parent().hide();
	});

	$('#subImagePreview').on('click', '.deleteSubImage', function() {
        $(this).parent().hide();
        // 필요하면 서버에 이미지 삭제 요청을 할 수 있음
    });
	$('#deletecontentImage').on('click',function() {
		$(this).parent().hide();
	});
    function updateDiscountAmountInput() {
        var selectedType = $("input[name='discountType']:checked").val();
console.log(selectedType); 
        if (selectedType === "fixed") {
            $('#productDcAmount').attr('type', 'number').attr('min', '0').removeAttr('max');
            $('#productDcAmount').removeAttr('disabled');
            $('#discountMessage').text(''); // 메시지 초기화
        } else if (selectedType === "percent") {
            $('#productDcAmount').attr('type', 'number').attr('min', '1').attr('max', '100');
            $('#productDcAmount').removeAttr('disabled');
            $('#discountMessage').text(''); // 메시지 초기화
        } else {
            $('#productDcAmount').val(0).attr('type', 'hidden').attr('disabled', true);
            $('#discountMessage').text(''); // 메시지 초기화
        }
        validateDiscountAmount(); // 유효성 검사 호출
    }

    // 할인 금액 유효성 검사
    $('#productDcAmount').on('input', validateDiscountAmount);

    function validateDiscountAmount() {
        var selectedType = $("input[name='discountType']:checked").val();
        var discountAmount = parseFloat($('#productDcAmount').val());
        var isValid = true;

        if (selectedType === "fixed") {
            if (discountAmount < 0) {
                isValid = false;
            }
        } else if (selectedType === "percent") {
            if (discountAmount < 1 || discountAmount > 100) {
                isValid = false;
            }
        }

        if (!isValid) {
            $('#discountMessage').text('유효하지 않은 범위의 숫자입니다.').css('color', 'red');
            $('#saveChangesBtn').attr('disabled', true); // 수정 버튼 비활성화
        } else {
            $('#discountMessage').text(''); // 메시지 초기화
            $('#saveChangesBtn').attr('disabled', false); // 수정 버튼 활성화
        }
    }

		$('#modalToggle2').on('show.bs.modal', function(event) {
			var button = $(event.relatedTarget); // 클릭한 버튼
			var productId = button.val(); // 버튼의 value 속성 값
			var modalTitle = '상품 ID: ' + productId; // 제목 설정
			var modal = $(this);
			modal.find('.modal-title').text(modalTitle); // 모달 제목 업데이트
		});

		// 삭제 확인 버튼 클릭 시 처리
		$('#confirmDeleteBtn').click(
				function() {
					var productId = $('#modalToggle2 .modal-title').text()
							.split(': ')[1]; // 제목에서 상품 ID 추출
					console.log(productId);
					console.log($(this).val());
					// Ajax 요청으로 삭제
					$.ajax({
						url : '/admin/productmanage/productDelete', // 삭제 요청을 보낼 URL
						type : 'POST', // HTTP 메소드
						dataType : 'json',
						data : {
							productId : productId
						}, // 제품 ID 데이터 전송
						success : function(response) {
							 $('#toastTitle').text('성공!'); // 토스트 메시지 제목
			                 $('#toastBody').text('상품 삭제가 성공적으로 처리되었습니다.'); // 토스트 메시지 내용
			                 
			                 // 토스트 메시지 표시
			                 var toastElement = $('#toastMessage');
			                 toastElement.removeClass('hide').addClass('show');
							$("#modalToggle2").modal('hide'); // 모달이름
							 setTimeout(function() {
								 toastElement.hide();
					            }, 2000);
							 setTimeout(function() {
								 location.reload();
							  }, 1000);
							 
			            	
						},
						error : function(xhr, status, error) {
							console.log('Error:', error);
							console.log('xhr:', xhr);
							console.log('status:', status);
							 showToast("실패 ㅠㅠ", "상품 삭제가 실패하였습니다.")
						}
					});
				});

		
		// 수정 버튼 클릭 시 저장 처리
		 $('#saveChangesBtn').click(function() {
		        var productId = $('#productNo').val();
		        var productName = $('#productName').val();
		        var productPrice = $('#productPrice').val();
		        var productContent = $('#contentImgPreview').attr('src');
		        var deleteContentImg = $('#deletecontentImage').is(':visible') ? 'true' : productContent;
		        var productSellCount = $("#productSellCount").val();
		        // 할인 타입 설정
		        var discountType = $("input[name='discountType']:checked").val();
		        var existingMainImageUrl = $('#mainImagePreview').attr('src');
		        var deleteMainImage = $('#deleteImage').is(':visible') ? 'true' : existingMainImageUrl; // 삭제 버튼이 보이면 이미지가 삭제되지 않음
				console.log(productContent)
		        if (discountType == "percent") {
		        	discountType = "P"; // 퍼센트할인
		        } else if ( discountType == "none") {
		        	 discountType = "N"
		        }

		        var discountAmount = discountType === "N" ? 0 : $('#productDcAmount').val();
		        var formData = new FormData();
		        formData.append('product_no', productId);
		        formData.append('product_name', productName);
		        formData.append('product_price', productPrice);
		        formData.append('product_content', deleteContentImg);
		        formData.append('product_dc_type', discountType);
		        formData.append('dc_rate', discountAmount);
				formData.append('product_sell_count' , productSellCount);
				formData.append('product_main_image' , deleteMainImage);
				console.log(discountAmount);
		        // 메인 이미지
		        var mainImage = $('#image_main_url')[0].files[0];
		        if (mainImage) {
		            formData.append('image_main_url', mainImage);
		        }
		        var deleteSubImage = []; // 삭제할 서브 이미지의 인덱스를 추적
		        
		        $('#subImagePreview div').each(function(index) {
		            if ($(this).is(':hidden')) {  // 삭제 버튼이 눌린 이미지
		            	var subImageUrl = $(this).find('img').attr('src'); // 이미지의 경로를 가져옴
		                deleteSubImage.push(subImageUrl)
		            }
		        });

		        formData.append('product_sub_image', deleteSubImage);
		        // 서브 이미지들
		        var subImages = $('#image_sub_url')[0].files;
		        for (var i = 0; i < subImages.length; i++) {
		            formData.append('image_sub_url', subImages[i]);
		        }
		        var contentImage = $('#product_content_img')[0].files[0];
		        if (contentImage) {
		            formData.append('content_image', contentImage);
		        }
		        $.ajax({
		            url: '/admin/productmanage/productUpdate', // 수정 요청을 보낼 URL
		            type: 'POST',
		            data: formData,
		            processData: false, // 자동으로 데이터 처리하지 않도록 설정
		            contentType: false, // 컨텐츠 타입을 설정하지 않도록 설정
		            success: function(response) {
		            	 
		            	 $('#toastTitle').text('성공!'); // 토스트 메시지 제목
		                 $('#toastBody').text('상품 수정이 성공적으로 처리되었습니다.'); // 토스트 메시지 내용
		                 
		                 // 토스트 메시지 표시
		                 var toastElement = $('#toastMessage');
		                 toastElement.removeClass('hide').addClass('show');
						$("#modalToggle").modal('hide'); // 모달이름
						 setTimeout(function() {
							 toastElement.hide();
				            }, 2000);
						 setTimeout(function() {
							 location.reload();
						  }, 1000);
		            },
		            error: function(xhr, status, error) {
		                console.error('Error:', error);
		                showToast("실패 ㅠㅠ", "상품 수정이 실패하였습니다.") // 넣고싶은 문자
		            }
		        });
		    });
		
		$(".dropdown-item").on('click', function () {
			 let selectVal = $(this).parent().attr("value");
			console.log(selectVal);
			let productName = new URLSearchParams(window.location.search).get("product_name") ||  '';
			let productDcType = new URLSearchParams(window.location.search).getAll("product_dc_type") ||  '';
			let productStartDate = new URLSearchParams(window.location.search).get("reg_date_start") ||  '';
			let productEndDate= new URLSearchParams(window.location.search).get("reg_date_end") ||  '';
		
			
			var newUrl = '/admin/productmanage/productSearch?searchType=' + encodeURIComponent(selectVal) + "&product_name=" + encodeURIComponent(productName) + "&reg_date_start=" +encodeURIComponent(productStartDate) +"&reg_date_end=" + encodeURIComponent(productEndDate);
			if(productDcType == '') {
				 location.href= newUrl;
			} else {
			 productDcType.forEach(function(item) {
			        newUrl += "&product_dc_type=" + encodeURIComponent(item);
			 })
			 location.href= newUrl;
			}
	   });
	
			 checkedtype();
			
			 $(".productCheckbox").on('click' , function() {
				let value = $(this).val();
				if($(this).is(':checked')) {
					if(!selectedValues.includes(value)){
						selectedValues.push(value);
					}
				} else {
					selectedValues = selectedValues.filter(function(item) {
			            return item !== value;
			        });
				}
				console.log(selectedValues); 
		})
	
	});
	function allUpdate() {
	    
	    console.log(selectedValues);
	}
	function allDelete() {
	    
	    alert("모든 업데이트가 삭제되었습니다!");
	}
	function showProductList(i, e) {
	    // URL 파라미터로 사용할 값들을 가져옴
	    let selectVal = new URLSearchParams(window.location.search).get("searchType") || '';
	    let productName = new URLSearchParams(window.location.search).get("product_name") || '';
	    let productDcType = new URLSearchParams(window.location.search).getAll("product_dc_type") || '';
	    let productStartDate = new URLSearchParams(window.location.search).get("reg_date_start") || '';
	    let productEndDate = new URLSearchParams(window.location.search).get("reg_date_end") || '';
	    
	    // 새로운 URL을 구성
	    var newUrl = '/admin/productmanage/productSearch?product_name=' + encodeURIComponent(productName) 
	               + "&reg_date_start=" + encodeURIComponent(productStartDate) 
	               + "&reg_date_end=" + encodeURIComponent(productEndDate) 
	               + "&pageNo=" + i 
	               + "&pagingSize=" + e;  // pagingSize 값 추가

	    // product_dc_type 값이 있을 경우 URL에 추가
	    if (productDcType !== '') {
	        productDcType.forEach(function(item) {
	            newUrl += "&product_dc_type=" + encodeURIComponent(item);
	        });
	    }

	    // searchType 값이 있을 경우 URL에 추가
	    if (selectVal !== '') {
	        newUrl += "&searchType=" + encodeURIComponent(selectVal);  // searchType 유지
	    }

	    // 새로운 URL로 이동
	    location.href = newUrl;
	}

	function checkedtype() {
	    let productDcType = new URLSearchParams(window.location.search).getAll("product_dc_type") || [];

	    // product_dc_type 클래스를 가진 모든 체크박스 요소를 선택
	    $(".form-check-input").each(function() {
	        // 체크박스의 값을 가져옴
	        let checkboxValue = $(this).val();

	        // URL에서 가져온 productDcType 값 중 하나와 일치하는지 확인
	        if (productDcType.includes(checkboxValue)) {
	            // 값이 일치하면 체크박스를 체크 상태로 설정
	            $(this).prop("checked", true);
	        }
	    });
	}
</script>
</head>

<body>
	<!-- Layout wrapper -->
	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">
			<!-- Menu -->

			<!-- Menu -->

			<jsp:include page="/WEB-INF/views/admin/components/sideBar.jsp">

				<jsp:param name="pageName" value="productView" />

			</jsp:include>

			<!-- / Menu -->

			<!-- Layout container -->

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

					<div class="container-xxl flex-grow-1 container-p-y mb-3">
						<div class="card accordion-item active mb-3">
							<h2 class="accordion-header" id="headingOne">
								<button type="button" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#accordionOne" aria-expanded="false" aria-controls="accordionOne">
									<h5>필터</h5>
								</button>
							</h2>


							<div id="accordionOne" class="accordion-collapse collapse show" data-bs-parent="#accordionExample">
								<div class="accordion-body">
									<form id="searchFilter" action="/admin/productmanage/productSearch">
										<div class="row mb-3">
											<label class="col-sm-2 col-form-label" for="basic-default-name">할인 타입</label>
											<div class="col-sm-10 d-flex align-items-center">
												<div class="form-check-inline">
													<input name="product_dc_type" class="form-check-input" type="checkbox" value="P" id="product_dc_p" /> <label class="form-check-label" for="product_p"> 비율 할인 </label>
												</div>
												<div class="form-check-inline">
													<input name="product_dc_type" class="form-check-input" type="checkbox" value="N" id="product_dc_n" /> <label class="form-check-label" for="product_n"> 없음 </label>
												</div>
											</div>
										</div>
										<div class="row mb-3">
											<label class="col-sm-2 col-form-label" for="product_name">상품 이름</label>
											<div class="col-sm-10">
												<input type="text" name="product_name" id="" class="form-control" placeholder="상품 이름 검색 .." aria-label="" aria-describedby="" />
											</div>
										</div>

										<div class="row mb-3">
											<label class="col-sm-2 col-form-label" for="basic-default-name">상품 등록일</label>
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
												<button type="submit" class="btn btn-primary">Search</button>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>

						<div class="card">
							<h5 class="card-header">
								상품 목록
								<div class="btn-group" style="float: right;">

									<button type="button" class="btn btn-outline-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">정렬</button>
									<ul class="dropdown-menu" style="">
										<li value="priceHigh">
											<a class="dropdown-item" href="javascript:void(0);">가격 높은 순으로 정렬</a>
										</li>
										<li value="priceLow">
											<a class="dropdown-item" href="javascript:void(0);">가격 낮은 순으로 정렬</a>
										</li>

										<li value="sortAmountLow">
											<a class="dropdown-item" href="javascript:void(0);">할인률 낮은 순</a>
										</li>
										<li value="sortAmountHigh">
											<a class="dropdown-item" href="javascript:void(0);">할인 높은 순 </a>
										</li>
									</ul>
								</div>
							</h5>

							<div class="d-flex justify-content-between align-items-center mb-3"></div>
							<div class="table-responsive text-nowrap">
								<table class="table">
									<thead class="table-light">
										<tr>
											<th><input type="checkbox" id="selectAll" onclick="toggleSelectAll(this)"> 전체 선택</th>
											<th>상품 번호</th>
											<th>상품 이름</th>
											<th>상품 가격</th>
											<th>상품 설명</th>
											<th>상품 할인 타입</th>
											<th>상품 할인 금액</th>
											<th>상품 수량</th>
											<th>상품 메인 이미지</th>
											<th>상품 서브 이미지</th>

										</tr>
									</thead>
									<tbody id="productTableBody" class="table-border-bottom-0">
										<c:forEach var="product" items="${productList}">
											<tr>
												<td><input class="productCheckbox" type="checkbox" name="productCheckbox" value="${product.product_no}"></td>
												<!-- 체크박스 추가 -->
												<td>${product.product_no}</td>
												<td>${product.product_name}</td>
												<td>${product.product_price}</td>
												<td><c:if test="${!fn:contains(product.product_content , 'Content') && product.product_content != null && product.product_content != ''}">
														<img src="${product.product_content}" width="40px" height="50" class="previewImg" data-bs-toggle="modal" data-bs-target="#modalToggle3">
													</c:if> <c:if test="${fn:contains(product.product_content , 'Content') && product.product_content != null && product.product_content != ''}">
														<img src="/resources/product/${product.product_content}" width="40px" height="50" class="previewImg" data-bs-toggle="modal" data-bs-target="#modalToggle3">
													</c:if></td>
												<td>${product.product_dc_type}</td>
												<td><fmt:formatNumber value="${product.dc_rate * 100}" type="number" />%</td>
												<td>${product.product_sell_count}</td>
												<td><c:forEach var="img" items="${product.list}">
														<c:if test="${img.image_type == 'M' && !fn:contains(img.image_url, 'Main') && img.image_url != null && img.image_url != ''}">
															<img src='${img.image_url}' alt="Main Image" width="50" height="50" class="previewImg" data-bs-toggle="modal" data-bs-target="#modalToggle3">
															<!-- 메인 이미지 URL 출력 -->
														</c:if>
														<c:if test="${img.image_type == 'M' && fn:contains(img.image_url, 'Main') && img.image_url != null && img.image_url != ''}">
															<img src='/resources/product/${img.image_url}' alt="Main Image" width="50" height="50" class="previewImg" data-bs-toggle="modal" data-bs-target="#modalToggle3">
															<!-- 메인 이미지 URL 출력 -->
														</c:if>
													</c:forEach></td>
												<td><c:forEach var="img" items="${product.list}">
														<c:if test="${img.image_type == 'S' && !fn:contains(img.image_url, 'Sub')&& img.image_url != null && img.image_url != ''}">
															<img src='${img.image_url}' alt="Sub Image" width="50" height="50" class="previewImg" data-bs-toggle="modal" data-bs-target="#modalToggle3">
															<!-- 서브 이미지 URL 출력 -->
														</c:if>
														<c:if test="${img.image_type == 'S' && fn:contains(img.image_url, 'Sub')&& img.image_url != null && img.image_url != ''}">
															<img src='/resources/product/${img.image_url}' alt="Sub Image" width="50" height="50" class="previewImg" data-bs-toggle="modal" data-bs-target="#modalToggle3">
															<!-- 메인 이미지 URL 출력 -->
														</c:if>
													</c:forEach></td>
												<td><div class="mt-3">
														<button type="button" class="btn rounded-pill btn-outline-primary" value="${product.product_no}" data-bs-toggle="modal" data-bs-target="#modalToggle">수정</button>
													</div></td>
												<td><div class="mt-3">
														<button type="button" class="btn rounded-pill btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modalToggle2" value="${product.product_no}">삭제</button>
													</div></td>

											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<div class="mt-4">
								<nav aria-label="Page navigation">
									<ul class="pagination justify-content-center">
										<c:choose>
											<c:when test="${pi.pageNo == 1}">
												<li class="page-item prev disabled">
													<a class="page-link" href="javascript:void(0);">
														<i class="tf-icon bx bx-chevrons-left"></i>
													</a>
												</li>
											</c:when>
											<c:otherwise>
												<li class="page-item prev">
													<a class="page-link" href="javascript:void(0);" onclick="showProductList(${pi.pageNo-1} , ${pi.viewPostCntPerPage})">
														<i class="tf-icon bx bx-chevrons-left"></i>
													</a>
												</li>
											</c:otherwise>
										</c:choose>

										<c:forEach var="i" begin="${pi.startPageNoCurBlock}" end="${pi.endPageNoCurBlock}">
											<c:choose>
												<c:when test="${pi.pageNo == i}">
													<li class="page-item active">
														<a class="page-link" href="javascript:void(0);" onclick="showProductList(${pi.pageNo}, ${pi.viewPostCntPerPage})">${i}</a>
													</li>
												</c:when>
												<c:otherwise>
													<li class="page-item">
														<a class="page-link" href="javascript:void(0);" onclick="showProductList(${i}, ${pi.viewPostCntPerPage})">${i}</a>
													</li>
												</c:otherwise>
											</c:choose>

										</c:forEach>

										<c:choose>
											<c:when test="${pi.pageNo == pi.totalPageCnt}">
												<li class="page-item disabled">
													<a class="page-link" href="javascript:void(0);">
														<i class="tf-icon bx bx-chevrons-right"></i>
													</a>
												</li>
											</c:when>
											<c:otherwise>
												<li class="page-item next">
													<a class="page-link" href="javascript:void(0);" onclick="showProductList(${pi.pageNo+1} , ${pi.viewPostCntPerPage})">
														<i class="tf-icon bx bx-chevrons-right"></i>
													</a>
												</li>
											</c:otherwise>
										</c:choose>

									</ul>
								</nav>
							</div>



						</div>
						<div class="card-body mb-3">
							<div>
								<small class="text-light fw-semibold" style="display: flex; justify-content: center; align-items: center;"></small>
							</div>
							<div>
								<small class="text-light fw-semibold" style="display: flex; justify-content: center; align-items: center;">체크한 상품</small>
							</div>
							<div class="demo-inline-spacing" style="display: flex; justify-content: center; align-items: center;">
								<button type="button" class="btn rounded-pill btn-primary" onclick="allUpdate();">일괄 수정</button>

								<button type="button" class="btn rounded-pill btn-danger" onclick="allDelete();">일괄 삭제</button>

							</div>
						</div>
						<!-- body  -->

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

	<!-- Modal 1-->
	<div class="modal fade" id="modalToggle" aria-labelledby="modalToggleLabel" tabindex="-1" style="display: none;" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modalToggleLabel">수정하기</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<input type="hidden" id="productNo" value="">
					<div class="mb-3">
						<label for="productName" class="form-label">상품 이름</label> <input type="text" class="form-control" id="productName">
					</div>
					<div class="mb-3">
						<label for="productPrice" class="form-label">상품 가격</label> <input type="text" class="form-control" id="productPrice">
					</div>
					<div class="mb-3">
						<label for="image_main_url" class="form-label">상품 설명 이미지</label>
						<div id="contentImg">

							<div style="position: relative; display: inline-block;">
								<img id="contentImgPreview" src="" alt="contentImage" width="100" height="100">
								<button id="deletecontentImage" type="button" class="btn btn-danger btn-sm" style="position: absolute; top: 0; right: 0;">X</button>
							</div>

						</div>
						<input type="file" class="form-control imgClass" id="product_content_img" accept="image/*">
					</div>
					<div class="mb-3">
						<label class="form-label">상품 할인 타입</label><br> <input type="radio" id="percentDiscount" name="discountType" value="percent"> 퍼센트할인 <input type="radio" id="noDiscount" name="discountType" value="none" checked> 없음
					</div>

					<div class="mb-3">
						<label for="productDcAmount" class="form-label">상품 할인 금액</label> <input type="number" class="form-control" id="productDcAmount" min="0">
						<div id="discountMessage" style="color: red;"></div>
					</div>
					<div class="mb-3">
						<label for="productDcAmount" class="form-label">상품 수량</label> <input type="number" class="form-control" id="productSellCount" min="0">
						<div id="discountMessage" style="color: red;"></div>
					</div>
					<div class="mb-3">
						<label for="image_main_url" class="form-label">상품 메인 이미지</label>
						<div id="mainImage">

							<div style="position: relative; display: inline-block;">
								<img id="mainImagePreview" src="" alt="Main Image" width="100" height="100">
								<button id="deleteImage" type="button" class="btn btn-danger btn-sm" style="position: absolute; top: 0; right: 0;">X</button>
							</div>

						</div>
						<input type="file" class="form-control imgClass" id="image_main_url" accept="image/*">
					</div>
					<div class="mb-3">
						<label for="image_sub_url" class="form-label">상품 서브 이미지</label>
						<div id="subImagePreviewContainer" style="display: none;">
							<div id="subImagePreview"></div>
							<!-- 서브 이미지 미리보기 영역 -->
						</div>
						<label for="udpate image" class="form-label imgClass">변경할 서브 이미지</label> <input type="file" class="form-control" id="image_sub_url" accept="image/*" multiple>
					</div>

				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" id="saveChangesBtn">저장</button>
					<button class="btn btn-danger" data-bs-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="modalToggle2" aria-labelledby="modalToggleLabel" tabindex="-1" style="display: none;" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modalToggleLabel"></h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">정말로 삭제하시겠습니까</div>
				<div class="modal-footer">
					<button class="btn btn-primary" id="confirmDeleteBtn">확인</button>
					<button class="btn btn-danger" data-bs-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="modalToggle3" aria-labelledby="modalToggleLabel" tabindex="-1" style="display: none;" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modalToggleLabel"></h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<img src="" id="bigImage" class="img-fluid">
				</div>
				<div class="modal-footer"></div>
			</div>
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
</body>

</html>
