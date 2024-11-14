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

let fileList = [];

	$(function(){
		
		getOrderedProducts();
		
		
		$('#inquiryTitle').on('input', function() {
			checkFormCompletion();
		});

		$('#inquiryContent').on('input', function() {
			checkFormCompletion();
		});
		
		
		$("#fileInput").on("change", function(){
			const maxSize = 10 * 1024 * 1024;
			
			$.each(this.files, function(index, file){
				if(file.type.startsWith("image/") && file.size <= maxSize){
					let isDuplicated = false;
					
					for(let i = 0; i < fileList.length; i++){
						if(fileList[i].name == file.name){
							isDuplicated = true;
						}
					}
					
					if(!isDuplicated){
						fileList.push(file);
						console.log(fileList);
					}	
				}
			})
			
			showFiles();
		});
		
		// 첨부파일 제거
		$(document).on("click", ".remove-item", function(){
			let parentLi = $(this).parent();
			
			for(let i = 0; i < fileList.length; i++){
				if(fileList[i].name == parentLi.text().trim()){
					console.log(fileList[i] + "삭제완료");		
					fileList.splice(i, 1);
					parentLi.remove();
					break;
				}
			}
			
			console.log(fileList);
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
			},
			error : function(error) {
				console.log(error);
			}
		
		});
	}
	
	// 첨부파일 리스트 보여주기
	function showFiles(){
		let listOutput = '';
		
		fileList.forEach(function(file){
			listOutput += `<li>\${file.name} <a class="remove-item" href="javascript:void(0)"><i class="lni lni-close"></i></a></li>`;
		});
			
		$(".fileList").html(listOutput);
	}
	
	// 문의 작성
	function writeInquiry(){
		let inquiryTitle = $("#inquiryTitle").val();
		let inquiryContent = $("#inquiryContent").val();
		let inquiryType = $("#selectInquiryType select").val();
		let productNo = null;
		
		let formData = new FormData();
		
		if($("#selectInquiryType select").val() == "상품"){
			productNo = $("#selectInquiryProduct select").val();
		}
		
		
		formData.append('inquiryTitle', inquiryTitle);
		formData.append('inquiryContent', inquiryContent);
		formData.append('inquiryType', inquiryType);
		formData.append('productNo', productNo);
		
		for (let i = 0; i < fileList.length; i++) {
	        formData.append('files', fileList[i]);
	    }
		
		$.ajax({
			url : '/serviceCenter/writeInquiry',
			type : 'POST',
			dataType: 'text',
			processData: false,
	        contentType: false, 
			data : formData,
			success : function(data) {
				console.log(data);
				location.href = "/serviceCenter/inquiries";
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
			$("#writeInquiryBtn").prop('disabled', false);
		} else {
			$("#writeInquiryBtn").prop('disabled', true);
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
#writeInquiryBtnArea {
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
						<h1 class="page-title">문의 작성</h1>
					</div>
				</div>
				<div class="col-lg-6 col-md-6 col-12">
					<ul class="breadcrumb-nav">
						<li><a href="index.html"><i class="lni lni-home"></i> Home</a></li>
						<li><a href="javascript:void(0)">Service Center</a></li>
						<li>문의 작성</li>
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
								<h5>문의</h5>
							</div>
							<div class="row">
								<form>
									<div class="col-md-12">
										<div class="single-form form-default">
											<label>문의 제목</label>
											<div class="form-input form">
												<input id="inquiryTitle" type="text" placeholder="문의 제목을 입력하세요.">
											</div>
										</div>
									</div>

									<div class="col-md-12">
										<div class="single-form form-default">
											<label>문의 타입</label>
											<div id="selectInquiryType" class="select-items">
												<select class="form-control">
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
												<textarea id="inquiryContent" rows="15" style="resize: none; padding: 10px 20px; height: 100%;"></textarea>
											</div>
										</div>
									</div>

									<div class="col-md-6">
										<div class="single-form form-default">
											<label>이미지 첨부</label>
											<div class="single-form form-default button" style="margin-top: 0px">
												<input type="file" id="fileInput" name="files" multiple style="display: none;" accept="image/" />
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

					<div id="writeInquiryBtnArea" class="button mt-2">
						<button class="btn" onclick="location.href='/serviceCenter/inquiries'">목록으로 돌아가기</button>
						<button id="writeInquiryBtn" class="btn" onclick="writeInquiry()" disabled>작성 완료</button>
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