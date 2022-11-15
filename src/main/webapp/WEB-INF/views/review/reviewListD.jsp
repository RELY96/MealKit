<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>reviewList</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script>
        // ** 상세페이지 Detail 바로 밑 출력 Json
        function reviewDetailD(e, reviewNo, itemNo, count) {

            console.log('*** e.type =>'+e.type);
            console.log('*** e.target =>'+e.target);

            $('#resultArea2').html(''); //클릭 시 resultArea2 클리어

            if( $('#'+count).html()=='' ) {
                $.ajax({
                    type: 'Get',
                    url: 'reviewDetailD?reviewNo='+reviewNo+"&itemNo="+itemNo,
                    success: function(resultData){

                        $('.reviewD').html('');
                        $('#'+count).html(resultData.reviewContent);
                    },
                    error: function(){
                        $('#resultArea2').html('서버 오류. 다시 시도하시기 바랍니다.');
                    }
                });
            } else {
                $('#'+count).html('');
            }
        } //reviewDetailD
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
    <section class="section_container">
        <table>
            <tr>
                <th>이미지 미리보기</th>
                <th colspan="2">제목</th>
                <th>아이디</th>
            </tr>
            <c:if test="${not empty reviewResult}">
                <c:forEach var="review" items="${reviewResult}" varStatus="reviewVs">
                    <tr>
                        <c:if test="${not empty review.imgName}">
                            <td><img src="${review.imgName}" width=50 height=50></td>
                        </c:if>

                        <c:if test="${review.reviewStep < 1}">
                            <td colspan="2">
                                <a href="javascript:;"
                                   onclick="reviewDetailD(event, ${review.reviewNo}, ${review.itemNo}, ${reviewVs.count})">${review.reviewTitle}</a>
                            </td>
                        </c:if>

                        <!-- Step > 0 이면 관리자가 단글 -> 여기만 &nbsp; 적용 & colspan 3  -->
                        <c:if test="${review.reviewStep > 0}">
                            <td colspan="3" text-align="right">
                                <a href="javascript:;"
                                   onclick="reviewDetailD(event, ${review.reviewNo}, ${review.itemNo}, ${reviewVs.count})">&nbsp;&nbsp;ㄴ답변&nbsp;${review.reviewTitle}</a>
                            </td>
                        </c:if>
                        <td>${review.userId}</td>
                    </tr>
                    <tr>
                        <td colspan="4"><span class="reviewD resultArea" id="${reviewVs.count}"></span></td>
                    </tr>
                    <tr hidden>
                        <td>${review.itemNo}</td>
                    </tr>
                    <br>
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

                <a href="reviewlistD${pageMaker.searchQuery(1)}" class="firstBtn">◀◀</a>&nbsp;
                <a href="reviewlistD${pageMaker.searchQuery(pageMaker.spageNo-1)}" class="forwardBtn">&lt;</a>&nbsp;&nbsp;
                <!-- 앞으로가기 : 현재페이지의 이전 그룹(spage-1)
                => rowsPerPage는 그대로, currPage=spage-1 : EL로 기재 -->
            </c:when>
            <c:otherwise>
                <span class="firstBtn none">◀◀&nbsp;&nbsp;&lt;&nbsp;</span>
            </c:otherwise>
        </c:choose>

        <!-- 2. Display PageNo - 반복문 begin(spage)-end(epage)(범위지정) 사용
              : ver01.pageMaker.makeQuery / ver02.searchQuery -->
        <c:forEach var="i" begin="${pageMaker.spageNo}" end="${pageMaker.epageNo-1}">
            <!-- currPage 는 cri안에 있으니까 .cri로 부르기
            i가 현재페이지라면(현재page 가 현재page라면) -->
            <c:if test="${i==pageMaker.cri.currPage}">
                <!-- 현재페이지 표식 -->
                <span class="currPage">${i}</span>&nbsp;
            </c:if>

            <c:if test="${i!=pageMaker.cri.currPage}">
                <!-- i가 현재페이지가 아닐 때 - 클릭하면 넘어가야 하니까 a href
                현재페이지 param으로 controller에 넣어줘서 기준 주고, controll동작하게 하기-->
                <a href="reviewlistD${pageMaker.searchQuery(i)}">${i}</a>
            </c:if>
        </c:forEach>

        <!-- 3. Next, Last button: ver01.pageMaker.makeQuery / ver02.SearchQuery -->
        <c:choose>
            <c:when test="${pageMaker.next && pageMaker.epageNo>0}">
                <a href="reviewlistD${pageMaker.searchQuery(pageMaker.epageNo+1)}" class="backBtn">&nbsp;&nbsp;&gt;</a>
                <!-- 뒤로가기 : 현재 페이지의 다음그룹
                => rowsPerPage는 그대로, currPage=epage+1 -->
                <a href="reviewlistD${pageMaker.searchQuery(pageMaker.lastPageNo)}" class="lastBtn">▶▶</a>
                <!-- lastPage는 pageMaker에서 계산해놨으니까 그대로 넣어주기 -->
            </c:when>
            <c:otherwise>
                <span class="lastBtn none">&nbsp;&gt;&nbsp;&nbsp;▶▶</span>
            </c:otherwise>
        </c:choose>
    </div>
</main>
</body>
</html>
