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
		<li class="nav-item"><a class="nav-link text-body" data-scroll=""
				href="<c:choose><c:when test='${not empty authority}'>/admin/admNoticeList</c:when><c:otherwise>/board/totalList</c:otherwise></c:choose>">
				<div class="icon me-2">
					<img alt="" src="/resources/image/board.png" style="width: 20px;">
				</div> <span class="h4">게시판</span>
				<hr class="horizontal dark mt-0" />
		</a></li>
		<li class="nav-item mx-auto">
<!-- 			<a href="/board/write" class="btn btn-lg btn-info w-100">게시글 등록</a> -->
			<div class="dropdown">
					<button class="btn bg-gradient-dark dropdown-toggle" type="button" id="dropdownMenuButton"
						data-bs-toggle="dropdown" aria-expanded="false" style="font-size: 1.1em; background: #17c1e8; width: 205px; height: 50px;">
				    	게시글 등록
					</button>
					<div class="dropdown-menu" aria-labelledby="dropdownMenuButton" style="width: 250px;">
						<p style="color: gray; text-align: center; margin-top: 10px;">게시글등록</p>
						<hr class="hr1">
						<div id="bookMark"></div>
							<c:if test="${authority eq 'admin'}">
<%-- 						 <c:forEach var="AuthrtVO" items="${empVO.empAuthVOList}" > --%>
<%-- 	           				 <c:if test="${AuthrtVO.authrtNm == 'AUTH_ADMIN'}"> --%>
									<div style="margin-left: 27px;">
										<a class="dropdown-item h5 text-dark" href="/admin/noticeBWrite">공지게시판</a>
									</div>
<%-- 							 </c:if> --%>
<%-- 						 </c:forEach> --%>
							</c:if>

							<div style="margin-left: 27px;">
								<a class="dropdown-item text-lg" href="/board/wholBWrite">전사게시판</a>
							</div>
							<div style="margin-left: 27px;">
								<a class="dropdown-item text-lg" href="/board/depBWrite">부서게시판</a>
							</div>
					</div>
				</div>
		<!-- 	<button class="btn btn-lg btn-info w-100">게시글 등록</button> -->
		</li>
		<li>
			<!-- 			<div style="margin-left: 20px;">전체게시판</div> -->
			<!-- 사용자/관리자 경로 다르게줌 -->
			<ul class="nav flex-column bg-white border-radius-lg p-2 mt-0 pt-0">
				<li class="nav-item pt-2">
					<a class="nav-link text-body" data-scroll="" href="<c:choose><c:when test='${not empty authority}'>/admin/admNoticeList</c:when><c:otherwise>/board/noticeBList</c:otherwise></c:choose>">
						<div class="icon me-2"></div> <span class="text-lg keepAll">공지게시판</span>
					</a>
				</li>
				<li class="nav-item pt-2">
					<a class="nav-link text-body" data-scroll="" href="<c:choose><c:when test='${not empty authority}'>/admin</c:when><c:otherwise>/board</c:otherwise></c:choose>/wholBList">
						<div class="icon me-2"></div> <span class="text-lg keepAll">전사게시판</span>
					</a>
				</li>
				<li class="nav-item pt-2">
					<a class="nav-link text-body"data-scroll="" href="<c:choose><c:when test='${not empty authority}'>/admin</c:when><c:otherwise>/board</c:otherwise></c:choose>/depBList">
						<div class="icon me-2"></div> <span class="text-lg keepAll">부서게시판</span>
					</a>
				</li>
				<c:if test='${empty authority}'>
					<li class="nav-item pt-2">
						<a class="nav-link text-body" data-scroll="" href="/board/myList">
							<div class="icon me-2"></div> <span class="text-lg keepAll">내가 쓴 글</span>
						</a>
					</li>
				</c:if>
			</ul>
		</li>
	</ul>
</div>