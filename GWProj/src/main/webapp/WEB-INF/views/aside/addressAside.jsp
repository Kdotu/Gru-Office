<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="card position-sticky top-1">
	<ul class="nav flex-column bg-white border-radius-lg p-3">
		<li class="nav-item mt-2">
			<img alt="" src="/resources/image/address.png" style="width: 20px;">
			<a href="/address/list"><span class="h4" style=" margin-left : 5px;">주소록</span></a>
			<hr class="horizontal dark mt-0">
		</a></li>
		<li>
			<ul class="nav flex-column bg-white border-radius-lg p-2 mt-0 pt-0">
				<li class="nav-item pb-2">
					<div class="icon me-2">
					<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-person-lines-fill text-dark" viewBox="0 0 16 16">
					  <path d="M6 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm-5 6s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zM11 3.5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1h-4a.5.5 0 0 1-.5-.5zm.5 2.5a.5.5 0 0 0 0 1h4a.5.5 0 0 0 0-1h-4zm2 3a.5.5 0 0 0 0 1h2a.5.5 0 0 0 0-1h-2zm0 3a.5.5 0 0 0 0 1h2a.5.5 0 0 0 0-1h-2z"/>
					</svg>
					</div> <a href="/address/list"><span class="text-xl h5"><b>전체 주소록</b></span></a>
				</li>
				<li class="nav-item">
					<div class="icon me-2">
					<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-star-fill text-dark mb-1" viewBox="0 0 16 16">
					  <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
					</svg>


					</div> <a href="/address/bookMarkList"><span class="text-xl keepAll h5"><b>즐겨찾는 주소록</b></span></a>
				</li>
				<!-- <li class="nav-item"><a class="nav-link text-body"
					data-scroll="" href="/address/bookMarkList">
						<div class="icon me-2"></div> <span class="text-sm">우리 부서</span>
				</a></li> -->
			</ul>

		</li>

	</ul>
</div>