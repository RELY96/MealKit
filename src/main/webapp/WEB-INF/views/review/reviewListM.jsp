<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>reviewList</title>
    <link rel="stylesheet" href="<c:url value='/css/review.css'/>">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="js/reviewAjax.js"></script>
</head>
<body>
<c:if test="${not empty message}">
    <script type="text/javascript">
        let message = "${message}";
        alert(message);
    </script>
</c:if>

<%@include file="../include/header.jsp" %>
<main class="main_container">
    <div class="main">

        <jsp:include page="../include/mypage.jsp" flush="false"/>


        <div class="reviewList">
            <h1>상품후기</h1>
            <section class="section_container">
                <table>
                    <tr>
                        <th>이미지 미리보기</th>
                        <th colspan="2">제목</th>
                        <th>아이디</th>
                    </tr>
                    <c:if test="${not empty reviewResult}">
                        <c:forEach var="review" items="${reviewResult}">
                            <c:if test="${review.reviewStep < 1}">
                                <tr>
                                    <c:if test="${not empty review.imgName}">
                                        <td><img src="${review.imgName}" width=150 height=150></td>
                                    </c:if>
                                    <td colspan="2">
                                        <a href="reviewdetail?reviewNo=${review.reviewNo}&itemNo=${review.itemNo}&link=M">${review.reviewTitle}</a>
                                    </td>
                                    <td>${review.userId}</td>
                                </tr>
                                <tr hidden>
                                    <td>${review.itemNo}</td>
                                </tr>
                                <br>
                            </c:if>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty reviewResult}">
                        <tr>
                            <td colspan="4">작성하신 후기가 없습니다.</td>
                        </tr>
                    </c:if>
                </table>
            </section>
            <hr>
            <c:if test="${not empty reviewResult}">
                <div class="paging">
                    <!-- 1. First, Prev button: ver01.pageMaker.makeQuery / ver02.SearchQuery -->
                    <c:choose>
                        <c:when test="${pageMaker.prev && pageMaker.spageNo>1}">

                            <a href="reviewlistM${pageMaker.searchQuery(1)}&link=M" class="firstBtn">◀◀</a>&nbsp;
                            <a href="reviewlistM${pageMaker.searchQuery(pageMaker.spageNo-1)}&link=M"
                               class="forwardBtn">&lt;</a>&nbsp;&nbsp;
                            <!-- 앞으로가기 : 현재페이지의 이전 그룹(spage-1)
                            => rowsPerPage는 그대로, currPage=spage-1 : EL로 기재 -->
                        </c:when>
                        <c:otherwise>
                            <span class="firstBtn none">◀◀&nbsp;&nbsp;&lt;&nbsp;</span>
                        </c:otherwise>
                    </c:choose>

                    <!-- 2. Display PageNo - 반복문 begin(spage)-end(epage)(범위지정) 사용
                          : ver01.pageMaker.makeQuery / ver02.searchQuery -->
                    <c:forEach var="i" begin="${pageMaker.spageNo}" end="${pageMaker.epageNo}"> <!-- ★★★ -->
                        <!-- currPage 는 cri안에 있으니까 .cri로 부르기
                        i가 현재페이지라면(현재page 가 현재page라면) -->
                        <c:if test="${i==pageMaker.cri.currPage}">
                            <!-- 현재페이지 표식 -->
                            <span class="currPage">${i}</span>
                        </c:if>

                        <c:if test="${i!=pageMaker.cri.currPage}">
                            <!-- i가 현재페이지가 아닐 때 - 클릭하면 넘어가야 하니까 a href
                            현재페이지 param으로 controller에 넣어줘서 기준 주고, controll동작하게 하기-->
                            <a href="reviewlistM${pageMaker.searchQuery(i)}&link=M">${i}</a>
                        </c:if>
                    </c:forEach>

                    <!-- 3. Next, Last button: ver01.pageMaker.makeQuery / ver02.SearchQuery -->
                    <c:choose>
                        <c:when test="${pageMaker.next && pageMaker.epageNo>0}">
                            <a href="reviewlistM${pageMaker.searchQuery(pageMaker.epageNo+1)}&link=M" class="backBtn">&nbsp;&nbsp;&gt;</a>
                            <!-- 뒤로가기 : 현재 페이지의 다음그룹
                            => rowsPerPage는 그대로, currPage=epage+1 -->
                            <a href="reviewlistM${pageMaker.searchQuery(pageMaker.lastPageNo)}&link=M" class="lastBtn">▶▶</a>
                            <!-- lastPage는 pageMaker에서 계산해놨으니까 그대로 넣어주기 -->
                        </c:when>
                        <c:otherwise>
                            <span class="lastBtn none">&nbsp;&gt;&nbsp;&nbsp;▶▶</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>
        </div>
    </div>
</main>
<jsp:include page="../include/footer.jsp" flush="false"/>
</body>
</html>
