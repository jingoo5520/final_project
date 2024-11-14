<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="EUC-KR">
<title>배송지 모달창</title>
<style type="text/css">

	#deliveryModal .modal-dialog {
		position: absolute;
		left: 50%;
		transform: translateX(-50%);
		margin: 0;
	}
	
	#deliveryModal .modal-content {
		width: 300px;
	}
	
	.modal-content .modal-header{
		margin: 0;
		height: 30px;
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
	
</style>

</head>
<body>
	<!-- The Modal -->
	<div class="modal fade" id="deliveryModal">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
			
				<!-- Modal Header -->
				<div class="modal-header">
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
			
				<!-- Modal body -->
				<div class="modal-body">
					<p class="modal-text"></p>
				</div>
			
			</div>
		</div>
	</div>
</body>
</html>