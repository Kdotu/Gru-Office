<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<h1>관리자페이지</h1>
<div
	class="page-header align-items-start min-vh-50 pt-5 pb-11 m-3 border-radius-lg"
	style="background-image: url('/resources/image/laptop.jpg');">
	<span class="mask bg-gradient-dark opacity-6"></span>
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-lg-12 text-center mx-auto">
				<h1 class="text-white mb-2 mt-5">GruOffice</h1>
				<p class="text-lead text-white">시간과 장소에 얽매이지 않고 언제 어디에서나!</p>
				<p class="text-lead text-white">조직의 업무 환경을 더 효율적이고 편리하게</p>
			</div>
			<div class="col-lg-12 text-center mx-auto">
				
				<div class="card mt-4" id="basic-info">
					<div class="card-header">
						<h5>기본정보</h5>
					</div>
					<div class="card-body pt-0">
						<div class="row">
							<div class="col-3">
								<label class="form-label" style="margin-bottom: 10px;">사이트명</label><br/>
								<label class="form-label" style="margin-bottom: 10px;">사이트URL</label><br/>
								<label class="form-label" style="margin-bottom: 10px;">사이트ID</label><br/>
								<label class="form-label" style="margin-bottom: 10px;">담당자</label><br/>
								<label class="form-label" style="margin-bottom: 10px;">도입날짜</label><br/>
								<label class="form-label" style="margin-bottom: 10px;">활동계정</label><br/>
							</div>
							<div class="col-9" style="text-align: left;">
								<p>사이트명</p>
								<p>사이트명</p>
								<p>사이트명</p>
								<p>사이트명</p>
								<p>사이트명</p>
								
							</div>
						</div>
						
					</div>
				</div>
			</div>
			
			<div class="col-lg-12 text-center mx-auto">
				<div class="card mt-4" id="basic-info">
				<div class="card-header">
						<h5>근태통계</h5>
					</div>
				<div class="row" >
					<div class="col-md-4" >
						<div class="card z-index-2">
							<div class="card-header p-3 pb-0">
								<h5>사원별</h5>
							</div>
							<div class="card mb-3">
							  <div class="card-body p-3">
							    <div class="chart">
							      <canvas id="pie-chart" class="chart-canvas" height="300px"></canvas>
							    </div>
							  </div>
							</div>
						</div>
					</div>
					<div class="col-md-4" >
						<div class="card z-index-2">
							<div class="card-header p-3 pb-0">
								<h5>부서별</h5>
							</div>
							<div class="card mb-3">
							  <div class="card-body p-3">
							    <div class="chart">
							      <canvas id="pie-chart" class="chart-canvas" height="300px"></canvas>
							    </div>
							  </div>
							</div>
						</div>
					</div>
					<div class="col-md-4" >
						<div class="card z-index-2">
							<div class="card-header p-3 pb-0">
								<h5>전사별</h5>
							</div>
							<div class="card mb-3">
							  <div class="card-body p-3">
							    <div class="chart">
							      <canvas id="pie-chart" class="chart-canvas" height="300px"></canvas>
							    </div>
							  </div>
							</div>
						</div>
					</div>
				</div>
				</div>
			</div>
			</div>
		</div>
	</div>
</div>