<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<style>
	.btn {
		margin-right: 15px;
	}
	.Heads{
		margin-left: 8px;
	}
	.myModalWidth {
    min-width: 700px;
	}

	/*드롭다운 관련 추가한 부분*/
	#drop-area {
	  border: 2px dashed #ccc;
	  border-radius: 20px;
	  width: 480px;
	/*   margin: 50px auto; */
	/*   padding: 20px; */
	}
	#drop-area.highlight {
	  border-color: purple;
	}

</style>

<!-- 모달 컨테이너 -->
  <div class="col-md-4">
<!-- 이 아래로 모달! -->

    <!-- Modal CarCreate-->
    <div class="modal fade" id="CreateCarModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalMessageTitle" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content myModalWidth">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">새로운 차량 등록</h5>
            <button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">×</span>
            </button>
          </div>
          <div class="modal-body">
            <form action="/admin/createCar" method="post" id="frmCar" enctype="multipart/form-data">
              <div class="form-group" align="left">
                <label for="car-name" class="col-form-label">차량명</label>
                <input type="text" class="form-control" name="vhrNm" id="car-name"/>
              </div>
              <div class="form-group">
                <label for="company-name" class="col-form-label">제조사</label>
                <input type="text" class="form-control" name="vhrCmp" id="company-name"/>
              </div>
              <div class="form-group">
                <label for="room-name" class="col-form-label">차량번호</label>
                <input type="text" class="form-control" name="vhrRegNo" id="room-name"/>
              </div>
              <div class="form-group">
                <label for="car-sort" class="col-form-label">차종</label>
                <input type="text" class="form-control" name="vhrSort" id="car-sort"/>
              </div>
              <div class="form-group">
                <label for="car-size" class="col-form-label">크기</label>
                <input type="text" class="form-control" name="vhrSz" id="car-size"/>
              </div>
              <div class="form-group">
                <label for="room-name" class="col-form-label">연료</label>
                <input type="text" class="form-control" name="vhrFuel" id="room-name"/>
              </div>
              <div class="form-group">
                <label for="car-info" class="col-form-label">설명</label>
                <textarea class="form-control" name="vhrInfo" id="car-info"></textarea>
              </div>
              <div class="form-group">
                <label for="car-image" class="col-form-label">이미지</label>
				<input class="form-control" type="file"  name="uploadFile" id="car-image" />
              </div>
              <sec:csrfInput/>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn bg-gradient-secondary" data-bs-dismiss="modal">닫기</button>
            <button type="submit" class="btn bg-gradient-info" form="frmCar">등록</button>
          </div>
        </div>
      </div>
    </div>
    <!-- Modal CarUpdate-->
    <div class="modal fade" id="UpdateCarModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalMessageTitle" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
        <div class="modal-content myModalWidth">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">차량 등록내용 수정</h5>
            <button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">×</span>
            </button>
          </div>
          <div class="modal-body">


	 <form action="/admin/updateCar" method="post" id="frmCarUpdate">
          <div class="row">
						<div class="col-12 col-sm-4 mx-auto">
							<div class="row" style="text-align: center;">
	                         <div class="mb-5 mt-5 mx-auto" style="position:relative; top:200px;">
<%-- 	                                <c:choose> --%>
<%-- 										<c:when test="${not empty empVO.fileGrVO.fileGroupNo}"> --%>
				                           <img id="carImg" src="/resources/upload/vhr/7/b2e8b2bd-fd60-4e46-b2b2-e9ca5b7809c5_디올뉴그랜저.png" class="border-radius-md" alt="team-2" style="width:400px; height:auto;">
<%-- 										</c:when>                            	 --%>
<%-- 										<c:otherwise> --%>
<!-- 				                            <img src="/resources/image/car-ioniq.png" class="border-radius-md" alt="team-2" style="width:400px; height:auto;"> -->
<%-- 										</c:otherwise> --%>
<%-- 	                            	</c:choose> --%>

				              <div class="form-group">
				                <input type="hidden" class="form-control" name="vhrNo" id="vhrNo-up">
				              </div>
				              <div class="form-group">
				                <label for="car-name" class="col-form-label">차량명</label>
				                <input type="text" class="form-control" name="vhrNm" id="vhrNm-up">
				              </div>
	                          </div>
                            </div>

	                     </div>
	                     <!-- 기본화면 -->
						 <div class="col-6 mx-auto" id="">
				              <div class="form-group my-1">
				                <label for="company-name" class="col-form-label">제조사</label>
				                <input type="text" class="form-control" name="vhrCmp" id="vhrCmp-up">
				              </div>
				              <div class="form-group my-1">
				                <label for="room-name" class="col-form-label">차량번호</label>
				                <input type="text" class="form-control" name="vhrRegNo" id="vhrRegNo-up">
				              </div>
				              <div class="form-group my-1">
				                <label for="car-sort" class="col-form-label">차종</label>
				                <input type="text" class="form-control" name="vhrSort" id="vhrSort-up">
				              </div>
				              <div class="form-group my-1">
				                <label for="car-size" class="col-form-label">크기</label>
				                <input type="text" class="form-control" name="vhrSz" id="vhrSz-up">
				              </div>
				              <div class="form-group my-1">
				                <label for="car-size" class="col-form-label">등록일</label>
				                <input type="date" class="form-control" name="vhrRegDt" id="vhrRegDt-up">
				              </div>
				              <div class="form-group my-1">
				                <label for="room-name" class="col-form-label">연료</label>
				                <input type="text" class="form-control" name="vhrFuel" id="vhrFuel-up">
				              </div>
				              <div class="form-group my-1">
				                <label for="car-info" class="col-form-label">설명</label>
				                <textarea class="form-control" name="vhrInfo" id="vhrInfo-up"></textarea>
				              </div>
						 </div>
				     <sec:csrfInput/>
				 </div>
	            </form>
	          </div>
          <div class="modal-footer">
            <button type="button" class="btn bg-gradient-secondary" data-bs-dismiss="modal">닫기</button>
            <button type="button" class="btn bg-gradient-warning" id="deleteCar">삭제</button>
            <button type="submit" class="btn bg-gradient-info" form="frmCarUpdate">수정</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Modal RoomCreate-->
    <div class="modal fade" id="CreateRoomModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalMessageTitle" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content myModalWidth">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">새로운 회의실 등록</h5>
            <button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">×</span>
            </button>
          </div>
          <div class="modal-body">
            <form action="/admin/createRoom" method="post" id="frmRoom">
              <div class="form-group">
                <label for="room-name" class="col-form-label">회의실명</label>
                <input type="text" class="form-control" name="mtgrmInfo" id="room-name">
              </div>
              <div class="form-group">
                <label for="pop_number" class="col-form-label">수용인원</label>
                <input type="number" class="form-control" name="mtgrmAvarPeo" id="pop_number">
              </div>
              <div class="form-group">
                <label for="projecter-number" class="col-form-label">프로젝터 갯수</label>
                <input type="number" class="form-control" name="mtgrmProj" id="projecter-number">
              </div>
              <div class="form-group">
                <label for="whiteboard-number" class="col-form-label">화이트보드 갯수</label>
                <input type="number" class="form-control" name="mtgrmBo" id="whiteboard-number">
              </div>
              <div class="form-group">
                <label for="computer-number" class="col-form-label">컴퓨터 갯수</label>
                <input type="number" class="form-control" name="mtgrmPc" id="computer-number">
              </div>
              <div class="form-group">
                <label for="aircon-number" class="col-form-label">냉난방기 갯수</label>
                <input type="number" class="form-control" name="mtgrmAir" id="aircon-number">
              </div>
              <sec:csrfInput/>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn bg-gradient-secondary" data-bs-dismiss="modal">닫기</button>
            <button type="submit" class="btn bg-gradient-info" form="frmRoom">등록</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Modal RoomUpdate-->
    <div class="modal fade" id="UpdateRoomModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalMessageTitle" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content myModalWidth">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">회의실 등록내용 수정</h5>
            <button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">×</span>
            </button>
          </div>
          <div class="modal-body">
            <form action="/admin/updateRoom" method="post" id="frmRoomUpdate">
              <div class="form-group">
                <input type="hidden" class="form-control" name="mtgrmNo" id="room-id-up">
              </div>
              <div class="form-group">
                <label for="room-name-up" class="col-form-label">회의실명</label>
                <input type="text" class="form-control" name="mtgrmInfo" id="room-name-up">
              </div>
              <div class="form-group">
                <label for="pop_number-up" class="col-form-label">수용인원</label>
                <input type="number" class="form-control" name="mtgrmAvarPeo" id="pop_number-up">
              </div>
              <div class="form-group">
                <label for="projecter-number-up" class="col-form-label">프로젝터 갯수</label>
                <input type="number" class="form-control" name="mtgrmProj" id="projecter-number-up">
              </div>
              <div class="form-group">
                <label for="whiteboard-number-up" class="col-form-label">화이트보드 갯수</label>
                <input type="number" class="form-control" name="mtgrmBo" id="whiteboard-number-up">
              </div>
              <div class="form-group">
                <label for="computer-number-up" class="col-form-label">컴퓨터 갯수</label>
                <input type="number" class="form-control" name="mtgrmPc" id="computer-number-up">
              </div>
              <div class="form-group">
                <label for="aircon-number-up" class="col-form-label">냉난방기 갯수</label>
                <input type="number" class="form-control" name="mtgrmAir" id="aircon-number-up">
              </div>
              <div class="form-group">
                <label for="aircon-number-up" class="col-form-label">사용가능 여부</label>
<!--                 <input type="text" class="form-control" name="mtgrmAvalYn" id="room-yn-up"> -->
                <select class="form-control" name="mtgrmAvalYn" id="room-yn-up">
                	<option value="Y">Y</option>
                	<option value="N">N</option>
                </select>
              </div>
              <sec:csrfInput/>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn bg-gradient-secondary text-lg" data-bs-dismiss="modal">닫기</button>
            <button type="button" class="btn bg-gradient-warning text-lg" id="deleteRoom">삭제</button>
            <button type="button" class="btn bg-gradient-info text-lg" form="frmRoomUpdate" id="roomUpdateBtn">등록</button>
          </div>
        </div>
      </div>
    </div>

<!-- 이 위로 모달들! -->

  </div>
<!-- 이 위로 모달 컨테이너 -->


<!-- 전체 div 시작 -->
			<div class="card col-11">
				<div class="card-body pt-2 pb-0">
					<br>
					<span class="text-gradient text-info text-uppercase text-xs font-weight-bold my-2 Heads">Resource management</span>
					<h3 class="card-title d-block text-darker Heads" >자원 관리</h3>
						<div>
							<p class="explains Heads">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
									fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
									  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
									  <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105
									  1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275
									  0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
								</svg>
								자원목록을 클릭하면 정보 수정 및 삭제가 가능합니다.
							</p>
						</div>
						<a class="btn bg-gradient-info text-lg" href="/admin/reserveList">전체 예약목록</a>
				</div>
			</div>

	<div class="row">
<!-- 회의실 관리 div 시작 -->
<div class="col-11">
			<button type="button" class="position-relative btn bg-gradient-info btn-block text-lg mb-3"
				data-bs-toggle="modal" data-bs-target="#CreateRoomModal" style="left:1140px; top:70px; ">
		     	회의실 등록
		    </button>
<h4 class="mb-0 font-weight-bolder Heads mb-1">회의실 관리</h4>
	<p class="explains Heads">
		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
			fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
			  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
			  <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105
			  1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275
			  0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
		</svg>
		현재 등록된 회의실 목록을 확인하고 회의실을 새로 등록할 수 있습니다.
	</p>
<div align="right">
	<div class="card card-body mt-2 mb-4">
		<div class="table-responsive ">
			<table class="table align-items-center mb-0 mx-auto">
				<thead>
					<tr>
						<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">
							순번
						</th>
						<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">
							회의실
						</th>
						<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">
							수용인원
						</th>
						<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7"
						data-bs-toggle="" data-bs-placement="top" title="프로젝터 갯수" data-container="body" data-animation="true"
						>
								<!-- 원래 토글에 tooltip 적혀 있었음 -->
<!-- 							<img class="icon" src="/resources/image/icon_projector.png" alt="프로젝터"> -->
							프로젝터 갯수
						</th>
						<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7"
						data-bs-toggle="" data-bs-placement="top" title="화이트보드 갯수" data-container="body" data-animation="true"
						>
<!-- 							<img class="icon" src="/resources/image/icon_whiteboard.png" alt="화이트보드"> -->
							화이트보드 갯수
						</th>
						<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7"
						data-bs-toggle="" data-bs-placement="top" title="컴퓨터 갯수" data-container="body" data-animation="true"
						>
<!-- 							<img class="icon" src="/resources/image/icon_com.png" alt="컴퓨터"> -->
							데스크탑 갯수
						</th>
						<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7"
						data-bs-toggle="" data-bs-placement="top" title="냉난방기 갯수" data-container="body" data-animation="true"
						>
<!-- 							<img class="icon" src="/resources/image/icon_aircon.png" alt="냉난방기"> -->
							냉난방기 갯수
						</th>
						<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">
							사용가능여부
						</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${mtgrmVOList}" var="roomVO" varStatus="stat">
						<tr class="RoomElement">
							<td class="align-middle text-center">
								<span class="text-secondary text-lg">${stat.count}</span>
								<input type="hidden" value="${roomVO.mtgrmNo}" class="mtgrmNoMy"/>
							</td>
							<td class="align-middle text-center">
								<span class="mb-0 text-lg mtgrmInfoMy">${roomVO.mtgrmInfo}</span>
							</td>
							<td class="align-middle text-center">
								<span class="mb-0 text-lg mtgrmAvarPeoMy">${roomVO.mtgrmAvarPeo}명</span>
							</td>
							<td class="align-middle text-center">
								<span class="text-secondary text-lg mtgrmProjMy">${roomVO.mtgrmProj}개</span>
							</td>
							<td class="align-middle text-center">
								<span class="text-secondary text-lg text-center mtgrmBoMy">${roomVO.mtgrmBo}개</span>
							</td>
							<td class="align-middle text-center">
								<span class="text-secondary text-lg text-center mtgrmPcMy">${roomVO.mtgrmPc}개</span>
							</td>
							<td class="align-middle text-center">
								<span class="text-secondary text-lg text-center mtgrmAirMy">${roomVO.mtgrmAir}개</span>
							</td>
							<td class="align-middle text-center">
								<span class="mb-0 text-lg mtgrmAvalYnMy">${roomVO.mtgrmAvalYn}</span>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
</div>
<!-- 회의실 관리 div 끝 -->
<!-- 차량 관리 div 시작 -->
<div class="col-11">
		    <button type="button" class="position-relative btn bg-gradient-info btn-block text-lg mb-3"
				data-bs-toggle="modal" data-bs-target="#CreateCarModal" style="left:1150px; top:70px; ">
		     	 차량 등록
		    </button>
<h4 class="mb-0 font-weight-bolder Heads mb-1">차량 관리</h4>
	<p class="explains Heads">
		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
			fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
			  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
			  <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105
			  1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275
			  0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
		</svg>
		현재 등록된 차량 목록을 확인하고 새로운 차량을 등록할 수 있습니다.
	</p>
<div align="right">
	<div class="card card-body mt-2 mb-4">
		<div class="table-responsive">
			<table class="table align-items-center mb-0 mx-auto">
				<thead>
					<tr>
						<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">순번</th>
						<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">차량명</th>
						<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">제조사</th>
						<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">차량번호</th>
						<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">차종</th>
						<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">크기</th>
						<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">등록일자</th>
						<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">연료</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${vhrVOList}" var="vhrVO" varStatus="stat">
						<tr class="CarElement">
							<td class="align-middle text-center"><span
								class="text-secondary text-lg">${stat.count}</span>
								<input type="hidden" value="${vhrVO.vhrNo}" class="vhrNoMy"/>
								<input type="hidden" value="${vhrVO.fileGrVO.filesList[0].fileStrgNm}" class="fileStrgNm"/>

							</td>
							<td class="align-middle text-center">
								<span class="mb-0 text-lg vhrNmMy" >${vhrVO.vhrNm}</span>
							</td>
							<td class="align-middle text-center">
								<span class="mb-0 text-lg vhrCmpMy">${vhrVO.vhrCmp}</span>
							</td>
							<td class="align-middle text-center">
								<span class="mb-0 text-lg vhrRegNoMy">${vhrVO.vhrRegNo}</span>
							</td>
							<td class="align-middle text-center">
								<span class="text-secondary text-lg text-center vhrSortMy">${vhrVO.vhrSort}</span>
							</td>
							<td class="align-middle text-center">
								<span class="text-secondary text-lg text-center vhrSzMy">${vhrVO.vhrSz}</span>
							</td>
							<td class="align-middle text-center">
								<span class="text-secondary text-lg text-center vhrRegDtMy"><fmt:formatDate pattern="yyyy-MM-dd" value="${vhrVO.vhrRegDt}" /></span>
							</td>
							<td class="align-middle text-center">
								<span class="text-secondary text-lg text-center vhrFuelMy">${vhrVO.vhrFuel}</span>
								<input type="hidden" value="${vhrVO.vhrInfo}" class="vhrInfoMy"/>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

		</div>
	</div>

</div>
<!-- 차량 관리 div 끝 -->

</div>
<!-- 전체 div 끝 -->

</div>
 <script>
// --------------드롭다운 관련 추가한 코드 ------------------
//프로필 사진 수정모드
 function fn_editImage(){
 	$("#showImage").hide();
 	$("#drop-area").show();
 }

 // 프로필 사진 열람모드
 function fn_editBack(){
 	// 갤러리 div에 원래 담겨있던 프로필 사진으로 되돌려놓기
 	let img =  '<img src="/resources/image/${empVO.empNo}.png" class="border-radius-md" alt="team-2" style="width:200px; height:auto;">';
 	$("#gallery").html(img);
 	$("#showImage").show();
 	$("#drop-area").hide();
 }

 function fn_confirmImage(){

		var formData = new FormData($("#profileImageFrm")[0]);

	    $.ajax({
	        url : "/emp/modifyFile",
	      	type : "POST",
	      	processData : false,
	      	contentType : false,
	      	data : formData,
	    	beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
	        success:function(res) {
	        	// 파일업로드 성공시
	        	// gallery랑 showImage id 부분 다시 로드
//	         	$("#imageSpace")load("${contextPath}/myPage/modifyInfo #gallery");
//	         	$("#imageSpace")load("${contextPath}/myPage/modifyInfo #showImage");
	          alert("성공하였습니다.");
	          console.log(res);
	          fn_editBack();

	      }
	      ,error: function (xhr)
	      {
	          alert(xhr.responseText);
	      }
	  });
	}

 $(function(){
	 $(".RoomElement").click(function(){
		 console.log("RoomElement");
		  var mtgrmNo = $(this).find(".mtgrmNoMy").val();
		  var mtgrmInfo = $(this).find(".mtgrmInfoMy").text();
		  var mtgrmAvarPeo = $(this).find(".mtgrmAvarPeoMy").text();
		  var mtgrmProj = $(this).find(".mtgrmProjMy").text();
		  var mtgrmBo = $(this).find(".mtgrmBoMy").text();
		  var mtgrmPc = $(this).find(".mtgrmPcMy").text();
		  var mtgrmAir = $(this).find(".mtgrmAirMy").text();
		  var mtgrmAvalYn = $(this).find(".mtgrmAvalYnMy").text();

		  $("#room-id-up").val(mtgrmNo);
		  $("#deleteRoom").val(mtgrmNo);

		  $("#room-name-up").val(mtgrmInfo);
		  $("#pop_number-up").val(parseInt(mtgrmAvarPeo));
		  $("#projecter-number-up").val(parseInt(mtgrmProj));
		  $("#computer-number-up").val(parseInt(mtgrmPc));
		  $("#whiteboard-number-up").val(parseInt(mtgrmBo));
		  $("#aircon-number-up").val(parseInt(mtgrmAir));
		  $("#room-yn-up").val(mtgrmAvalYn);
		  $("#UpdateRoomModal").modal("show");
	 });

	 $(".CarElement").click(function(){
		  var vhrNo = $(this).find(".vhrNoMy").val();
		  var vhrNm = $(this).find(".vhrNmMy").text();
		  var vhrCmp = $(this).find(".vhrCmpMy").text();
		  var vhrRegNo = $(this).find(".vhrRegNoMy").text();
		  var vhrSort = $(this).find(".vhrSortMy").text();
		  var vhrSz = $(this).find(".vhrSzMy").text();
		  var vhrRegDt = $(this).find(".vhrRegDtMy").text();
		  var vhrFuel = $(this).find(".vhrFuelMy").text();
		  var vhrInfo = $(this).find(".vhrInfoMy").val();
		  var fileStrgNm = $(this).find(".fileStrgNm").val();

		  $("#vhrNo-up").val(vhrNo);
		  $("#deleteCar").val(vhrNo);

		  $("#vhrNm-up").val(vhrNm);
		  $("#vhrCmp-up").val(vhrCmp);
		  $("#vhrRegNo-up").val(vhrRegNo);
		  $("#vhrSort-up").val(vhrSort);
		  $("#vhrSz-up").val(vhrSz);
		  $("#vhrRegDt-up").val(vhrRegDt);
		  $("#vhrFuel-up").val(vhrFuel);
		  $("#vhrInfo-up").val(vhrInfo);


		  if(fileStrgNm == null||fileStrgNm ==''){
		  	$('#carImg').attr('src', "/resources/image/car-ioniq.png");
		  } else {
		 	 $('#carImg').attr('src', "/resources/upload" + fileStrgNm);
		  }

		  $("#UpdateCarModal").modal("show");
	 });

     $("#deleteRoom").click(function(){
  		console.log(this.value);
  		var data ={
  			mtgrmNo:this.value
  		}

 			$.ajax({
 			    url: "/admin/deleteRoom",
 			    contentType:"application/json;charset:utf-8",
 			    data:JSON.stringify(data),
 			    type:"post",
 	   			beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
 					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
 				},
 			    success: function(response) {
 			    	location.reload();
 			    }
 			});

      });

      $("#deleteCar").click(function(){
  		console.log(this.value);
  		var data ={
  			vhrNo:this.value
  		}

 			$.ajax({
 			    url: "/admin/deleteCar",
 			    contentType:"application/json;charset:utf-8",
 			    data:JSON.stringify(data),
 			    type:"post",
 	   			beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
 					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
 				},
 			    success: function(response) {
 			    	location.reload();
 			    }
 			});
      });

	$(document).on("click","#roomUpdateBtn",function(){
// 		swal({
// 		      title: "회의실 수정하시겠습니까?",
// 		      icon: "success", //success, warning, error
// 		      text: "입력한 내용으로 정보가 바로 반영됩니다.",
// 		      button: "확인",
// 		   }).then(function () {
// 				$("#frmRoomUpdate").submit();
// 		    });


		swal({
     	    title: "회의실 수정하시겠습니까?",
     	    text : "입력한 내용으로 정보가 바로 반영됩니다.",
			icon: "success", //success, warning, error
			buttons: {
				cancel: {
				    text: "취소",
				    value: false,
				    visible: true,
				    className: "btn btn-secondary"
				  },
				  confirm: {
				    text: "확인",
				    value: true,
				    className: "btn btn-success"
				  }
			  },
			closeOnClickOutside: false,
		}).then(function(){
			$("#frmRoomUpdate").submit();
		})
	})
 });

 </script>