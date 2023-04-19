<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
.form-label{
font-size: 1.0em; 
}
</style>



<sec:authorize access="isAuthenticated()">
	<!-- CustomUser.java에서 private EmpVO empVO() 멤버변수를 principal 객체를 통해 사용 가능 -->
	<sec:authentication property="principal.empVO" var="empVO" />
</sec:authorize>


<div class="row">
<div class="col-2">
		<jsp:include page="/WEB-INF/views/aside/workAside.jsp" />
</div>
<div class="col-9" style="margin-left:30px;">
<div class="col-lg-9 mt-lg-0 mt-4">
	
	<div class="card card-body" id="profile">
		<div class="row justify-content-start align-items-start" >
			<div class="col-sm-auto col-4" >
						<c:choose>
							<c:when test="${not empty empVO.fileGrVO.fileGroupNo}">
								<img
									src="/resources/upload${empVO.fileGrVO.filesList[0].fileStrgNm}"
									class="w-100 border-radius-lg shadow-sm" alt="team-2"
									style="width: 200px; height: 100px;">
							</c:when>
							<c:otherwise>
								<img src="/resources/upload/emp/profile/default.png"
									class="w-100 border-radius-lg shadow-sm" alt="team-2"
									style="width: 200px; height: 100px;">
							</c:otherwise>
						</c:choose>
					</div>
			<div class="col-sm-auto col-8 my-auto" >
				<div class="h-100" >
					<h4 class="mb-1 font-weight-bolder">${empVO.empNm }</h4>
					<p class="mb-0 font-weight-bold" style="font-size:1.2em;">${empVO.jbpsNm } &nbsp; / ${empVO.deptNm }</p>
				</div>
			</div>
		</div>
	</div>

	<div class="card mt-4" id="basic-info">
		<div class="card-header">
			<h4>기본정보</h4>
		</div>
		<div class="card-body pt-0">
			<div class="row">
				<div class="col-6">
					<label class="form-label" style="font-size:1.3em;">소속</label>
					<div class="input-group">
						<p style="font-size:1.2em;">그루IT</p>
					</div>
				</div>
				<div class="col-6">
					<label class="form-label" style="font-size:1.3em;">사번</label>
					<div class="input-group">
					<p style="font-size:1.2em;">${empVO.empNo }</p>
					</div>
				</div>
			</div>
			
			<div class="row">
				
				<div class="col-6">
					<label class="form-label mt-4" style="font-size:1.3em;">직책</label>
					<div class="input-group">
					<p style="font-size:1.2em;">${empVO.jbpsNm }</p>
					</div>
				</div>
				<div class="col-6">
					<label class="form-label mt-4" style="font-size:1.3em;">이메일</label>
					<div class="input-group">
					<p style="font-size:1.2em;">${empVO.empEmlAddr }</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="col-lg-9 mt-lg-0 mt-4">
	
	<div class="card mt-4" id="basic-info">
		<div class="card-header">
			<h4>부가정보</h4>
		</div>
		<div class="card-body pt-0">
			<div class="row">
				<div class="col-6">
					<label class="form-label" style="font-size:1.3em;">내선번호</label>
					<div class="input-group">
					<p style="font-size:1.2em;">${empVO.empCoTelno }</p>
					</div>
				</div>
				<div class="col-6">
					<label class="form-label" style="font-size:1.3em;">입사일</label>
					<div class="input-group">
					<p style="font-size:1.2em;"><fmt:formatDate value="${empVO.empJncmpYmd}" pattern="yyyy-MM-dd" /></p>
					</div>
				</div>
			</div>
			
			<div class="row">
				
				<div class="col-6">
					<label class="form-label mt-4" style="font-size:1.3em;">연락처</label>
					<div class="input-group">
					<p style="font-size:1.2em;">${empVO.empMblTelno }</p>
					</div>
				</div>
				<div class="col-6">
					<label class="form-label mt-4" style="font-size:1.3em;">부서</label>
					<div class="input-group">
					<p style="font-size:1.2em;">${empVO.deptNm }</p>
					</div>
				</div>
			</div>
			<div class="row">
				
				<div class="col-6">
					<label class="form-label mt-4" style="font-size:1.3em;">생년월일</label>
					<div class="input-group">
						<p style="font-size:1.2em;"><fmt:formatDate value="${empVO.empBrdt}" pattern="yyyy-MM-dd" /></p>
					</div>
				</div>
				<div class="col-6">
					<label class="form-label mt-4" style="font-size:1.3em;">재직상태</label>
					<div class="input-group">
						<c:if test="${empVO.empHdofYn  eq 'HDOF0001'}">
						<p style="font-size:1.2em;">재직</p>
						</c:if>
						<c:if test="${empVO.empHdofYn  eq 'HDOF0002'}">
						<p style="font-size:1.2em;">퇴사</p>
						</c:if>
					</div>
				</div>
			</div>
			
			<div class="row">
				
				<div class="col-6">
					<label class="form-label mt-4" style="font-size:1.3em;">성별</label>
					<div class="input-group">
					
					<c:if test="${empVO.empGender  eq 'GENDER0001'}">
					<p style="font-size:1.2em;">남성</p>
					</c:if>
					<c:if test="${empVO.empGender  eq 'GENDER0002'}">
					<p style="font-size:1.2em;">여성</p>
					</c:if>
					
					</div>
				</div>
				<div class="col-6">
					<label class="form-label mt-4" style="font-size:1.3em;">퇴사일</label>
					<div class="input-group">
					
						<c:if test="${empVO.empRsgntnYmd eq null }">
						<p style="font-size:1.2em;">-</p>
						</c:if>
						<c:if test="${empVO.empRsgntnYmd ne null }">
						<p style="font-size:1.2em;"><fmt:formatDate value="${empVO.empRsgntnYmd}" pattern="yyyy-MM-dd" /></p>
						</c:if>
					</div>
				</div>
			</div>
			
			<div class="row">
				
				<div class="col-12">
					<label class="form-label mt-4" style="font-size:1.3em;">주소</label>
					<div class="input-group">
					  <p style="font-size:1.2em;">${empVO.empAddr } &nbsp;&nbsp; ${empVO.empDaddr }</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</div>
</div>