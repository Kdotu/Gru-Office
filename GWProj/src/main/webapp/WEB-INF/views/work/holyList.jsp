<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<script>

$(function(){
	
//연차 정보가져오는 ajax
$.ajax({
	url:"/work/getHoliInfo",
	type:"post",
	beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
           xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	},
	success:function(result){
		
	str = "";
	
	str+="	<table class='table align-items-center mb-0'>                                                               ";
	str+="	<thead>                                                                                                     ";
	str+="	<tr>                                                                                                        ";
	str+="	<th class='text-uppercase text-secondary font-weight-bolder' style='font-size:1.2em;'>이름</th>                    ";
	str+="	<th class='text-uppercase text-secondary font-weight-bolder'  style='font-size:1.2em;'>부서명</th>             ";
	str+="	<th class='text-uppercase text-secondary font-weight-bolder'  style='font-size:1.2em;'>휴가종류</th>           ";
	str+="	<th class='text-uppercase text-secondary font-weight-bolder'  style='font-size:1.2em;'>연차 사용기간</th>";
	str+="	<th class='text-uppercase text-secondary font-weight-bolder'  style='font-size:1.2em;'>사용 연차</th>   ";
	str+="	</tr>                                                                                                       ";
	str+="	</thead>                                                                                                    ";
	str+="	<tbody>                                                                                                     ";
	$.each(result,function(i,v){
		str+="	<tr>                                                               ";
		str+="	<td>                                                               ";
		str+="	<div class='d-flex px-2 py-1'>                                     ";
		str+="	<div class='d-flex flex-column justify-content-center'>            ";
		str+="	<h6 class='mb-0' style='font-size:1.1em;'>"+v.EMP_NM+"</h6>                      ";
		str+="	</div>                                                             ";
		str+="	</div>                                                             ";
		str+="	</td>                                                              ";
		str+="	<td>                                                               ";
		str+="	<p class='mb-0'  style='font-size:1.1em;'>"+v.DEPT_NM+"</p>        ";
		str+="	</td>                                                              ";
		str+="	<td>                                                               ";
		str+="	<span class='badge badge-dot me-4'>                                ";
		str+="	<span class='text-dark'  style='font-size:1.4em; margin-left:20px;'>"+v.HOLI_CLSF+"</span>                 ";
		str+="	</span>                                                            ";
		str+="	</td>                                                              ";
		str+="	<td class='align-middle text-center text-sm'>                      ";
		str+="	<p class='mb-0'  style='font-size:1.4em;  margin-left:-80px;'>"+v.HOLI_BGNG_YMD+"~"+v.HOLI_END_YMD+"</p>   ";
		str+="	</td>                                                              ";
		str+="	<td class='align-middle text-center'>                              ";
		str+="	<span class=''  style='font-size:1.4em; margin-left:-110px;'>"+v.HOLI_APLY_CNT+"</span>                      ";
		str+="	</td>                                                              ";
		str+="	</tr>                                                              ";
	})
	str+="</tbody>";
	str+="</table>";
	
	$('#holiday').append(str); 
	

	}
	
	});
});


</script>


<sec:authorize access="isAuthenticated()">
	<!-- CustomUser.java에서 private EmpVO empVO() 멤버변수를 principal 객체를 통해 사용 가능 -->
	<sec:authentication property="principal.empVO" var="empVO" />
</sec:authorize>


<div class="row">
	<div class="col-2">
		<jsp:include page="/WEB-INF/views/aside/workAside.jsp" />
	</div>
	<div class="col-10">
		<div class="container-fluid py-4">
					<div class="row">
						<div class="col-lg-4 col-md-4 col-12">
							<div class="card"
								style="background-image: url('/resources/maincss/assets/img/curved-images/white-curved.jpeg')">
								<span class="mask bg-gradient-dark opacity-9 border-radius-xl"></span>
								<div class="card-body p-3 position-relative"
									style="height: 158px;">
									<div class="row" style="margin-top: 30px;">
										<div class="col-4 text-end" style="margin-top: 17px;">
									<c:choose>
										<c:when test="${not empty empVO.fileGrVO.fileGroupNo}">
											<img
												src="/resources/upload/emp/profile/noface.png"
												class="w-100 border-radius-lg shadow-sm" alt="team-2"
												style="margin-top:-30px; width:30px; height:100px;">
										</c:when>
										<c:otherwise>
											<img src="/resources/upload/emp/profile/default.png"
												class="w-100 border-radius-lg shadow-sm" alt="team-2"
												style="margin-top:-30px; width:30px; height:100px;">
										</c:otherwise>
									</c:choose>
								</div>
										<div class="col-8 text-start">
											<h3 class="text-white font-weight-bolder mb-0 mt-3">${empVO.empNm }&nbsp;&nbsp; ${empVO.jbpsNm }</h3>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-2 col-md-2 col-12">
							<div class="card"         
								style="background-image: url('/resources/maincss/assets/img/curved-images/white-curved.jpeg')">
								<span class="mask bg-gradient-info  opacity-9 border-radius-xl"></span>
								<div class="card-body p-3 position-relative"
									style="height: 158px;">
									<div class="row">
										<div class="col-12 text-center">
											<h4 class="text-white font-weight-bolder mb-0 mt-3">발생 연차</h4>
											<span id="state1" countTo="15" class="text-white" style="font-size: 2.5em; font-weight: lighter;"></span>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-2 col-md-2 col-12">
							<div class="card"         
								style="background-image: url('/resources/maincss/assets/img/curved-images/white-curved.jpeg')">
								<span class="mask bg-gradient-info  opacity-9 border-radius-xl"></span>
								<div class="card-body p-3 position-relative"
									style="height: 158px;">
									<div class="row">
										<div class="col-12 text-center">
											<h4 class="text-white font-weight-bolder mb-0 mt-3">발생 월차</h4>
											<span id="state2" countTo="0" class="text-white" style="font-size: 2.5em; font-weight: lighter;"></span>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-2 col-md-2 col-12">
							<div class="card"         
								style="background-image: url('/resources/maincss/assets/img/curved-images/white-curved.jpeg')">
								<span class="mask bg-gradient-info  opacity-9 border-radius-xl"></span>
								<div class="card-body p-3 position-relative"
									style="height: 158px;">
									<div class="row">
										<div class="col-12 text-center">
											<h4 class="text-white font-weight-bolder mb-0 mt-3">사용 연차</h4>
											<c:set var="count" value="${15-empVO.empCrtHoli}"></c:set>
											<span id="state3" countTo=<c:out value="${count}" /> class="text-white" style="font-size: 2.5em; font-weight: lighter;"></span>
										</div>
									</div>
								</div>
							</div>
					
				</div>
				<div class="col-lg-2 col-md-2 col-12">
							<div class="card"         
								style="background-image: url('/resources/maincss/assets/img/curved-images/white-curved.jpeg')">
								<span class="mask bg-gradient-info  opacity-9 border-radius-xl"></span>
								<div class="card-body p-3 position-relative"
									style="height: 158px;">
									<div class="row">
										<div class="col-12 text-center">
											<h4 class="text-white font-weight-bolder mb-0 mt-3">잔여 연차</h4>
											<span id="state4" countTo=${empVO.empCrtHoli } class="text-white" style="font-size: 2.5em; font-weight: lighter;"></span>
										</div>
									</div>
								</div>
							</div>
					
				</div>
			</div>
			<div class="row my-4">
			<h5>사용내역</h5>
<div class="col-12">
<div class="card">
<div class="table-responsive" id="holiday">
<!-- <table class="table align-items-center mb-0"> -->
<!-- <thead> -->
<!-- <tr> -->
<!-- <th class="text-uppercase text-secondary text-sm font-weight-bolder opacity-7">이름</th> -->
<!-- <th class="text-uppercase text-secondary text-sm font-weight-bolder opacity-7 ps-2">부서명</th> -->
<!-- <th class="text-uppercase text-secondary text-sm font-weight-bolder opacity-7 ps-2">휴가종류</th> -->
<!-- <th class="text-center text-uppercase text-secondary text-sm font-weight-bolder opacity-7">연차 사용기간</th> -->
<!-- <th class="text-center text-uppercase text-secondary text-sm font-weight-bolder opacity-7">사용 연차</th> -->
<!-- </tr> -->
<!-- </thead> -->
<!-- <tbody> -->

<!-- </tbody> -->
<!-- </table> -->
</div>
</div>
</div>
</div>

<div class="row my-4">
			<h5>생성내역</h5>
<div class="col-12">
<div class="card">
<div class="table-responsive">
<table class="table align-items-center mb-0">
<thead>
<tr>
<th class='text-uppercase text-secondary font-weight-bolder' style='font-size:1.2em;'>등록일</th>
<th class='text-uppercase text-secondary font-weight-bolder' style='font-size:1.2em;'>사용기간</th>
<th class='text-uppercase text-secondary font-weight-bolder' style='font-size:1.2em;'>발생일수</th>
<th class='text-uppercase text-secondary font-weight-bolder' style='font-size:1.2em;'>내용</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<div class="d-flex px-2 py-1">
<div class="d-flex flex-column justify-content-center">
<h6 class="text-dark mb-0" style='font-size:1.1em;'>2023-<fmt:formatDate value="${empVO.empJncmpYmd}" pattern="MM-dd" var="empJncmpYmd" />${empJncmpYmd }</h6>
</div>
</div>
</td>
<td>
<p class="text-dark mb-0" style='font-size:1.1em;'>2023-12-31</p>
</td>
<td>
<span class="badge badge-dot me-4">
<span class="text-dark" style="font-size:1.4em; margin-left:20px;">15</span>
</span>
</td>
<td class="align-middle text-center">
<p class="text-dark mb-0 " style='font-size:1.1em; margin-left:-100px;'>2023년도 기준 연차 15일 생성</p>
</td>

</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
		</div>
	</div>
</div>
<script src="/resources/maincss/assets/js/plugins/datatables.js"></script>
<script src="/resources/maincss/assets/js/plugins/countup.min.js"></script>
<script>
if (document.getElementById('state1')) {
    const countUp = new CountUp('state1', document.getElementById("state1").getAttribute("countTo"));
    if (!countUp.error) {
      countUp.start();
    } else {
      console.error(countUp.error);
    }
  }
  if (document.getElementById('state2')) {
    const countUp = new CountUp('state2', document.getElementById("state2").getAttribute("countTo"));
    if (!countUp.error) {
      countUp.start();
    } else {
      console.error(countUp.error);
    }
  }
  if (document.getElementById('state3')) {
    const countUp = new CountUp('state3', document.getElementById("state3").getAttribute("countTo"));
    if (!countUp.error) {
      countUp.start();
    } else {
      console.error(countUp.error);
    }
  }
  if (document.getElementById('state4')) {
    const countUp = new CountUp('state4', document.getElementById("state4").getAttribute("countTo"));
    if (!countUp.error) {
      countUp.start();
    } else {
      console.error(countUp.error);
    }
  }
</script>