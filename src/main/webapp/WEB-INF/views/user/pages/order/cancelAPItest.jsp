<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	window.onload = function() {
		loadInfo()
		$('#orderIdList').on('change', function() {
			 $("#orderStatus").text(order.orderStatus)
			 
	 		if ($("#orderStatus").text() == "결제완료") {
				$("#canCancel").text("예")
			} else {
				$("#canCancel").text("아니오")
			}
		});
	}
	
	function loadInfo() {
		let memberId = null
		let orderInfo = null
		// id 얻어오기
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
        $("#memberId").text(memberId);
		
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
		
		makeUI(orderInfo)
	}
	
	function makeUI(orderInfo) {
		for (order of orderInfo) {
			$("#orderIdList").append(`<option value="\${order.orderId}">\${order.orderId}</option>`)
		}
		

	}
	

	
</script>
</head>
<body>
<p>지금 로그인한 회원 아이디 : <span id="memberId"></span></p>
<p>이 회원의 주문번호 : <select id="orderIdList"><option>--선택하기--</option></select></p>
<p>주문 상태 : <span id="orderStatus"></span></p>
<p>취소 가능 : <span id="canCancel"></span></p>

</body>
</html>