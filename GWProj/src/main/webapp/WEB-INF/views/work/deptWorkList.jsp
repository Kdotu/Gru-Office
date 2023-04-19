<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script>
$(function(){
 weekNo = ${weekNo}
 year = ${year}
 monthInt = ${month} 
 
 function getLastDayOfMonth(year, month) {
	  return new Date(year, month , 0).getDate();
	}

	lastday = getLastDayOfMonth(year, monthInt); 
	
 if(monthInt<10){
		month = '0'+monthInt;
	}
	
	if(monthInt>12){
		month=1;
		year+=1;
	}
 
 
 
	
 //받아온 weekNo에 따라 날짜 태그에 일자 text()세팅 
 str = ""; 
 if(weekNo == '1'){
	 str += year+"."+month+".01 ~ "+year+"."+month+".07";   
 }else if(weekNo == '2'){
	 str += year+"."+month+".08 ~ "+year+"."+month+".14";
 }else if(weekNo == '3'){
	 str += year+"."+month+".15 ~ "+year+"."+month+".21";
 }else if(weekNo == '4'){
	 str += year+"."+month+".22 ~ "+year+"."+month+".28";
 }else{
	str  +=  year+"."+month+".29 ~ "+year+"."+month+"."+lastday;  
 }
 
 $('#daySetting').text(str); 
 
 cnt = 1; 
 day = []; 
 
 //주차에 해당하는 일자 세팅 
 if(weekNo == '1'){
	 for(i = 1; i <= 7; i++){
		 day[cnt] = "0"+i; 
		 cnt +=1; 
	 }   
 }else if(weekNo == '2'){
	 for(i = 8; i <= 14; i++){
		 if(i < 10){
			 i = "0" + i; 
		 }
		 day[cnt] = i; 
		 cnt +=1;
	 }
 }else if(weekNo == '3'){
	 for(i = 15; i <= 21; i++){
		 day[cnt] = i; 
		 cnt +=1; 
	 }   
 }else if(weekNo == '4'){
	 for(i = 22; i <= 28; i++){
		 day[cnt] = i; 
		 cnt +=1; 
	 }   
 }else{
	 for(i = 29; i <= lastday; i++){
		 day[cnt] = i; 
		 cnt +=1; 
	 }
 }
 

	 // 1~4주차일경우 위에서 받아온 일자 세팅
	 $('#day1').text(day[1]+"일");
	 $('#day2').text(day[2]+"일");
	 $('#day3').text(day[3]+"일");
	 $('#day4').text(day[4]+"일");
	 $('#day5').text(day[5]+"일");
	 $('#day6').text(day[6]+"일");
	 $('#day7').text(day[7]+"일");
	
 
//만약 5주차이면서 마지막일자가 30일이거나 31일 경우 
 if(weekNo == '5' && lastday == 30){
	 $('#day3').text("-");
	 $('#day4').text("-");
	 $('#day5').text("-");
	 $('#day6').text("-");
	 $('#day7').text("-");
	 
	 //day[]에도 세팅해주기 
	 day[3]='-';
	 day[4]='-';
	 day[5]='-';
	 day[6]='-';
	 day[7]='-';
	 
 }else if(weekNo == '5' && lastday == 31){
	 $('#day4').text("-");
	 $('#day5').text("-");
	 $('#day6').text("-");
	 $('#day7').text("-");
	 
	//day[]에도 세팅해주기 
	 day[4]='-';
	 day[5]='-';
	 day[6]='-';
	 day[7]='-';
 }
 
 //다음 주차 버튼 이벤트 
 $('#nextWeek').on('click',function(){
	 
	 weekNo = parseInt(weekNo); 
// 	 alert("weekNo : " + weekNo); 
	 
	 //5주차라면 다음 달로 넘겨야함 
	 if(weekNo==5){
		 month = monthInt+1;
		 weekNo = 1; 
		lastday = getLastDayOfMonth(year, month); 	 
		 if(month < 10){
			 month = '0'+month; 
		 }
	 }else{
		 weekNo = weekNo+1; 
		lastday = getLastDayOfMonth(year, month); 	 
	 }
	 
	 weekNo = weekNo+""; 
	 
	 
// 	 alert('나와 : ' + lastday); 
	 
// 	 alert("year 2023 : "+year);
// 	 alert("month 03 : "+month);
// 	 alert("weekNo 5 : "+weekNo);
	 
	location.href = "/work/deptWorkList?year="+year+"&month="+month+"&weekno="+weekNo+"&lastday="+lastday;
 })
 
 
  //다음 주차 버튼 이벤트 
 $('#lastWeek').on('click',function(){
	 
	 weekNo = parseInt(weekNo); 
// 	 alert("weekNo : " + weekNo); 
	 
	 //5주차라면 다음 달로 넘겨야함 
	 if(weekNo==1){
		 month = monthInt-1;
		 weekNo = 5; 
		lastday = getLastDayOfMonth(year, month); 	 
		 if(month < 10){
			 month = '0'+month; 
		 }
	 }else{
		 weekNo = weekNo-1; 
		lastday = getLastDayOfMonth(year, month); 	 
	 }
	 
	 weekNo = weekNo+""; 
	 
	 
// 	 alert('나와 : ' + lastday); 
	 
// 	 alert("year 2023 : "+year);
// 	 alert("month 03 : "+month);
// 	 alert("weekNo 5 : "+weekNo);
	 
	location.href = "/work/deptWorkList?year="+year+"&month="+month+"&weekno="+weekNo+"&lastday="+lastday;
 })
 
 //검색 버튼 누르면 리스트를 다시 출력 
 $('#search').on('click', function(){
	number = $('#searchNum').val(); 
	choice = $('#choices-tm').val(); 
	
	// 데이터로 보낼 것들 
	let data = {"number" : number,
				"choice" : choice,
				"year" : year,
				"month" : month,
				"weekno" : weekNo,
				"lastday" : lastday};
	
	$.ajax({
		url:"/work/deptWorkSearch",
		type:"post",
		data: JSON.stringify(data),
		contentType:"application/json;charset=utf-8",
		beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
               xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success:function(result){
			console.log("리저트 : " + result); 
			str = ""; 
			                 
	str+="		<div class='table-responsive'>";
	str+="	<table class='table table-flush' id='datatable-search'>                                                          ";
	str+="	<thead class='thead-light'>                                                                                      ";
	str+="		<tr>                                                                                                         ";
	str+="			<th data-sortable=''                                                                                     ";
	str+="				style='width: 13%; font-size: 1.3em; text-align: center;'><a                                         ";
	str+="				href='#' class='dataTable-sorter'>이름</a></th>                                                      ";
	str+="			<th data-sortable=''                                                                                     ";
	str+="				style='width: 13%; font-size: 1.3em; text-align: center;'><a                                         ";
	str+="				href='#' class='dataTable-sorter'>누적근무시간</a></th>                                              ";
	str+="			<th data-sortable=''                                                                                     ";
	str+="				style='width: 13%; font-size: 1.3em; text-align: center;' id='day1'><a                               ";
	str+="				href='#' class='dataTable-sorter' >"+day[1]+"일</a></th>                                                       ";
	str+="			<th data-sortable=''                                                                                     ";
	str+="				style='width: 13%; font-size: 1.3em; text-align: center;' id='day2'><a                               ";
	str+="				href='#' class='dataTable-sorter' >"+day[2]+"일</a></th>                                                       ";
	str+="			<th data-sortable=''                                                                                     ";
	str+="				style='width: 13%; font-size: 1.3em; text-align: center;' id='day3'><a                               ";
	str+="				href='#' class='dataTable-sorter' >"+day[3]+"일</a></th>                                                       ";
	str+="			<th data-sortable=''                                                                                     ";
	str+="				style='width: 13%; font-size: 1.3em; text-align: center;' id='day4'><a                               ";
	str+="				href='#' class='dataTable-sorter' >"+day[4]+"일</a></th>                                                       ";
	str+="			<th data-sortable=''                                                                                     ";
	str+="				style='width: 13%; font-size: 1.3em; text-align: center;' id='day5'><a                               ";
	str+="				href='#' class='dataTable-sorter' >"+day[5]+"일</a></th>                                                       ";
	str+="			<th data-sortable=''                                                                                     ";
	str+="				style='width: 13%; font-size: 1.3em; text-align: center;' id='day6'><a                               ";
	str+="				href='#' class='dataTable-sorter' >"+day[6]+"일</a></th>                                                       ";
	str+="			<th data-sortable=''                                                                                     ";
	str+="				style='width: 13%; font-size: 1.3em; text-align: center;' id='day7'><a                               ";
	str+="				href='#' class='dataTable-sorter' >"+day[7]+"일</a></th>                                                       ";
	str+="		</tr>                                                                                                        ";
	str+="	</thead>                                                                                                         ";
	str+="	<tbody>                                                                                                          ";
	$.each(result,function(i,v){
	str+="		<tr>                                                                                                         ";
	str+="			<td>                                                                                                     ";
	str+="				<div class='d-flex align-items-center'                                                               ";
	str+="					style='margin-left: 20px;'>                                                                      ";
	str+="					<div class='form-check' style='margin-left:-20px;'></div>                                                                   ";
	str+="					<p class='font-weight-bold ms-2 mb-0' style='font-size:1.2em;'> "+v.empNm+"&nbsp; "+v.jbpsNm+"</p>     ";
	str+="				</div>                                                                                               ";
	str+="			</td>                                                                                                    ";
	str+="			<td class='font-weight-bold' style='text-align: center; color:red;'><span class='my-2' style='font-size:1.1em;'           ";
	str+="				>"+v.total+"</span></td>                                                                      ";
	str+="			<td class='font-weight-bold' >                                                                   ";
	str+="				<div class='d-flex align-items-center' style='margin-left: 20px;'>                                   ";
	str+="					<span style='font-size:1.2em;'>"+v.mon+"</span>                                                                   ";
	str+="				</div>                                                                                               ";
	str+="			</td>                                                                                                    ";
	str+="			<td class='font-weight-bold' >                                                                   ";
	str+="				<div class='d-flex align-items-center' style='margin-left: 20px;'>                                   ";
	str+="					<span style='font-size:1.2em;'> "+ v.tue +"</span>                                                                    ";
	str+="				</div>                                                                                               ";
	str+="			</td>                                                                                                    ";
	str+="			<td class='font-weight-bold' style='text-align: center;'><span                                   ";
	str+="				class='my-2' style='font-size:1.2em;'>                                                                                ";
	str+="					 " + v.wed +" </span></td>                                                                    ";
	str+="			<td class='font-weight-bold' style='text-align: center;'><span                                   ";
	str+="				class='my-2' style='font-size:1.2em;'> "+ v.thu +" </span></td>                                                  ";
	str+="			<td class='font-weight-bold'                                                                     ";
	str+="				style='text-align: center;'><span class='my-2' style='font-size:1.2em;'>"+ v.fri +" </span></td>                ";
	str+="			<td class='font-weight-bold'                                                                     ";
	str+="				style='text-align: center;'><span class='my-2' style='font-size:1.2em;'>" + v.sat +"</span></td>                   ";
	str+="			<td class='font-weight-bold'                                                                     ";
	str+="				style='text-align: center;'><span class='my-2' style='font-size:1.2em;'>" + v.sun +"</span></td>                   ";
	str+="		</tr>                                                                                                        ";
	}); //반복문 끝 
	str+="	</tbody>                                                                                                         ";
	str+="	</div>                                                                                                         ";
			
	$('#searchDiv').html(str); 		
		} //success끝 
	});
	 
 })
 
 
}) //ready function 종료 

</script>

<script src="/resources/maincss/assets/js/plugins/datatables.js"></script>
<div class="row">
	<div class="col-2">
		<jsp:include page="/WEB-INF/views/aside/workAside.jsp" />
	</div>
	<div class="col-10">
		<div class="d-flex mt-4 pt-2"
			style="text-align: center; margin-left: 480px;">
			<button id="lastWeek" class="btn btn-outline-black rounded-circle p-2 mb-0"
				type="button" style="background: white; margin-top: -10px;">
				<i class="fas fa-backward p-2" aria-hidden="true"></i>
			</button>
			&nbsp;&nbsp;&nbsp;
			<h4 id="daySetting"></h4>
			&nbsp;&nbsp;&nbsp;
			<button id="nextWeek" class="btn btn-outline-black rounded-circle p-2 mb-0"
				type="button"  style="background: white; margin-top: -10px;">
				<i class="fas fa-forward p-2" aria-hidden="true"></i>
			</button>
		</div>
		
		
		

		<div class="container-fluid py-4">
				
			<div class="row">
				<div class="col-8">
					<div class="row">
						<div class="col-lg-2" style="width: 230px;">
							<div class="input-group mb-4">
								<span class="input-group-text"><i
									class="ni ni-zoom-split-in"></i></span> <input id="searchNum" class="form-control"
									placeholder="업무시간(주52시간)" type="number" onfocus="focused(this)"
									onfocusout="defocused(this)" style="height:48px; font-size:1.1em;">
							</div>
						</div>
						<div class="col-lg-2" style="margin-left: -20px; width:190px;">
							<select class="form-control" name="choices-tm"
								id="choices-tm"></select> 
						</div>
						<div class="col-lg-3" style="margin-left: -13px;">
							<button type="button" id="search" class="btn btn-secondary" style="width: 90px; font-size:1.0em;">검색</button>
						</div>
					</div>
				</div>
				<div class="col-4" align="right">
					<div class="d-sm-flex justify-content-between" style="margin-left: 210px;">
					<div class="d-flex">
						<button class="btn btn-icon btn-outline-dark ms-2 export"
							data-type="csv" type="button" style="width: 180px;">
							<span class="btn-inner--icon"><i class="ni ni-archive-2"></i></span>
							<span class="btn-inner--text">EXCEL download</span>
						</button>
					</div>
				</div>
				</div>
			</div>
			<div class="row">
					<div class="col-12">
						<div class="card">
							<div id="searchDiv">
							<div class="table-responsive"> 
								<table class="table table-flush" id="datatable-search">
									<thead class="thead-light">
										<tr>
											<th data-sortable=""
												style="width: 13%; font-size: 1.3em; text-align: center;"><a
												href="#" class="dataTable-sorter">이름</a></th>
											<th data-sortable=""
												style="width: 13%; font-size: 1.3em; text-align: center;"><a
												href="#" class="dataTable-sorter">누적근무시간</a></th>
											<th data-sortable=""
												style="width: 20%; font-size: 1.3em; text-align: center;" id="day1"><a
												href="#" class="dataTable-sorter" >00</a></th>
											<th data-sortable=""
												style="width: 13%; font-size: 1.3em; text-align: center;" id="day2"><a
												href="#" class="dataTable-sorter" >00</a></th>
											<th data-sortable=""
												style="width: 13%; font-size: 1.3em; text-align: center;" id="day3"><a
												href="#" class="dataTable-sorter" >00</a></th>
											<th data-sortable=""
												style="width: 13%; font-size: 1.3em; text-align: center;" id="day4"><a
												href="#" class="dataTable-sorter" >00</a></th>
											<th data-sortable=""
												style="width: 13%; font-size: 1.3em; text-align: center;" id="day5"><a
												href="#" class="dataTable-sorter" >00</a></th>
											<th data-sortable=""
												style="width: 13%; font-size: 1.3em; text-align: center;" id="day6"><a
												href="#" class="dataTable-sorter" >00</a></th>
											<th data-sortable=""
												style="width: 13%; font-size: 1.3em; text-align: center;" id="day7"><a
												href="#" class="dataTable-sorter" >00</a></th>
										</tr>
									</thead>
									<tbody>
									<c:forEach var="work3VO" items="${workList }" varStatus="stat">
										<tr>
											<td>
												<div class="d-flex align-items-center"
													style="margin-left: 20px;">
													<div class="form-check" style="margin-left:-30px;"></div>
													<p class="font-weight-bold ms-2 mb-0" style="font-size:1.1em;">${work3VO.empNm }&nbsp; ${work3VO.jbpsNm }</p>
												</div>
											</td>
											<td class="font-weight-bold" style="text-align: center; color:red;"><span class="my-2"
												style="font-size:1.1em;"> ${work3VO.total }</span></td>
											<td class="font-weight-bold" style="font-size:1.1em;" >
												<div class="d-flex align-items-center" style="margin-left: 20px;">
													<span>  ${work3VO.mon }</span>
												</div>
											</td>
											<td class="font-weight-bold" style="font-size:1.1em;" >
												<div class="d-flex align-items-center" style="margin-left: 20px;">
													<span> ${work3VO.tue }</span>
												</div>
											</td>
											<td class="font-weight-bold" style="text-align: center;"><span
												class="my-2 " style="font-size:1.1em;">
													 ${work3VO.wed } </span></td>
											<td class="font-weight-bold" style="text-align: center;"><span
												class="my-2" style="font-size:1.1em;">  ${work3VO.thu } </span></td>
											<td class=" font-weight-bold"
												style="text-align: center;"><span class="my-2" style="font-size:1.1em;">  ${work3VO.fri } </span></td>
											<td class="font-weight-bold"
												style="text-align: center;"><span class="my-2" style="font-size:1.1em;">${work3VO.sat }</span></td>
											<td class="font-weight-bold"
												style="text-align: center;"><span class="my-2" style="font-size:1.1em;">${work3VO.sun }</span></td>
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

<!-- choices 자바스크립트 -->
<script>

if (document.getElementById('choices-tm')) {
	var tm = document.getElementById('choices-tm');
	setTimeout(function() {
		const example = new Choices(tm);
	}, 1);

	var tmArray = new Array();
	tmArray[0] = "미만";
	tmArray[1] = "초과";
	
	for (m = 0; m < tmArray.length; m++) {
		var optn = document.createElement("OPTION");
		optn.text = tmArray[m];
		optn.value = tmArray[m];
		if (m == "초과") {
			optn.selected = true;
		}
		tm.options.add(optn);
	}
}

	if (document.getElementById('choices-year')) {
		var year = document.getElementById('choices-year');
		setTimeout(function() {
			const example = new Choices(year);
		}, 1);

		for (y = 1900; y <= 2020; y++) {
			var optn = document.createElement("OPTION");
			optn.text = y;
			optn.value = y;

			if (y == 2020) {
				optn.selected = true;
			}

			year.options.add(optn);
		}
	}

	if (document.getElementById('choices-day')) {
		var day = document.getElementById('choices-day');
		setTimeout(function() {
			const example = new Choices(day);
		}, 1);

		for (y = 1; y <= 31; y++) {
			var optn = document.createElement("OPTION");
			optn.text = y;
			optn.value = y;

			if (y == 1) {
				optn.selected = true;
			}

			day.options.add(optn);
		}

	}

	if (document.getElementById('choices-month')) {
		var month = document.getElementById('choices-month');
		setTimeout(function() {
			const example = new Choices(month);
		}, 1);

		var d = new Date();
		var monthArray = new Array();
		monthArray[0] = "1";
		monthArray[1] = "2";
		monthArray[2] = "3";
		monthArray[3] = "4";
		monthArray[4] = "5";
		monthArray[5] = "6";
		monthArray[6] = "7";
		monthArray[7] = "8";
		monthArray[8] = "9";
		monthArray[9] = "10";
		monthArray[10] = "11";
		monthArray[11] = "12";
		for (m = 0; m <= 11; m++) {
			var optn = document.createElement("OPTION");
			optn.text = monthArray[m];
			// server side month start from one
			optn.value = (m + 1);
			// if june selected
			if (m == 1) {
				optn.selected = true;
			}
			month.options.add(optn);
		}
	}

	function visible() {
		var elem = document.getElementById('profileVisibility');
		if (elem) {
			if (elem.innerHTML == "Switch to visible") {
				elem.innerHTML = "Switch to invisible"
			} else {
				elem.innerHTML = "Switch to visible"
			}
		}
	}

	var openFile = function(event) {
		var input = event.target;

		// Instantiate FileReader
		var reader = new FileReader();
		reader.onload = function() {
			imageFile = reader.result;

			document.getElementById("imageChange").innerHTML = '<img width="200" src="' + imageFile + '" class="rounded-circle w-100 shadow" />';
		};
		reader.readAsDataURL(input.files[0]);
	};
</script>
<script>
	var win = navigator.platform.indexOf('Win') > -1;
	if (win && document.querySelector('#sidenav-scrollbar')) {
		var options = {
			damping : '0.5'
		}
		Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
	}
</script>