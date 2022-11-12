<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>noticeList</title>
    <link rel="stylesheet" href="resources/css/boardList.css">
    <script src="resources/ajaxLib/jquery-3.2.1.min.js"></script>
    <script>
        // ** notice Search js
        $(function () {
            $('#searchType').change(function () {
                if ($(this).val() == 'a') $('#keyword').val('');
            }); //change
            $('#noticeSearchBtn').click(function () {
                self.location = "noticelist"
                    + "${pageMaker.makeQuery(1)}"
                    + "&searchType="
                    + $('#searchType').val()
                    + "&keyword="
                    + $('#keyword').val()
            }); //click
        }); //ready
    </script>
</head>
<body>
<c:if test="${not empty message}">
    <script type="text/javascript">
        let message = "${message}";
        alert(message);
    </script>
</c:if>
<main class="main_container">
    <h1>공지사항</h1>
    <section class="section_container">
        <div id="noticeSearchBar">
            <select name="searchType" id="searchType" class="searchBar">
                <option value="a" ${pageMaker.cri.searchType==null ? 'selected':''}>--전체--</option>
                <option value="t" ${pageMaker.cri.searchType=='t' ? 'selected':''}>제목</option>
                <option value="c" ${pageMaker.cri.searchType=='c' ? 'selected':''}>내용</option>
                <option value="tc" ${pageMaker.cri.searchType=='tc' ? 'selected':''}>제목+내용</option>
            </select>
            <input type="text" name="keyword" id="keyword" value="${pageMaker.cri.keyword}">
            <button id="noticeSearchBtn">검색</button>
        </div>
        <br>

        <table>
            <tr>
                <th>분류</th>
                <th>제목</th>
                <th>등록일</th>
            </tr>
            <c:if test="${not empty noticeResult}">
                <c:forEach var="notice" items="${noticeResult}">
                    <tr>
                        <td>${notice.noticeType}</td>
                        <td>
                            <a href="noticedetail?noticeNo=${notice.noticeNo}">${notice.noticeTitle}</a>
                        </td>
                        <td>${notice.regDate}</td>
                    </tr>
                </c:forEach>
            </c:if>
        </table>
    </section>
    <hr>
        <!-- Paging 1)forward button 2)back button 3)pageNo -->
        <div>
            <!-- 1. First, Prev button: ver01.pageMaker.makeQuery / ver02.SearchQuery -->
            <c:choose>
                <c:when test="${pageMaker.prev && pageMaker.spageNo>1}">

                    <a href="noticelist${pageMaker.searchQuery(1)}" class="firstBtn">◀◀</a>&nbsp;
                    <a href="noticelist${pageMaker.searchQuery(pageMaker.spageNo-1)}" class="forwardBtn">&lt;</a>&nbsp;&nbsp;
                    <!-- 앞으로가기 : 현재페이지의 이전 그룹(spage-1)
                    => rowsPerPage는 그대로, currPage=spage-1 : EL로 기재 -->
                </c:when>
                <c:otherwise>
                    <span class="firstBtn none">◀◀&nbsp;&nbsp;&lt;&nbsp;</span>
                </c:otherwise>
            </c:choose>

            <!-- 2. Display PageNo - 반복문 begin(spage)-end(epage)(범위지정) 사용
                  : ver01.pageMaker.makeQuery / ver02.searchQuery -->
            <c:forEach var="i" begin="${pageMaker.spageNo}" end="${pageMaker.epageNo}">
                <!-- currPage 는 cri안에 있으니까 .cri로 부르기
                i가 현재페이지라면(현재page 가 현재page라면) -->
                <c:if test="${i==pageMaker.cri.currPage}">
                    <!-- 현재페이지 표식 -->
                    <span class="currPage">${i}</span>&nbsp;
                </c:if>

                <c:if test="${i!=pageMaker.cri.currPage}">
                    <!-- i가 현재페이지가 아닐 때 - 클릭하면 넘어가야 하니까 a href
                    현재페이지 param으로 controller에 넣어줘서 기준 주고, controll동작하게 하기-->
                    <a href="noticelist${pageMaker.searchQuery(i)}">${i}</a>
                </c:if>
            </c:forEach>

            <!-- 3. Next, Last button: ver01.pageMaker.makeQuery / ver02.SearchQuery -->
            <c:choose>
                <c:when test="${pageMaker.next && pageMaker.epageNo>0}">
                    <a href="noticelist${pageMaker.searchQuery(pageMaker.epageNo+1)}" class="backBtn">&nbsp;&nbsp;&gt;</a>
                    <!-- 뒤로가기 : 현재 페이지의 다음그룹
                    => rowsPerPage는 그대로, currPage=epage+1 -->
                    <a href="noticelist${pageMaker.searchQuery(pageMaker.lastPageNo)}" class="lastBtn">▶▶</a>
                    <!-- lastPage는 pageMaker에서 계산해놨으니까 그대로 넣어주기 -->
                </c:when>
                <c:otherwise>
                    <span class="lastBtn none">&nbsp;&gt;&nbsp;&nbsp;▶▶</span>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="linkBtn_container">
            <div class="linkBtn">
                <div class="Insert">
                    <c:if test="${ userId == 'admin'}">
                        <a href="noticeinsertf">공지등록</a>
                    </c:if>
                </div>
            </div>
        </div>
</main>
</body>
</html>
