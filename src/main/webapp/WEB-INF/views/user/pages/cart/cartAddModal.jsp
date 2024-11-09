<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="EUC-KR">
<title>장바구니 모달창</title>
<style type="text/css">
	.modal-content .modal-header{
		margin: 0;
		height: 65px;
		border: none !important;
	}
	
	.modal-content .modal-body {
		height: 100px;
		border: none !important;
		
	}
	
	.modal-content .modal-body .modal-text {
		height: 20px;
		text-align: center;
		font-weight: bold;
		font-size: 16px;
		color: rgb(34,34,34);
		display: block;
	}
	.modal-content .modal-footer {
		height: 60px;
		padding:0;
		display: flex;
		justify-content: space-between !important;
		margin:0 !important;
	}
	
	.modal-content .modal-footer #keepProduct {
		width: 248px;
		height:60px;
		font-size: 18px;
		border: none;
		border-bottom: 1px solid rgb(136, 136, 136);
		font-weight: bold;
		margin: 0;
	}
	
	.modal-content .modal-footer #goCart {
		width: 248px;
		height:60px;
		font-size: 18px;
		border: none;
		border-bottom: 1px solid rgb(136, 136, 136);
		background-color: #807E6F;
		color: #FFFFFF;
		font-weight: bold;
		margin: 0;
	}
	
</style>

</head>
<body>
	<!-- The Modal -->
	<div class="modal fade" id="myModal">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
			
				<!-- Modal Header -->
				<div class="modal-header">
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
			
				<!-- Modal body -->
				<div class="modal-body">
				<p class="modal-text">쇼핑백에 상품을 담았습니다.</p>
				</div>
			
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" id="keepProduct" data-bs-dismiss="modal">상품 계속보기</button>
					<button type="button" id="goCart" data-bs-dismiss="modal">장바구니 가기</button>
				</div>
			
			</div>
		</div>
	</div>
</body>
</html>