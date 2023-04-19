<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
.choices__list--single{
 font-size: 1.2em;
}
</style>


<div class="row">
	<div class="col-12">

			<div class="card-header pb-0">
				<div class="d-lg-flex">
				</div>
			</div>
			<!-- data-table 시작 -->
			<div class="container-fluid py-4">
				<div class="row d-sm-flex justify-content-between" align="left" style="margin-left: -6780px; margin-bottom:20px;">
					<div class="col-2 ms-auto my-auto mt-lg-0 mt-4" >
						<div class="ms-auto my-auto" >
								<a class="btn bg-gradient-info text-lg" href="/admin/empCreate" style="margin-bottom:10px;">+&nbsp;
								사원 등록</a>
						</div>
					</div>
<!-- 					<div class="col-2 d-flex"> -->
<!-- 						<button class="btn btn-icon btn-outline-dark ms-2 export" -->
<!-- 							data-type="csv" type="button"> -->
<!-- 							<span class="btn-inner--icon"><i class="ni ni-archive-2"></i></span> -->
<!-- 							<span class="btn-inner--text">EXCEL download</span> -->
<!-- 						</button> -->
<!-- 					</div> -->
				</div>
				<div class="row" style="margin-top:-17px;">
					<div class="col-12">
						<div class="card">
							<div class="table-responsive">
							<div style="width:170px; margin-top:10px; margin-left:10px;">
								<select id="empSearch" name="empSearch"></select>
							</div>
								<div id="empS">
								<table class="table table-flush" id="datatable-search">
									<thead class="thead-light">
										<tr>
											<th data-sortable=""
												style="width: 13%; font-size: 1.3em; text-align: center;"><a
												href="#" class="dataTable-sorter">NO.</a></th>
											<th data-sortable=""
												style="width: 13%; font-size: 1.3em; text-align: center;"><a
												href="#" class="dataTable-sorter">사원번호</a></th>
											<th data-sortable=""
												style="width: 20%; font-size: 1.3em; text-align: left;"><a
												href="#" class="dataTable-sorter">사원명</a></th>
											<th data-sortable=""
												style="width: 13%; font-size: 1.3em; text-align: left;"><a
												href="#" class="dataTable-sorter">부서</a></th>
											<th data-sortable=""
												style="width: 13%; font-size: 1.3em; text-align: center;"><a
												href="#" class="dataTable-sorter">직위</a></th>
											<th data-sortable=""
												style="width: 13%; font-size: 1.3em; text-align: center;"><a
												href="#" class="dataTable-sorter">입사일</a></th>
										</tr>
									</thead>
									<tbody>
									<c:forEach var="empVO" items="${empVOList}" varStatus="stat">
										<tr>
											<td>
												<div class="d-flex align-items-center"
													style="margin-left: 20px;">
													<div class="form-check"></div>
													<p class="font-weight-bold ms-2 mb-0" style="font-size:1.2em;">${stat.count}</p>
												</div>
											</td>
											<td class="font-weight-bold" style="text-align: center;"><span class="my-2" style="font-size:1.2em;"
												><a href ="/admin/updateEmp?empNo=${empVO.empNo}">${empVO.empNo }</a></span></td>
											<td class="font-weight-bold" style="text-align: center;">
												<div class="d-flex align-items-center">
													<button style="margin-left: 10px;"
														class="btn btn-icon-only btn-rounded btn-outline-success mb-0 me-2 btn-sm d-flex align-items-center 															justify-content-center">
														<i class="fas fa-check" aria-hidden="true"></i>
													</button>
													<span style="font-size:1.2em;">${empVO.empNm }</span>
												</div>
											</td>
											<td class="font-weight-bold" >
												<div class="d-flex align-items-center" style="margin-left: 20px;">
													<span style="font-size:1.2em; margin-left:-30px;">${empVO.deptNm }</span>
												</div>
											</td>
											<td class="font-weight-bold" style="text-align: center;"><span
												class="my-2" style="font-size:1.2em;">
													${empVO.jbpsNm }</span></td>
											<td class="font-weight-bold" style="text-align: center;"><span
												class="my-2" style="font-size:1.2em;"><fmt:formatDate value="${empVO.empJncmpYmd}" pattern="yyyy-MM-dd" /></span></td>
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
			<!-- data-table 끝 -->
		</div>
	</div>


<script src="/resources/maincss/assets/js/plugins/datatables.js"></script>
<script src="/resources/maincss/assets/js/plugins/choices.min.js"></script>

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
        filename: "사원목록",
      };

      if (type === "csv") {
        data.columnDelimiter = "|";
      }

      dataTableSearch.export(data);
    });
  });
  
  
  if (document.getElementById('empSearch')) {
		var empSearch = document.getElementById('empSearch');
		setTimeout(function() {
			const example = new Choices(empSearch);
		}, 1);

		var empSearchArray = new Array();
		empSearchArray[0] = "선택";
		empSearchArray[1] = "재직";
		empSearchArray[2] = "퇴직";
		
		
		
		var empValArray = new Array();
		empValArray[0] = "-";
		empValArray[1] = "HDOF0001";
		empValArray[2] = "HDOF0002";
	
		
		for (m = 0; m < empSearchArray.length; m++) {
			var optn = document.createElement("OPTION");
			optn.text = empSearchArray[m];
			optn.value = empValArray[m];
			if (empSearchArray[m] == "선택") {
				optn.selected = true;
			}
			empSearch.options.add(optn);
		}
	}
  
  $('#empSearch').on('change', function(){
	  	  
	  
			//사원 번호 변수에 담기 
			let empHdofYn = $(this).val();
			
			if(empHdofYn == '-'){
				location.reload();
			}
			
			let data = {"empHdofYn" : empHdofYn};
			
			$.ajax({
				url:"/admin/empSearch",
				type:"post",
				data: JSON.stringify(data),
				contentType:"application/json;charset=utf-8",
				beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
	                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				success:function(result){
					console.log(result); 
					
					cnt = 1; 
					str = ""; 
					
			str+="	<table class='table table-flush' id='datatable-search'>                                                                                                ";
			str+="	<thead class='thead-light'>                                                                                                                            ";
			str+="		<tr>                                                                                                                                               ";
			str+="			<th data-sortable=''                                                                                                                           ";
			str+="				style='width: 13%; font-size: 1.3em; text-align: center;'><a                                                                               ";
			str+="				href='#' class='dataTable-sorter'>NO.</a></th>                                                                                             ";
			str+="			<th data-sortable=''                                                                                                                           ";
			str+="				style='width: 13%; font-size: 1.3em; text-align: center;'><a                                                                               ";
			str+="				href='#' class='dataTable-sorter'>사원번호</a></th>                                                                                        ";
			str+="			<th data-sortable=''                                                                                                                           ";
			str+="				style='width: 20%; font-size: 1.3em; text-align: left;'><a                                                                                 ";
			str+="				href='#' class='dataTable-sorter'>사원명</a></th>                                                                                          ";
			str+="			<th data-sortable=''                                                                                                                           ";
			str+="				style='width: 13%; font-size: 1.3em; text-align: left;'><a                                                                                 ";
			str+="				href='#' class='dataTable-sorter'>부서</a></th>                                                                                            ";
			str+="			<th data-sortable=''                                                                                                                           ";
			str+="				style='width: 13%; font-size: 1.3em; text-align: center;'><a                                                                               ";
			str+="				href='#' class='dataTable-sorter'>직위</a></th>                                                                                            ";
			str+="			<th data-sortable=''                                                                                                                           ";
			str+="				style='width: 13%; font-size: 1.3em; text-align: center;'><a                                                                               ";
			str+="				href='#' class='dataTable-sorter'>입사일</a></th>                                                                                          ";
			str+="		</tr>                                                                                                                                              ";
			str+="	</thead>                                                                                                                                               ";
			str+="	<tbody>                                                                                                                                                ";
			
			$.each(result,function(i,v){
			str+="		<tr>                                                                                                                                               ";
			str+="			<td>                                                                                                                                           ";
			str+="				<div class='d-flex align-items-center'                                                                                                     ";
			str+="					style='margin-left: 20px;'>                                                                                                            ";
			str+="					<div class='form-check'></div>                                                                                                         ";
			str+="					<p class='text-md font-weight-bold ms-2 mb-0'>"+cnt+"</p>                                                                        ";
			
			cnt+=1; 
			
			str+="				</div>                                                                                                                                     ";
			str+="			</td>                                                                                                                                          ";
			str+="			<td class='font-weight-bold' style='text-align: center;'><span class='my-2 text-md'                                                            ";
			str+="				><a href ='/admin/updateEmp?empNo="+v.empNo+"'>"+ v.empNo+"</a></span></td>                                                                                                               ";
			str+="			<td class='text-md font-weight-bold' style='text-align: center;'>                                                                              ";
			str+="				<div class='d-flex align-items-center'>                                                                                                    ";
			str+="					<button style='margin-left: 10px;'a                                                                                                    ";
			str+="						class='btn btn-icon-only btn-rounded btn-outline-success mb-0 me-2 btn-sm d-flex align-items-center justify-content-center'>       ";
			str+="						<i class='fas fa-check' aria-hidden='true'></i>                                                                                    ";
			str+="					</button>                                                                                                                              ";
			str+="					<span>"+v.empNm+"</span>                                                                                                           ";
			str+="				</div>                                                                                                                                     ";
			str+="			</td>                                                                                                                                          ";
			str+="			<td class='text-md font-weight-bold' >                                                                                                         ";
			str+="				<div class='d-flex align-items-center' style='margin-left: 20px;'>                                                                         ";
			str+="					<span>"+v.deptNm+"</span>                                                                                                          ";
			str+="				</div>                                                                                                                                     ";
			str+="			</td>                                                                                                                                          ";
			str+="			<td class='text-md font-weight-bold' style='text-align: center;'><span                                                                         ";
			str+="				class='my-2 text-md'>                                                                                                                      ";
			str+="					"+v.jbpsNm+"</span></td>                                                                                                           ";
			str+="			<td class='text-md font-weight-bold' style='text-align: center;'><span                                                                         ";
			str+="				class='my-2 text-md'>"+v.empJncmpYmds+"</span></td>                                      ";
			str+="		</tr>	                                                                                                                                           ";
			})
			str+="	</tbody>                                                                                                                                               ";
					
					
					
					
					
					
					
					$('#empS').html(str); 
					
					
					
					
			}
			
		})

  })
  
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