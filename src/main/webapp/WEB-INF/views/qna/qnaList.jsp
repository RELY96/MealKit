<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>qnaList</title>
    <link rel="stylesheet" href="<c:url value='/css/qna.css'/>">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="js/qnaAjax.js"></script>
    <script>
        // ** notice Search js
        $(function () {
            $('#searchType').change(function () {
                if ($(this).val() == 'a') $('#scKeyword').val('');
            }); //change
            $('#qnaSearchBtn').click(function () {
                self.location = "qnalist"
                    + "${pageMaker.makeQuery(1)}"
                    + "&searchType="
                    + $('#searchType').val()
                    + "&scKeyword="
                    + $('#scKeyword').val()
                    + "&link="
                    + "${link}"
            }); //click
        }); //ready
    </script>
</head>
<body>
<jsp:include page="../include/header.jsp" flush="false" />

<c:if test="${not empty message}">
    <script type="text/javascript">
        let message = "${message}";
        alert(message);
    </script>
</c:if>
<main class="main_container">
    <div class="main">
        <c:if test="${link eq 'A'}">
            <jsp:include page="../include/admin.jsp" flush="false" />
        </c:if>
        <c:if test="${link eq 'C'}">
            <jsp:include page="../include/center.jsp" flush="false" />
        </c:if>

        <c:if test="${link eq 'M'}">
            <jsp:include page="../include/mypage.jsp" flush="false" />
        </c:if>
        <div class="qnaList">
    <h1>1:1문의</h1>
            <hr>
    <section class="section_container">
        <div id="qnaSearchBar">
            <select name="searchType" id="searchType" class="searchBar">
                <option value="a" ${pageMaker.cri.searchType==null ? 'selected':''}>--전체--</option>
                <option value="i" ${pageMaker.cri.searchType=='i' ? 'selected':''}>아이디</option>
                <option value="t" ${pageMaker.cri.searchType=='t' ? 'selected':''}>제목</option>
                <option value="c" ${pageMaker.cri.searchType=='c' ? 'selected':''}>내용</option>
            </select>
            <input type="text" name="scKeyword" id="scKeyword" value="${pageMaker.cri.scKeyword}">
            <button id="qnaSearchBtn">검색</button>
        </div>
        <br>

        <table>
            <tr>
                <th>아이디</th>
                <th>제목</th>
                <th>등록일</th>
            </tr>
            <c:if test="${not empty qnaResult}">
                <c:forEach var="qna" items="${qnaResult}">
                    <tr>
                        <c:if test="${qna.userId == 'admin'}">
                            <td>관리자</td>
                        </c:if>
                        <c:if test="${qna.userId != 'admin'}">
                            <td>${qna.userId}</td>
                        </c:if>
                        <td>
                            <c:if test="${qna.qnaChild > 0}">
                                <c:forEach begin="1" end="${qna.qnaChild}">
                                    <span>&nbsp;&nbsp;</span>
                                </c:forEach>
                                <span style="color:blue">ㄴ</span>
                            </c:if>
                            <!-- 유저 -->
                            <c:if test="${userId != 'admin'}">
                                <c:choose>
                                    <c:when test="${userId == qna.userId}">
                                        <a href="qnadetail?qnaNo=${qna.qnaNo}&link=${link}">${qna.qnaTitle}</a>
                                    </c:when>
                                    <c:when test="${userId != qna.userId && qna.userId != 'admin'}">
                                        [작성자 혹은 관리자만 확인 가능한 문의입니다.]
                                    </c:when>
                                    <c:when test="${qna.userId == 'admin'}">
                                        [답변완료]
                                    </c:when>
                                </c:choose>
                            </c:if>

                            <!-- 관리자 -->
                            <c:if test="${userId == 'admin'}">
                                <a href="qnadetail?qnaNo=${qna.qnaNo}&link=${link}">${qna.qnaTitle}</a>
                            </c:if>
                        </td>
                        <td>${qna.regDate}</td>
                    </tr>
                </c:forEach>
            </c:if>
        </table>
    </section>

    <div class="paging">
        <c:choose>
            <c:when test="${pageMaker.prev && pageMaker.spageNo>1}">
                <a href="qnalist${pageMaker.searchQuery(1)}&link=${link}" class="firstBtn">◀◀</a>&nbsp;
                <a href="qnalist${pageMaker.searchQuery(pageMaker.spageNo-1)}&link=${link}" class="forwardBtn">&lt;</a>&nbsp;
            </c:when>
            <c:otherwise>
                <span class="firstBtn none">◀◀&nbsp;&nbsp;&lt;&nbsp;</span>
            </c:otherwise>
        </c:choose>

        <c:forEach var="i" begin="${pageMaker.spageNo}" end="${pageMaker.epageNo}">
            <c:if test="${i==pageMaker.cri.currPage}">
                <span class="currPage">${i}</span>
            </c:if>

            <c:if test="${i!=pageMaker.cri.currPage}">
                <a href="qnalist${pageMaker.searchQuery(i)}&link=${link}">${i}</a>
            </c:if>
        </c:forEach>

        <c:choose>
            <c:when test="${pageMaker.next && pageMaker.epageNo>0}">
                <a href="qnalist${pageMaker.searchQuery(pageMaker.epageNo+1)}&link=${link}" class="backBtn">&nbsp;&nbsp;&gt;</a>
                <a href="qnalist${pageMaker.searchQuery(pageMaker.lastPageNo)}&link=${link}" class="lastBtn">▶▶</a>
            </c:when>
            <c:otherwise>
                <span class="lastBtn none">&nbsp;&gt;&nbsp;&nbsp;▶▶</span>
            </c:otherwise>
        </c:choose>
    </div>
    <div class="linkBtn_container">
        <div class="linkBtn">
            <div class="Insert">
                <c:if test="${not empty userId && userId != 'admin'}">
                    <a href="qnainsertf?link=${link}">1:1 문의하기</a>
                </c:if>
            </div>
        </div>
    </div>
    </div>
    </div>
</main>
<jsp:include page="../include/footer.jsp" flush="false" />
</body>
</html>
