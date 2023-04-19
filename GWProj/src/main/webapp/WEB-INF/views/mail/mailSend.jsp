<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/mailAside.jsp" />
		</div>
		<div class="col-lg-9 ">
			<div class="card">
				<div align="center">
					<img alt="" src="/resources/image/plane.png" style="width: 200px; margin-bottom: 30px; margin-top: 200px;">
					<h4>메일을 성공적으로 보냈습니다.</h4>
					<br/>
					<a href="/mail/recieveList" style="font-size: 1.2em;">받은메일함 가기</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;
					<a href="/mail/write" style="font-size: 1.2em;">메일쓰기</a>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
				</div>
			</div>
		</div>
	</div>
</div>





