<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ page session="true"%>
<%--<%@ page import="java.net.URLDecoder"%>--%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 상세</title>
    <link rel="stylesheet" href="<c:url value='/css/event.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>

</head>

<body>
<jsp:include page="../include/header.jsp" flush="false" />
<main>

    <div class="main">
        <jsp:include page="../include/admin.jsp" flush="false" />

        <div class="oventDetail">

<div class="pageTitle_container">
    <h3>이벤트</h3>
    <hr>
</div>

    <div class="event_container">
        <c:set var="pageLink" value="/eventModify?eventN0=${eventVO.eventNo}"/>
            <table>
                <tr>
                    <th>
                        ${eventVO.eventName}
                    </th>
                </tr>
                <tr>
                    <td>
                      <h3>관리자</h3>
                    </td>
                </tr>
                <tr>
                    <td><img src="<c:url value='${eventVO.imgName}'/>"></td>
                </tr>
            </table>
            <div class="button_container">
                <button type="button" id="listBtn" class="btn-list">목록으로</button>
                <button type="button" id="modifyBtn" class="btn-modify">수정</button>
                <button type="button" id="delBtn" class="btn-del">삭제</button>
            </div>

        </form>

    </div>

<script>

    let eventNo ='${eventVO.eventNo}';

    $(document).ready(function(){

        $("#listBtn").on("click", function(){
            location.href="<c:url value='/event'/>";
        });

        $("#modifyBtn").on("click", function(){
            location.href="<c:url value='/event/modify'/>";
        });

        $("#delBtn").on("click", function(){
                if(!confirm("이벤트를 삭제하시겠습니까?")) return;

                $.ajax({
                    type:'delete',
                    url: '/meal/event/'+eventNo,
                    headers : { "content-type": "application/json"},
                    dataType : 'text',
                    data : JSON.stringify({eventNo:eventNo}),
                    success : function(result){
                        alert("삭제가 완료되었습니다");
                        location.href="<c:url value='/event'/>";
                    },
                    error   : function(){ alert("삭제를 실패하였습니다") }
                });
        });

    });

</script>
        </div>
    </div>
</main>
<jsp:include page="../include/footer.jsp" flush="false" />
</body>

</html>