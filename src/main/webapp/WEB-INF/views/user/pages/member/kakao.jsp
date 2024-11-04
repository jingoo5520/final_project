<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function () {
		// URL에서 쿼리스트링 가져오기
		let query = window.location.search;
		// URLSearchParams 객체 생성
	    let urlParams = new URLSearchParams(query);
		// code값 저장
		let code = urlParams.get("code");
		if(code) {
			let uri = "/member/kakao/login";
			$.ajax({
				uri: uri,
				type: "post",
				data: {code : code},
				dataType: "json",
				success: function (data) {
					console.log(data);
				},
				error: function () {
				},
				complete: function () {
				},
			});	
		}
	});
</script>
<title>kakao</title>
</head>
<body>
<h1>카카오</h1>
</body>
</html>