<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<main class="main-content  mt-0">
	<div
		class="page-header align-items-start min-vh-50 pt-5 pb-11 m-3 border-radius-lg"
		style="background-image: url('/resources/image/laptop.jpg');">
		<span class="mask bg-gradient-dark opacity-6"></span>
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-lg-5 text-center mx-auto">
					<h1 class="text-white mb-2 mt-5">Welcome!</h1>
					<h5 class="text-white mb-2 mt-5">GruOffice</h5>
					<p class="text-lead text-white">시간과 장소에 얽매이지 않고 언제 어디에서나!</p>
					<p class="text-lead text-white">조직의 업무 환경을 더 효율적이고 편리하게</p>
				</div>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row mt-lg-n10 mt-md-n11 mt-n10 justify-content-center">
			<div class="col-xl-6 col-lg-5 col-md-7 mx-auto">
				<div class="card z-index-0 my-5 py-3">
					<div class="card-header text-center pt-4 mx-2 mt-2">
						<table class="mx-auto">
							<tr>
								<td width=""><img class="mx-3 mt-2 mb-2"
									style="width: 120px; height: 120px; float: left;"
									src="/resources/image/logo6.png" alt="bear-logo.png" /></td>
								<td>
									<h3>${title}</h3>
									<div class="card-body text-center">
										<h4>${msg}</h4>
										<a href="/main" class="btn bg-gradient-info w-70 my-4 mb-2" style="font-size : 1.2em;">로그인하러 가기</a>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<h5>GruOffice</h5>
								</td>
								<td>
								</td>
							</tr>
						</table>
						<hr class="horizontal dark mt-0 mb-0">
						<div class="text-center w-50 mx-auto">
<!-- 							<a href="/login" class="btn bg-gradient-info w-100 my-4 mb-2">로그인하러 가기</a> -->
						</div>
					</div>
					<div class="mt-2 position-relative text-center">
						<!-- 						<p -->
						<!-- 							class="text-sm font-weight-bold mb-2 text-secondary text-border d-inline z-index-2 bg-white px-3"></p> -->
					</div>

				</div>
			</div>
		</div>
	</div>
</main>
