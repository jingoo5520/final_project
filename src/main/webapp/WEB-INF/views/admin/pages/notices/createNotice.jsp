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

<link rel="icon" type="image/x-icon" href="/favicon.ico">

<!-- Page CSS -->

<!-- Helpers -->
<script src="/resources/assets/admin/vendor/js/helpers.js"></script>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
<!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
<script src="/resources/assets/admin/js/config.js"></script>

<!-- jQuery -->
<script src="/resources/assets/admin/vendor/libs/jquery/jquery.js"></script>

<!-- Summernote -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote.min.js"></script>
</head>

<style>
    html, body {
        height: 100%;
        margin: 0;
    }

    .full-height {
        height: 100vh;
        display: flex;
        flex-direction: column;
    }

    .form-content {
        flex-grow: 1;
        display: flex;
        justify-content: center;
        align-items: flex-start; /* 위쪽으로 정렬 */
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

				<jsp:param name="pageName" value="notice" />

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
              <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">공지 /</span> 공지사항 작성</h4>

              <div class="row w-100">
                <!-- Basic -->
                <div class="col-12">
                  <div class="card mb-4">
                    <div class="card-body demo-vertical-spacing demo-only-element">
                      <div id="formContainer">
                      <form id="noticeForm" action="/admin/notices/addNotice" method="post" enctype="multipart/form-data" >
                      <div class="input-group">
                        <input type="text" class="form-control" name="noticeTitle" placeholder="제목을 입력하세요" aria-label="Username" aria-describedby="basic-addon11" required/>
                      </div>
                      <div class="input-group">
                        <input type="text" class="form-control" name="adminId" value="${adminId}" placeholder="작성자를 입력하세요" aria-label="Username" aria-describedby="basic-addon11" required readonly/>
                      </div>
                      
                      <div class="input-group">
				        <div class="input-group-text">
				          <input class="form-check-input mt-0" type="radio" name="noticeType" value="N" aria-label="공지" checked required id="noticeType1" onchange="changeForm(this.value)"/>공지</div>
						<div class="input-group-text">
				          <input class="form-check-input mt-0" type="radio" name="noticeType" value="E" aria-label="이벤트" required id="noticeType2" onchange="changeForm(this.value)" disabled/>이벤트</div>
				      </div>

                      <div class="input-group" id="summerSize">
                        <div id="summernote" aria-label="With textarea" placeholder="내용을 입력하세요" required></div>
                      </div>
                      <input type="hidden" name="noticeContent" id="noticeContentInput" required/>
				<!-- 공지 등록 버튼 -->
		      	<div class="text-end mt-3">
					<button type="submit" class="btn rounded-pill btn-outline-primary">공지 등록</button>
				</div>
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
//         function changeForm(value) {
//         	const noticeType = document.querySelector('input[name="noticeType"]:checked').value;
//             const noticeForm = document.getElementById("noticeForm");
//             const eventForm = document.getElementById("eventForm");

//             // 폼 보여주기/숨기기

// 			    if (noticeType === 'N') {
// 			        noticeForm.style.display = 'block';
// 			        eventForm.style.display = 'none';
// 			    } else if (noticeType === 'E') {
// 			        noticeForm.style.display = 'none';
// 			        eventForm.style.display = 'block';
//                 } else {
//                 console.error("폼 요소를 찾을 수 없습니다."); // 에러 메시지
//             }
//         }

//         // 쿼리 스트링 업데이트 함수 정의
//         function updateQueryString(key, value) {
//             const url = new URL(window.location.href);  // 현재 URL 가져오기
//             url.searchParams.set(key, value);           // 쿼리 스트링 업데이트
//             window.history.pushState({}, '', url);      // URL 업데이트
//         }

//         $(document).ready(function() {
//             // 선택된 라디오 버튼에 따라 changeForm 호출
//             $('input[name="noticeType"]').on('change', function() {
//                 changeForm(this.value); // 선택된 값으로 폼 변경
//             });
    	
        // Summernote 설정
        $('#summernote').summernote({
        	width: '100%',
        	height: 800,
            lang: 'ko-KR',
            placeholder: '내용을 입력하세요.',
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
                onImageUpload: function(files) {
                    const selectedType = $('input[name="noticeType"]:checked').val();
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
                url: '/post/saveNotice',
                type: 'POST',
                data: { noticeContent: noticeContent },
                success: function(response) {
                    alert(response);
                },
                error: function() {
                    alert('공지사항 저장 실패');
                }
            });
        }

        window.onload = function() {
            const noticeType = "${notice.notice_type}";
            if (noticeType === 'N') {
                document.getElementById('noticeType1').checked = true;
                changeForm("N"); // 처음 로드 시 폼 전환
            } else if (noticeType === 'E') {
                document.getElementById('noticeType2').checked = true;
                changeForm("E"); // 처음 로드 시 폼 전환
            }
        };

        // 폼 제출 시 내용 가져오기 및 검증
        $('form').on('submit', function(e) {
        	let noticeTitle = $('input[name="noticeTitle"]').val();
        	let adminId = $('input[name="adminId"]').val();
        	let noticeContent = $('#summernote').summernote('code');

            console.log("Notice Title:", noticeTitle);
            console.log("Admin ID:", adminId);
            console.log("Notice Content:", noticeContent);

            // 필드 검증
            if (!noticeTitle || !adminId || !noticeContent.trim()) {
                e.preventDefault();
                alert('모든 필드를 채워주세요.');
            } else {
                $('#noticeContentInput').val(noticeContent);
            }
        });
    });
    </script>
  </body>
</html>