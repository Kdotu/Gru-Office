<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<style>
.hr1{
	height: 2px;
	background-color: gray;
	margin: 5px;
}
</style>

<sec:authorize access="isAuthenticated()">
	<!-- CustomUser.java에서 private EmpVO empVO() 멤버변수를 principal 객체를 통해 사용 가능 -->
	<sec:authentication property="principal.empVO" var="empVO" />
</sec:authorize>

<div class="card position-sticky top-1">
	<ul class="nav flex-column bg-white border-radius-lg p-3">
		<li class="nav-item pt-2">
			<a class="nav-link text-body" data-scroll="" href="<c:choose><c:when test='${not empty authority}'>/admin/srvyMain</c:when><c:otherwise>/survey/main</c:otherwise></c:choose>">
				<div class="icon me-2">
					<img class="img mb-2" src="/resources/maincss/assets/img/survey.png" style="width: 25px;">
				</div><span class="h4 text-dark" style="margin-left : 5px;">설문조사</span>
				<hr class="horizontal dark mt-0">
			</a>
		</li>
		<li class="nav-item">
			<a href="<c:choose><c:when test='${not empty authority}'>/admin/srvyCreate</c:when><c:otherwise>/survey/create</c:otherwise></c:choose>" class="btn btn-lg btn-info w-100" style="font-size: 1.1em;">설문 등록</a>
		</li>
		<li>
			<ul class="nav flex-column bg-white border-radius-lg p-2 mt-0 pt-0 pb-0 mb-0">
				<li class="nav-item mt-0 pt-0">
					<a class="nav-link text-body" data-scroll="" href="<c:choose><c:when test='${not empty authority}'>/admin/srvyList</c:when><c:otherwise>/survey/list</c:otherwise></c:choose>">
						<div class="icon me-2"></div> <span class="text-lg keepAll">전체 설문</span>
					</a>
				</li>
			</ul>
			<ul class="nav flex-column bg-white border-radius-lg p-2 mt-0 pt-0">

				<li class="nav-item<c:if test='${not empty authority}'>pt-2</c:if>">
				<c:if test="${authority ne 'admin'}">
					<a class="nav-link text-body" data-scroll="" href="/survey/list?status=enroll">
						<div class="icon me-2"></div> <span class="text-lg keepAll">등록한 설문</span>
					</a>
				</li>
				</c:if>
				<!-- 관리자 -->
				<c:choose>
					<c:when test='${empty authority}'>
						<li class="nav-item">
							<a class="nav-link text-body" data-scroll="" href="/survey/list?status=reply">
								<div class="icon me-2"></div> <span class="text-lg keepAll">답변한 설문</span>
							</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="nav-item">
							<a class="nav-link text-body" data-scroll="" href="/admin/srvyManage">
							<div class="icon me-2"></div> <span class="text-lg keepAll">태그 관리</span>
							</a>
						</li>
					</c:otherwise>
				</c:choose>
			</ul></li>
	</ul>
</div>