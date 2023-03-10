<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>reviewList</title>
    <link rel="stylesheet" href="<c:url value='/css/review.css'/>">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="js/reviewAjax.js"></script>
    <script>
        // ** notice Search js
        $(function () {
            $('#searchType').change(function () {
                if ($(this).val() == 'a') $('#scKeyword').val('');
            }); //change
            $('#reviewSearchBtn').click(function () {
                self.location = "reviewlist"
                    + "${pageMaker.makeQuery(1)}"
                    + "&searchType="
                    + $('#searchType').val()
                    + "&scKeyword="
                    + $('#scKeyword').val()
            }); //click
        }); //ready
    </script>
</head>
<body>
<%@include file="../include/header.jsp"%>

<c:if test="${not empty message}">
    <script type="text/javascript">
        let message = "${message}";
        alert(message);
    </script>
</c:if>

<main class="main_container">
    <div class="main">
        <c:if test="${userId == 'admin'}">
            <jsp:include page="../include/admin.jsp" flush="false" />
        </c:if>
        <c:if test="${userId != 'admin'}">
            <jsp:include page="../include/mypage.jsp" flush="false" />
        </c:if>
        <div class="reviewList">

    <h1>상품후기</h1>
            <hr>
    <section class="section_container">
        <div id="reviewSearchBar">
            <select name="searchType" id="searchType" class="searchBar">
                <option value="a" ${pageMaker.cri.searchType==null ? 'selected':''}>--전체--</option>
                <option value="in" ${pageMaker.cri.searchType=='in' ? 'selected':''}>상품명</option>
            </select>
            <input type="text" name="scKeyword" id="scKeyword" value="${pageMaker.cri.scKeyword}">
            <button id="reviewSearchBtn">검색</button>
        </div>
        <br>
        <table>
            <tr>
                <th>상품</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
            </tr>
            <c:if test="${not empty reviewResult}">
                <c:forEach var="review" items="${reviewResult}">
                        <tr>
                            <c:if test="${not empty review.imgName}">
                                <td><img src="${review.imgName}"></td>
                            </c:if>
                            <c:if test="${review.reviewStep < 1}">
                                <td><a href="reviewdetail?reviewNo=${review.reviewNo}&itemNo=${review.itemNo}&link=A">${review.reviewTitle}</a></td>
                            </c:if>
                            <!-- Step > 0 이면 관리자가 단글 -> 여기만 &nbsp; 적용 & colspan 3  -->
                            <c:if test="${review.reviewStep > 0}">
                                <td></td>
                                <td text-align="right">
                                    <a href="reviewdetail?reviewNo=${review.reviewNo}&itemNo=${review.itemNo}&link=A">&nbsp;&nbsp;ㄴ답변&nbsp;${review.reviewTitle}</a>
                                </td>
                            </c:if>
                            <c:if test="${review.userId != 'admin'}">
                                <td>${review.userId}</td>
                            </c:if>
                            <c:if test="${review.userId == 'admin'}">
                                <td>관리자</td>
                            </c:if>
                            <td class="regDate">${review.regDate}</td>
                        </tr>

                        <tr hidden>
                            <td>${review.itemNo}</td>
                        </tr>
                </c:forEach>
            </c:if>
        </table>
    </section>
    <div class="paging">
        <c:choose>
            <c:when test="${pageMaker.prev && pageMaker.spageNo>1}">
                <a href="reviewlist${pageMaker.searchQuery(1)}&link=A" class="firstBtn">◀◀</a>&nbsp;
                <a href="reviewlist${pageMaker.searchQuery(pageMaker.spageNo-1)}&link=A" class="forwardBtn">&lt;</a>&nbsp;&nbsp;
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
                <a href="reviewlist${pageMaker.searchQuery(i)}&link=A">${i}</a>
            </c:if>
        </c:forEach>

        <c:choose>
            <c:when test="${pageMaker.next && pageMaker.epageNo>0}">
                <a href="reviewlist${pageMaker.searchQuery(pageMaker.epageNo+1)}&link=A" class="backBtn">&nbsp;&nbsp;&gt;</a>
                <a href="reviewlist${pageMaker.searchQuery(pageMaker.lastPageNo)}&link=A" class="lastBtn">▶▶</a>
            </c:when>
            <c:otherwise>
                <span class="lastBtn none">&nbsp;&gt;&nbsp;&nbsp;▶▶</span>
            </c:otherwise>
        </c:choose>
    </div>
        </div>
    </div>
</main>
<jsp:include page="../include/footer.jsp" flush="false" />
</body>
</html>
