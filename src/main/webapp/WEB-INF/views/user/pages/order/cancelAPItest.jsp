<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
	table {border: medium solid #6495ed;border-collapse: collapse;width: 100%;} th{font-family: monospace;border: thin solid #6495ed;padding: 5px;background-color: #D0E3FA;}th{text-align: left;}td{font-family: sans-serif;border: thin solid #6495ed;padding: 5px;text-align: center;}.odd{background:#e8edff;}img{padding:5px; border:solid; border-color: #dddddd #aaaaaa #aaaaaa #dddddd; border-width: 1px 2px 2px 1px; background-color:white;}</style>
	</style>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/styles/default.min.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js"></script>
	<script>hljs.highlightAll();</script>
</head>
<body>

	<script>
	function kakaopayCancelRequest(paymentId, cancelReason, amount) {
		let response = null
		$.ajax({
			async: false,
			url: "/order/KakaoPayCancel",
			type: "POST",
			contentType: "application/json",
			dataType: 'json',
			data: JSON.stringify({
				paymentId: paymentId,
				amount: "" + amount,
				cancelReason: cancelReason,
			}),
			success: function(res) {
				response = res.response
			},
			error: function(xhr, status, error) {
				console.error(`Error: ${status}, ${error}`);
				console.error(xhr.responseText);
			}
		});
		return JSON.parse(response)
	}
	
	function kakaopayAPITest(id, reason, amount) {
		let result = kakaopayCancelRequest(id, reason, amount)
		console.log("카카오페이APITest 응답 결과 : ")
		console.log(result)
	}
	</script>

	<h1>카카오페이 API 테스트</h1>
	<button onclick="kakaopayAPITest('T72fe6147f575eb02b72', '이유는 없다', 3886888)">카카오페이APITest</button>
	
	<h1>이 cancels 테이블의 정보로 API를 실험해보세요</h1>
	<p>K : 카카오페이, T : 토스, N : 네이버페이</p>
	
	<table>
	<tbody><tr><th colspan="10"><pre><code>select p.payment_method , c.*<br>from cancels c<br>join payments p on p.order_id = c.order_id<br></code></pre></th></tr><tr><th>payment_method</th><th>cancel_no</th><th>order_id</th><th>cancel_apply_date</th><th>cancel_complete_date</th><th>cancel_retract_date</th><th>cancel_type</th><th>cancel_status</th><th>cancel_reason</th><th>order_product_no</th></tr><tr class="odd"><td>K</td><td>34</td><td>472d75f3-2ddd-4773-9f4a-8c7d168e6ed0</td><td>2024-11-10 08:28:16.000</td><td>&nbsp;</td><td>&nbsp;</td><td>cancel</td><td>취소 요청</td><td>목걸이는 필요없어요<br>배송 언제되요</td><td>348</td></tr>
		<tr><td>T</td><td>38</td><td>797c5f05-f448-4517-99f2-8d6ee255b873</td><td>2024-11-10 08:29:53.000</td><td>&nbsp;</td><td>&nbsp;</td><td>cancel</td><td>취소 요청</td><td>취소할께요</td><td>312</td></tr>
		<tr class="odd"><td>T</td><td>39</td><td>daaafc5d-99f7-4e71-86f4-cf24f0aec311</td><td>2024-11-10 08:30:18.000</td><td>&nbsp;</td><td>&nbsp;</td><td>cancel</td><td>취소 요청</td><td>그냥 다 취소시켜줘요</td><td>315</td></tr>
		<tr><td>T</td><td>40</td><td>daaafc5d-99f7-4e71-86f4-cf24f0aec311</td><td>2024-11-10 08:30:18.000</td><td>&nbsp;</td><td>&nbsp;</td><td>cancel</td><td>취소 요청</td><td>그냥 다 취소시켜줘요</td><td>316</td></tr>
		<tr class="odd"><td>K</td><td>42</td><td>df40180c-268d-4b79-84e9-9ca530a750ad</td><td>2024-11-10 08:30:37.000</td><td>&nbsp;</td><td>&nbsp;</td><td>cancel</td><td>취소 요청</td><td>이유 없어요</td><td>351</td></tr>
		<tr><td>N</td><td>50</td><td>6b1d2272-506e-4e16-8aa4-4bd5a345e102</td><td>2024-11-10 11:19:47.000</td><td>&nbsp;</td><td>&nbsp;</td><td>cancel</td><td>취소 요청</td><td>빨리 취소해줘요</td><td>365</td></tr>
		<tr class="odd"><td>N</td><td>51</td><td>6b1d2272-506e-4e16-8aa4-4bd5a345e102</td><td>2024-11-10 11:19:47.000</td><td>&nbsp;</td><td>&nbsp;</td><td>cancel</td><td>취소 요청</td><td>빨리 취소해줘요</td><td>366</td></tr>
		<tr><td>N</td><td>53</td><td>d346d260-ac42-41ab-9eab-8ef47de93683</td><td>2024-11-10 11:21:46.000</td><td>&nbsp;</td><td>&nbsp;</td><td>cancel</td><td>취소 요청</td><td>실수했어요</td><td>368</td></tr>
		<tr class="odd"><td>T</td><td>60</td><td>280d024b-9ba3-4551-be6d-bffdf70ff2e7</td><td>2024-11-10 13:27:59.000</td><td>&nbsp;</td><td>&nbsp;</td><td>return</td><td>취소 요청</td><td>배송받았는데 별로네요</td><td>378</td></tr>
		<tr><td>T</td><td>61</td><td>280d024b-9ba3-4551-be6d-bffdf70ff2e7</td><td>2024-11-10 13:27:59.000</td><td>&nbsp;</td><td>&nbsp;</td><td>return</td><td>취소 요청</td><td>배송받았는데 별로네요</td><td>379</td></tr>
	</tbody>
	</table>

	<h1>토스 결제 취소 함수</h1>
	<p>paymentKey는 orders 테이블에 있는 payment_module_key 가져오세요. cancels 테이블에 있는 order_id로 조회할 수 있습니다.</p>
	<p>cancelReason은 cancels 테이블에 있는 cancel_reason 가져오세요</p>
	<p>amount는 order_products 테이블에 있는 paid_amount 가져오세요. cancels 테이블에 있는 order_product_no로 조회할 수 있습니다.</p>
	<p>예를 들어 tossCancelRequest("tviva20241110083846B2sA0", '이유1', 10000)를 하면 10000원이 취소되고, tossCancelRequest("tviva20241110083846B2sA0", '이유2')를 하면 남아있는 전액이 취소됩니다.</p>
	<pre><code>
		function tossCancelRequest(paymentKey, cancelReason, amount = null) {
			let encodedSecretKey = null
			let cancelResponse = null
			
			// encodedSecretKey 취득
			$.ajax({
				async: false,
				url: '/order/tossSecretKey',
				type: 'GET',
				dataType: "json",
				success: function(response) {
					encodedSecretKey = response.encodedSecretKey
					console.log("encodedSecretKey : " + encodedSecretKey)
				},
				error: function(xhr, status, error) {
					console.error(`Error: ${status}, ${error}`);
				   console.error(xhr.responseText);
				}
			})
			
			if (cancelReason == null) {
				cancelReason = ''
			}
			let requestObj = {
				 cancelReason: cancelReason,
			}
			if (amount != null) {
				requestObj.cancelAmount = amount
			}
			
			$.ajax({
				 async: false,
				 url: `https://api.tosspayments.com/v1/payments/\${paymentKey}/cancel`,
				 method: 'POST',
				 headers: {
				   'Authorization': `Basic \${encodedSecretKey}`,
				   'Content-Type': 'application/json',
				 },
				 data: JSON.stringify(requestObj),
				 success: function(response) {
					 cancelResponse = response
				 },
				 error: function(xhr, status, error) {
				   console.error(`Error: ${status}, ${error}`);
				   console.error(xhr.responseText);
				 }
			});
			return cancelResponse
		}
	</code></pre>
	<h2>paymentCancelRequest("tviva20241110083846B2sA0", 10000)의 반환값 예시</h2>
	<p>응답 결과의 자세한 설명은 https://docs.tosspayments.com/guides/v2/cancel-payment#%EB%B6%80%EB%B6%84-%EC%B7%A8%EC%86%8C%ED%95%98%EA%B8%B0를 참조하세요</p>
	<pre><code>
	{
	  "mId": "tvivarepublica",
	  "lastTransactionKey": "2B73EEB6C846F8540C5FFF5799AB412C",
	  "paymentKey": "tviva20241110100850BczW6",
	  "orderId": "d2be3d0f-318f-4eff-a6d3-e5d102eabb9a",
	  "orderName": "[강진구 PICK] J.Fenella",
	  "taxExemptionAmount": 0,
	  "status": "PARTIAL_CANCELED",
	  "requestedAt": "2024-11-10T10:08:50+09:00",
	  "approvedAt": "2024-11-10T10:09:18+09:00",
	  "useEscrow": false,
	  "cultureExpense": false,
	  "card": {
	    "issuerCode": "21",
	    "acquirerCode": "21",
	    "number": "55213300****079*",
	    "installmentPlanMonths": 0,
	    "isInterestFree": false,
	    "interestPayer": null,
	    "approveNo": "00000000",
	    "useCardPoint": false,
	    "cardType": "신용",
	    "ownerType": "개인",
	    "acquireStatus": "READY",
	    "amount": 177136
	  },
	  "virtualAccount": null,
	  "transfer": null,
	  "mobilePhone": null,
	  "giftCertificate": null,
	  "cashReceipt": null,
	  "cashReceipts": null,
	  "discount": null,
	  "cancels": [
	    {
	      "transactionKey": "2B73EEB6C846F8540C5FFF5799AB412C",
	      "cancelReason": "아무 이유",
	      "taxExemptionAmount": 0,
	      "canceledAt": "2024-11-10T10:10:14+09:00",
	      "easyPayDiscountAmount": 0,
	      "receiptKey": null,
	      "cancelStatus": "DONE",
	      "cancelRequestId": null,
	      "cancelAmount": 10000,
	      "taxFreeAmount": 0,
	      "refundableAmount": 167136
	    }
	  ],
	  "secret": "ps_GjLJoQ1aVZXZlANnWL0P8w6KYe2R",
	  "type": "NORMAL",
	  "easyPay": null,
	  "country": "KR",
	  "failure": null,
	  "isPartialCancelable": true,
	  "receipt": {
	    "url": "https://dashboard.tosspayments.com/receipt/redirection?transactionId=tviva20241110100850BczW6&ref=PX"
	  },
	  "checkout": {
	    "url": "https://api.tosspayments.com/v1/payments/tviva20241110100850BczW6/checkout"
	  },
	  "currency": "KRW",
	  "totalAmount": 177136,
	  "balanceAmount": 167136,
	  "suppliedAmount": 151942,
	  "vat": 15194,
	  "taxFreeAmount": 0,
	  "method": "카드",
	  "version": "2022-11-16",
	  "metadata": null
	}
	</code></pre>
	
	<h1>네이버페이 결제 취소 함수</h1>
	<pre><code>
	    function naverpayCancelRequest(paymentId, cancelReason, amount) {
		let response = null
		$.ajax({
			async: false,
			url: "/order/NaverPayCancel",
			type: "POST",
			contentType: "application/json",
			dataType: 'json',
			data: JSON.stringify({
				paymentId: paymentId,
				amount: "" + amount,
				cancelReason: cancelReason,
			}),
			success: function(res) {
				response = res.response
			},
			error: function(xhr, status, error) {
				console.error(`Error: ${status}, ${error}`);
				console.error(xhr.responseText);
			}
		});
		return JSON.parse(response)
	}
	</code></pre>
	
	<h2>응답 예시</h2>
	<p>totalRestAmount 속성에서 남은 환불한 양 확인 가능</p>
	<p>자세한 정보는 https://developers.pay.naver.com/docs/v2/api#payments-payments_cancel 참조</p>
	<pre><code>
	{
	    "code": "Success",
	    "message": "성공",
	    "body": {
	        "paymentId": "20241110NP1166110241",
	        "payHistId": "20241110NP1166130812",
	        "primaryPayMeans": "CARD",
	        "primaryPayCancelAmount": 10000,
	        "primaryPayRestAmount": 955862,
	        "npointCancelAmount": 0,
	        "npointRestAmount": 0,
	        "giftCardCancelAmount": 0,
	        "giftCardRestAmount": 0,
	        "discountCancelAmount": 0,
	        "discountRestAmount": 0,
	        "cancelYmdt": "20241110125427",
	        "totalRestAmount": 955862,
	        "applyRestAmount": 955862,
	        "taxScopeAmount": 10000,
	        "taxExScopeAmount": 0,
	        "taxScopeRestAmount": 955862,
	        "taxExScopeRestAmount": 0,
	        "environmentDepositAmount": 0,
	        "environmentDepositRestAmount": 0
    	},
    	"dazRE": "mDgrJ"
    }
    // 
	</code></pre>
	
	<h1>카카오페이 결제취소 함수</h1>
	<pre><code>
	function kakaopayCancelRequest(paymentId, cancelReason, amount) {
		let response = null
		$.ajax({
			async: false,
			url: "/order/KakaoPayCancel",
			type: "POST",
			contentType: "application/json",
			dataType: 'json',
			data: JSON.stringify({
				paymentId: paymentId,
				amount: "" + amount,
				cancelReason: cancelReason,
			}),
			success: function(res) {
				response = res.response
			},
			error: function(xhr, status, error) {
				console.error(`Error: ${status}, ${error}`);
				console.error(xhr.responseText);
			}
		});
		return JSON.parse(response)
	}
	</code></pre>
	<h2>응답 예시</h2>
	<p>"cancel_available_amount" 객체에서 남은 환불 가능한 돈 확인 가능</p>
    <p>자세한 정보는 https://developers.kakaopay.com/docs/payment/online/cancellation 참조</p>
	<pre><code>
	   {
	    "tid": "T7303217058063930439",
	    "cid": "TC0ONETIME",
	    "status": "PART_CANCEL_PAYMENT",
	    "partner_order_id": "partner_order_id",
	    "partner_user_id": "partner_user_id",
	    "payment_method_type": "MONEY",
	    "item_name": "목걸이 외",
	    "aid": "A73033087f575eb02c28",
	    "payload": "아무 이유",
	    "quantity": 1,
	    "amount": {
	        "total": 396700,
	        "tax_free": 0,
	        "vat": 0,
	        "point": 0,
	        "discount": 0,
	        "green_deposit": 0
	    },
	    "canceled_amount": {
	        "total": 10000,
	        "tax_free": 0,
	        "vat": 0,
	        "point": 0,
	        "discount": 0,
	        "green_deposit": 0
	    },
	    "cancel_available_amount": {
	        "total": 386700,
	        "tax_free": 0,
	        "vat": 0,
	        "point": 0,
	        "discount": 0,
	        "green_deposit": 0
	    },
	    "approved_cancel_amount": {
	        "total": 10000,
	        "tax_free": 0,
	        "vat": 0,
	        "point": 0,
	        "discount": 0,
	        "green_deposit": 0
	    },
	    "created_at": "2024-11-10T13:09:59",
	    "approved_at": "2024-11-10T13:10:28",
	    "canceled_at": "2024-11-10T13:14:00"
	}
	</code></pre>
	
</body>
<script>
	// paymentKey는 orders 테이블에 있는 payment_module_key 가져오세요. cancels 테이블에 있는 order_id로 조회할 수 있습니다.
	// cancelReason은 cancels 테이블에 있는 cancel_reason 가져오세요
	// amount는 order_products 테이블에 있는 paid_amount 가져오세요. cancels 테이블에 있는 order_product_no로 조회할 수 있습니다.
	// 예를 들어 tossCancelRequest("tviva20241110083846B2sA0", '이유1', 10000)를 하면 10000원이 취소되고, 
	// tossCancelRequest("tviva20241110083846B2sA0", '이유2')를 하면 남아있는 전액이 취소됩니다.
    function tossCancelRequest(paymentKey, cancelReason, amount = null) {
        let encodedSecretKey = null
        let cancelResponse = null
        
        // encodedSecretKey 취득
        $.ajax({
            async: false,
            url: '/order/tossSecretKey',
            type: 'GET',
            dataType: "json",
            success: function(response) {
                encodedSecretKey = response.encodedSecretKey
                console.log("encodedSecretKey : " + encodedSecretKey)
            },
            error: function(xhr, status, error) {
 			   console.error(`Error: ${status}, ${error}`);
			   console.error(xhr.responseText);
            }
        })
        
        if (cancelReason == null) {
        	cancelReason = ''
        }
        let requestObj = {
			 cancelReason: cancelReason,
        }
        if (amount != null) {
        	requestObj.cancelAmount = amount
        }
        
        $.ajax({
        	 async: false,
			 url: `https://api.tosspayments.com/v1/payments/\${paymentKey}/cancel`,
			 method: 'POST',
			 headers: {
			   'Authorization': `Basic \${encodedSecretKey}`,
			   'Content-Type': 'application/json',
			 },
			 data: JSON.stringify(requestObj),
			 success: function(response) {
				 cancelResponse = response
			 },
			 error: function(xhr, status, error) {
			   console.error(`Error: ${status}, ${error}`);
			   console.error(xhr.responseText);
			 }
        });
        return cancelResponse
    }
	
    // paymentCancelRequest("tviva20241110083846B2sA0", 10000)의 반환값 예시
	/* {
	  "mId": "tvivarepublica",
	  "lastTransactionKey": "2B73EEB6C846F8540C5FFF5799AB412C",
	  "paymentKey": "tviva20241110100850BczW6",
	  "orderId": "d2be3d0f-318f-4eff-a6d3-e5d102eabb9a",
	  "orderName": "[강진구 PICK] J.Fenella",
	  "taxExemptionAmount": 0,
	  "status": "PARTIAL_CANCELED",
	  "requestedAt": "2024-11-10T10:08:50+09:00",
	  "approvedAt": "2024-11-10T10:09:18+09:00",
	  "useEscrow": false,
	  "cultureExpense": false,
	  "card": {
	    "issuerCode": "21",
	    "acquirerCode": "21",
	    "number": "55213300****079*",
	    "installmentPlanMonths": 0,
	    "isInterestFree": false,
	    "interestPayer": null,
	    "approveNo": "00000000",
	    "useCardPoint": false,
	    "cardType": "신용",
	    "ownerType": "개인",
	    "acquireStatus": "READY",
	    "amount": 177136
	  },
	  "virtualAccount": null,
	  "transfer": null,
	  "mobilePhone": null,
	  "giftCertificate": null,
	  "cashReceipt": null,
	  "cashReceipts": null,
	  "discount": null,
	  "cancels": [
	    {
	      "transactionKey": "2B73EEB6C846F8540C5FFF5799AB412C",
	      "cancelReason": "아무 이유",
	      "taxExemptionAmount": 0,
	      "canceledAt": "2024-11-10T10:10:14+09:00",
	      "easyPayDiscountAmount": 0,
	      "receiptKey": null,
	      "cancelStatus": "DONE",
	      "cancelRequestId": null,
	      "cancelAmount": 10000,
	      "taxFreeAmount": 0,
	      "refundableAmount": 167136
	    }
	  ],
	  "secret": "ps_GjLJoQ1aVZXZlANnWL0P8w6KYe2R",
	  "type": "NORMAL",
	  "easyPay": null,
	  "country": "KR",
	  "failure": null,
	  "isPartialCancelable": true,
	  "receipt": {
	    "url": "https://dashboard.tosspayments.com/receipt/redirection?transactionId=tviva20241110100850BczW6&ref=PX"
	  },
	  "checkout": {
	    "url": "https://api.tosspayments.com/v1/payments/tviva20241110100850BczW6/checkout"
	  },
	  "currency": "KRW",
	  "totalAmount": 177136,
	  "balanceAmount": 167136,
	  "suppliedAmount": 151942,
	  "vat": 15194,
	  "taxFreeAmount": 0,
	  "method": "카드",
	  "version": "2022-11-16",
	  "metadata": null
	} */
	// 응답 결과의 자세한 설명은 https://docs.tosspayments.com/guides/v2/cancel-payment#%EB%B6%80%EB%B6%84-%EC%B7%A8%EC%86%8C%ED%95%98%EA%B8%B0를 참조하세요
	
    function naverpayCancelRequest(paymentId, cancelReason, amount) {
		let response = null
		$.ajax({
			async: false,
			url: "/order/NaverPayCancel",
			type: "POST",
			contentType: "application/json",
			dataType: 'json',
			data: JSON.stringify({
				paymentId: paymentId,
				amount: "" + amount,
				cancelReason: cancelReason,
			}),
			success: function(res) {
				response = res.response
			},
			error: function(xhr, status, error) {
				console.error(`Error: ${status}, ${error}`);
				console.error(xhr.responseText);
			}
		});
		return JSON.parse(response)
	}
	
	// 응답 예시
	// totalRestAmount 속성에서 남은 환불한 양 확인 가능
/*	{
    "code": "Success",
    "message": "성공",
    "body": {
        "paymentId": "20241110NP1166110241",
        "payHistId": "20241110NP1166130812",
        "primaryPayMeans": "CARD",
        "primaryPayCancelAmount": 10000,
        "primaryPayRestAmount": 955862,
        "npointCancelAmount": 0,
        "npointRestAmount": 0,
        "giftCardCancelAmount": 0,
        "giftCardRestAmount": 0,
        "discountCancelAmount": 0,
        "discountRestAmount": 0,
        "cancelYmdt": "20241110125427",
        "totalRestAmount": 955862,
        "applyRestAmount": 955862,
        "taxScopeAmount": 10000,
        "taxExScopeAmount": 0,
        "taxScopeRestAmount": 955862,
        "taxExScopeRestAmount": 0,
        "environmentDepositAmount": 0,
        "environmentDepositRestAmount": 0
    },
    "dazRE": "mDgrJ" */
    // 자세한 정보는 https://developers.pay.naver.com/docs/v2/api#payments-payments_cancel 참조
    
    

</script>
</html>