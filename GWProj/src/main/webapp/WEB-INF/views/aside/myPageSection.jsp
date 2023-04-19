<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.empVO" var="empVO" />

<div class="container-fluid">
      <div class="page-header min-height-300 border-radius-xl mt-4" style="background-image: url('/resources/image/laptop.jpg'); background-position-y: 50%;">
<!--         <span class="mask bg-gradient-primary opacity-6"></span> -->
      </div>
      <div class="card card-body blur shadow-blur mx-4 mt-n6 overflow-hidden">
        <div class="row gx-4">
          <div class="col-auto">
            <div class="avatar avatar-xl position-relative">
           	<c:choose>
				<c:when test="${not empty empVO.fileGrVO.fileGroupNo}">
                 	<img src="/resources/upload${empVO.fileGrVO.filesList[0].fileStrgNm}" class="w-100 border-radius-lg shadow-sm" alt="team-2" style="width:200px; height:auto;">
				</c:when>
				<c:otherwise>
                	<img src="/resources/upload/emp/profile/default.png" class="w-100 border-radius-lg shadow-sm" alt="team-2" style="width:200px; height:auto;">
				</c:otherwise>
            </c:choose>
            </div>
          </div>
          <div class="col-auto my-auto">
            <div class="h-100">
              <h4 class="mb-1">${empVO.empNm}</h4>
              <p class="mb-0 font-weight-bold text-lg">${empVO.jbpsNm} / ${empVO.deptNm}</p>
            </div>
          </div>
          <div class="col-lg-4 col-md-6 my-sm-auto ms-sm-auto me-sm-0 mx-auto mt-3">
            <div class="nav-wrapper position-relative end-0">
            </div>
          </div>
        </div>
      </div>
    </div>
</sec:authorize>