<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="EUC-KR">
<title>쿠폰 목록 모달창</title>
<style type="text/css">
	#couponModal .modal-content .modal-header{
		margin: 0;
		border: none !important;
	}
	
	#couponModal .modal-content .modal-body, #couponModal .modal-content .modal-footer {
		border: none !important;
	}
	
	#couponModal .modal-content .modal-body .modal-text {
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
<div class="modal fade" id="couponModal" tabindex="-1" role="dialog" aria-labelledby="couponModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable" role="document">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        쿠폰 목록 출력
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
      </div>

    </div>
  </div>
</div>
</body>
</html>