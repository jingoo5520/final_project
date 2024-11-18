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
    <link rel="shortcut icon" type="image/x-icon" href="/resources/assets/user/images/logo/white-logo.svg" />

    <!-- ========================= CSS here ========================= -->
    <link rel="stylesheet" href="/resources/assets/user/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/resources/assets/user/css/LineIcons.3.0.css" />
    <link rel="stylesheet" href="/resources/assets/user/css/tiny-slider.css" />
    <link rel="stylesheet" href="/resources/assets/user/css/glightbox.min.css" />
    <link rel="stylesheet" href="/resources/assets/user/css/main.css" />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        let fileList = []; // 업로드할 새로운 파일 목록
        let existFileList = []; // 기존에 이미 서버에 존재하는 파일 목록
        let removedFileList = []; // 기존에 있는 파일 중 삭제하고자 하는 파일 목록
        
        $(document).ready(function() {
        	
            const reviewNo = "${param.reviewNo}"; // 서버에서 reviewNo 값 제공

            $.ajax({
                url: '/review/getImgs', // 파일 리스트를 가져오는 API 엔드포인트
                type: 'GET',
                dataType: 'json',
                data: { "reviewNo" : reviewNo }, // 필요한 파라미터 전달
                success: function(data) {
                    existFileList = data; // 서버에서 받아온 파일 리스트를 existFileList에 저장
                    showFiles(); // 파일 리스트 화면에 표시
                    showExistFileList();
//                     console.log("받아온 data : ", data);

                },
                error: function(error) {
                    console.error("기존 파일 목록을 불러오는 중 오류 발생:", error);
                }
            });
            
        // 파일 첨부시 파일 목록에 추가
		$("#fileInput").on("change", function(){
			// 이미지 파일만 업로드 가능
			const imageTypes = ["image/jpeg", "image/png"];
			
			// 중복 이름 거르기
			$.each(this.files, function(index, file){
				if (!imageTypes.includes(file.type)) {
// 		            console.log("이미지 파일이 아닙니다", file.name);
// 		            console.log(file.type);
		            return; 
		        }
				
				let inFileList = fileList.some(function(f){
					return f.name === file.name; 
				}); 
				
				let inExistFileList = existFileList.some(function(f){
					return f.image_url === file.name; 
				});
					
				if(!inFileList && !inExistFileList) {
					fileList.push(file);
				}
			});
// 			console.log(fileList);
// 			console.log(existFileList);
			showFiles();
		});
        
        $(document).ready(function() {
            // 별 클릭 시 별점 값 설정 및 스타일 변경
            $(".star").on("click", function() {
                let selectedValue = $(this).data("value");
                $("#reviewScore").val(selectedValue); // 선택한 별점 값을 숨겨진 input에 설정

//                 console.log("선택한 별점 값:", selectedValue); // 콘솔에 별점 값 출력
                // 선택한 별점까지 스타일 적용
                $(".star").each(function() {
                    let starValue = $(this).data("value");
                    if (starValue <= selectedValue) {
                        $(this).addClass("selected"); // 선택된 별점 클래스
                    } else {
                        $(this).removeClass("selected");
                    }
                });
            });
        });
	});
		
		// 추가되는 첨부파일 제거
		$(document).on("click", ".remove-item", function(){
			let parentLi = $(this).parent();
			
			for(let i = 0; i < fileList.length; i++){
				if(fileList[i].name == parentLi.text().trim()){
// 					console.log(fileList[i] + "삭제완료");		
					fileList.splice(i, 1);
					parentLi.remove();
					break;
				}
			}
			
// 			console.log(fileList);
// 			console.log(existFileList);
			showFiles();
		})
		
		// 기본 첨부 이미지파일 제거
			$(document).on("click", ".remove-file", function(){
			let parentLi = $(this).parent();
			
			for(let i = 0; i < existFileList.length; i++){
				if(existFileList[i] == parentLi.text().trim()){
// 					console.log(existFileList[i] + "삭제완료");	
					removedFileList.push(existFileList[i]);
					existFileList.splice(i, 1);
					parentLi.remove();
					break;
				}
			}
			
// 			console.log("ex: " + existFileList);
// 			console.log("rm: " + removedFileList);
			showExistFileList();
		})
		
		
	// 첨부파일 리스트 보여주기
	function showFiles(){
		let listOutput = '';
		
		fileList.forEach(function(file){
			listOutput += `<li>\${file.name} <a class="remove-item" href="javascript:void(0)"><i class="lni lni-close"></i></a></li>`;
		});
			
		$(".fileList").html(listOutput);
	}


	// 기존 파일 리스트 보여주기
	function showExistFileList() {
		let listOutput = '';
		
		existFileList.forEach(function(file){
			listOutput += `<li>\${file} <a class="remove-file" href="javascript:void(0)"><i class="lni lni-close"></i></a></li>`;	
		});
		$(".existFileList").html(listOutput);
	}


	// 수정 완료
	function modifyReview(){
		let reviewNo = "${param.reviewNo}";
		let reviewTitle = $("#reviewTitle").val();
		let reviewContent = $("#reviewContent").val();
		let reviewScore = $("#reviewScore").val();
		let formData = new FormData();
		
		formData.append('reviewNo', Number(reviewNo));
		formData.append('reviewTitle', reviewTitle);
		formData.append('reviewContent', reviewContent);
		formData.append('reviewScore', reviewScore);
		
		
		for (let i = 0; i < fileList.length; i++) {
	        formData.append('files', fileList[i]);
	    }
		
		for (let i = 0; i < existFileList.length; i++) {
	        formData.append('existFiles', existFileList[i]);
	    }
		
		for (let i = 0; i < removedFileList.length; i++) {
			formData.append('removedFiles', removedFileList[i])
		}
		
		for(const x of formData) {
// 			console.log(x);
		};
		
		$.ajax({
			url : '/review/modifyReview',
			type : 'POST',
			dataType: 'text',
			processData: false,
	        contentType: false, 
			data : formData,
			success : function(data) {
// 				console.log(data);
				location.href = "/review/reviewDetail?reviewNo=${param.reviewNo}";
				
			},
			error : function(error) {
				alert("관리자가 답글을 단 게시글이거나 입력조건을 충족하지 못했습니다.");
				console.log(error);
			}
		
		})
	}
	
	
    </script>
</head>

<style>
    #saveReviewBtnArea {
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

    .remove-item, .remove-file {
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

    .star-rating .star {
        font-size: 24px;
        color: #ddd;
        cursor: pointer;
        transition: color 0.2s;
    }

    .star-rating .star.selected {
        color: gold;
        /* 선택된 별점 색상 */
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
                                <h5>리뷰 상세</h5>
                            </div>


                            <div class="row">
								<form>
                                <c:forEach var="review" items="${reviews}">
                                    <div class="col-12">
                                        <div class="single-form form-default">
                                            <label>상품 사진</label>
                                            <div class="form-input form">
                                                <img src="${review.product_image_url}" alt="${review.product_name}" onerror="this.onerror=null; this.src='/resources/images/noP_image.png';" style="width: 200px; height: 200px; object-fit: cover;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="single-form form-default">
                                            <label>상품 이름</label>
                                            <div class="form-input form">
                                                <input type="text" name="product_name" value="${review.product_name}" readonly>
                                                <input type="hidden" id="product_no" name="product_no" value="${review.product_no}">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-12">
                                        <div class="single-form form-default">
                                            <label>리뷰 제목</label>
                                            <div class="form-input form">
                                                <input id="reviewTitle" name="review_title" type="text" placeholder="리뷰 제목을 입력하세요." value="${review.review_title}" >
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-12">
                                        <div class="single-form form-default">
                                            <label>별점</label>
                                            <div id="starRating" class="star-rating">
                                                <c:forEach begin="1" end="5" var="star">
                                                    <i class="star ${star <= review.review_score ? 'selected' : ''}" data-value="${star}" >&#9733;</i>
                                                </c:forEach>
                                            </div>
                                            <input type="hidden" id="reviewScore" name="reviewScore" value="${review.review_score}">
                                        </div>
                                    </div>

                                    <div class="col-md-12">
                                        <div class="single-form form-default">
                                            <label>리뷰 작성일</label>
                                            <div>
                                                <fmt:formatDate value="${review.register_date}" pattern="yyyy-MM-dd  HH:mm:ss (EEE)" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-12">
                                        <div class="single-form form-default">
                                            <label>리뷰 내용</label>
                                            <div class="form-input form">
                                                <textarea id="reviewContent" rows="15" style="resize: none; padding: 10px 20px; height: 100%;" >${review.review_content}</textarea>
                                            </div>
                                        </div>
                                    </div>

                                </c:forEach>
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
                                        
                                        <div>
                                            <label>기본 첨부 이미지</label>
											<ul class="existFileList list mt-1">
												
                                            </ul>
                                        </div>
                                    </div>
                                    
								</form>
                            </div>

                        </section>

                    </div>
                    <!--/ End Shopping Cart -->

                    <div id="saveReviewBtnArea" class="button mt-2">
                        <button class="btn" onclick="location.href='/review/writableReview'">
                            목록으로 돌아가기
                        </button>
                        <button id="saveReviewBtn" class="btn" onclick="modifyReview()">
                            수정완료
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
    <script>
        // index에서 topbar가 display none되지 않도록 처리
        $("#test").css("display", "block");
    </script>
</body>

</html>