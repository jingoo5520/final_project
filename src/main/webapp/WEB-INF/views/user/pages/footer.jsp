<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html class="no-js" lang="zxx">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <title>Footer</title>
    <meta name="description" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="shortcut icon" type="image/x-icon" href="/resources/assets/user/images/logo/favicon.png" />

    <!-- ========================= CSS here ========================= -->
    <link rel="stylesheet" href="/resources/assets/user/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/resources/assets/user/css/LineIcons.3.0.css" />
    <link rel="stylesheet" href="/resources/assets/user/css/tiny-slider.css" />
    <link rel="stylesheet" href="/resources/assets/user/css/glightbox.min.css" />
    <link rel="stylesheet" href="/resources/assets/user/css/main.css" />

</head>
<body>
    <!-- Start Footer Area -->
    
    <footer class="footer">
        <!-- Start Footer Top -->
        <div class="footer-top">
            <div class="container">
                <div class="inner-content">
                    <div class="row">
                        <div class="col-lg-3 col-md-4 col-12">
                            <div class="footer-logo">
                                <a href="${pageContext.request.contextPath}/">
                                    <img src="/resources/assets/user/images/logo/white-logo.svg" alt="#">
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Footer Top -->
        <!-- Start Footer Middle -->
        <div class="footer-middle">
            <div class="container">
                <div class="bottom-inner">
                    <div class="row">
                        <div class="col-lg-3 col-md-6 col-12">
                            <!-- Single Widget -->
                            <div class="single-footer f-contact">
                                <h3>Get In Touch With Us</h3>
                                <p class="phone">Phone: (+82) 010-0000-0000</p>
                                <ul>
                                    <li><span>Monday-Friday: </span> 9:30 - 18:30</li>
                                </ul>
                                <p class="mail">
                                    <a href="mailto:teamproject2@abc.com">teamproject2@abc.com</a>
                                </p>
                            </div>
                            <!-- End Single Widget -->
                        </div>
                        <div class="col-lg-3 col-md-6 col-12">
                            <!-- Single Widget -->
                            <div class="single-footer f-link">
                                <h3>Pages</h3>
                                <ul>
                                    <li><a href="/serviceCenter/notice">공지사항</a></li>
                                    <li><a href="/event">이벤트</a></li>
                                    <li><a href="/serviceCenter/inquiries">고객센터</a></li>
                                </ul>
                            </div>
                            <!-- End Single Widget -->
                        </div>
                        <div class="col-lg-3 col-md-6 col-12">
                            <!-- Single Widget -->
                        	<div class="single-footer f-link">
                                <h3>Members</h3>
                                <ul>
                                	<c:if test="${empty sessionScope.loginMember }">
                                    	<li><a href="/member/viewSignUp">회원가입</a></li>
                                   		<li><a href="/member/viewLogin">로그인</a></li>
                                    </c:if>
                                    <c:if test="${not empty sessionScope.loginMember }">
                                    	<li><a href="${pageContext.request.contextPath}/member/myPage/viewOrder">내 정보</a></li>
										<li><a href="${pageContext.request.contextPath}/member/logout">로그아웃</a></li>
                                    </c:if>
                                    <li><a href="/serviceCenter/memberships">멤버쉽 혜택</a></li>
                                    <li><a href="/product/jewelry/all">카테고리</a></li>
                                    <li><a href="/cart">장바구니</a></li>
                                </ul>
                            </div>
                            <!-- End Single Widget -->
                        </div>
                       <div class="col-lg-3 col-md-6 col-12">
                            <!-- Single Widget -->
                            <div class="single-footer f-link">
                                <h3>Information</h3>
                                <ul>
                                    <li><a href="https://docs.google.com/spreadsheets/d/1ULEzyom9b-teEy3ERGJSTtn1C1u6tFI2_f3Zmhp_PYA/edit?gid=488089020#gid=488089020">기능명세서</a></li>
                                    <li><a href="https://docs.google.com/spreadsheets/d/1TqMi5rk0uO-Az_MNDS0bLJajiCx10kAMmpXf07ObsY4/edit?gid=1351357681#gid=1351357681">테이블명세서</a></li>
                                    <li><a href="https://www.notion.so/2-111b8702aaa180cbac60c0dc4504a9b9">Notion</a></li>
                                    <li><a href="https://app.diagrams.net/#G1DC2MAYNjGgyQx5aA0wegAu6TrnZgy5oG#%7B%22pageId%22%3A%222c0d36ab-eaac-3732-788b-9136903baeff%22%7D">Site Map</a></li>
                                    <li><a href="https://github.com/jingoo5520/final_project">Git Hub</a></li>
                                </ul>
                            </div>
                            <!-- End Single Widget -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Footer Middle -->
        <!-- Start Footer Bottom -->
        <div class="footer-bottom">
            <div class="container">
                <div class="inner-content">
                    <div class="row align-items-center">
                    	<div class="col-lg-4 col-12">
                    		<div class="copyright">
                    			<p>Project Hosted by<a href="https://www.cafe24.com/" rel="nofollow"
                                        target="_blank">Cafe24</a></p>
                    		</div>
                        </div>
                        <div class="col-lg-4 col-12">
                           <div class="copyright">
                                <p>Project Developed by<a href="https://goott.co.kr/129" rel="nofollow"
                                        target="_blank">Goot Acardemy</a></p>
                            </div>
                        </div>
                        <div class="col-lg-4 col-12">
                            <div class="copyright">
                                <p>Project Template by<a href="https://graygrids.com/" rel="nofollow"
                                        target="_blank">GrayGrids</a></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Footer Bottom -->
    </footer>
    <!--/ End Footer Area -->
</body>
</html>