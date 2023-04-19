<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- jQuery -->
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="/resources/js/jquery-3.6.3.min.js"></script>

 <script src="/resources/ckeditor/ckeditor.js"></script>

<!-- <script type="text/javascript"> -->
// $(function(){
// 	$("#send").on("click",function(){
// 		console.log("온?");
// 		window.close();	
// 		});	
// });

<!-- </script> -->




<style>
.lb{
	width: 100px;
}
</style>
<!-- 메일쓰기 -->
<!-- body_left -->
<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->	
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4">
<!-- 2번째 사이드바 -->	


		<!-- body_center -->
		<p>메일쓰기</p>
			<div class="card">
				<div class="table-responsive">
					<div class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
						<div class="dataTable-top">
							<div>
								
									<button type="button" class="btn btn-outline-dark btn-sm" id="send">보내기</button>
									<button type="button" class="btn btn-outline-dark btn-sm">임시저장</button>					
							</div>																	
							<div class="dataTable-search">								
							</div>
						</div>
						
						<div class="dataTable-top">
							<form>
							  <div class="form-group row" >
							    <label for="inputEmail3" class="col-sm-2 col-form-label lb">받는사람</label>
							    <div class="col-sm-10">
							      <div class="form-check" style="width:100%;">
							      	<div style="float:left; margin-top: 5px;">
							        	<input class="form-check-input" type="checkbox" id="gridCheck1">
							        </div>
							        <div style="float:left; margin-top: 15px;">
								        <label class="form-check-label" for="gridCheck1">
								        	  나에게 
								        </label>
							        </div>
							        <div style="float:left;margin-left:10px;width:80%;">
							        	<input type="email" class="form-control" id="inputEmail3" placeholder="Email" style="width:100%;" />
							        </div>
							        <div style="float:left;margin-left:10px;">
							        	<input class="btn btn-outline-info" type="button" value="주소록" />
							        </div>
							      </div>
							    </div>
							  </div>
							  <div class="form-group row">
							    <label for="inputReperences3" class="col-sm-2 col-form-label lb">참조</label>					    
							    <div class="col-sm-8" style="margin-left: 80px;">
							      <input type="text" class="form-control" id="inputReperences3" placeholder="Reperences">
							    </div>
							  </div>
							  <div class="form-group row">
							    <label for="inputtitle3" class="col-sm-2 col-form-label lb">제목</label>					    
							    <div class="col-sm-10">
							    
							    	<div class="form-check" style="width:100%;">
								      	<div style="float:left; margin-top: 5px;">
								        	<input class="form-check-input" type="checkbox" id="gridCheck2">
								        </div>
								        <div style="float:left; margin-top: 5px;">
									        <label class="form-check-label" for="gridCheck2">
									        	  중요 
									        	    <img alt="" src="/resources/image/star.png" style="width: 20px;">
									        </label>
								        </div>
								        <div style="float:left;margin-left:10px;width:80%;">
								        	<input type="Title" class="form-control" id="inputtitle3" placeholder="Title" style="width:100%;" />
								        </div>								   
							     	 </div>							    
							      </div> 		
							    </div>
							  </div>							  
							  
							  <div class="dataTable-top">
							    <label for="inputfile3" class="col-sm-2 col-form-label lb">파일첨부</label>
							    <div class="col-sm-10">
<!-- 							    <input type="button" name="file" id="file" value="파일선택" > -->
<!-- 							     <input type="file" class="form-control" id="inputfile3" placeholder="여기에 첨부파일을 끌어오세요. 또는 파일선택"> -->
							     <form action="/file-upload" class="form-control dropzone" id="dropzone" />
								  <div class="fallback">
								    <input name="file" type="file" id="file" multiple />
								  </div>
								</form>
<!-- 								    <button type="button" name="reference" value="reference">자료실</button>								     -->
							    </div>
							  </div>						
							</form>
						</div>
					</div>
					<!-- ckeditor -->
					<div class="form-group row" style="margin-left:20px;">
						<label class="col-sm-2"></label>
						<div style="width:90%;">
						<!-- 세로 : cols, 가로 : rows -->
							<textarea class="form-control" cols="70" rows="2" id="description" name="description"></textarea>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>	
<script type="text/javascript">
CKEDITOR.replace('description');

CKEDITOR.resize("300px", "500px");
</script>