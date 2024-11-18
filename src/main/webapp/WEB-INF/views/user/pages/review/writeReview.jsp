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

        $(function() {
            $('#reviewTitle').on('input', function() {
                checkFormCompletion();
                
                // 리뷰 제목이 92바이트를 넘는지 확인
                let byteLength = getByteLength($(this).val());
                if (byteLength > 90) {
                    alert('리뷰 제목 제한을 넘었습니다.'); // 알림 메시지
                    $(this).val(truncateToByteLength($(this).val(), 90)); // 92바이트로 제한
                }
            });

            $('#reviewContent').on('input', function() {
                checkFormCompletion();
            });

            $("#fileInput").on("change", function() {

                $.each(this.files, function(index, file) {
                    // 중복 파일 거르기
                    if (!fileList.some(function(f) {
                            return f.name === file.name
                        })) {
                        fileList.push(file);
//                         console.log(fileList);
                    }
                });

                showFiles();
            });

            // 첨부파일 제거
            $(document).on("click", ".remove-item", function() {
                let parentLi = $(this).parent();

                for (let i = 0; i < fileList.length; i++) {
                    if (fileList[i].name == parentLi.text().trim()) {
//                         console.log(fileList[i] + "삭제완료");
                        fileList.splice(i, 1);
                        parentLi.remove();
                        break;
                    }
                }

//                 console.log(fileList);
                showFiles();
            })

        });

        // 첨부파일 리스트 보여주기
        function showFiles() {
            let listOutput = '';

            fileList.forEach(function(file) {
                listOutput += `<li>\${file.name} <a class="remove-item" href="javascript:void(0)"><i class="lni lni-close"></i></a></li>`;
            });

            $(".fileList").html(listOutput);
        }

        // 리뷰 저장
        function saveReview() {
            let reviewTitle = $("#reviewTitle").val();
            let reviewContent = $("#reviewContent").val();
            let reviewScore = $("#reviewScore").val();
            let product_no = $("#product_no").val();

            let formData = new FormData();


            formData.append('review_title', reviewTitle);
            formData.append('review_content', reviewContent);
            formData.append('review_score', reviewScore);
			formData.append('product_no', product_no);
            
            for (let i = 0; i < fileList.length; i++) {
                formData.append('files', fileList[i]);
            }
            
            // 별점 선택 여부 확인
            if (reviewScore == 0) {
                const proceed = confirm("별점 선택을 안 하셨습니다. 작성 완료 하시겠습니까?");
                if (!proceed) {
                    alert("별점을 선택해주세요."); // 별점 선택을 요청하는 메시지
                    return; // 함수 종료, 작성 완료로 진행하지 않음
                }
            }

            $.ajax({
                url: '/review/writeReview',
                type: 'POST',
                dataType: 'text',
                processData: false,
                contentType: false,
                data: formData,
                success: function(data) {
//                     console.log(data);
                    location.href = "/review/writtenByReview";
                },
                error: function(error) {
//                 	console.log("다메다메");
                    console.log(error);
                }
            });
        }

        // 모든 폼에 입력값이 있는지 체크
        function checkFormCompletion() {
            let reviewTitleCheck = reviewTitleValid();
            let reviewContentCheck = reviewContentValid();
            let reviewScoreCheck = reviewScoreValid();

            if (reviewTitleCheck && reviewContentCheck && reviewScoreCheck) {
                $("#saveReviewBtn").prop('disabled', false);
            } else {
                $("#saveReviewBtn").prop('disabled', true);
            }
        }

    	// 리뷰 제목 검사
    	function reviewTitleValid() {
    		let valid = false;

            // 리뷰 제목이 92바이트를 넘지 않는지 확인
            if (getByteLength($('#reviewTitle').val()) > 0 && getByteLength($('#reviewTitle').val()) <= 90) {
                valid = true;
            }
    		return valid;
    	}
    	
    	// 리뷰 내용 검사
    	function reviewContentValid() {
    		let valid = false;

    		if ($('#reviewContent').val().length > 0) {
    			valid = true;
    		}
    		return valid;
    	}

        // 리뷰 점수 유효성 검사
    	function reviewScoreValid() {
    		let valid = false;

    		if ($('#reviewScore').val().length > 0) {
    			valid = true;
    		}
    		return valid;
    	}
        
        // 문자열의 바이트 길이 계산
        function getByteLength(str) {
            return new Blob([str]).size;
        }

        // 문자열을 지정된 바이트 길이로 자르기
        function truncateToByteLength(str, maxBytes) {
            let truncatedStr = str;
            while (getByteLength(truncatedStr) > maxBytes) {
                truncatedStr = truncatedStr.slice(0, -1);
            }
            return truncatedStr;
        }
        
        
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
    .star-rating .star {
    font-size: 24px;
    color: #ddd;
    cursor: pointer;
    transition: color 0.2s;
}

.star-rating .star.selected {
    color: gold; /* 선택된 별점 색상 */
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

                    <jsp:param name="pageName" value="writableReview" />

                </jsp:include>
                <!-- / sideBar -->

                <div class="col-lg-9 col-12">
                    <!-- Shopping Cart -->
                    <div class="checkout-steps-form-style-1">
                        <section class="checkout-steps-form-content collapse show" id="collapseThree" aria-labelledby="headingThree" data-bs-parent="#accordionExample">
                            <div class="cart-list-title">
                                <h5>리뷰</h5>
                            </div>
                            
                            
                            <div class="row">
                                    <div class="col-12">
                                        <div class="single-form form-default">
                                            <label>상품 사진</label>
                                            <div class="form-input form">
                                                <img src="${image_url}" alt="${param.product_name }" onerror="this.onerror=null; this.src='/resources/images/noP_image.png';" style="width: 200px; height: 200px; object-fit: cover;">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="single-form form-default">
                                            <label>상품 이름</label>
                                            <div class="form-input form">
                                                <input type="text" name = "product_name" value="${param.product_name}" readonly>
                                                <input type="hidden" id="product_no" name="product_no" value="${param.product_no}">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-12">
                                        <div class="single-form form-default">
                                            <label>리뷰 제목</label>
                                            <div class="form-input form">
                                                <input id="reviewTitle" name="review_title" type="text" placeholder="리뷰 제목을 입력하세요.">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-12">
                                        <div class="single-form form-default">
                                            <label>별점</label>
							    <div id="starRating" class="star-rating">
							        <i class="star" data-value="1">&#9733;</i>
							        <i class="star" data-value="2">&#9733;</i>
							        <i class="star" data-value="3">&#9733;</i>
							        <i class="star" data-value="4">&#9733;</i>
							        <i class="star" data-value="5">&#9733;</i>
							    </div>
							    <input type="hidden" id="reviewScore" name="reviewScore" value="0">

                                        </div>
                                    </div>

                                    <div class="col-md-12">
                                        <div class="single-form form-default">
                                            <label>리뷰 내용</label>
                                            <div class="form-input form">
                                                <textarea id="reviewContent" rows="15"  style="resize: none; padding: 10px 20px; height: 100%;"></textarea>
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

                            </div>

                        </section>

                    </div>
                    <!--/ End Shopping Cart -->

                    <div id="saveReviewBtnArea" class="button mt-2">
                        <button class="btn" onclick="location.href='/review/writableReview'">
                            목록으로 돌아가기
                        </button>
                        
                        <button id="saveReviewBtn" class="btn" onclick="saveReview()" disabled>
                            리뷰 등록
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