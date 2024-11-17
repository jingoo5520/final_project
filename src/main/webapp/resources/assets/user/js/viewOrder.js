
	var orderInfo = null

	function showViewOrderPage(orderInfo) {
		console.log("showViewOrderPage 함수 호출중")
		
		if (orderInfo.length <= 0) {
			let tags = ''
			tags += `<div class="d-flex justify-content-center align-items-center flex-column" style="height: 100%;">`
			tags += `<div id="row align-items-center">
						<img alt="주문내역 없음" src="/resources/assets/user/images/error/emptyCart.png" style="width: 100px;">
			 		 </div>`
			tags += `<div id="row align-items-center" style="margin-top: 10px;">`
			tags += 	"<p><b>아직 주문 내역이 없습니다</b></p>"
			tags += "</div>"

			tags += `</div>` // class="d-flex justify-content-center align-items-center" end
			$("#productsView").html(tags)
			return
		}
		
		
		
		let tags = ''
		tags += '<div class="cart-list-head">'
		tags += `
			<div class="cart-list-title">
				<div class="row align-items-center">
					<div class="col-lg-1 col-md-1 col-12"></div>
					<div class="col-lg-4 col-md-4 col-12"><p>주문이름</p></div>
					<div class="col-lg-2 col-md-2 col-12"><p>주문일자/주문번호</p></div>
					<div class="col-lg-2 col-md-2 col-12"><p>처리상태/결제수단</p></div>
					<div class="col-lg-3 col-md-3 col-12"><p>변경/처리</p></div>
				</div>
			</div>` // class="cart-list-title" end
		// orderInfo를 최근순으로 정렬
		orderInfo.sort((a, b) => 
				new Date(b.orderDate) - new Date(a.orderDate) 
			);
		
		for (orderJson of orderInfo) {
			let orderDate = orderJson.orderDate
			let orderId = orderJson.orderId
			let orderStatus = orderJson.orderStatus
			if (orderStatus == "결제대기") {
				continue; // 결제대기 상태인 주문은 표시하지 않음
			}
			let products = orderJson.products
			let payMethod = orderJson.payMethod
			if (payMethod == "TC") {
				payMethod = "카드결제"
			} else if (payMethod == "TA") {
				payMethod = "계좌이체"
			} else if (payMethod == "N") {
				payMethod = "네이버페이"
			} else if (payMethod == "K") {
				payMethod = "카카오페이"
			}
			for (product of products.values()) {
				tags += `<div class="cart-single-list grid-container">`
				tags += `<div class="row align-items-center">`
				tags += `<div class="col-lg-1 col-md-1 col-12">`
				tags += `<img src="${product.image_url}" onerror="this.onerror=null; this.src='/resources/images/noP_image.png';">`
				tags += `</div>`
				tags += `<div class="col-lg-4 col-md-4 col-12">`
				if (products.length >= 2) {
					tags += `<p>${products['0'].product_name}외 ${products.length - 1}건</p>`
				} else {
					tags += `<p>${products['0'].product_name}</p>`
				}
				tags += `</div>`
				tags += `<div class="col-lg-2 col-md-2 col-12">`
				tags += `<p>${orderDate}</p>`
				tags += `<p>${orderId}</p>`
				tags += `</div>`
				tags += `<div class="col-lg-2 col-md-2 col-12">`
				tags += `<p>${orderStatus}</p>`
				tags += `<p>${payMethod}</p>`
				// working...
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
		tags += '</div>' // class="cart-list-head" end
		
	
		$("#productsView").html("")
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
		tag = `<div class="button"">
					<button class="btn" attr-order-id=${orderId} attr-cancel-type=${cancelType}>${buttonValue}</button>
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
		console.log("onOrderCancelBtnClicked 함수 호출중")
		let orderId = orderJson.orderId
		console.log("orderJson in onOrderCancelBtnClicked : " + JSON.stringify(orderJson))
		$("#productsView").html("")
		tags = ""
		tags += `<div class="card">`
		tags += `<div class="card-body row">`
		tags += `<div class="title col-12">`
		tags += (cancelType == "cancel" ? `<h3>주문 취소 신청</h3>` :  `<h3>반품/환불 신청</h3>`)
		tags += `</div>` // class="title col-12" end
		tags += `<p>주문번호 : ${orderId}</p>`

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
						<img src="${product.image_url}" onerror="this.onerror=null; this.src='/resources/images/noP_image.png';"></a>
					</div>
					<div class="col-lg-4 col-md-4 col-12">
						<p>${product.product_name}</p>
					</div>`
			if (product.cancel_status == "None") {
				tags +=`<div class="col-lg-4 col-md-4 col-12">
					<p>${orderJson.orderStatus}</p>
				</div>`
			} else {
				tags +=`<div class="col-lg-4 col-md-4 col-12">
					<p>${product.cancel_status}</p>
				</div>`
			}
			if (product.cancel_status == "None") {
				tags +=`<div class="col-lg-3 col-md-3 col-12">
					<input class="form-check-input" type="checkbox" attr-orderproduct-no=${product.orderproduct_no} attr-checked-msg="환불신청" onclick="showInfoForCheckbox(this)"></input>
					<span></span>
				</div>`
			} else if (product.cancel_status == "환불대기중") {
				tags +=`<div class="col-lg-3 col-md-3 col-12">
					<input class="form-check-input" type="checkbox" attr-orderproduct-no=${product.orderproduct_no} attr-checked-msg="환불취소" onclick="showInfoForCheckbox(this)"}></input>
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
		tags += `<button class="btn" onclick="submitOrderCancel(\'${cancelType}\')">확인</button>`
		tags += `</div>`
		tags += `<div class="col-lg-6 col-md-6 col-12 button">`
		tags += `<button class="btn" onclick="cancelSubmit()">취소</button>`
		tags += `</div>`

		tags += `</div>` // class="card-body row" end
		tags += `</div>` // class="card" end
		tags += `<div style="display:none;" id="order-id">${orderId}</div>`
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
		
		console.log("products : ")
		console.log(products)
		if (products.length <= 0) {
			openModal("변경처리할 상품을 선택해주세요", "")
			return false
		}
		
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
	}
	
/*	// 모달 열기
	function openModal(title, text) {
		$("#modalcontainer").css("display", "block");
		$("#modalTitle").text(title);
		$("#modalText").html(text);
	}
	
	// 모달 닫기
	function closeModal() {
		$("#modalcontainer").css("display", "none");
	} */