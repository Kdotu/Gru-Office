<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- jQuery -->
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="/resources/maincss/assets/js/plugins/datatables.js"></script>

<sec:authorize access="isAuthenticated()">
	<!-- CustomUser.java에서 private EmpVO empVO() 멤버변수를 principal 객체를 통해 사용 가능 -->
	<sec:authentication property="principal.empVO" var="empVO" />
</sec:authorize>


<!-- 공지게시판 목록 -->
<!-- body_left -->
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-3">
			<jsp:include page="/WEB-INF/views/aside/boardAside.jsp" />
		</div>
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4">

<div class="row">
        <div class="col-12">
          <div class="card">

          	<div class="row">
				<div class="col-9" >
<!-- 					<a href="/admin/noticeBWrite" class="btn btn-outline-dark btn-sm">글쓰기</a> -->
<!-- 					<button type="button" class="btn btn-outline-dark btn-sm">글쓰기</button> -->
<!-- 					<button type="button" class="btn btn-outline-dark btn-sm">메일발송</button> -->
<!-- 					<button type="button" class="btn btn-outline-danger btn-sm">삭제</button> -->
				</div>


			</div>

            <div class="card-header">
              <h4 class="mb-0">공지게시판</h4>
            </div>
            <div class="table-responsive">
              <table class="table table-flush" id="datatable-search">
                <thead class="thead-light">
                  <tr>
                    <th style="font-size: 1.1em;">No</th>
                    <th style="font-size: 1.1em;">글제목</th>
                    <th style="font-size: 1.1em;">작성자</th>
                    <th style="font-size: 1.1em;">등록일자</th>
                    <th style="font-size: 1.1em;">조회수</th>
<!--                     <th>팝업여부</th> -->
                  </tr>
                </thead>
                <tbody>
                	<c:forEach var="wholBVO" items="${data}" varStatus="stat">
	                  <tr>
	                    <td class="text-lg font-weight-normal">${wholBVO.rnum}</td>
	                    <td class="text-lg font-weight-normal">
	                    <a href="/admin/admNoticeDtl?wholBbsNo=${wholBVO.wholBbsNo}">${wholBVO.wholBbsTtl}</a>
	                    </td>
	                    <td class="text-lg font-weight-normal">${wholBVO.empNm}</td>
	                    <td class="text-lg font-weight-normal">
	                    <fmt:formatDate value="${wholBVO.wholBbsRegYmd}" pattern="yyyy-MM-dd HH:mm:ss" />
	                    </td>
	                    <td class="text-lg font-weight-normal">${wholBVO.wholBbsInqCnt}</td>
<%-- 	                    <c:if test="${wholBVO.popupYn eq 'Y'}"> --%>
<!-- 	                    	<td class="text-sm font-weight-normal">적용</td> -->
<%-- 	                    </c:if> --%>
<%-- 	                    <c:if test="${wholBVO.popupYn eq 'N'}"> --%>
<!-- 	                    	<td class="text-sm font-weight-normal">미적용</td> -->
<%-- 	                    </c:if> --%>
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