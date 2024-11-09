<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
</style>
</head>

<body>

	<!-- header -->
	<jsp:include page="../header.jsp"></jsp:include>
	<!-- / header -->
	<!-- Start Breadcrumbs -->
	<div class="breadcrumbs">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-lg-6 col-md-6 col-12">
					<div class="breadcrumbs-content">
						<h1 class="page-title">MyPage</h1>
					</div>
				</div>
				<div class="col-lg-6 col-md-6 col-12">
					<ul class="breadcrumb-nav">
						<li><a href="index.html"><i class="lni lni-home"></i>
								Home</a></li>
						<li><a href="javascript:void(0)">MyPage</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- End Breadcrumbs -->
	<section class="product-grids section">
		<div class="contentContainer container">
			<div class="row">
				<!-- sideBar -->
				<jsp:include page="../myPageSideBar.jsp">
					<jsp:param name="pageName" value="modiInfo" />
				</jsp:include>
				<!-- / sideBar -->
				<!-- contents -->
				<div class="col-lg-9 col-12" id="modiInfoView">
					<main class="right-pane">

						<h1>회원 정보 수정</h1>
						<c:if test="${empty sessionScope.auth}">
							<form class="row" action="/member/auth" method="post">
								<div class="auth">
									<div class="input-group">
										<span class="input-group-text">비밀번호</span> <input
											type="password" class="form-control" id="pwd" name="pwd">
									</div>
									<button class="btn" type="submit">확인</button>
								</div>
							</form>
						</c:if>
						<c:if test="${not empty sessionScope.auth}">
							<form id="form">
								<div class="form-group input-group">
									별명<input type="text" id="nickname" name="nickname">
								</div>
								<div id="gender" class="area">
									성별<span id="genderStatus"></span><input type="hidden" value="">
								</div>
								<div class="form-check">
									<input type="radio" class="form-check-input" id="M"
										name="gender" value="M"> <label
										class="form-check-label" for="M">남자</label>
								</div>
								<div class="form-check">
									<input type="radio" class="form-check-input" id="F"
										name="gender" value="F"> <label
										class="form-check-label" for="F">여자</label>
								</div>
								<div class="form-check">
									<input type="radio" class="form-check-input" id="N"
										name="gender" value="N"> <label
										class="form-check-label" for="N">미선택</label>
								</div>
								<div class="form-group input-group">
									휴대폰<input type="text" id="phone_number" name="phone_number"><span
										id="phoneStatus"></span><input type="hidden" value="">
								</div>
								<div class="form-group input-group">
									우편번호<input type="text" id="zipCode" name="zipCode" readonly
										onclick="selectAddress();">
								</div>
								<div class="form-group input-group">
									주소<input type="text" id="address" name="address" readonly
										onclick="selectAddress();">
								</div>
								<div class="form-group input-group">
									상세주소<input type="text" id="address2" name="address2">
								</div>
								<div class="form-group input-group">
									이메일<input type="text" id="email" name="email"><span
										id="emailStatus"></span><input type="hidden" value="">
								</div>
								<button id="button" class="btn btn-info" type="button"
									value="수정하기">수정하기</button>
							</form>
						</c:if>
					</main>
				</div>
				<!-- / contents -->

			</div>
		</div>
	</section>

	<jsp:include page="../footer.jsp"></jsp:include>
</body>
<script type="text/javascript">
var phoneExp = /010(-\d{4}-\d{4}|\d{8})$/; // 휴대폰 번호 정규식 (010-1234-5678), 01012345678 형식만 허용
var emailExp = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/; // 이메일 정규식(testuser@test.com)
let tmpPhone = "tmpPhone";
let tmpEmail = "tmpEmail";
// 회원 정보 불러오기
	function getMemberData() {
		$.ajax({
			url : "/member/getDTO", // 데이터가 송수신될 서버의 주소
			type : "GET", // 통신 방식 (GET, POST, PUT, DELETE)
			dataType : "json", // 수신 받을 데이터 타입 (MIME TYPE)
			success : function(data) {
				// 통신이 성공하면 수행할 함수
				console.log(data);
				settingData(data);
			},
			error : function() {
			}, 
			complete : function() {
			},
		});
	}
	$(function() {
		getMemberData();
		
		// 이메일 입력중
		$("#email").keyup(function() {
			checkEmail();
	    });
		// 휴대폰번호 입력중
		$("#phone_number").keyup(function() {
			checkPhone();
	    });
		
		function checkEmail() {
			let tmp = $("#email").val();
	       	if(tmp == tmpEmail) {
	       		isMsg("email", "변경사항 없음", "blue", true);
	       	} else {
	       		if (isCheck("email", tmp, emailExp, "이메일 형식이 아닙니다.", "red")) {
		            dbCheck("email", tmp).then(isAvailable => {
		                if (isAvailable) {
		                    isMsg("email", "사용가능한 이메일 입니다.", "blue", true);
		                } else {
		                    isMsg("email", "이미 사용중인 이메일 입니다.", "red", false);
		                }
		            }).catch(error => {
		                isMsg("email", error, "red", false);
		            });
		        }
	       	}
		}
		function checkPhone() {
			let tmp = $("#phone_number").val();
	        if(tmp == tmpPhone) {
	        	isMsg("phone_number", "변경사항 없음", "blue", true);
	        } else {
	        	if (isCheck("phone_number", tmp, phoneExp, "전화번호 형식이 아닙니다.", "red")) {
		            dbCheck("phone", tmp).then(isAvailable => {
		                if (isAvailable) {
		                    isMsg("phone_number", "사용가능한 휴대폰번호 입니다.", "blue", true);
		                } else {
		                    isMsg("phone_number", "이미 사용중인 휴대폰번호 입니다.", "red", false);
		                }
		            }).catch(error => {
		                isMsg("phone_number", error, "red", false);
		            });
		        }
	        }
		}
		
		// 정규식 테스트 결과에 따라 ture, false 반환
		function isCheck(id, tmp, regExp, msg, color) {
			if (regExp.test(tmp)) { // 정규식 유효성 true
				console.log("정규식 : true");
				console.log("#" + id);
				$("#" + id).next().text("");
				$("#" + id).next().next().val("true");
				return true;
			} else { // 정규식 유효성 false
				console.log("정규식 : false");
				console.log("#" + id);
				$("#" + id).next().text(msg);
				$("#" + id).next().css("color", color);
				$("#" + id).next().next().val("false");
				return false;
			}
		}
		
		// 입력값에 따라 msg출력
		function isMsg(id, msg, color, result) {
			$("#" + id).next().text(msg);
			$("#" + id).next().css("color", color);
			$("#" + id).next().next().val(result);
		}
		
		// email, phone_number를 중복인지 아닌지 체크하는 ajax
		function dbCheck(key, value) {
			// https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Global_Objects/Promise
			// dbCheck()를 호출한 곳에서 ajax 응답결과를 기다리지 않고 동작하기 때문에, Promise 로 ajax결과값을 받은 후에 dbCheck()가 동작하도록 함.
		    return new Promise((resolve, reject) => {
		        $.ajax({
		            url: "/member/isDuplicate",
		            type: "POST",
		            dataType: "json",
		            data: {
		                key: key,
		                value: value
		            },
		            success: function(data) {
		                console.log(data);
		                if (data.status === "Duplicate") {
		                    resolve(false); // 중복이면 false
		                } else if (data.status === "notDuplicate") {
		                    resolve(true); // 중복이 아니면 true
		                }
		            },
		            error: function() {
		                reject("서버 오류"); // 오류 발생 시 reject
		            }
		        });
		    });
		}
		
		// 1초뒤 동작
		setTimeout(function () {
			checkEmail();
			checkPhone();
		},1000);
		
	});
	
	// 받아온 정보 뿌리기
	function settingData(data) {
		tmpPhone = data.phone_number; // 전역변수에 저장
		tmpEmail = data.email; // 전역변수에 저장
		$("#nickname").val(data.nickname);
		$("#phone_number").val(data.phone_number);
		$("#zipCode").val(data.zipCode);
		$("#address").val(data.address);
		$("#address2").val(data.address2);
		$("#email").val(data.email);
		let gender = data.gender;
		switch (gender) {
		case "M":
			$("#M").prop("checked", true);
			break;
		case "F":
			$("#F").prop("checked", true);
			break;
		default:
			$("#N").prop("checked", true);
			break;
		}
	}
	
	
	// 수정하기
	$("#button").click(function(e) {
    e.preventDefault(); // 기본 제출 동작 방지
    let result = true;
    let text = ""; // modal의 text영역에 들어갈 내용
    let emailCheck = $("#email").next().next().val();
    let phoneCheck = $("#phone_number").next().next().val();
    console.log(emailCheck);
    console.log(phoneCheck);
    
    if (emailCheck != "true") {
        result = false;
        text += "<div>이메일</div>";
    }
    
    if (phoneCheck != "true") {
        result = false;
        text += "<div>휴대폰번호</div>";
    }
    
    console.log(result);
    
    if (result) {
        $.ajax({
            type: 'POST',
            url: '/member/modiInfo',
            data: $("#form").serialize(), // 폼 데이터를 DTO로 받을수 있도록 해줌(데이터 직렬화)
            dataType: "json",
            success: function(data) {
                console.log(data);
                if (data.status == "success") {
                    console.log("성공");
					alert("변경 성공"); // 모달로 수정 예정
					getMemberData();
                } else if (data.status == "fail") {
                    console.log("변경 실패");
                    alert("변경 실패"); // 모달로 수정 예정
                }
            },
            error: function(error) {
                console.log("통신 실패");
            }
        });
    } else {

    }
});
	// daum 주소 api
	// 주소칸에서 onclick으로 호출
	function selectAddress() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
	            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
	            console.log(data);
	            $("#zipCode").val(data.zonecode);
	            $("#address").val(data.address);
	        }
	    }).open();
	}
</script>
</html>