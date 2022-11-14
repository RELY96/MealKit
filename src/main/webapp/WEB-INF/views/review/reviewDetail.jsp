<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>reviewDetail</title>
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
<main class="main_container">
    <h1>상품후기</h1>
    <section class="section_container">
        <table>
            <tr>
                <td>제목</td>
                <td>${reviewResult.reviewTitle}</td>
                <td background-color="#f8f8f8">아이디</td>
                <td>${reviewResult.userId}</td>
            </tr>

            <tr>
                <td>리뷰 이미지</td>
                <td>
                    <c:if test="${not empty reviewResult.imgName}">
                        <img src="${reviewResult.imgName}" width=250 height=250>
                    </c:if>
                </td>
                <c:if test="${not empty reviewResult.itemName}">
                    <td>상품명:<br>${reviewResult.itemName}</td>
                    <td>가격:<br>${reviewResult.itemPrice}</td>
                </c:if>
            </tr>

            <tr>
                <td>내용</td>
                <td colspan="3"><textarea rows="10" cols="50" readonly>${reviewResult.reviewContent}</textarea></td>
            </tr>

            <tr hidden>
                <td>후기번호</td>
                <td>${reviewResult.reviewNo}</td>
            </tr>
            <tr hidden>
                <td>${reviewResult.orderNo}</td>
                <td>${reviewResult.itemNo}</td>
                <td>${reviewResult.reviewRoot}</td>
                <td>${reviewResult.reviewStep}</td>
                <td>${reviewResult.reviewChild}</td>
            </tr>
        </table>
    </section>

    <div class="linkBtn_container">
        <div class="linkBtn">
            <a href="reviewlist">목록으로</a>&nbsp;&nbsp;
            <c:if test="${userId == 'admin' && reviewResult.reviewChild < 1}">
    <span class="textLink"
          onclick="reviewReplyF(${reviewResult.orderNo},${reviewResult.itemNo},${reviewResult.reviewRoot},${reviewResult.reviewStep},${reviewResult.reviewChild})">답글달기</span><br>
            </c:if>
            <c:if test="${reviewResult.reviewStep < 1}">
            <span class="textLink"
                  onclick="reviewReplyD(${reviewResult.reviewRoot},${reviewResult.reviewStep},${reviewResult.reviewChild})">댓글보기</span>
            </c:if>
            <c:if test="${userId == reviewResult.userId || userId == 'admin'}">
                <a href="reviewdetail?jCode=U&reviewNo=${reviewResult.reviewNo}">수정하기</a>&nbsp;&nbsp;
                <a href="reviewdelete?reviewNo=${reviewResult.reviewNo}&reviewRoot=${reviewResult.reviewRoot}"
                   onclick="return confirm('삭제하시겠습니까? 확인/취소');">삭제하기</a>
            </c:if>
        </div>
    </div>
    <section class="section_container">
        <!-- Ajax 답글 달기, 답글 출력 창 -->
        <div id="resultArea1"></div>
        <div id="resultArea2"></div>
        <div id="resultArea3"></div>
    </section>
</main>
</body>
</html>
