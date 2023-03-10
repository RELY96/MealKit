<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value='/css/admin.css'/>">
<body>

<aside class="admin">
  <h3>관리자 페이지</h3>
  <div>상품 관리
    <ul>
      <li><a href="<c:url value='/item/list'/>">　- 상품 목록</a></li>
    </ul>
    <ul>
      <li><a href="<c:url value='/event/list?link=A'/>">　- 이벤트 목록</a></li>
    </ul>
  </div>

  <div>판매 관리
    <ul>
      <li><a href="<c:url value='/order/list'/>">　- 주문 목록</a></li>
    </ul>
  </div>

  <div>회원 관리
    <ul>
      <li><a href="<c:url value='/user/list'/>">　- 회원 목록</a></li>
    </ul>
  </div>

  <div>게시판 관리
    <ul>
      <li><a href="<c:url value='/noticelist?link=A'/>">　- 공지사항</a></li>
      <li><a href="<c:url value='/qnalist?link=A'/>">　- 1:1문의</a></li>
      <li><a href="<c:url value='/reviewlist'/>">　- 상품후기</a></li>
    </ul>
  </div>

</aside>

</body>
</html>
