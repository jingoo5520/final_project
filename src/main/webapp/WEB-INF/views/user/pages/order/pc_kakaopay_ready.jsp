<!-- TODO ; 없어도 될 것 같음. 이 파일 삭제 가능 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>카카오페이 결제 대기 화면</h1>
</body>
<script>
	var kakaopay = {
        ref: null,
    };
    
	console.log(${paymentURL})
	
    kakaopay.ref = window.open('', 'paypopup', 'width=426,height=510,toolbar=no');
    if (kakaopay.ref) {
        setTimeout(function(){
            kakaopay.ref.location.href=${paymentURL}
        }, 0);
    } else {
        throw new Error("popup을 열 수 없습니다!(cannot open popup)");
    }
</script>
</html>