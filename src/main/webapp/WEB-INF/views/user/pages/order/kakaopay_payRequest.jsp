<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카카오페이 결제 요청 페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
window.onload = function() {
	// TODO : 모델에 pg_token, tid 있음
	let data = {
		tid : "${tid}",
		pg_token : "${pg_token}"
	}
	
 	$.ajax({
		type : "POST",
		url: window.location.origin + "/kakaopay_payRequest", // 절대 경로
		data : JSON.stringify(data),
		contentType : "application/json",
		dataType : "json",
		success : function(response) {
			console.log("결제요청의 결과, response : " + JSON.stringify(response))
			if (response.result == "success") {
				// 여기는 팝업페이지이므로, 이 페이지를 닫고 다른 페이지를 성공 페이지로 이동시켜야 함.
				// 부모 창의 배경을 원래대로 변경
			    if (window.opener) {
			    	window.opener.releaseInputBlock()
			        // TODO : 실제 결제완료 페이지로 이동시키기
			       	window.opener.location.href = window.location.origin + "/pages/order/success"
			    }
				window.close();
			} else {
				
			}
		}
	})
}
</script>
</head>
<body>
<h1>카카오페이 결제 요청 페이지</h1>
<h2>pg_token</h2>
<p>${pg_token}</p>
</body>
</html>