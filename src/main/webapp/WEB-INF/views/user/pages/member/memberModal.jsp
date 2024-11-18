<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="EUC-KR">
<title>modal</title>
<style type="text/css">
/* 모달 */
#modalcontainer {
	display: none; /* 기본적으로 숨김 */
	position: fixed;
	z-index: 1050; /* 헤더보다 우선하여 보이도록 설정 */
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgb(0, 0, 0);
	background-color: rgba(0, 0, 0, 0.4); /* 배경 색상 */
}

.modalBody {
	border-radius: 30px;
	background-color: #fff;
	margin: 15% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 700px;
	background-color: #fff;
}

.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.addressName {
	display: none;
}

#modalTitle {
	text-align: center;
	margin: 20px;
}

#modalText {
	margin: 50px 100px 50px 100px;
}

.modalLink {
	text-align: center;
	font-size: 18px;
}
</style>

</head>
<body>
	<!-- 모달 -->
	<div id="modalcontainer">
		<div class="modalBody">
			<span class="close" onclick="closeModal();">&times;</span> <br>
			<h2 id="modalTitle">제목</h2>
			<p id="modalText">내용</p>
		</div>
	</div>
</body>
</html>