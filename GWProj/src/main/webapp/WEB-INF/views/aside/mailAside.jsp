<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${stat ne 'addrMail' }">
<div class="card position-sticky top-1" style="height: 100%;">
	<div class="mt-2 mb-2 mx-2 pb-2 px-2 pt-2">
		<h4><img class="img" alt="" src="/resources/maincss/assets/img/mail.png" style="width: 27px; margin: 10px; margin-top: 3px;">메일함</h4>
	</div>
	<ul
		class="nav flex-column bg-white border-radius-lg p-1 px-2 pb-2 pt-0 mt-0">
		<li class="nav-item mx-auto w-100" style="align-content: center;">
			<a class="btn btn-info w-100 " href="/mail/write" style="font-size: 1.2em;">
				<i class="ni ni-email-83 px-2"></i>메일 쓰기 
			</a>
		</li>
		<!-- 태그 시작 -->
		<li class="nav-item" style="margin-top: 15px;">
			<div style="margin-left: 10px;">
				<h5><i class="ni ni-tag"></i>&nbsp;&nbsp;&nbsp;태그</h5>
			</div>
			<div>
				<ul class="nav flex-column bg-white border-radius-lg p-3 pt-0">
					<li class="nav-item p-0">
						<a class="nav-link text-body text-center" data-scroll="" href="/mail/managementTag">
							<i class="ni ni-tag" style="color: red"></i> <span class="text-lg">경영자료</span>
						</a>
					</li>
					<li class="nav-item p-0">
						<a class="nav-link text-body text-center" data-scroll="" href="/mail/referenceTag">
							<i class="ni ni-tag" style="color: green"></i> <span class="text-lg">참고자료</span>
						</a>
					</li>
					<li class="nav-item p-0">
						<a class="nav-link text-body text-center" data-scroll="" href="/mail/accontingTag">
							<i class="ni ni-tag" style="color: purple"></i> <span class="text-lg">회계자료</span>
						</a>
					</li>
				</ul>
			</div>
		</li>
		<!-- 태그 끝 -->
		<!-- 메일함 시작 -->
		<li class="nav-item">
			<div style="margin-left: 10px;">
				<h5><i class="ni ni-email-83"></i>&nbsp;&nbsp;&nbsp;메일함</h5>
			</div>
			<div>
				<ul class="nav flex-column bg-white border-radius-lg p-3 pt-0">
					<li class="nav-item p-0"><a
						class="nav-link text-body text-center" data-scroll="" href="/mail/recieveList">
							<img src="/resources/image/rmail.png" style="width: 18px; margin-right: 5px;" /> <span class="text-lg">받은메일함</span>
					</a></li>
					<li class="nav-item p-0"><a
						class="nav-link text-body text-center" data-scroll="" href="/mail/send">
							<img src="/resources/image/smail.png" style="width: 20px; margin-right: 5px;"/> <span class="text-lg">보낸메일함</span></a>
					</li>
					<li class="nav-item p-0"><a
						class="nav-link text-body text-center" data-scroll="" 
						href="
<!-- 						/mail/importantEml -->
						">
							<img src="/resources/image/star.png" style="width: 20px; margin-right: 5px;"/> <span class="text-lg">중요메일함</span>
					</a></li>
					<li class="nav-item p-0"><a
						class="nav-link text-body text-center" data-scroll="" href="/mail/trash">
							<img src="/resources/image/trash3.svg" class="px-2" style="margin-left: -28px;"/> <span class="text-lg">휴지통</span>
					</a></li>
				</ul>
			</div>
		</li>
		<!-- 메일함 끝 -->
	</ul>
</div>
</c:if>