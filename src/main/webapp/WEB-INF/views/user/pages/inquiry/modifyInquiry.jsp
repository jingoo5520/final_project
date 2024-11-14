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
<script type="text/javascript">

let existFileList = [];
let fileList = [];

	$(function(){
		
		getOrderedProducts();
		setData();
		
		$('#inquiryTitle').on('input', function() {
			checkFormCompletion();
		});

		$('#inquiryContent').on('input', function() {
			checkFormCompletion();
		});
		
		$("#fileInput").on("change", function(){
			const maxSize = 10 * 1024 * 1024;
			
			// 중복 이름 거르기
			$.each(this.files, function(index, file){
				if (!file.type.startsWith("image/") || file.size > maxSize) {
		            console.log("이미지 파일이 아니거나, 파일 용량이 10MB를 초과합니다.", file.name);
		            console.log(file.type);
		            return; 
		        }
				
				let inFileList = fileList.some(function(f){
					return f.name === file.name; 
				}); 
				
				let inExistFileList = existFileList.some(function(f){
					return f.inquiry_image_original_name === file.name; 
				});
					
				if(!inFileList && !inExistFileList) {
					fileList.push(file);
					console.log(fileList);	
				}
			});
			
			showFiles();
		});
		
		// 첨부파일 제거
		$(document).on("click", ".remove-item", function(){
			let parentLi = $(this).parent();
			
			for(let i = 0; i < existFileList.length; i++){
				if(existFileList[i].inquiry_image_original_name == parentLi.text().trim()){
					console.log(existFileList[i].inquiry_image_original_name + "삭제완료");		
					existFileList.splice(i, 1);
					parentLi.remove();
					break;
				}
			}
			
			for(let i = 0; i < fileList.length; i++){
				if(fileList[i].name == parentLi.text().trim()){
					console.log(fileList[i] + "삭제완료");		
					fileList.splice(i, 1);
					parentLi.remove();
					break;
				}
			}
			
			console.log(fileList);
			console.log(existFileList);
			$("#fileInput").val("");
			showFiles();
		})
		
		
		// 문의 타입이 상품인 경우 주문 상품 리스트 가져와야함
		$("#selectInquiryType select").on("change", function(){
			if($(this).val() == "상품"){
				$("#orderList").show();
			} else {
				$("#selectInquiryProduct select").val("");
				$("#orderList").hide();
			}
			
			checkFormCompletion();
		});
		
		$("#selectInquiryProduct select").on("change", function(){
			checkFormCompletion();
			console.log($(this).val());
		});
	});
	
	// 주문 상품 리스트 가져오기
	function getOrderedProducts(){
		
		$.ajax({
			url : '/serviceCenter/getOrderedProducts',
			type : 'GET',
			dataType: 'json',
			success : function(data) {
				console.log(data);
				
				let output = '';
				output += `<option value="" disabled selected>상품선택</option>`;
				
				data.forEach(function(orderProduct){
					output += `<option value="\${orderProduct.product_no}">\${orderProduct.product_name}</option>`
				})
				
				$("#orderListSelect").html(output);
				$("#selectInquiryProduct select").val(${inquiryDetail.product_no});
				
			},
			error : function(error) {
				console.log(error);
			}
		
		});
	}

	// 첨부파일 리스트 보여주기
	function showFiles(){
		let listOutput = '';
		
		existFileList.forEach(function(file){
			listOutput += `<li>\${file.inquiry_image_original_name} <a class="remove-item" href="javascript:void(0)"><i class="lni lni-close"></i></a></li>`;	
		});
		
		fileList.forEach(function(file){
			listOutput += `<li>\${file.name} <a class="remove-item" href="javascript:void(0)"><i class="lni lni-close"></i></a></li>`;
		});
			
		$(".fileList").html(listOutput);
	}
	
	// 초기 페이지 세팅
	function setData(){
		$("#inquiryType").val("${inquiryDetail.inquiry_type}").attr("selected", "selected");
		
		if("${inquiryDetail.inquiry_type}" != '상품'){
			$("#orderList").hide();	
		} else {
			
		} 
		
	    ${inquiryImgList}.forEach(function(inquiryImg){
	    	existFileList.push(inquiryImg);
	    })
		
		showFiles();
	}
	
	// 수정 완료
	function updateInquiry(){
		let inquiryNo = "${inquiryDetail.inquiry_no}";
		let inquiryTitle = $("#inquiryTitle").val();
		let inquiryContent = $("#inquiryContent").val();
		let inquiryType = $("#inquiryType").val();
		let productNo = null;
		
		let formData = new FormData();
		
		if($("#selectInquiryType select").val() == "상품"){
			productNo = $("#selectInquiryProduct select").val();
		}
		
		console.log("inquiryNo: " + inquiryNo);
		console.log("inquiryNo: " + typeof inquiryNo);
		
		formData.append('inquiryNo', Number(inquiryNo));
		formData.append('inquiryTitle', inquiryTitle);
		formData.append('inquiryContent', inquiryContent);
		formData.append('inquiryType', inquiryType);
		formData.append('productNo', productNo);
		
		for (let i = 0; i < fileList.length; i++) {
	        formData.append('files', fileList[i]);
	    }
		
		for (let i = 0; i < existFileList.length; i++) {
	        formData.append('existFiles', existFileList[i].inquiry_image_uri);
	    }
		
		for(const x of formData) {
			console.log(x);
		};
		
		$.ajax({
			url : '/serviceCenter/modifyInquiry',
			type : 'POST',
			dataType: 'text',
			processData: false,
	        contentType: false, 
			data : formData,
			success : function(data) {
				console.log(data);
				location.href = "/serviceCenter/inquiryDetail?inquiryNo=${inquiryDetail.inquiry_no}";
			},
			error : function(error) {
				console.log(error);
			}
		
		});
	}
	
	// 모든 폼에 입력값이 있는지 체크
	function checkFormCompletion() {
		let inquiryTitleCheck = inquiryTitleValid();
		let inquiryContentCheck = inquiryContentValid();
		let inquiryProductCheck = inquiryProductValid();

		if (inquiryTitleCheck && inquiryContentCheck && inquiryProductCheck) {
			$("#modifyInquiryBtn").prop('disabled', false);
		} else {
			$("#modifyInquiryBtn").prop('disabled', true);
		}
	}
	
	// 문의 제목 검사
	function inquiryTitleValid() {
		let valid = false;

		if ($('#inquiryTitle').val().length > 0) {
			valid = true;
		}
		return valid;
	}
	
	// 문의 내용 검사
	function inquiryContentValid() {
		let valid = false;

		if ($('#inquiryContent').val().length > 0) {
			valid = true;
		}
		return valid;
	}
	
	// 상품 선택 검사
	function inquiryProductValid(){
		let valid = false;

		if ($('#selectInquiryType select').val() != "상품" || $('#selectInquiryProduct select').val() != null) {
			valid = true;
		}
		
		return valid;
	}
	
</script>
</head>

<style>
#modifyInquiryBtnArea {
	display: flex;
	flex-direction: row;
	justify-content: flex-end;
}

.checkout-steps-form-style-1 .checkout-steps-form-content {
	border: 1px solid rgb(230, 230, 230) !important;
}

.cart-list-title {
	padding: 20px 0px !important;
}

.remove-item {
	color: #fff;
	background-color: #f44336;
	font-size: 8px;
	height: 18px;
	width: 18px;
	line-height: 18px;
	border-radius: 50%;
	text-align: center;
	margin-left: 5px;
	font-size: 8px;
	height: 18px;
	width: 18px;
	line-height: 18px;
	border-radius: 50%;
	text-align: center;
	height: 18px;
	width: 18px;
	line-height: 18px;
	border-radius: 50%;
	text-align: center;
	width: 18px;
	line-height: 18px;
	border-radius: 50%;
	text-align: center;
}

.list li {
	display: flex;
	flex-direction: row;
	align-items: center;
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
						<h1 class="page-title">Shop Grid</h1>
					</div>
				</div>
				<div class="col-lg-6 col-md-6 col-12">
					<ul class="breadcrumb-nav">
						<li><a href="index.html"><i class="lni lni-home"></i> Home</a></li>
						<li><a href="javascript:void(0)">Shop</a></li>
						<li>Shop Grid</li>
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

					<jsp:param name="pageName" value="inquiries" />

				</jsp:include>
				<!-- / sideBar -->
				
				
				<div class="col-lg-9 col-12">
					<!-- Shopping Cart -->
					<div class="checkout-steps-form-style-1">
						<section class="checkout-steps-form-content collapse show" id="collapseThree" aria-labelledby="headingThree" data-bs-parent="#accordionExample">
							<div class="cart-list-title">
								<h5>문의 수정</h5>
							</div>
							<div class="row">
								<form>
									<div class="col-md-12">
										<div class="single-form form-default">
											<label>문의 제목</label>
											<div class="form-input form">
												<input id="inquiryTitle" type="text" placeholder="문의 제목을 입력하세요." value="${inquiryDetail.inquiry_title }">
											</div>
										</div>
									</div>

									<div class="col-md-12">
										<div class="single-form form-default">
											<label>문의 타입</label>
											<div id="selectInquiryType" class="select-items">
												<select id="inquiryType" class="form-control">
													<option value="상품">상품</option>
													<option value="주문">주문</option>
													<option value="회원">회원</option>
													<option value="기타">기타</option>
												</select>
											</div>
										</div>
									</div>

									<!-- 주문 상품 -->
									<div class="col-md-12">
										<div id="orderList" class="single-form form-default">
											<label>주문 상품</label>
											<div id="selectInquiryProduct" class="select-items">
												<select id="orderListSelect" class="form-control">
												</select>
											</div>
										</div>
									</div>

									<div class="col-md-12">
										<div class="single-form form-default">
											<label>문의 내용</label>
											<div class="form-input form">
												<textarea id="inquiryContent" rows="15" style="resize: none; padding: 10px 20px; height: 100%;">${inquiryDetail.inquiry_content }</textarea>
											</div>
										</div>
									</div>

									<div class="col-md-6">
										<div class="single-form form-default">
											<label>이미지 첨부</label>
											<div class="single-form form-default button" style="margin-top: 0px">
												<input type="file" id="fileInput" name="files" multiple style="display: none;" />
												<button class="btn" onclick="document.getElementById('fileInput').click(); return false;">이미지 첨부하기</button>
											</div>
										</div>
									</div>

									<div class="col-md-12">
										<div class="single-form form-default">
											<label>첨부된 이미지</label>
											<ul class="fileList list mt-1">

											</ul>
										</div>
									</div>

								</form>
							</div>

						</section>

					</div>
					<!--/ End Shopping Cart -->

					<div id="modifyInquiryBtnArea" class="button mt-2">
						<button class="btn" onclick="location.href='/serviceCenter/inquiryDetail?inquiryNo=${inquiryDetail.inquiry_no}'">
							수정 취소
							<span class="dir-part"></span>
						</button>
						<button id="modifyInquiryBtn" class="btn" onclick="updateInquiry()">
							수정 완료
							<span class="dir-part"></span>
						</button>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- End Product Grids -->



	<jsp:include page="/WEB-INF/views/user/pages/footer.jsp"></jsp:include>

	<!-- ========================= scroll-top ========================= -->
	<a href="#" class="scroll-top"> <i class="lni lni-chevron-up"></i>
	</a>

	<!-- ========================= JS here ========================= -->
	<script src="/resources/assets/user/js/bootstrap.min.js"></script>
	<script src="/resources/assets/user/js/tiny-slider.js"></script>
	<script src="/resources/assets/user/js/glightbox.min.js"></script>
	<script src="/resources/assets/user/js/main.js"></script>
	<script type="text/javascript">
        //========= Hero Slider 
        tns({
            container: '.hero-slider',
            slideBy: 'page',
            autoplay: true,
            autoplayButtonOutput: false,
            mouseDrag: true,
            gutter: 0,
            items: 1,
            nav: false,
            controls: true,
            controlsText: ['<i class="lni lni-chevron-left"></i>', '<i class="lni lni-chevron-right"></i>'],
        });

        //======== Brand Slider
        tns({
            container: '.brands-logo-carousel',
            autoplay: true,
            autoplayButtonOutput: false,
            mouseDrag: true,
            gutter: 15,
            nav: false,
            controls: false,
            responsive: {
                0: {
                    items: 1,
                },
                540: {
                    items: 3,
                },
                768: {
                    items: 5,
                },
                992: {
                    items: 6,
                }
            }
        });

    </script>
	<script>
        const finaleDate = new Date("February 15, 2023 00:00:00").getTime();

        const timer = () => {
            const now = new Date().getTime();
            let diff = finaleDate - now;
            if (diff < 0) {
                document.querySelector('.alert').style.display = 'block';
               // index에서 topbar가 display none되지 않도록 처리
               // document.querySelector('.container').style.display = 'none';
            }

            let days = Math.floor(diff / (1000 * 60 * 60 * 24));
            let hours = Math.floor(diff % (1000 * 60 * 60 * 24) / (1000 * 60 * 60));
            let minutes = Math.floor(diff % (1000 * 60 * 60) / (1000 * 60));
            let seconds = Math.floor(diff % (1000 * 60) / 1000);

            days <= 99 ? days = `0${days}` : days;
            days <= 9 ? days = `00${days}` : days;
            hours <= 9 ? hours = `0${hours}` : hours;
            minutes <= 9 ? minutes = `0${minutes}` : minutes;
            seconds <= 9 ? seconds = `0${seconds}` : seconds;

            document.querySelector('#days').textContent = days;
            document.querySelector('#hours').textContent = hours;
            document.querySelector('#minutes').textContent = minutes;
            document.querySelector('#seconds').textContent = seconds;

        }
        timer();
        setInterval(timer, 1000);
        
        // index에서 topbar가 display none되지 않도록 처리
        $("#test").css("display", "block");
    </script>
</body>

</html>