<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- jQuery -->
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="/resources/maincss/assets/js/plugins/datatables.js"></script>


<!-- 부서게시판 목록 -->
<!-- body_left -->
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/boardAside.jsp" />
		</div>
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4">

<div class="row mt-4">
        <div class="col-12">
          <div class="card">

          	<div class="row" style="margin: 10px;">
<!-- 				<div class="col-9" > -->
<!-- 					<button type="button" class="btn btn-outline-dark btn-sm">글쓰기</button> -->
<!-- 									<button type="button" class="btn btn-outline-dark btn-sm">메일발송</button> -->
<!-- 									<button type="button" class="btn btn-outline-danger btn-sm">삭제</button> -->
<!-- 				</div> -->


			</div>

					<div class="card-header">
              <h2 class="mb-0">부서게시판</h2>
              <p class=" mb-0">
											<p class="text-mb mb-0 mx-3">
												<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle"viewBox="0 0 16 16">
									  				<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
									  				<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
												</svg>
												 자신이 속한 부서게시판의 조회 및 글등록이 가능합니다.
											</p>
              </p>
            </div>

            <div class="table-responsive">
              <table class="table align-items-center mb-0">
                <thead>
                  <tr>                    
					<th style="font-size:1.3em; text-align:center;"
						class="text-uppercase  font-weight-bolder">No</th>
					<th style="font-size:1.3em; text-align:center;"
						class="text-uppercase  font-weight-bolder">글제목</th>
					<th style="font-size:1.3em; text-align:center;"
						class="text-uppercase  font-weight-bolder ps-2">작성자</th>
					<th style="font-size:1.3em; text-align:center;"
						class="text-uppercase  font-weight-bolder ps-2">등록일자</th>
					<th style="font-size:1.3em; text-align:center;"
						class="text-uppercase  font-weight-bolder ps-2">조회수</th>
                 	</tr>
                </thead>
                <tbody>
                	<c:forEach var="wholBVO" items="${data}" varStatus="stat">
	                  <tr>
	                    <td style="font-size:1.2em; text-align:center;">${wholBVO.rnum}</td>
	                    <td style="font-size:1.2em; text-align:center;">${wholBVO.wholBbsTtl}</td>
	                    <td style="font-size:1.2em; text-align:center;">${wholBVO.empNm}</td>
	                    <td style="font-size:1.2em; text-align:center;">
	                    <fmt:formatDate value="${wholBVO.wholBbsRegYmd}" pattern="yyyy-MM-dd HH:mm:ss" />
	                    </td>
	                   <td style="font-size:1.2em; text-align:center;">${wholBVO.wholBbsInqCnt}</td>
	                  </tr>
                    </c:forEach>

                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>

<script type="text/javascript">
const dataTableSearch = new simpleDatatables.DataTable("#datatable-search", {
    searchable: true,
    fixedHeight: false,
    perPageSelect: false
  });

  document.querySelectorAll(".export").forEach(function(el) {
    el.addEventListener("click", function(e) {
      var type = el.dataset.type;

      var data = {
        type: type,
        filename: "부서 근태현황",
      };

      if (type === "csv") {
        data.columnDelimiter = "|";
      }

      dataTableSearch.export(data);
    });
  });
  </script>
  <script>
		var win = navigator.platform.indexOf('Win') > -1;
		if (win && document.querySelector('#sidenav-scrollbar')) {
			var options = {
				damping : '0.5'
			}
			Scrollbar.init(document.querySelector('#sidenav-scrollbar'),
					options);
		}
	</script>