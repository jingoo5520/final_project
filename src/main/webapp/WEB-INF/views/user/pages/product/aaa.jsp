<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 검색 결과 표시 -->
<div class="container">
    <h3>검색 결과: 총 ${totalCount}건</h3>

    <div class="search-results">
        <c:forEach var="product" items="${searchResults}">
            <div class="product-item">
                <a href="/product/jewelry/detail?productNo=${product.product_no}">
                    <img src="${empty product.image_main_url ? '/resources/images/noP_image.png' : product.image_main_url}" alt="${product.product_name}" width="300px" height="300px">
                    <p>${product.product_name}</p>
                    <p>${product.product_price}원</p>
                </a>
            </div>
        </c:forEach>
    </div>
</div>

<!-- 검색 폼 -->
<div class="single-widget search">
    <h3>찾으실 상품을 검색해주세요.</h3>
    <form action="/product/jewelry/result" method="get">
        <input type="text" name="query" placeholder="Search Here..." value="${query != null ? query : ''}">
        <input type="hidden" name="category" value="${category}">
        <input type="hidden" name="sortField" value="${sortField}">
        <input type="hidden" name="sortOrder" value="${sortOrder}">
        <button type="submit"><i class="lni lni-search-alt"></i></button>
    </form>
</div>

<!-- 페이지네이션 -->
<div class="row">
    <div class="col-12">
        <div class="pagination left">
            <ul class="pagination-list">
                <c:if test="${pagingInfo.startPageNoCurBlock > 1}">
                    <li>
                        <a href="/product/jewelry/result?page=${pagingInfo.startPageNoCurBlock - 1}&pageSize=${pagingInfo.viewPostCntPerPage}&sortOrder=${sortOrder}&sortField=${sortField}&query=${query}&category=${category}">
                            <i class="lni lni-chevron-left"></i> 이전
                        </a>
                    </li>
                </c:if>

                <c:forEach var="i" begin="${pagingInfo.startPageNoCurBlock}" end="${pagingInfo.endPageNoCurBlock}">
                    <c:choose>
                        <c:when test="${i == pagingInfo.pageNo}">
                            <li class="active"><a href="">${i}</a></li>
                        </c:when>
                        <c:otherwise>
                            <li>
                                <a href="/product/jewelry/result?page=${i}&pageSize=${pagingInfo.viewPostCntPerPage}&sortOrder=${sortOrder}&sortField=${sortField}&query=${query}&category=${category}">${i}</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:if test="${pagingInfo.endPageNoCurBlock < pagingInfo.totalPageCnt}">
                    <li>
                        <a href="/product/jewelry/result?page=${pagingInfo.endPageNoCurBlock + 1}&pageSize=${pagingInfo.viewPostCntPerPage}&sortOrder=${sortOrder}&sortField=${sortField}&query=${query}&category=${category}">
                            다음 <i class="lni lni-chevron-right"></i>
                        </a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</div>
</body>
</html>