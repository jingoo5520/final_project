<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="EUC-KR">
<title>배송지 삭제 모달창</title>
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
	
	.modal-content .modal-footer #cancleDelete {
		width: 248px;
		height:60px;
		font-size: 18px;
		border: none;
		border-radius: 4px;
		border-top: 1px solid #dee2e6;
		border-right: 1px solid #dee2e6;
		font-weight: bold;
		margin: 0;
	}
	
	.modal-content .modal-footer #deleteDelivery {
		width: 248px;
		height:60px;
		font-size: 18px;
		border: none;
		border-radius: 4px;
		background-color: #807E6F;
		color: #FFFFFF;
		font-weight: bold;
		margin: 0;
	}
	
</style>

</head>
<body>
	<!-- The Modal -->
	<div class="modal fade" id="deleteDeliveryModal">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
			
				<!-- Modal Header -->
				<div class="modal-header">
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
			
				<!-- Modal body -->
				<div class="modal-body">
					<p class="modal-text">배송지를 지우시겠습니까?</p>
				</div>
			
				<!-- Modal footer -->
				<form action="/member/myPage/deleteDelivery" method="post">
					<div class="modal-footer">
						<button type="button" id="cancleDelete" data-bs-dismiss="modal">뒤로가기</button>
						<input type="hidden" id="deleteDeliveryNo" name="deliveryNo">
						<button type="submit" id="deleteDelivery">삭제하기</button>
					</div>
				</form>
			
			</div>
		</div>
	</div>
</body>
</html>