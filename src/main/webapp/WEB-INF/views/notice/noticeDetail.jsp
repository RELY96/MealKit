<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>NoticeDetail</title>
    <link rel="stylesheet" href="resources/css/boardDetail.css">
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
        <table>
            <tr>
                <td>제목</td>
                <td>${noticeResult.noticeTitle}</td>
            </tr>
            <tr>
                <td>작성일</td>
                <td>${noticeResult.regDate}</td>
            </tr>
            <tr>
                <td>내용</td>
                <td><textarea rows="15" cols="100" readonly>${noticeResult.noticeContent}</textarea></td>
            </tr>

            <tr hidden>
                <td>글번호</td>
                <td>${noticeResult.noticeNo}</td>
            </tr>
        </table>
    </section>
    <hr>
    <div class="linkBtn_container">
        <div class="linkBtn">
            &nbsp;&nbsp;<a href="noticelist">목록으로</a><br>
            <c:if test="${userId == 'admin'}">
                &nbsp;&nbsp;<a href="noticedetail?jCode=U&noticeNo=${noticeResult.noticeNo}">수정하기</a>
                &nbsp;&nbsp;<a href="noticedelete?noticeNo=${noticeResult.noticeNo}" onclick="return confirm('삭제하시겠습니까? 확인/취소');">삭제하기</a>
            </c:if>
        </div>
    </div>
</main>
</body>
</html>