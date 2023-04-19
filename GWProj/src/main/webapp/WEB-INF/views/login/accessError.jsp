<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<main class="main-content  mt-0">
	<div
		class="page-header align-items-start min-vh-50 pt-5 pb-11 m-3 border-radius-lg"
		style="background-image: url('/resources/image/laptop.jpg');">
		<span class="mask bg-gradient-dark opacity-6"></span>
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-lg-5 text-center mx-auto">
					<h1 class="text-white mb-2 mt-5">GruOffice</h1>
					<p class="text-lead text-white">시간과 장소에 얽매이지 않고 언제 어디에서나!</p>
					<p class="text-lead text-white">조직의 업무 환경을 더 효율적이고 편리하게</p>
				</div>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row mt-lg-n10 mt-md-n11 mt-n10 justify-content-center">
			<div class="col-xl-5 col-lg-5 col-md-7 mx-auto w-50">
				<div class="card z-index-0 mb-5">
					<div class="card-header text-center pt-4 mx-2 mt-2 mb-0"
						style="align-content: center;">
						<table class="mx-auto">
							<tr>
								<td width="">
									<img class="mx-3 mt-2 mb-2" style="width: 120px; height: 120px; float: left;"
										src="/resources/image/logo6.png" alt="bear-logo.png" /></td>
								<td> </td>
								<td> </td>
								<td> </td>
								<td>
									<h1>${msg}</h1>
									<p class="lead text-gray-800">해당 페이지에 대한 권한이 없습니다.</p>
<!-- 									<h4 class="lead text-gray-800">해당 페이지에 대한 권한이 없습니다.</h4> -->
								</td>
							</tr>
							<tr>
								<td>
									<h5>GruOffice</h5>
								</td>
								<td> </td>
								<td> </td>
								<td> </td>
								<td> </td>
							</tr>
						</table>
					</div>
					<div class="card-body">
						<div class="text-center">
						
							<p class="text-gray-500 mb-0">
<%-- 								${SPRING_SECURITY_403_EXCEPTION.getMessage()} --%>
								</p>
							<!--로그인이 되어있다면 -->
							<sec:authorize access="isAuthenticated()">
							<a href="/main" class="btn bg-gradient-info w-70 my-4 mb-2" style="font-size : 1.2em;">메인으로</a>
							</sec:authorize>
							<!--로그인이 되어있지 않다면 -->
							 <sec:authorize access="isAnonymous()">
							<a href="/main" class="btn bg-gradient-info">← 로그인하러가기</a>
							</sec:authorize>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</main>
<jsp:include page="/WEB-INF/views/tiles/footer.jsp" />