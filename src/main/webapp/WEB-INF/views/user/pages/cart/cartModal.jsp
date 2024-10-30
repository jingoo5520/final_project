<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="EUC-KR">
<title>장바구니 모달창</title>
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
        쇼핑백에 상품을 담았습니다.
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
      	<button type="button" class="btn btn-danger" id="keepProduct" data-bs-dismiss="modal">상품 계속보기</button>
        <button type="button" class="btn btn-primary" id="goCart" data-bs-dismiss="modal">장바구니 가기</button>
      </div>

    </div>
  </div>
</div>
</body>
</html>