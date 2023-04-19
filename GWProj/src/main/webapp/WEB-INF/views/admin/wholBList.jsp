<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 전체게시판 목록 -->
<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-3">
			<jsp:include page="/WEB-INF/views/aside/boardAside.jsp" />
		</div>
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4">
	<div class="row">
        <div class="col-12">
          <div class="card">
            <div class="card-header">
              <h3 class="mb-0">전사게시판</h3>
              <p class="text-sm mb-0">

              </p>
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
                  </tr>
                </thead>
                <tbody>
                	<c:forEach var="wholBVO" items="${data}" varStatus="stat">
	                  <tr>
	                    <td class="text-md font-weight-normal">${wholBVO.rnum}</td>
	                    <td class="text-md font-weight-normal">
	                    <a href="/board/noticeBDetail?wholBbsNo=${wholBVO.wholBbsNo}">${wholBVO.wholBbsTtl}</a>
	                    </td>
	                    <td class="text-md font-weight-normal">${wholBVO.empNm}</td>
	                    <td class="text-md font-weight-normal">
	                    <fmt:formatDate value="${wholBVO.wholBbsRegYmd}" pattern="yyyy-MM-dd HH:mm:ss" />
	                    </td>
	                    <td class="text-md font-weight-normal">${wholBVO.wholBbsInqCnt}</td>
	                  </tr>
                    </c:forEach>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
     </div>
    </div>
   </div>

