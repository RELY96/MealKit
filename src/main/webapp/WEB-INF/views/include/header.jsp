<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="loginId" value="${sessionScope.userId==null ? '' : sessionScope.userId}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}"/>
<c:set var="pageName" value="${loginId=='admin' ? '관리자페이지' : '마이페이지'}"/>
<c:set var="MyPageLink" value="${loginId=='' ?  '/login/login'  :  ( loginId=='admin' ? '/item/list' : '/mypage/order')}"/>
<c:set var="loginOut" value="${loginId=='' ? '로그인' : '로그아웃'}"/>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value='/css/basic.css'/>">
<script defer src="<c:url value='/js/basic.js'/>"></script>
<body>
<header>
  <div class="summit_line"></div>
  <section class="gram_container">
    <h1>
      <a class="logo_image" href="<c:url value='/'/>">편한밥상</a>
    </h1>
    <div class="user_input">
      <div class="memberShip">
        <a href="<c:url value='${loginOutLink}'/>">${loginOut}</a>|
        <a href="<c:url value='/register/register'/>" >회원가입</a>|

        <a href="<c:url value='${MyPageLink}'/>" >${pageName}</a>|
        <a href="<c:url value='/noticelist?link=C'/>">고객센터</a>
        <a href="<c:url value='/cart'/>">　</a>
      </div>

      <form action="" role="input">
        <fieldset>
          <legend>
            <input type="text">
            <button></button>
          </legend>
        </fieldset>
      </form>
    </div>
  </section>

  <nav>
    <ul class="menu">
      <li><a href="#">편한밥상 소개</a></li>
      <li><a href="#">전체보기</a></li>
      <li><a class="meal" href="#">밀키트</a></li>
      <li><a class="them" href="#">테마별</a></li>
      <li><a href="#">베스트</a></li>
      <li><a href="#">신메뉴</a></li>
      <li><a href="#">커뮤니티</a></li>
    </ul>
    <div class="menus">
      <div id="category01">
        <ul>
          <li><a href="">한식</a></li>
          <li><a href="">양식</a></li>
          <li><a href="">중식/일식</a></li>
          <li><a href="">분식/야식</a></li>
          <li><a href="">세트상품</a></li>
        </ul>
      </div>

      <div class="thema">
        <ul>
          <li><a href="">비오는날</a></li>
          <li><a href="">집들이</a></li>
          <li><a href="">캠핑</a></li>
          <li><a href="">술안주</a></li>
          <li><a href="">혼밥</a></li>
        </ul>
      </div>
    </div>
  </nav>
</header>
</body>
</html>
