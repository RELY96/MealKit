<%@ page contentType="text/html;charset=UTF-8"  language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<!DOCTYPE html>
<html>
<head>
  <title>orderList</title>
  <link rel="stylesheet" href="<c:url value='/css/updateUser.css'/>">
  <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
</head>
<body>
<jsp:include page="../include/header.jsp" flush="false" />
<main>
  <div class="main">
    <jsp:include page="../include/mypage.jsp" flush="false" />

    <div class="updateUser">
      <h3>회원정보변경</h3>
      <hr>
      <div class="userId">
        <p>아이디</p>　<p>${sessionScope.userId.length() > 12 ?  '********'  : user.userId}</p>
      </div>
      <div class="userPwd">
        <p>비밀번호</p>　<p>********</p>　<input type="button" class="pwd" value="비밀번호 변경" id="updPwdBtb">
      </div>
      <script>
        if("${sessionScope.userId.length()}">12){
          $('#updPwdBtb')[0].style.display = 'none';
        }
      </script>
      <div class="pwd hidden" id="pwd">
        <div><span>현재비밀번호</span><input type="text" id="currentPwd"></div>
        <div><span>신규비밀번호</span><input type="text" id="newPwd1"><div id="msgPwd" style="color: red"></div></div>
        <div><span>신규비밀번호 재입력</span><input type="text" id="newPwd2"><div id="msgPwd2" style="color: red"></div> </div>
        <div class="pwdCheck">
          <input type="button" id="pwdCancel" value="취소">
          <input type="button" id="pwdComplete" value="완료">
        </div>
      </div>

      <div>
        <div class="userName"> <p>이름(실명)</p><p>${user.userName}</p>　<input type="button" class="name" value="이름 변경"></div>
        <div class="userNameForm">
          <form action="<c:url value='/update/userName'/>" method="post" id="nameForm">
            <div class="name hidden" id="name">
              <div><span>새로운 이름</span><input type="text" id="newName" name="newName"><div id="msgName" style="color: red"></div></div>
              <div>
                <input type="button" id="nameCancel" value="취소">
                <input type="button" id="nameComplete" value="완료">
              </div>
            </div>
          </form>
        </div>
      </div>

      <div>
        <div class="userEmail">
          <p> 이메일</p><p>${user.userEmail}</p>　<input type="button" class="email" value="이메일 변경"></div>
        <div class="userEmailForm">
          <form action="<c:url value='/update/userEmail'/>" method="post" id="emailForm">
            <div class="email hidden" id="email">
              <div><span>이메일 입력</span> <input type="text" id="userEmailArr" name="userEmailArr"> @ <input type="text" id="selectedEmail" name="userEmailArr">
                <select id="selectEmail">
                  <option value="직접입력" selected>　직접입력</option>
                  <option value="naver.com">naver.com</option>
                  <option value="daum.net">daum.net</option>
                  <option value="gmail.com">gmail.com</option>
                  <option value="nate.com">nate.com</option>
                </select> &nbsp; <div id="msgEmail" style="color: red"></div>
              </div>
              <div>
                <input type="button" id="emailCancel" value="취소">
                <input type="button" id="emailComplete" value="완료">
              </div>
            </div>
          </form>
        </div>
      </div>

      <div>
        <div class="userPhone">
          <p>휴대전화</p>　<p>${user.userPhone}</p>　<input type="button" class="phone" value="휴대전화 변경"> </div>

        <div class="userPhoneForm">
          <form action="<c:url value='/update/userPhone'/>" method="post" id="phoneForm">
            <div class="phone hidden" id="phone">
              <div><span>휴대폰번호 입력</span><input type="text" id="newPhone" name="newPhone"><div id="msgPhone" style="color: red"></div></div>
              <div>
                <input type="button" id="phoneCancel" value="취소">
                <input type="button" id="phoneComplete" value="완료">
              </div>
            </div>
          </form>
        </div>

        <div class="userAddr">
          <p>주소</p>　<p>${user.userAddr}</p>　<input type="button" class="addr" value="주소 변경"> </div>

        <div class="userAddrForm">
          <form action="<c:url value='/update/userAddr'/>" method="post" id="addrForm">
            <div class="addr hidden" id="addr">
              <div>
                <span>주소입력</span>
                <input type="text" id="zipNo" style="width: 80px" name="zipNo" placeholder="우편번호" readonly/>
                <input type="text" id="roadAddrPart1" style="width: 400px" name="roadAddrPart1" placeholder="도로명주소" readonly/>
                <input type="text" id="addrDetail" name="addrDetail" placeholder="상세주소" />
                <button type="button" id="addrBtn" onClick="goPopup();">우편번호 검색</button> &nbsp;
              </div>
              <div id="msgAddr" style="color: red; display: none"></div>
              <div>
                <input type="button" id="addrCancel" value="취소">
                <input type="button" id="addrComplete" value="완료">
              </div>
            </div>
          </form>
        </div>
      </div>

      <div class="userGender">
        <p>성별</p>　<p>${user.userGender}</p>
      </div>

      <script>
        let currentPwd = document.querySelector("#currentPwd");
        let newPwd1 = document.querySelector("#newPwd1");
        let newPwd2 = document.querySelector("#newPwd2");
        let newPhone = $('#newPhone')[0];
        let newName = $('#newName')[0];
        let email1 = $('#userEmailArr')[0];
        let email2 = $('#selectedEmail')[0];

        let msgPwd = document.querySelector("#msgPwd");
        let msgPwd2 = document.querySelector("#msgPwd2");
        let msgName = $('#msgName')[0];
        let msgEmail = $('#msgEmail')[0];

        let RAP = $('#roadAddrPart1')[0];
        let AD = $('#addrDetail')[0];
        let ZN = $('#zipNo')[0];

        // 주소 우편번호 팝업창 api
        function goPopup(){
          let url = "/meal/addr?userId=${sessionScope.userId}";
          let pop = window.open(url,"pop","width=570,height=420, scrollbars=yes, resizable=yes");
        }

        function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo){
          RAP.value = roadAddrPart1+roadAddrPart2;
          AD.value = addrDetail;
          ZN.value = zipNo;
        }

        //핸드폰 입력값 검사
        $('#phoneComplete')[0].addEventListener('click', function (){
          let test = /^[0-9]{3}-[0-9]{4}-[0-9]{4}/;
          let test2 = newPhone.value;
          if(test.test(test2) && test2.length==13){
            $('#phoneForm').submit();
          }else{
            msgPhone.innerHTML = "010-0000-0000 형식이어야 합니다.";
            newPhone.focus();
          }
        })

        //주소 입력값 검사
        $('#addrComplete')[0].addEventListener('click', function (){
          if(AD.value != ''){
            $('#addrForm').submit();
          }else{
            msgAddr.style.display = 'block'
            msgAddr.innerHTML = "주소를 확인해주세요.";
            ZN.focus();
          }
        })

        //이름 바꿀때
        $('#nameComplete')[0].addEventListener('click', function (){
          let test = /[!?@#$%^&*():;+-=~{}<>\_\[\]\|\\\"\'\,\.\/\`\₩]/g;
          let test2 = newName.value;
          if(test.test(test2)){
            msgName.innerHTML = "특수문자가 있어선 안됩니다.";
            newName.focus();
            return;
          }
          if(test2.length < 1 || test2.length > 10){
            msgName.innerHTML = "1~10자 이내로 입력하셔야 합니다.";
            newName.focus();
            return;
          }
          $('#nameForm').submit();
        })

        //이메일 세팅
        selectEmail.addEventListener('change', function (e) {
          selectedEmail.setAttribute('value', e.target.value);
        });

        //이메일 바꿀때
        $('#emailComplete')[0].addEventListener('click', function (){
          if(email1.value == '' || email2.value == ''){
            msgEmail.innerHTML = "이메일을 확인해주세요";
            email1.focus();
          }else{
            $('#emailForm').submit();
          }
        })

        document.getElementsByTagName("main")[0].addEventListener('click', function (e) {
          if (e.target.getAttribute('type') != 'button') return;
          if(e.target.value == '취소'){
            $('.'+e.target.id.replace("Cancel", ""))[0].classList.remove('hidden');
            $('.'+e.target.id.replace("Cancel", ""))[1].classList.add('hidden');
            clearMsg();
          }else if(e.target.value == '완료'){
            return;
          }else{
            clearMsg();
            visible(e.target);
          }
        })

        function visible(object) {
          $('.'+object.className)[1].classList.remove('hidden');
          hidden(object.className);
          object.classList.add('hidden');
        }

        document.querySelector("#pwdComplete").addEventListener('click',function(){
          //신규 비밀번호 형식이 안맞을경우
          let reg = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/g;
          let txt =  newPwd1.value;
          if( !reg.test(txt) ) {
            msgPwd.innerHTML = "8자 이상 숫자,특수문자,영문자가 하나씩 포합되어야합니다.";
            msgPwd2.innerHTML = "";
            newPwd1.focus();
            return;
          }
          //현재 비밀번호와 신규비밀번호가 같을경우
          if (currentPwd.value == newPwd1.value){
            msgPwd.innerHTML = "현재비밀번호와 신규비밀번호가 같습니다.";
            msgPwd2.innerHTML = "";
            newPwd1.focus();
            return;
          }
          //신규비밀번호 안맞을경우
          if (newPwd1.value!=newPwd2.value){
            msgPwd.innerHTML = "";
            msgPwd2.innerHTML = "신규 비밀번호와 값이 다릅니다";
            newPwd2.focus();
            return;
          }
          $.ajax({
            type:'POST',
            url: '/meal/update/userPwd',
            headers: {"content-type":"apllication/json"},
            dataType: 'text',
            data:JSON.stringify(currentPwd.value+"/"+newPwd1.value),
            success: function (result){
              if(result==0) alert("비밀번호가 변경되지 않았습니다.")
              if(result==1) alert("비밀번호가 변경되었습니다.")
              if (result==2) {
                currentPwd.focus();
                msgPwd.innerHTML = "현재 비밀번호가 맞지 않습니다";
                msgPwd2.innerHTML = "";
              }
              else {
                $('.pwd')[0].style.display = 'inline-block'
                $('.pwd')[1].style.display = 'none'
              }
            },
            error: function(){alert("error : ")}
          })
        });
        function hidden(name) {
          $('.pwd')[0].classList.remove('hidden');
          $('.name')[0].classList.remove('hidden');
          $('.email')[0].classList.remove('hidden');
          $('.phone')[0].classList.remove('hidden');
          $('.addr')[0].classList.remove('hidden');
          $('.pwd')[1].classList.add('hidden');
          $('.name')[1].classList.add('hidden');
          $('.email')[1].classList.add('hidden');
          $('.phone')[1].classList.add('hidden');
          $('.addr')[1].classList.add('hidden');
          $('.'+name)[1].classList.remove('hidden');
        }

        function clearMsg(){
          msgName.innerHTML = '';
          msgAddr.innerHTML = '';
          msgPwd.innerHTML = '';
          msgPhone.innerHTML = '';
          msgEmail.innerHTML = '';
        }
      </script>

    </div>
  </div>
</main>
<jsp:include page="../include/footer.jsp" flush="false" />
</body>
</html>