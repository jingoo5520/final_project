<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html lang="en" class="light-style layout-menu-fixed" dir="ltr" data-theme="theme-default" data-assets-path="/resources/assets/admin/" data-template="vertical-menu-template-free">
<head>

<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

<title>Dashboard - Analytics | Sneat - Bootstrap 5 HTML Admin Template - Pro</title>

<meta name="description" content="" />

<!-- Favicon -->
<link rel="icon" type="image/x-icon" href="/resources/assets/admin/img/favicon/favicon.ico" />

<!-- Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap" rel="stylesheet" />

<!-- Icons. Uncomment required icon fonts -->
<link rel="stylesheet" href="/resources/assets/admin/vendor/fonts/boxicons.css" />

<!-- Core CSS -->
<link rel="stylesheet" href="/resources/assets/admin/vendor/css/core.css" class="template-customizer-core-css" />
<link rel="stylesheet" href="/resources/assets/admin/vendor/css/theme-default.css" class="template-customizer-theme-css" />
<link rel="stylesheet" href="/resources/assets/admin/css/demo.css" />

<!-- Vendors CSS -->
<link rel="stylesheet" href="/resources/assets/admin/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

<link rel="stylesheet" href="/resources/assets/admin/vendor/libs/apex-charts/apex-charts.css" />

<!-- Page CSS -->

<!-- Helpers -->
<script src="/resources/assets/admin/vendor/js/helpers.js"></script>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
<!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
<script src="/resources/assets/admin/js/config.js"></script>

<!-- jQuery -->
<script src="/resources/assets/admin/vendor/libs/jquery/jquery.js"></script>

<!-- Summernote CSS -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote.min.css" rel="stylesheet">

<!-- Summernote JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote.min.js"></script>
</head>

<style>
    html, body {
        height: 100%;
        margin: 0;
    }

    .full-height {
        height: 100vh; /* Viewport height */
        display: flex;
        flex-direction: column;
    }

    .form-content {
        flex-grow: 1;
        display: flex;
        justify-content: center;
        align-items: flex-start; /* 위쪽 정렬 */
        padding: 20px;
    }
    
    .note-editable {
    overflow-y: auto;
	}
</style>


<body>
	<!-- Layout wrapper -->
	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">
			
			
			<!-- Menu -->

			<jsp:include page="/WEB-INF/views/admin/components/sideBar.jsp">

				<jsp:param name="pageName" value="event" />

			</jsp:include>

		<!-- / Menu -->

        <!-- Layout container -->

			<div class="layout-page">
				<!-- Navbar -->
				<nav class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme" id="layout-navbar">
					<div class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none">
						<a class="nav-item nav-link px-0 me-xl-4" href="javascript:void(0)"> <i class="bx bx-menu bx-sm"></i>
						</a>
					</div>

				</nav>
				<!-- / Navbar -->

				<!-- Content wrapper -->
				<div class="content-wrapper">
					<!-- Content -->

					<div class="container-xxl flex-grow-1 container-p-y">



						<!-- body  -->
				<!-- / Content -->

<div class="container-xxl flex-grow-1 container-p-y">
  <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">공지 /</span>이벤트 수정</h4>

  <div class="row w-100">
    <!-- Basic -->
    <div class="col-12">
      <div class="card mb-4">
        <div class="card-body demo-vertical-spacing demo-only-element">
          <form action="/admin/notices/updateEvent" method="post" enctype="multipart/form-data">
            <input type="hidden" id="notice_no" name="notice_no" value="${event.notice_no}" />
            <div class="input-group">
              <input id="notice_title" type="text" class="form-control" name="notice_title" placeholder="제목을 입력하세요" value="${event.notice_title}" required />
            </div>
            <div class="input-group">
              <input id="admin_id" type="text" class="form-control" name="admin_id" placeholder="작성자를 입력하세요" value="${event.admin_id}" required readonly/>
            </div>
            <div class="input-group">
              <div class="input-group-text">
                <input id="noticeType1" class="form-check-input mt-0" type="radio" name="notice_type" value="N" required id="noticeType1" onchange="changeForm(this.value)" disabled />
                <label for="noticeType1">공지</label>
              </div>
              <div class="input-group-text">
                <input id="noticeType2" class="form-check-input mt-0" type="radio" name="notice_type" value="E" checked required id="noticeType2" onchange="changeForm(this.value)" />
                <label for="noticeType2">이벤트</label>
              </div>
            </div>
			<div class="mb-3">
			    <label for="event_start_date" class="form-label">이벤트 시작 날짜</label>
			    <!-- 날짜와 시간을 함께 입력하는 datetime-local 타입으로 변경 -->
			    <input type="datetime-local" class="form-control" id="event_start_date" name="event_start_date"
			           value="${event.event_start_date != null ? event.event_start_date : ''}">
			</div>
			
			<div class="mb-3">
			    <label for="event_end_date" class="form-label">이벤트 종료 날짜</label>
			    <input type="datetime-local" class="form-control" id="event_end_date" name="event_end_date"
			           value="${event.event_end_date != null ? event.event_end_date : ''}">
			</div>

            <div class="input-group">
			<div id="summernote" aria-label="With textarea">${event.notice_content}</div>
			</div>
			<input type="hidden"  name="notice_content" id="eventContentInput" />
            <!-- 기존 썸네일 -->
            <div class="card-body">
              <h5>현재 썸네일</h5>
              <img id="currentThumbnail" src="${event.thumbnail_image}" alt="현재 썸네일" style="width: 100%; height: auto;" />
              <input type="file" id="thumbnailInput" name="thumbnail_image" accept="image/*" style="display: none;" data-current-image="${event.thumbnail_image}"/>
			  
			<div class="mb-3">
				<label for="banner_image" class="form-label">배너 이미지 업로드</label>
				<input type="file" class="form-control" id="banner_image" name="banner_image" accept="image/*">
			</div>
			<div class="mb-3">
				<label for="thumbnail_image" class="form-label">썸네일 이미지 업로드</label>
				<input type="file" class="form-control" id="thumbnailInput2" name="thumbnail_image2" accept="image/*">
			</div>
            </div>
<!--           <form action="/updateThumbnail" method="post" enctype="multipart/form-data"> -->
<%-- 		    <input type="hidden" name="noticeNo" value="${notice.notice_no}" /> --%>
<!-- 		    <input type="file" id="updateThumbnail" name="file" accept="image/*" /> -->
<!-- 		    <button type="submit">썸네일 교체</button> -->
<!-- 		</form> -->
		
<!-- 		<form action="/deleteThumbnail" method="post"> -->
<%-- 		    <input type="hidden" id="deleteThumbnail" name="noticeNo" value="${notice.notice_no}" />  --%>
<!-- 		    <button type="submit">썸네일 삭제</button> -->
<!-- 		</form> -->
<!--           <div class="text-end mt-3"> -->
         
            <button type="submit" class="btn rounded-pill btn-outline-warning">수정하기</button>
            <a href="/admin/notices/event" class="btn rounded-pill btn-outline-secondary">취소</a>
          </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</div>
</div>
</div>
</div>
</div>
            <!-- / Content -->
    
    
				<!-- Footer -->
				<footer class="content-footer footer bg-footer-theme">
					<div class="container-xxl d-flex flex-wrap justify-content-between py-2 flex-md-row flex-column">
						<div class="mb-2 mb-md-0">
							©
							<script>
								document.write(new Date().getFullYear());
							</script>
							, made with ❤️ by <a href="https://themeselection.com" target="_blank" class="footer-link fw-bolder">ThemeSelection</a>
						</div>
						<div>
							<a href="https://themeselection.com/license/" class="footer-link me-4" target="_blank">License</a> <a href="https://themeselection.com/" target="_blank" class="footer-link me-4">More Themes</a> <a href="https://themeselection.com/demo/sneat-bootstrap-html-admin-template/documentation/" target="_blank" class="footer-link me-4">Documentation</a> <a href="https://github.com/themeselection/sneat-html-admin-template-free/issues" target="_blank" class="footer-link me-4">Support</a>
						</div>
					</div>
				</footer>
				<!-- / Footer -->

				<div class="content-backdrop fade"></div>
			</div>
			<!-- Content wrapper -->
		</div>
		<!-- / Layout page -->
	</div>

	<!-- Overlay -->
	<div class="layout-overlay layout-menu-toggle"></div>
	<!-- / Layout wrapper -->
              

    <!-- Core JS -->
    <!-- build:js assets/vendor/js/core.js -->
    <script src="/resources/assets/admin/vendor/libs/popper/popper.js"></script>
    <script src="/resources/assets/admin/vendor/js/bootstrap.js"></script>
    <script src="/resources/assets/admin/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

    <script src="/resources/assets/admin/vendor/js/menu.js"></script>
    <!-- endbuild -->

    <!-- Vendors JS -->
    <script src="/resources/assets/admin/vendor/libs/apex-charts/apexcharts.js"></script>

    <!-- Main JS -->
    <script src="/resources/assets/admin/js/main.js"></script>

    <!-- Page JS -->
    <script src="/resources/assets/admin/js/dashboards-analytics.js"></script>

    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
    
    <script>
    $(document).ready(function() {
        // changeForm 함수 정의
     function changeForm(value) {
     	const noticeType = document.querySelector('input[name="notice_type"]:checked').value;
         const noticeForm = document.getElementById("noticeForm");
         const eventForm = document.getElementById("eventForm");
        }

//          // 폼 보여주기/숨기기

//			    if (noticeType === 'N') {
//			        noticeForm.style.display = 'block';
//			        eventForm.style.display = 'none';
//			    } else if (noticeType === 'E') {
//			        noticeForm.style.display = 'none';
//			        eventForm.style.display = 'block';
//              } else {
//              console.error("폼 요소를 찾을 수 없습니다."); // 에러 메시지
//          }
//      }

//      // 쿼리 스트링 업데이트 함수 정의
//      function updateQueryString(key, value) {
//          const url = new URL(window.location.href);  // 현재 URL 가져오기
//          url.searchParams.set(key, value);           // 쿼리 스트링 업데이트
//          window.history.pushState({}, '', url);      // URL 업데이트
//      }

//      $(document).ready(function() {
//          // 선택된 라디오 버튼에 따라 changeForm 호출
//          $('input[name="noticeType"]').on('change', function() {
//              changeForm(this.value); // 선택된 값으로 폼 변경
//          });
 	
     	// Summernote 설정
        $('#summernote').summernote({
        	width: '100%',
        	height: 800,
            lang: 'ko-KR',
            toolbar: [
//                 ['fontsize', ['fontsize']],
                ['style', ['bold', 'italic', 'underline', 'strikethrough', 'clear']],
//                 ['color', ['color']],
//                 ['table', ['table']],
//                 ['para', ['ul', 'ol', 'paragraph']],
//                 ['height', ['height']],
                ['insert', ['picture']]
            ],
            fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', '맑은 고딕', '궁서', '굴림체', '굴림', '돋음체', '바탕체'],
            fontSizes: ['8', '9', '10', '11', '12', '14', '16', '18', '20', '22', '24', '28', '30', '36', '50', '72', '96'],
            focus: true,
            callbacks: {
                onChange: function (contents, $editable) {
                    $('#eventContentInput').val(contents);
                }, // 여기에 콤마 추가
                onImageUpload: function(files) {
                    const selectedType = $('input[name="notice_type"]:checked').val();
                    for (let i = 0; i < files.length; i++) {
                        sendFile(files[i], selectedType);
                    }
                }
            }
        });
    	
        function insertImageIntoEditor(imageUrl) {
            const range = window.getSelection().getRangeAt(0);
            const img = document.createElement("img");
            img.src = imageUrl;

            if (range && range.startContainer) {
                const startContainer = range.startContainer;
                if (startContainer.length > 0) {
                    range.insertNode(img);
                    range.setStartAfter(img);
                    range.collapse(true);
                    const selection = window.getSelection();
                    selection.removeAllRanges();
                    selection.addRange(range);
                } else {
                    console.error("노드 길이가 0입니다. 삽입할 수 없습니다.");
                }
            } else {
                console.error("유효하지 않은 range입니다.");
            }
        }
        
        function sendFile(file, noticeType) {
            let data = new FormData();
            data.append("file", file);
            data.append("noticeType", noticeType);

            $.ajax({
                url: "/post/uploadImage",
                type: "POST",
                data: data,
                contentType: false,
                processData: false,
                success: function(fileName) {
                    let imageUrl = '/resources/eventImages/' + fileName;
                    $('#summernote').summernote('insertImage', imageUrl);
                    console.log('업로드 성공:', fileName);
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.error('Image upload failed:', textStatus, errorThrown);
                }
            });
        }

        function saveNotice() {
            let noticeContent = $('#summernote').summernote('code');
            $.ajax({
                url: '/post/saveEvent',
                type: 'POST',
                data: { noticeContent: noticeContent },
                success: function(response) {
                    alert(response);
                },
                error: function() {
                    alert('이벤트 저장 실패');
                }
            });
        }
    	
        window.onload = function() {
            const noticeType = "${event.notice_type}";
            if (noticeType === 'E') {
                document.getElementById('noticeType2').checked = true;
                changeForm("E"); // 처음 로드 시 폼 전환
            } else if (noticeType === 'N') {
                document.getElementById('noticeType1').checked = true;
                changeForm("N"); // 처음 로드 시 폼 전환
            }
        };
    	
     // 폼 제출 시 내용 가져오기 및 검증
        $('form').on('submit', function(e) {
            let noticeNo = $('input[name="notice_no"]').val();
            let noticeTitle = $('input[name="notice_title"]').val();
            let adminId = $('input[name="admin_id"]').val();
            let noticeContent = $('#summernote').summernote('code');
            
            // 이벤트 시작일 및 종료일 입력값 가져오기
            let eventStartDate = $('input[name="event_start_date"]').val();
            let eventEndDate = $('input[name="event_end_date"]').val();
            
            // 썸네일 + 배너
            let thumbnailImage = $('input[name="thumbnail_image"]')[0].files[0]; // 썸네일 이미지
            let bannerImage = $('input[name="banner_image"]')[0].files[0]; // 배너 이미지
            
            console.log("Event Title:", noticeTitle); // 확인
            console.log("Admin ID:", adminId); // 확인
            console.log("Event Content:", noticeContent); // 확인
            console.log("Event Start Date:", eventStartDate); // 확인
            console.log("Event End Date:", eventEndDate); // 확인
            console.log("Thumbnail Image:", thumbnailImage); // 확인
            console.log("Banner Image:", bannerImage); // 확인

            // 필드 검증: 제목, 관리자 ID, 내용만 필수
            if (!noticeTitle || !adminId || !noticeContent.trim()) {
                e.preventDefault();
                alert('제목, 관리자 ID, 내용을 모두 채워주세요.'); // 경고 메시지 표시
            } else {
                $('#eventContentInput').val(noticeContent); // 실제 hidden input에 값 설정
            }
        });
    });
    
    
// 썸네일 교체 버튼 클릭 시 파일 선택 대화상자 열기
document.addEventListener("DOMContentLoaded", function() {
    const thumbnailInput = document.getElementById("thumbnailInput");
    const thumbnailInput2 = document.getElementById("thumbnailInput2");
    const currentThumbnail = document.getElementById("currentThumbnail");
    const noticeNo = document.getElementById("notice_no").value;
//     alert(noticeNo);

    // 현재 썸네일 이미지 설정
    if (thumbnailInput) {
        const currentImageSrc = thumbnailInput.value ? URL.createObjectURL(thumbnailInput.files[0]) : thumbnailInput.dataset.currentImage;
        currentThumbnail.src = currentImageSrc; // 현재 썸네일 이미지 경로 설정
    }

    // thumbnailInput2에서 파일 선택 시 이벤트 처리
    if (thumbnailInput2) {
        thumbnailInput2.onchange = function(event) {
            const file = event.target.files[0];
            if (!file) {
                alert("파일을 선택하지 않았습니다.");
                return;
            }
            console.log("thumbnailInput2에서 파일 선택됨:", file.name);

            const formData = new FormData();
            formData.append("thumbnail", file);

            if (!noticeNo) {
                console.error("noticeNo가 설정되지 않았습니다.");
                alert("공지 번호를 찾을 수 없습니다.");
                return;
            }

            /* fetch('/admin/notices/updateThumbnail/' + noticeNo, {
                method: 'POST',
                body: formData
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('서버 응답 오류');
                }
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    currentThumbnail.src = data.newThumbnailPath; // 썸네일 경로 업데이트
                    alert("썸네일 교체 완료");
                } else {
                    alert("썸네일 교체 실패: " + data.error);
                }
            })
            .catch(error => {
                console.error("Error:", error);
                alert("오류 발생: " + error.message);
            }); */
        };
    } else {
        console.error("Element not found: thumbnailInput2");
    }
});

// 배너 교체 버튼 클릭 시 파일 선택 대화상자 열기
document.addEventListener("DOMContentLoaded", function() {
    const bannerInput = document.getElementById("banner_image");
    const noticeNo = document.getElementById("notice_no").value;

    
    
    // 배너 파일 선택 시 이벤트 처리
    bannerInput.addEventListener("change", function(event) {
    	
    	console.log(event);
    	
    	
    	
        const file = event.target.files[0];
        if (!file) {
            alert("파일을 선택하지 않았습니다.");
            return;
        }
        console.log("배너 파일 선택됨:", file.name);

        const formData = new FormData();
        formData.append("banner", file);

        if (!noticeNo) {
            console.error("noticeNo가 설정되지 않았습니다.");
            alert("공지 번호를 찾을 수 없습니다.");
            return;
        }

        /* // 배너 이미지 업로드 요청
        fetch('/admin/notices/updateBanner/' + noticeNo, {
            method: 'POST',
            body: formData
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('서버 응답 오류');
            }
            return response.json();
        })
        .then(data => {
            if (data.success) {
                alert("배너 교체 완료");
            } else {
                alert("배너 교체 실패: " + data.error);
            }
        })
        .catch(error => {
            console.error("Error:", error);
            alert("오류 발생: " + error.message);
        }); */
    });
});


    // 썸네일 삭제
//     document.getElementById("deleteThumbnailBtn").onclick = function() {
//         if (confirm("정말로 썸네일을 삭제하시겠습니까?")) {
//             const noticeNo = document.getElementById("deleteThumbnailBtn").dataset.noticeNo; // 공지 번호 가져오기
//             fetch('/admin/notices/deleteThumbnail/' + noticeNo, {
//                 method: "DELETE"
//             })
//             .then(response => {
//                 if (!response.ok) {
//                     throw new Error('Network response was not ok');
//                 }
//                 return response.json();
//             })
//             .then(data => {
//                 if (data.success) {
//                     document.getElementById("currentThumbnail").src = ""; // 썸네일 경로 비우기
//                     alert("썸네일 삭제 완료");
//                 } else {
//                     alert("썸네일 삭제 실패: " + data.error);
//                 }
//             })
//             .catch(error => {
//                 console.error("Error:", error);
//                 alert("썸네일 삭제 중 오류 발생");
//             });
//         }
//     };

</script>
  </body>
</html>