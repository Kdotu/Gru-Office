<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<link rel="stylesheet" href="/resources/css/sweetalert2.min.css" />
<script text="text/javascript" src="/resources/js/sweetalert2.min.js"></script>
<script src="/resources/js/sweetalert.min.js"></script>

<script src="/resources/maincss/assets/js/plugins/chartjs.min.js"></script>
<script src="/resources/maincss/assets/js/plugins/choices.min.js"></script>

<script type="text/javascript">
<c:if test="${param.status eq 'ok'}">
	swal({
	 	title: "답변 등록이 완료되었습니다!",
	 	icon :"success"
	 });
</c:if>
<c:if test="${resMsg eq 'Success'}">
	swal({
	 	title: "설문 등록이 완료되었습니다!",
	 	icon :"success"
	 });
</c:if>
</script>
<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid my-3 py-3 mx-0 px-0" id="loadSpace">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/surveyAside.jsp" />
		</div>
		<div class="col-lg-10 mt-lg-0 mt-4 mb-4">
<!-- 2번째 사이드바 -->
				<div class="row">
					<div class="col-lg-5">
						<div class="card h-100">
							<div class="card-header pb-0" style="border-bottom: 1px dotted gray;">
								<div class="d-flex align-items-center">
									<h3 class="mb-0">설문조사 상세</h3>
								</div>
								<p class="explains text-sm mb-0 position-relative" style="bottom:10px;">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
										<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
										<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
									</svg>
									<span>설문조사의 상세정보를 확인할 수 있습니다.</span>
								<c:if test="${srvyVO.srvySsts eq 'SRVY0001'}">
									<a class="position-relative badge badge-success" style="left:15px;bottom:35px; font-weight: bolder; font-size: 1.3em; height: 50px; width: 150px; padding-top: 15px;"
									 data-bs-toggle="tooltip" data-bs-placement="bottom" aria-label="현재 진행중인 설문조사입니다." data-bs-original-title="현재 진행중인 설문조사입니다.">진행중</a>
								</c:if>
								<c:if test="${srvyVO.srvySsts eq 'SRVY0002'}">
									<a class="position-relative badge badge-warning" style="left:15px;bottom:35px; font-weight: bolder; font-size: 1.3em; height: 50px; width: 150px; padding-top: 15px;"
										 data-bs-toggle="tooltip" data-bs-placement="bottom" aria-label="보류 처리된 설문조사는 답변이 불가능합니다." data-bs-original-title="보류 처리된 설문조사는 답변이 불가능합니다." >보류</a>
								</c:if>
								<c:if test="${srvyVO.srvySsts eq 'SRVY0003'}">
									<a class="position-relative badge badge-secondary" style="left:15px;bottom:35px; font-weight: bolder; font-size: 1.3em; height: 50px; width: 150px; padding-top: 15px;"
									data-bs-toggle="tooltip" data-bs-placement="bottom" aria-label="마감된 설문은 답변 제출이 불가능합니다." data-bs-original-title="마감된 설문은 답변 제출이 불가능합니다." >마감</a>
								</c:if>
								</p>
							</div>
							<div class="card-body pt-0" style="border-bottom: 1px dotted gray;">
								<div class="row">
									<div class="col-12">
<!-- 										<img class="w-100 border-radius-lg shadow-lg mt-3" src="https://images.unsplash.com/photo-1555041469-a586c61ea9bc?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&amp;ixlib=rb-1.2.1&amp;auto=format&amp;fit=crop&amp;w=1950&amp;q=80" alt="product_image"> -->
									</div>
									<div class="col-12 mt-4">
										<span> <label class="form-label mt-1 mb-0">등록자 : </label><br>
											<a href="javascript:;" class="avatar avatar-sm rounded-circle" data-bs-toggle="tooltip" data-bs-placement="bottom" aria-label="${srvyVO.deptNm} ${srvyVO.empTitle}" data-bs-original-title="${srvyVO.deptNm} ${srvyVO.empTitle} ">
							                    <span>
												<c:choose>
													<c:when test="${not empty srvyVO.srvyProfile}">
									                 	<img src="/resources/upload${srvyVO.srvyProfile}" class="avatar avatar-md rounded-circle img" alt="${srvyVO.srvyProfile}" style="width:50px; height:50px; border-radius: 50px; object-fit:cover;">
													</c:when>
													<c:otherwise>
									                	<img src="/resources/upload/emp/profile/default.png" class="avatar avatar-md rounded-circle img" alt="default.png" style="width:50px; height:50px; border-radius: 50px; object-fit:cover;">
													</c:otherwise>
									            </c:choose>
							                    </span>
						                    </a>
										</span>
										<br />
										<span> <label class="form-label mt-1 mb-0">대상자 : </label>
										<c:forEach var="trprVO" items="${trprVOList}" varStatus="stat">
											<a href="javascript:;" class="avatar avatar-sm rounded-circle" data-bs-toggle="tooltip" data-bs-placement="bottom" aria-label="${trprVO.deptNm} ${trprVO.trprEmpTitle}" data-bs-original-title="${trprVO.deptNm} ${trprVO.trprEmpTitle}">
												<c:choose>
													<c:when test="${not empty trprVO.srvyProfile}">
									                 	<img class="avatar rounded-circle img" alt="Image placeholder" src="/resources/upload${trprVO.srvyProfile}" alt="${trprVO.srvyProfile}" style="width:30px; height:30px;  border-radius: 50px; object-fit:cover;" >
													</c:when>
													<c:otherwise>
									                	<img class="avatar rounded-circle img" src="/resources/upload/emp/profile/default.png" alt="default.png" style="width:30px; height:30px; border-radius: 50px; object-fit:cover;">
													</c:otherwise>
								        	    </c:choose>
											</a>
										</c:forEach>
										</span>
										<div>
											<label class="form-label mt-1 mb-0">설문조사 기한 : </label>
											<span class="badge badge-secondary">
												<fmt:formatDate pattern="yyyy-MM-dd" value="${srvyVO.srvyBgngYmd}" /> ~ <fmt:formatDate pattern="yyyy-MM-dd" value="${srvyVO.srvyEndYmd}" />
											</span>
										</div>
			                            <div class="col mt-1">
               						 		 <label class="form-label mt-1 mb-0">설문조사 태그:</label>
			                				<c:forEach var="hashTagVO" items="${hashTagVOList}" varStatus="stat">
			                					<span class="badge bg-secondary">${hashTagVO.hashTagNm}</span>
<%-- 						                  		<input class="form-control" id="choices-hashTags" type="text" value="${hashTagVO.hashTagNm}" /> --%>
			                				</c:forEach>
					              	 	</div>
									</div>
								</div>
							</div>
							<div class="card-body" id="commentSpace">
								<div id="commentUpdate">
								<label class="h6">설문 제목 :
									<h5 class="font-weight-bolder"> ${srvyVO.srvyTtl}</h5></label><br>
								<label class="h6">설문 내용 :
					              <h5 class="font-weight-bolder">${srvyVO.srvyExpln}</h5></label>
					              <c:if test="${not empty fileVOList}">
						              <c:forEach var="fileVO" items="${fileVOList}" varStatus="stat">
						              	<c:if test="${fileVO.fileOrgnlNm != null}">
							              <img alt="Image placeholder" src="/resources/upload${fileVO.fileStrgNm}" class="img-fluid border-radius-lg shadow-lg">
						                </c:if>
						              </c:forEach>
					              </c:if>
					              <div class="row align-items-center px-2 mt-4 mb-2">
					                <div class="col-sm-8">
					                  <div class="d-flex">
					                    <div class="d-flex align-items-center">
					                      <i class="ni ni-chat-round me-1 cursor-pointer" data-bs-toggle="tooltip" data-bs-original-title="댓글수"></i>
					                      <span class="text-sm me-3">${srvyVO.srvyCmntCnt} </span>
					                    </div>
					                    <div class="d-flex align-items-center">
					                      <i class="ni ni-single-02 me-1 cursor-pointer" data-bs-toggle="tooltip" data-bs-original-title="참여자수"></i>
					                      <span class="text-sm me-2">${srvyVO.srvyTrprCnt}</span>
					                    </div>
					                    <div class="d-flex align-items-center">
					                      <i class="ni ni-check-bold me-1 cursor-pointer" data-bs-toggle="tooltip" data-bs-original-title="답변수"></i>
					                      <span class="text-sm me-2">${srvyVO.srvyRspnsCnt}</span>
					                    </div>
					                    <div class="d-flex align-items-center">
					                    </div>
					                  </div>
					                </div>
					                <hr class="horizontal dark my-3">
					              </div>
					              <!-- Comments -->
					              <div class="mb-1">
					              <c:choose>
						              <c:when test="${not empty CmntVOList}">
						              <c:forEach var="cmntVO" items="${CmntVOList}" varStatus="stat">
						                <div class="d-flex mt-3 cmntInfo">
						                  <div class="flex-shrink-0">
						                  <c:choose>
												<c:when test="${not empty cmntVO.cmntProfile}">
								                 	<img alt="${cmntVO.cmntProfile}" class="avatar rounded-circle me-3 img" src="/resources/upload${cmntVO.cmntProfile}"  style="width: 50px; border-radius: 50px; object-fit:cover;">
												</c:when>
												<c:when test="${authority eq 'admin'}">
													<img src="/resources/maincss/assets/img/user1.png" class="avatar rounded-circle me-3 img" alt="관리자user1.png" style="width: 50px; border-radius: 50px; object-fit:cover;">
												</c:when>
												<c:otherwise>
								                	<img src="/resources/upload/emp/profile/default.png" class="avatar rounded-circle me-3 img" alt="default.png" style="width: 50px; border-radius: 50px; object-fit:cover;">
												</c:otherwise>
						         		   </c:choose>
					                 	    <input type="hidden" name="cmntNo" value="${cmntVO.cmntNo}" class="cmntNo" />
						                  </div>
						                  <div class="flex-grow-1 ms-3 row commentZone">
						                    <div class="h6 mt-0 mb-0 col-8">${cmntVO.empDeptNm} ${cmntVO.empTitle}</div>
						                    <div class="col-4 commentUpdate" style="display:none;">
							                    <button type='button' value='"+ res.taskCmntList[i].cmntNo +"' style='float:right;' class='btn-close text-dark deleteCmnt'>
													<span aria-hidden='true' class='delCBtn'>×</span>
												</button>
												<button type='button' value='cmntVO.cmntNo' style='float:right;' class='btn-close text-dark editCmnt'>
													<img src='/resources/image/editC.png' style='width:10px; margin-left:-5px;' class='editCBtn'>
												</button>
						                    </div>
												<span class="text-xs" style="color:gray; ">${cmntVO.cmntRegYmd}</span>
						                    <p class="text-sm">${cmntVO.cmntCn}
						                    </p>
						                  </div>
						                </div>
						                  </c:forEach>
						                </c:when>
						                <c:otherwise>
						                	<div>등록된 댓글이 없습니다.</div>
						                </c:otherwise>
					                </c:choose>

					                <div class="d-flex mt-4">
					                  <div class="flex-shrink-0">
	    							<sec:authorize access="isAuthenticated()">
										<sec:authentication property="principal.empVO" var="empVO" />
               				           	<c:choose>
											<c:when test="${not empty empVO.fileGrVO.fileGroupNo}">
							                 	<img src="/resources/upload${empVO.fileGrVO.filesList[0].fileThumb}" class="avatar rounded-circle me-3 img" alt="${empVO.fileGrVO.filesList[0].fileThumb}" style="width: 50px; border-radius: 50px; object-fit:cover;">
											</c:when>
											<c:when test="${authority eq 'admin'}"> <!-- 관리자의 경우 -->
							                 	<img src="/resources/maincss/assets/img/user1.png" class="avatar rounded-circle me-3 img" alt="관리자user1.png" style="width: 50px; border-radius: 50px; object-fit:cover;">
											</c:when>
											<c:otherwise>
							                	<img src="/resources/upload/emp/profile/default.png" class="avatar rounded-circle me-3 img" alt="default.png" style="width: 50px; border-radius: 50px; object-fit:cover;">
											</c:otherwise>
						         	   </c:choose>
				                 	 </sec:authorize>
					                  </div>
					                  <div class="flex-grow-1 my-auto row">
					                      <textarea class="form-control col-lg" placeholder="댓글 입력..." rows="1" id="srvyComment"></textarea>
					                      <button type="button" class="btn btn-outline-dark col-3 mx-1 my-0 p-0" style="width:50px;" onclick="fn_createComment()">등록</button>
					                  </div>
					                </div>
					              </div>
					            </div>
				            </div>
						</div>
					</div>
					<!-- 설문조사 상세 정보 (질문/보기) 시작 -->
					<div class="col-lg-7 mt-lg-0 mt-4">
						<div class="card" id="qstnSpace">
							<div class="card-body" id="qstnContent">
								<div><c:choose><c:when test="${not empty srvyRspnVOList}"><span class="badge h6 badge-info" style="float:right;">응답완료</span></c:when><c:otherwise><span class="badge h6 badge-secondary" style="float:right;">미응답</span></c:otherwise></c:choose></div>
								<div class="mx-2 m-1"  style="clear:both;">
								<form id="srvyRspnFrm">
								<input type="hidden" name="srvyNo" value="${srvyVO.srvyNo}" />
								<c:choose>
									<%-- 설문조사 등록한 답변이 있을 경우 출력 시작 --%>
									<c:when test="${not empty srvyRspnVOList}"><%--질문이 선택형일 경우 --%>
										<c:forEach var="srvyQstnVO" items="${srvyVO.srvyQstnVOList}" varStatus="stat1">
											 <div class="qust-${stat1.count} py-2 my-2">
												<div class="h5">${stat1.count}. ${srvyQstnVO.srvyQstnCn}</div>
												<c:choose>
 									               <c:when test="${srvyQstnVO.srvyQstnType eq 'QSTN0001'}">
									                    <c:set var="isRspnChecked" value="false"/>
									                    <c:forEach var="SrvyQstnArtVO" items="${srvyQstnVO.srvyQstnArtVOList}" varStatus="stat2">
									                        <c:choose>
									                            <c:when test="${not isRspnChecked}"> <%-- 답변으로 제출한 radio는 checked 설정 --%>
									                                <c:forEach var="srvyRspnVO" items="${srvyRspnVOList}" varStatus="stat">
									                                    <c:if test="${srvyRspnVO.srvyQstnNo eq srvyQstnVO.srvyQstnNo}">
									                                        <c:set var="isRspnChecked" value="true"/>
									                                        <div class="form-check">
									                                            <input class="form-check-input" type="radio" name="srvyRspnVOList[${stat1.index}].srvyRspnsCn" checked
									                                            	   id="radio-${stat1.index}-${stat2.index}" value="${SrvyQstnArtVO.srvyQstnArtclOrder}" disabled />
									                                            <label class="form-check-label" for="radio-${stat1.index}-${stat2.index}">${SrvyQstnArtVO.srvyQstnArtclCn}</label>
									                                        </div>
									                                    </c:if>
									                                </c:forEach>
									                            </c:when>
									                            <c:otherwise><%-- 답변이 아닌 radio는 일반 출력 설정 --%>
									                                <div class="form-check">
									                                    <input class="form-check-input" type="radio" name="srvyRspnVOList[${stat1.index}].srvyRspnsCn"
									                                           id="radio-${stat1.index}-${stat2.index}" value="${SrvyQstnArtVO.srvyQstnArtclOrder}" disabled />
									                                    <label class="form-check-label" for="radio-${stat1.index}-${stat2.index}">${SrvyQstnArtVO.srvyQstnArtclCn}</label>
									                                </div>
									                            </c:otherwise>
									                        </c:choose>
									                    </c:forEach>

									                    <div class="row mt-3 mx-auto">
			 											<div class="col-5 text-center">
			 												<div class="chart mt-3">
			 													<canvas id="chart-doughnut-${stat1.index}" class="chart-canvas" style="height:200px;"></canvas>
			 												</div>
			 											</div>
												<!-- 차트 옆 표 시작 -->
														<div class="col-7 my-auto">
															<div class="table-responsive">
																<table class="table align-items-center mb-0">
																	<tbody>
																	<c:forEach var="srvyQstnArtVO" items="${srvyQstnVO.srvyQstnArtVOList}" varStatus="stat2">
																	  <tr>
																	    <td>
																	      <div class="d-flex px-2 py-1">
																	        <div></div>
																	        <div class="d-flex flex-column justify-content-center">
																	          <h6 class="mb-0 text-sm">${srvyQstnArtVO.srvyQstnArtclCn}</h6>
																	        </div>
																	      </div>
																	    </td>
																	    <td class="align-middle text-center text-sm">
																		<c:forEach var="rspnCntVO" items="${rspnCntList}" varStatus="stat">
																			<c:if test="${rspnCntVO.srvyQstnArtclOrder eq srvyQstnArtVO.srvyQstnArtclOrder && rspnCntVO.srvyQstnArtclCn eq srvyQstnArtVO.srvyQstnArtclCn}">
																		            <span>[ 답변수 : ${rspnCntVO.rspnsCnt} ]</span>
																				    <span class="text-xs font-weight-bold"><fmt:parseNumber value='${rspnCntVO.rspnsCnt / rspnCntVO.totalRspnCnt * 100}' integerOnly='true' /> %</span>
																			</c:if>
																		</c:forEach>
																	    </td>
																	  </tr>
																	</c:forEach>
																	</tbody>
																</table>
															</div>
														</div>
												<!-- 차트 옆 표 끝 -->
													</div>
									                </c:when>
									                <c:otherwise> <%-- 질문이 답변형일 경우 --%>
									                	<c:forEach var="SrvyQstnArtVO" items="${srvyQstnVO.srvyQstnArtVOList}" varStatus="stat2">
							                                <c:forEach var="srvyRspnVO" items="${srvyRspnVOList}" varStatus="stat">
							                                    <c:if test="${srvyRspnVO.srvyQstnNo eq srvyQstnVO.srvyQstnNo}">
							                                        <c:set var="isRspnChecked" value="true"/>
							                                        <div class="form-check">
						                                        		<div class="form-group">
																		    <div class="input-group mt-3">
																		      <span class="input-group-text" style="background-color: #e1e9f7;">답변</span>
																		      <textarea class="form-control" name="srvyRspnVOList[${stat1.index}].srvyRspnsCn" readonly required>${srvyRspnVO.srvyQstnArtNm}</textarea>
																		    </div>
																		</div>
							                                        </div>
							                                    </c:if>
							                                </c:forEach>
						                                </c:forEach>
					                                </c:otherwise>
				                                </c:choose>
											</div>
										</c:forEach>
									</c:when>
									<%-- 설문조사 등록한 답변이 있을 경우 출력 끝 --%>
									<%-- 설문조사 등록한 답변이 없을 경우 출력 시작 --%>
									<c:otherwise>
										<c:set var="isEmpTrPr" value="false"/>
										<c:forEach var="trprVO" items="${trprVOList}" varStatus="stat">
											<sec:authorize access="isAuthenticated()">
												<sec:authentication property="principal.empVO" var="empVO" />
											<c:if test="${trprVO.empNo eq empVO.empNo}">
												<c:set var="isEmpTrPr" value="true"/>
											</c:if>
											</sec:authorize>
										</c:forEach>
											<c:forEach var="srvyQstnVO" items="${srvyVO.srvyQstnVOList}" varStatus="stat1">
												<input type="hidden" name="srvyRspnVOList[${stat1.index}].srvyQstnNo" value="${srvyQstnVO.srvyQstnNo}" />
												<input type="hidden" name="srvyRspnVOList[${stat1.index}].srvyNo" value="${srvyVO.srvyNo}" />
											<sec:authorize access="isAuthenticated()">
												<sec:authentication property="principal.empVO" var="empVO" />
												<input type="hidden" name="srvyRspnVOList[${stat1.index}].empNo" value="${empVO.empNo}" />
											</sec:authorize>
												 <div class="qust-${stat1.count} py-2 my-2">
													<div class="h5">${stat1.count}. ${srvyQstnVO.srvyQstnCn}</div>
													<c:choose>
														<c:when test="${srvyQstnVO.srvyQstnType eq 'QSTN0001'}">
														<c:forEach var="SrvyQstnArtVO" items="${srvyQstnVO.srvyQstnArtVOList}" varStatus="stat2">
														<div class="form-check">
															<input class="form-check-input" type="radio" name="srvyRspnVOList[${stat1.index}].srvyRspnsCn" id="radio-${stat1.index}-${stat2.index}"
																   value="${SrvyQstnArtVO.srvyQstnArtclOrder}" <c:if test="${srvyVO.srvySsts eq 'SRVY0002' || not isEmpTrPr}">disabled</c:if> required >
														  	<label class="form-check-label" for="radio-${stat1.index}-${stat2.index}">${SrvyQstnArtVO.srvyQstnArtclCn}</label>
														 </div>
														</c:forEach>
														</c:when>
														<c:otherwise>
															<div class="form-group">
															    <div class="input-group">
															      <span class="input-group-text" style="background-color: #e1e9f7;">답변</span>
															      <textarea class="form-control" name="srvyRspnVOList[${stat1.index}].srvyRspnsCn" required></textarea>
															    </div>
															</div>
														</c:otherwise>
													</c:choose>
												</div>
											</c:forEach>
									</c:otherwise>
									<%-- 설문조사 등록한 답변이 없을 경우 출력 끝 --%>
								</c:choose>
								</form>
							<!-- 답변 제출/수정 버튼 시작 -->
									<div class="row">
										<div class="col-7">
										</div>
										<div class="col-5"  style="float:right;">
										<c:choose>
											<c:when test="${empty srvyRspnVOList && authority ne 'admin'}">
												<button
												<c:choose>
													<c:when test="${srvyVO.srvySsts eq 'SRVY0002' || not isEmpTrPr}"> data-bs-toggle="tooltip" data-bs-placement="bottom" aria-label="설문대상자가 아니거나 보류/마감 처리된 설문은 답변이 불가능합니다." data-bs-original-title="설문대상자가 아니거나 보류/마감 처리된 설문은 답변이 불가능합니다."</c:when>
												<c:otherwise>onclick="fn_confirm_Rspn()"</c:otherwise>
												</c:choose> class="btn btn-sm btn-outline-dark" >답변 제출</button>
											</c:when>
											<c:when test="${empty srvyRspnVOList && authority eq 'admin'}">

											</c:when>
											<c:otherwise>
												<input type="button" onclick="fn_modify_Rspn()" class="btn btn-sm btn-outline-dark" <c:if test="${srvyVO.srvySsts eq 'SRVY0002' || not isEmpTrPr}">disabled</c:if> value="답변 수정" />
											</c:otherwise>
										</c:choose>
											<a href="/survey/list?status=progress" class="btn btn-sm btn-outline-dark">목록</a>
										</div>
									</div>
							<!-- 답변 제출/수정 버튼 끝 -->
									</div>
								</div>
							</div>
						</div>
						<!-- 설문조사 상세 정보 (질문/보기) 끝 -->
					</div>
				</div>
			</div>
		</div>
<!-- 차트 시작 -->
<script>
const rspnArr = "${srvyRspnVOList}";
console.log(rspnArr);
	<c:forEach var="srvyQstnVO" items="${srvyVO.srvyQstnVOList}" varStatus="stat">
		var ctx2 = document.getElementById("chart-doughnut-${stat.index}").getContext("2d");
		// Doughnut chart
		new Chart(ctx2, {
		  type: "doughnut",
		  data: {
		    labels: [
		    	<c:forEach var="SrvyQstnArtVO" items="${srvyQstnVO.srvyQstnArtVOList}" varStatus="stat2">
		    		"${SrvyQstnArtVO.srvyQstnArtclCn}",
		    	</c:forEach>
		    	],
		    datasets: [{
		      label: "Surveys",
		      weight: 9,
		      cutout: 60,
		      tension: 0.9,
		      pointRadius: 2,
		      borderWidth: 2,
		      backgroundColor: [
		    	  '#cb0c9f', '#2152ff','#a8b8d8', '#3A416F', '#f53939','#FC9797'
		    	  ],
		      data: [
				<c:forEach var="rspnCntVO" items="${rspnCntList}" varStatus="stat3">
					<c:if test="${rspnCntVO.srvyQstnNo eq srvyQstnVO.srvyQstnNo}">
						'${rspnCntVO.rspnsCnt}',
					</c:if>
				</c:forEach>
		    	  ],
		      fill: false
		    }],
		  },
		  options: {
		    responsive: true,
		    maintainAspectRatio: false,
		    plugins: {
		      legend: {
		        display: false,
		      }
		    },
		    interaction: {
		      intersect: false,
		      mode: 'index',
		    },
		    scales: {
		      y: {
		        grid: {
		          drawBorder: false,
		          display: false,
		          drawOnChartArea: false,
		          drawTicks: false,
		        },
		        ticks: {
		          display: false
		        }
		      },
		      x: {
		        grid: {
		          drawBorder: false,
		          display: false,
		          drawOnChartArea: false,
		          drawTicks: false,
		        },
		        ticks: {
		          display: false,
		        }
		      },
		    },
		  },
		});
	</c:forEach>

</script>
<!-- 차트 끝 -->
<script>


// 설문 답변제출
function fn_confirm_Rspn(){
	console.log("rspn");
	swal({
		  title: "설문조사 답변을 제출하시겠습니까?",
		  text: "확인을 누르면 답변이 등록됩니다.",
		  icon: "warning",
		  buttons: {
			  cancel : "취소",
			  modifyOK : {
				text : "등록",
				value : "createOk"
			  }
			},
		})
		.then((value) => {
		  switch (value) {
		    case "createOk":
		    	var formData = $("#srvyRspnFrm").serialize();
//		    	 action="/survey/createRespn" method="post"

		   	$.ajax({
		   		url:"/survey/createRspn",
		   		type:"POST",
		   		data : formData,
		       	beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
		       		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		      		},
		   		success : function(res){
		   			console.log("res : ",res);
		   			if(res == "success"){
						// status 1이란 답변 완료 flag
						location.href="/survey/detail?srvyNo=${srvyVO.srvyNo}&status=ok";

		   			}else{
		   				// 답변 제출 실패 alert 띄우기

		   			}
		   		},
		   		error : function(xhr){
		   			alert(xhr.status);
		   		}
		   	})
		    	break;
		    default:
		      swal({
	 		    	title: "설문 답변등록 취소!",
	 		    	icon :"error"
	 		    });
		 	 }
		});
	}

// 해시태그 리스트 출력
	var hashTagVOList = "${hashTagVOList}";
	console.log("hashTagVOList : " + hashTagVOList);

    if (document.getElementById('choices-hashTags')) {
        var skills = document.getElementById('choices-hashTags');
        const example = new Choices(skills, {
          delimiter: ',',
          editItems: true,
          maxItemCount: 5,
          removeItemButton: false,
          addItems: true
        });
      }
    // 등록된 태그를 출력 후 수정불가능하도록 disabled 처리
    $(function(){
		$(".choices__input--cloned").attr("disabled",true);
    })

// 댓글등록
function fn_createComment(){
   	let commnetVal = document.querySelector("#srvyComment").value;
	let srvyNo = "${srvyVO.srvyNo}";

	if(commnetVal == ''){
		swal({
			title: "댓글 내용을 입력해주세요",
			icon: "warning", //success, warning, error
			button: "확인",
			closeOnClickOutside: false
		});
		return false;
	}

    console.log("commnetVal : " + commnetVal);
    let data ={
		"cmntClsf" : srvyNo,
		"cmntCn" : commnetVal
    };

    let urlRoot ="/survey/createSrvyCmnt";
    let reloadURL = "/survey/detail";


	if(${authority eq 'admin'}){
		urlRoot = "/admin/createSrvyAdminCmnt";
		reloadURL = "/admin/srvyDetail"
	}


	$.ajax({
	    url: urlRoot,
	    contentType:"application/json;charset:utf-8",
	    data:JSON.stringify(data),
	    type:"post",
			beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	    success: function(res) {

	    	if(res > 0){
		    	commnetVal="";
		    	let Toast = Swal.mixin({
		    		toast:true,
		    		position:'middle-middle',
		    		showConfirmButton:false,
		    		timer:3000
		    	});
		    	Toast.fire({
		    		icon:'success',
		    		title:'댓글 등록 완료!'
		    	});
	    	}
	    	$("#commentSpace").load("${contextPath}" + reloadURL + "?srvyNo=${srvyVO.srvyNo} #commentUpdate");
	    }
	});
   }
// 댓글 수정/삭제모드
$(document).on("mouseenter",".commentZone",function(){
	$(this).find(".commentUpdate").css("display","");
});
$(document).on("mouseleave",".commentZone",function(){
	$(this).find(".commentUpdate").css("display","none");
});

// 댓글 수정
$(document).on("click",".editCBtn",function(){
	console.log("댓글.수정");
	console.log($(this));
})

// 댓글 삭제
$(document).on("click",".delCBtn",function(){
	console.log("댓글삭제");
	console.log($(this));

	let cmntNo = $(this).parents(".cmntInfo").find(".cmntNo").val();
	console.log("cmntNo : " + cmntNo);

})

</script>