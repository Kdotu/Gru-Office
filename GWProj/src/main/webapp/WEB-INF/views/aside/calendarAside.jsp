<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="card position-sticky top-1">
	<ul class="nav flex-column bg-white border-radius-lg p-3">
		<li class="nav-item">
			<div class="icon me-2">
				<img alt="" src="/resources/image/address.png" style="width: 20px;">
			</div> <span class="text-lg">일정</span>
			<hr class="horizontal dark mt-0">
		</li>
		<li>
			<ul class="nav flex-column bg-white border-radius-lg p-2 mt-0 pt-0">
				<li class="nav-item pb-2"><a href="#"><span class="text-xl"><b>내
								캘린더</b></span></a></li>
				<li class="nav-item"><a class="nav-link text-body"
					data-scroll="" href="#2">
						<div class="icon me-2"></div> <span class="text-sm keepAll">내
							일정</span>
				</a></li>
				<li class="nav-item"><a class="nav-link text-body"
					data-scroll="" href="#2">
						<div class="icon me-2"></div> <span class="text-sm keepAll">비밀
							일정</span>
				</a></li>
				<li class="nav-item pb-2"><a href="#"><span class="text-xl"><b>관심
								캘린더</b></span></a> <a href=""> + 사원추가</a></li>

				<li class="nav-item pb-2"><a href="#"><span class="text-xl"><b>등록자별</b></span></a>
					<div class="input-group mx-auto">
						<label class="checkbox-inline"><input class='filter'
							type="checkbox" value="김삼밥" checked>김삼밥</label><br /> <label
							class="checkbox-inline"><input class='filter'
							type="checkbox" value="다현" checked>다현</label><br /> <label
							class="checkbox-inline"><input class='filter'
							type="checkbox" value="사나" checked>사나</label><br /> <label
							class="checkbox-inline"><input class='filter'
							type="checkbox" value="나연" checked>나연</label><br /> <label
							class="checkbox-inline"><input class='filter'
							type="checkbox" value="지효" checked>지효</label>
					</div></li>
			</ul>
		</li>
	</ul>
</div>