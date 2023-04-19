<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

        
<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/myPageAside.jsp" />
		</div>
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4">
<!-- 상단에 들어가는 마이페이지 회원정보 시작 -->
	<jsp:include page="/WEB-INF/views/aside/myPageSection.jsp" />
<!-- 상단에 들어가는 마이페이지 회원정보 끝 -->					
		
		
		
		
<!-- 2번째 사이드바 -->
            <h5>쪽지함</h5>
          <div class="card mt-4" id="notifications">
            <div class="card-header">
              <p class="text-sm">Choose how you receive notifications. These notification settings apply to the things you’re watching.</p>
            </div>
            <div class="card-body pt-0">




            </div>
          </div>
        </div><!-- end for row의 2번째 부분 -->
      </div>
    </div>

