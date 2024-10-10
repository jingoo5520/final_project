<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>

	$(function(){
		
		// 아이디 유효성검사
		$("#userId").keyup(function () {
			let tmpUserId = $("#userId").val();
			let lowercase = /^[a-z]+$/; // 영 소문자 구분 정규식
			let blank = /\s/; 					// 공백 정규식
			isValid = true;

// 			유효성 조건
			$("#conditionLength").css("font-weight", "normal");
			$("#conditionLowercase").css("font-weight", "normal");
			$("#canUseId").css("font-weight", "normal");

		
		// 아이디 4 ~ 12자 이내
		if (tmpUserId.length >= 4 && tmpUserId.length <= 12) {
			$("#conditionLength").css("font-weight", "bold"); // 조건 충족 시 굵은 글씨
		} else {
			isValid = false;
		}
		
		// 영문 소문자 검사
		if (lowercase.test(tmpUserId)) {
			$("#conditionLowercase").css("font-weight", "bold"); // 조건 충족 시 굵은 글씨
		} else {
			isValid = false;
		}

		// 공백 검사
		if (blank.test(tmpUserId)) {
			$("#userId").val("");
			isValid = false;
		}

		
// 		$("#canUseId").css("font-weight", "bold"); // 조건 충족 시 굵은 글씨

// 			console.log(isValid);
		// 아이디 중복검사
		if (isValid) {
			$.ajax({
			    url: "/test/idDuplicate", // 데이터가 송수신될 서버의 주소
			    type: "POST", // 통신 방식 (GET, POST, PUT, DELETE)
			    dataType: "json", // 수신 받을 데이터 타입 (MIME TYPE)
			    data: {
			    	"tmpUserId" : tmpUserId
			    }, // 보내는 데이터
			    success: function (data) {  // 통신이 성공하면 수행할 함수
// 			      console.log(data);
				    if (data.msg == "duplicate") {
				    	$("#canUseId").html("중복된 아이디입니다.").css("color", "red");
	                    $("#idValid").val("");
	                    $("#userId").focus();
				    } else if (data.msg == "not duplicate") {
				    	$("#canUseId").html("사용 가능한 아이디입니다.").css("color", "green");
	                    $("#idValid").val("checked");
				    }
			    },
			    error: function () {},
			    complete: function () {},
			  });
		}
		})
	})
	
		// 받은 회원 값 저장
		function save(event) {
// 			alert("1");
			let result = false;
			event.preventDefault(); // 기본 form 제출 동작 막기
			let tmpUserId = $("#userId").val();
			let userPwd = $("#userPwd1").val();
			let userName = $("#userName").val();
			let userPhone = $("#mobile").val();
			let userMail = $("#email").val();
			
			console.log(userPwd);
			console.log(userName);
			console.log(userPhone);
			console.log(userMail);
			
			$.ajax({
			    url: "/test/registerMember", // 데이터가 송수신될 서버의 주소
			    type: "POST", // 통신 방식 (GET, POST, PUT, DELETE)
			    dataType: "json", // 수신 받을 데이터 타입 (MIME TYPE)
			    contentType: "application/json", // JSON 형식으로 서버에 전송
			    processData: false, // 데이터를 쿼리 스트링으로 처리하지 않도록 설정
			    data: JSON.stringify({ // JSON 문자열로 변환
			    	member_id: tmpUserId,         // MemberDTO의 member_id에 매핑
			        member_pwd: userPwd,          // MemberDTO의 member_pwd에 매핑
			        member_name: userName,        // MemberDTO의 member_name에 매핑
			        phone_number: userPhone,      // MemberDTO의 phone_number에 매핑
			        email: userMail               // MemberDTO의 email에 매핑
			    }), // 보내는 데이터
			    success: function (data) {  // 통신이 성공하면 수행할 함수
			      console.log("회원가입 성공:", data);
		            if (data.status == "success") {
		                alert("회원가입이 완료되었습니다.");
		            } else {
		                alert("회원가입에 실패했습니다.");
		            }
			    },
			    error: function () {},
			    complete: function () {},
			  });
			
			result = false;
			return result;
		}
</script>
</head>
<body>
	<div class = container>
	<h1>회원가입</h1>
	
	<form onsubmit="return save(event);" enctype="multipart/form-data">
	
			<div class="mb-3 mt-3">
			
			    <label for="userId" class="form-label">아이디 </label> 
			    <input type="text" class="form-control" id="userId" placeholder="아이디를 입력하세요" name="userId"/>
			    <span id=userIdError></span>
			    
<!-- 			    유효성 조건 -->
			    <div class="idCondition">
			        <span id="conditionLength">4~12자 이내, </span>
			        <span id="conditionLowercase">영문 소문자, </span>
			        <span id="canUseId">사용 가능 ID</span>
			    </div>
			    
			</div>
			
			<div class="mb-3 mt-3">
			    <label for="userPwd1" class="form-label">비밀번호 </label> 
			    <input type="password" class="form-control" id="userPwd1" placeholder="비밀번호를 입력하세요" name="userPwd">
			</div>
			 
			 <div class="mb-3 mt-3">
			    <label for="userName" class="form-label">이름  </label>
			    <input type="text" class="form-control" id="userName" name ="userName" placeholder="이름을 입력하세요" >
			</div>
			
			<div class="mb-3 mt-3">
			    <label for="mobile" class="form-label">휴대전화번호  </label> 
			    <input type="text" class="form-control" id="mobile" placeholder="전화번호를 입력하세요" name="mobile">
			</div>
			
			<div class="mb-3 mt-3">
			    <label for="email" class="form-label">이메일  </label> 
			    <input type="text" class="form-control" id="email" placeholder="이메일을 입력하세요" name="email">
			</div>
			
			<div>
				<input type="submit" value="확인" />
			</div>
			
	</form>
	
	
	
	
	
	</div> <!-- 	container div -->
	

</body>
</html>
