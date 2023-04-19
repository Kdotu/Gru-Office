<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- jQuery -->
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="/resources/js/jquery-3.6.3.min.js"></script>

<script src="/resources/ckeditor/ckeditor.js"></script>
<script src="/resources/maincss/assets/js/plugins/dropzone.min.js"></script>
	
<script src="../../assets/js/plugins/chartjs.min.js"></script>



<!-- 전체게시판 목록 -->
<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/boardAside.jsp" />
		</div>
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4">
			<!-- 2번째 사이드바 -->
			<!-- body_center -->

			<div class="card">
				<div class="dataTable-top">
				
				
				<div class="card mb-3">
  <div class="card-body p-3">
    <div class="chart">
      <canvas id="bar-chart" class="chart-canvas" height="300px"></canvas>
    </div>
  </div>
</div>
				
				
				
				</div>
			</div>
		</div>
	</div>
</div>



