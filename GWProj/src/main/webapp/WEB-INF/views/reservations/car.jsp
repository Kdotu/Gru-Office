<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- CSS only -->
<style type="text/css">
.row {
	width: 100%;
}

</style>

<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/reserveAside.jsp" />
		</div>
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4">
<!-- 2번째 사이드바 -->
			<div class="card">
				<div class="card-body pt-4">
					<span class="text-gradient text-info text-uppercase text-xs font-weight-bold my-2" style="margin-left: 10px;">Car Reserve</span>
					<h3 class="mb-0 font-weight-bolder" style="margin-left: 10px;">차량 예약</h3>
						<div>
							<p class="explains mb-0" style="margin-left: 10px;">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
									fill="currentColor" class="bi bi-info-circle"
									viewBox="0 0 16 16">
								  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
								  <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105
								   1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275
								    0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
								</svg>
								원하는 차량을 선택하여 일정을 확인하고 예약신청을 할 수 있습니다.
							</p>
						</div>
				</div>
			</div>

					<div class="row mx-auto" align="left">
						<!-- 여기서부터 카드임 -->
						
<!-- 1 row 시작 -->
<div class="row mt-lg-4 mt-2">
<c:forEach items="${vhrVOList}" var="VhrVO">
          <div class="col-lg-4 col-md-6 mb-4">
            <div class="card">
              <div class="card-body p-3">
                <div class="d-flex">
                <div style="height:200px;">
	                <c:if test="${VhrVO.fileGrVO.filesList eq null}">
		                <img src="/resources/image/car-sonata.png"
							 class="img-fluid border-radius-lg mx-auto"/>
	                </c:if>
	                <c:if test="${VhrVO.fileGrVO.filesList ne null}">
		                <img src="/resources/upload${VhrVO.fileGrVO.filesList[0].fileStrgNm}"
							 class="img-fluid border-radius-lg mx-auto"/>
                	</c:if>
              	 </div>
                </div>
	                <div class="d-flex">
	                  <div class="ms-3 my-auto">
						<span class="text-gradient text-info text-uppercase text-lg font-weight-bold my-2">${VhrVO.vhrCmp}</span>
						<a href="javascript:;" class="card-title h4 d-block text-darker">${VhrVO.vhrNm}</a>
	                  </div>
                </div>
                  <p class="card-description" style="float:right;">
					<span class="badge bg-gradient-secondary">${VhrVO.vhrSort}</span>
					<span class="badge bg-gradient-info">${VhrVO.vhrSz}</span>
					<span class="badge bg-gradient-warning">${VhrVO.vhrFuel}</span>
				  </p>
                <hr class="horizontal dark" style="clear:both;">
                <div class="row">
                  <div class="col-6">
                  <span class="text-gradient text-dark text-uppercase text-xs font-weight-bold my-2" style="margin-left: 15px;">차량 등록일자</span>
                    <h6 style="margin-left: 15px;" class="text-lg mb-0"><fmt:formatDate pattern="yyyy-MM-dd" value="${VhrVO.vhrRegDt}" /></h6>
                  <span class="text-gradient text-dark text-uppercase text-xs font-weight-bold my-2" style="margin-left: 15px;">차량 등록번호</span>
					<p style="margin-left: 15px;" class="text-dark text-lg font-weight-bold mb-0">${VhrVO.vhrRegNo}</p>
                  </div>
                  <div class="col-6 text-end">
				  <form action="/reserve/carDet" method="post">
				  	  <input type="hidden" name="vhrNo" value="${VhrVO.vhrNo}">
	                  <button class="btn btn-icon mt-4 btn-3 btn-dark" type="submit">
						<span class="btn-inner--icon"><i class="ni ni-button-play"></i></span> <span class="btn-inner--text text-lg">차량 상세</span>
					  </button>
					  <sec:csrfInput/>
                  </form>
                  </div>
                </div>
              </div>
            </div>
          </div>
</c:forEach>
<!-- 1 row 끝 -->			

					</div>
				</div>
			</div>
		</div>
	</div>
