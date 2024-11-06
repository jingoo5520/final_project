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
	let pageNo = 1;
	let pagingSize = 5;
	let pageCntPerBlock = 5;

	// 문의 리스트 보여주기
	function showInquiryList(pageNo) {
		$.ajax({
			url : '/serviceCenter/getInquiries',
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
				
				$.each(data.list, function(index, inquiry) {
					let timestamp = inquiry.inquiry_reg_date;
					let date = new Date(timestamp);
					
					let year = date.getFullYear();
					let month = String(date.getMonth() + 1).padStart(2, '0'); 
					let day = String(date.getDate()).padStart(2, '0'); 

				    date = `\${year}-\${month}-\${day}`;
					
					listOutput +=
						`<div class="cart-single-list" onclick="location.href='/serviceCenter/inquiryDetail?inquiryNo=\${inquiry.inquiry_no}'">`
						+ '<div class="row align-items-center">'
						+ `<div class="col-lg-2 col-md-2 col-12">\${inquiry.inquiry_no }</div>`
						+ `<div class="col-lg-6 col-md-6 col-12">\${inquiry.inquiry_title }</div>`
						+ `<div class="col-lg-2 col-md-2 col-12">\${date}</div>`
						+ `<div class="col-lg-2 col-md-2 col-12">\${inquiry.inquiry_status == "W" ? "답변 대기" : "답변 완료"} </div>`
						+ `</div>`
						+ `</div>`;
				});

				$('#inquiryList').html(listOutput);
				
				if(data.pi.pageNo == 1){
				} else {
					paginationOutput += `<li><a href="javascript:void(0)" onclick="showInquiryList(\${data.pi.pageNo - 1})"><i class="lni lni-chevron-left"></i></a></li>`;
				}
				
				
				for(let i = data.pi.startPageNoCurBloack; i < data.pi.endPageNoCurBlock + 1; i++){
					if(i == data.pi.pageNo) {
						paginationOutput += `<li class="active"><a href="javascript:void(0)" onclick="showInquiryList(\${i})">\${i}</a></li>`;
					} else {
						paginationOutput += `<li><a href="javascript:void(0)" onclick="showInquiryList(\${i})">\${i}</a></li>`;	
					}
				}
				
				
				if(data.pi.pageNo == data.pi.totalPageCnt){
				} else {
					paginationOutput += `<li><a href="javascript:void(0)" onclick="showInquiryList(\${data.pi.pageNo + 1})"><i class="lni lni-chevron-right"></i></a></li>`;
				}
				
				$('.pagination-list').html(paginationOutput);
				
				
			},
			error : function(error) {
				console.log(error);
			}
		});
	}
	
	// 디테일 페이지 이동
	function goInquiryDetailPage(inquiryNo) {
		
	}

</script>

<script>
	$(document).ready(function() {
		let orderInfo = loadOrderInfo()
		insertUIToPage(orderInfo)
	})

	function insertUIToPage(orderInfo) {
		let tags = ''
		tags += '<div class="cart-list-head">'
		tags += `
			<div class="cart-list-title">
				<div class="row align-items-center">
					<div class="col-lg-1 col-md-1 col-12"></div>
					<div class="col-lg-4 col-md-4 col-12"><p>상품정보</p></div>
					<div class="col-lg-2 col-md-2 col-12"><p>주문일자/주문번호</p></div>
					<div class="col-lg-2 col-md-2 col-12"><p>처리상태</p></div>
					<div class="col-lg-3 col-md-3 col-12"><p>변경/처리</p></div>
				</div>
			</div>`
		
		for (orderJson of orderInfo) {
			let orderDate = orderJson.orderDate
			let orderId = orderJson.orderId
			let orderStatus = orderJson.orderStatus

			for (product of orderJson.products) {
				tags += `<div class="cart-single-list grid-container">`
				tags += `<div class="row align-items-center">`
				tags += `<div class="col-lg-1 col-md-1 col-12">`
				tags += `<a href="">` // TODO : 상품 상세페이지 이동
				tags += `<img src=\${product.image_url} alt="#">` // TODO : alt image 삽입
				tags += `</a>`
				tags += `</div>`
				tags += `<div class="col-lg-4 col-md-4 col-12">`
				tags += `<p>\${product.product_name}</p>`
				tags += `</div>`
				tags += `<div class="col-lg-2 col-md-2 col-12">`
				tags += `<p>\${orderDate}</p>`
				tags += `<p>\${orderId}</p>`
				tags += `</div>`

				tags += `<div class="col-lg-2 col-md-2 col-12">`
				tags += `<p>\${orderStatus}</p>`
				tags += `</div>`
				tags += `<div class="col-lg-2 col-md-2 col-12">`
				
				// orderStatus는 "결제대기", "결제완료", "상품준비중", "배송준비중", "배송중", "배송완료" 중 하나이다
				if (orderStatus == "결제완료" || orderStatus == "배송완료") {
					tags += makeButtonTag(orderStatus, "") // TODO : 함수 호출
				} else {
					tags += "<p></p>" // 아무것도 표시하지 않음
				}

				tags += `</div>`
				tags += `</div>` // class="row align-items-center" end
				tags += `</div>` // class="cart-single-list grid-container" end
			}
		}
		tags += '</div>' // class="cart-list-head" end
		$("#productsView").append(tags)
	}

	function makeButtonTag(name, functionName) {
		tag = `<div class="button">
					<button class="btn" onclick="\${functionName}">주문 취소</button>
				</div>`
		return tag
	}
	
	function loadOrderInfo() {
		let memberId = null
		let orderInfo = null
		// 로그인한 id 얻어오기
        $.ajax({
            async: false,
            type : 'GET',
            url : "/getLoginedId",
            dataType : "text",
            success : function(response) {
                memberId = response
            },
            error : function(request, status, error) {
                console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);       
            }
        })
        
        
        $.ajax({
			async: false,
			type: 'GET',
			url: '/orderProducts?memberId=' + memberId,
			dataType: 'json',
            success : function(response) {
                orderInfo = response
            },
            error : function(request, status, error) {
                console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);       
            }
		})
		
		console.log("orderInfo : ")
		console.log(orderInfo)
		console.log(JSON.stringify(orderInfo))
		return orderInfo
	}
</script>

</head>

<style>
#writeInquiryBtnArea {
	display: flex;
	flex-direction: row;
	justify-content: flex-end;
}

.cart-single-list {
	padding: 10px 20px !important;
}

.pagination {
	margin: 20px 0px !important;
}

.cart-single-list:hover {
	background-color: #f0f0f0;
	cursor: pointer;
	transition: background-color 0.3s ease;
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
				<jsp:include page="/WEB-INF/views/user/pages/myPageSideBar.jsp">

					<jsp:param name="pageName" value="viewOrder" />

				</jsp:include>
				<!-- / sideBar -->


				<div class="col-lg-9 col-12" id="productsView">



					<!-- <div id="writeInquiryBtnArea" class="button mt-2">
						<button class="btn" onclick="location.href = '/serviceCenter/writeInquiry'">
							문의 작성
							<span class="dir-part"></span>
						</button>
					</div> -->
				</div>
				
				<!--/ End Shopping Cart -->
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
<!-- 	<script type="text/javascript">
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

    </script> -->
<!-- 	<script>
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
    </script> -->
</body>

</html>