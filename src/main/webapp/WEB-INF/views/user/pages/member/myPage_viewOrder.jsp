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

<!-- 커스텀 스타일 -->
<style>
	.btn {
		width: 100%;
	}
	
	.form-group input.text-input:focus {
		border-color: #A8A691;
	}

	.form-group input.text-input {
		width: 100%;
		padding: 15px 20px;
		border-radius: 4px;
		border: 1px solid #e6e2f5;
		transition: all 0.4s ease;
		margin-bottom: 1rem;
	}

	.form-group textarea:focus {
  		border-color: #A8A691;
		resize: none;
	}
	
	.form-group textarea {
		height: 180px;
		width: 100%;
		border: 1px solid #e6e2f5;
		padding: 15px 20px;
		color: #333;
		resize: none;
		font-weight: 400;
		resize: vertical;
		border-radius: 4px;
		background-color: #fff;
		-webkit-transition: all 0.4s ease;
		transition: all 0.4s ease;
	}
</style>

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
/* 	let orderInfo = null
	
	$(document).ready(function() {
		orderInfo = loadOrderInfo()
		showViewOrderPage(orderInfo)
	})

	function showViewOrderPage(orderInfo) {
		let tags = ''
		tags += '<div class="cart-list-head">'
		tags += `
			<div class="cart-list-title">
				<div class="row align-items-center">
					<div class="col-lg-1 col-md-1 col-12"></div>
					<div class="col-lg-4 col-md-4 col-12"><p>주문이름</p></div>
					<div class="col-lg-2 col-md-2 col-12"><p>주문일자/주문번호</p></div>
					<div class="col-lg-2 col-md-2 col-12"><p>처리상태</p></div>
					<div class="col-lg-3 col-md-3 col-12"><p>변경/처리</p></div>
				</div>
			</div>`
		
		// orderInfo를 최근순으로 정렬
		orderInfo.sort((a, b) => 
				new Date(b.orderDate) - new Date(a.orderDate) 
			);
		
			
		for (orderJson of orderInfo) {
			let orderDate = orderJson.orderDate
			let orderId = orderJson.orderId
			let orderStatus = orderJson.orderStatus
			let products = orderJson.products
			tags += `<div class="cart-single-list grid-container">`
			tags += `<div class="row align-items-center">`
			tags += `<div class="col-lg-1 col-md-1 col-12">`
			tags += `<img src=\${products[0].image_url} alt="#">` // TODO : alt image 삽입
			tags += `</div>`
			tags += `<div class="col-lg-4 col-md-4 col-12">`
			if (products.length >= 2) {
				tags += `<p>\${products[0].product_name}외 \${products.length - 1}건</p>`
			} else {
				tags += `<p>\${products[0].product_name}</p>`
			}
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
			if (orderStatus == "결제완료") {
				tags += makeButtonTag("cancel", orderId)
			} else if (orderStatus == "배송완료") {
				tags += makeButtonTag("return", orderId)
			} else {
				tags += "<p></p>" // 아무것도 표시하지 않음
			}
			tags += `</div>`
			tags += `</div>` // class="row align-items-center" end
			tags += `</div>` // class="cart-single-list grid-container" end
		}
		tags += '</div>' // class="cart-list-head" end
			
/* 		for (orderJson of orderInfo) {
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
				if (orderStatus == "결제완료") {
					tags += makeButtonTag("cancel", orderId)
				} else if (orderStatus == "배송완료") {
					tags += makeButtonTag("return", orderId)
				} else {
					tags += "<p></p>" // 아무것도 표시하지 않음
				}

				tags += `</div>`
				tags += `</div>` // class="row align-items-center" end
				tags += `</div>` // class="cart-single-list grid-container" end
			}
		}
		tags += '</div>' // class="cart-list-head" end */
		
		
		$("#productsView").html(tags)
		// 버튼에 이벤트 핸들러 부착
 		$(".button .btn").each(function() {
			$(this).click(function() {
				let orderId = $(this).attr("attr-order-id")
				let aOrder = orderInfo.find((o) => o.orderId == orderId)
				console.log("aOrder : " + JSON.stringify(aOrder))
				console.log("orderId : " + orderId)
				let cancelType = $(this).attr("attr-cancel-type")
				onOrderCancelBtnClicked(aOrder, cancelType)
			})
		})
		
	}

	function makeButtonTag(cancelType, orderId) { // TODO : orderStatus에 따라 버튼의 이름 다르게 만들기
		let buttonValue = null
		if (cancelType == "cancel") {
			buttonValue = "주문 취소"
		} else if (cancelType == "return") {
			buttonValue = "반품/환불"
		}
		tag = `<div class="button">
					<button class="btn" attr-order-id=\${orderId} attr-cancel-type=\${cancelType}>\${buttonValue}</button>
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

	function onOrderCancelBtnClicked(orderJson, cancelType) {
		let orderId = orderJson.orderId
		console.log("orderJson in onOrderCancelBtnClicked : " + JSON.stringify(orderJson))
		$("#productsView").html("")
		tags = ""
		tags += `<div class="card">`
		tags += `<div class="card-body row">`
		tags += `<div class="title col-12">`
		tags += (cancelType == "cancel" ? `<h3>주문 취소 신청</h3>` :  `<h3>반품/환불 신청</h3>`)
		tags += `</div>` // class="title col-12" end
		tags += `<p>주문번호 : \${orderId}</p>`

		tags += `
		<div class="cart-list-title col-12">
			<div class="row align-items-center">
				<div class="col-lg-1 col-md-1 col-12"></div>
				<div class="col-lg-4 col-md-4 col-12"><p>상품정보</p></div>
				<div class="col-lg-4 col-md-4 col-12"><p>처리상태</p></div>
				<div class="col-lg-3 col-md-3 col-12"><p>취소/환불</p></div>
			</div>
		</div>`
		
		// working...
		for (product of orderJson.products) {
			tags += `<div class="cart-single-list col-12">`
			tags += `
				<div class="row align-items-center">
					<div class="col-lg-1 col-md-1 col-12"><a href="">
						<img src=\${product.image_url} alt="#"></a>
					</div>
					<div class="col-lg-4 col-md-4 col-12">
						<p>\${product.product_name}</p>
					</div>`
			if (product.cancel_status == "None") {
				tags +=`<div class="col-lg-4 col-md-4 col-12">
					<p>\${orderJson.orderStatus}</p>
				</div>`
			} else {
				tags +=`<div class="col-lg-4 col-md-4 col-12">
					<p>\${product.cancel_status}</p>
				</div>`
			}
			if (product.cancel_status == "None") {
				tags +=`<div class="col-lg-3 col-md-3 col-12">
					<input class="form-check-input" type="checkbox" attr-orderproduct-no=\${product.orderproduct_no} attr-checked-msg="환불신청" onclick="showInfoForCheckbox(this)"></input>
					<span></span>
				</div>`
			} else if (product.cancel_status == "환불대기중") {
				tags +=`<div class="col-lg-3 col-md-3 col-12">
					<input class="form-check-input" type="checkbox" attr-orderproduct-no=\${product.orderproduct_no} attr-checked-msg="환불취소" onclick="showInfoForCheckbox(this)"}></input>
					<span></span>
				</div>`
			} else if (product.cancel_status == "환불취소" || product.cancel_status == "환불완료") {
				tags += `<p></p>`
			}
			tags += `</div>`
			tags += `</div>`
		} // for_end

		tags += `<p>신청사유</p>`

		tags += `<div class="form-group col-12">`
		tags += `<textarea id="cancel-reason"></textarea>` // TODO : 255자 이상 안들어가게 막아줘야 함
		tags += `</div>` // textarea end

		tags += `<p>계좌 정보</p>`
		tags += `<div class="form-group col-lg-6 col-md-6 col-12">`
		tags += `<input class="text-input" type="text" placeholder="예금주" id="account-owner"></input>`
		tags += `</div>`
		tags += `<div class="form-group col-lg-6 col-md-6 col-12">`
		tags += `<input class="text-input" type="text" placeholder="은행" id="account-bank"></input>`
		tags += `</div>`
		tags += `<div class="form-group col-lg-6 col-md-6 col-12">`
		tags += `<input class="text-input" type="text" placeholder="계좌번호" id="account-number"></input>`
		tags += `</div>`
		tags += "<p></p>"

		tags += `<div class="col-lg-6 col-md-6 col-12 button">`
		tags += `<button class="btn" onclick="submitOrderCancel(\'\${cancelType}\')">확인</button>`
		tags += `</div>`
		tags += `<div class="col-lg-6 col-md-6 col-12 button">`
		tags += `<button class="btn" onclick="cancelSubmit()">취소</button>`
		tags += `</div>`

		tags += `</div>` // class="card-body row" end
		tags += `</div>` // class="card" end
		tags += `<div style="display:none;" id="order-id">\${orderId}</div>`
		$("#productsView").html(tags)
	} // function end
	
	function showInfoForCheckbox(elt) {
		if ($(elt).is(":checked")) {
			$(elt).next().html($(elt).attr("attr-checked-msg"))
		} else {
			$(elt).next().html("")
		}
	}
	
	function submitOrderCancel(cancelType) {
		let products = []
		$(".form-check-input").each(function() {
			if ($(this).is(':checked')) {
				let p = {}
				p.orderproductNo = ($(this).attr("attr-orderproduct-no"))
				p.request = ($(this).attr("attr-checked-msg"))
				products.push(p)
			}
		})
		let orderId = $("#order-id").text()
		let cancelReason = $("#cancel-reason").val()
		let accountOwner =  $("#account-owner").val()
		let accountBank = $("#account-bank").val()
		let accountNumber = $("#account-number").val()
		
		$.ajax({
			async: false,
			type: 'POST',
			url: '/cancelOrder',
			data: JSON.stringify({
				orderId: orderId,
				cancelType: cancelType,
				products: products,
				cancelReason: cancelReason,
				accountOwner: accountOwner,
				accountBank: accountBank,
				accountNumber: accountNumber
			}),
			dataType: 'json',
			contentType: 'application/json',
            success : function(response) {
                console.log("/cancelOrder 요쳥의 응답 : " + response)
                location.href = window.location.origin + "/member/myPage/viewOrder?result=success"
            },
            error : function(request, status, error) {
                console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                // TODO : 에러 페이지 보여주기
            }
		})
	}
	
	function cancelSubmit() {
		showViewOrderPage(orderInfo)
	} */
</script>


<!-- <div class="col-12">
	<div class="form-group message">
		<textarea name="message" placeholder="Your Message"></textarea>
	</div>
</div> -->


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
	
	<script src="/resources/assets/user/js/viewOrder.js"></script>
	
	<script>
	var orderInfo = null
	
	$(document).ready(function() {
		orderInfo = loadOrderInfo()
		showViewOrderPage(orderInfo)
	})
	</script>
</body>

</html>