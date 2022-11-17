<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ page session="true"%>
<%--<%@ page import="java.net.URLDecoder"%>--%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>paymentConfirm</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<style>
    .paymentSuccess {
        margin-top: 250px;
        margin-bottom: 50px;
        width: 900px;
        margin:auto;
        text-align:center;
    }

    .paymentSuccess a {
        padding: 8px 10px;
        background-color: whitesmoke;
        border: 1px solid darkgray;
        cursor: pointer;
        width: 120px;
        margin-left: 5px;
    }

</style>

<body>
<jsp:include page="include/header.jsp" flush="false" />

<main>
    <div class="paymentSuccess">
        <h1>결제가 완료 되었습니다</h1>
        <a href="<c:url value='/'/>">홈으로</a>
        <a href="<c:url value='/mypage/order'/>">주문 확인</a>
    </div>
</main>

</body>

</html>