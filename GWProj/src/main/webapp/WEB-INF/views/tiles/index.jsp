<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="apple-touch-icon" sizes="76x76" href="/resources/maincss/assets/img/apple-icon.png">
<link rel="icon" type="image/png" href="/resources/maincss/assets/img/bear2.png">
<title>GruOffice</title>

<!-- 조직도 스크립트 -->
<!-- 조직도 스크립트 css만 주석처리하면 우리 부트스트랩 css랑 충돌안남 -->
<!--  <link rel="stylesheet" href="/resources/css/jquery.treeview.css" />  -->
<!--  	<link rel="stylesheet" href="/resources/css/screen.css" />  -->

<!-- 폰트 설정 -->
<style>
	@font-face {
    font-family: 'LINESeedKR-Bd';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/LINESeedKR-Bd.woff2') format('woff2');
    font-weight: 700;
    font-style: normal;
}
@font-face {
    font-family: 'TheJamsil5Bold';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/TheJamsil5Bold.woff2') format('woff2');
    font-weight: 700;
    font-style: normal;
}
p, h1, h2, h3, h4, h5, h6, span, div, a, button, dl, dd{
    font-family: 'LINESeedKR-Bd';
}
.folder{
font-size:1.3em;
}

.file{
font-size:1.3em;
}
</style>

<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="/resources/js/jquery.cookie.js"></script>
<script src="/resources/js/jquery.treeview.js"></script>
<script type="text/javascript" src="/resources/js/demo.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		$("#browser").treeview({
			toggle: function() {
				console.log("%s was toggled.", $(this).find(">span").text());
			}
		});

		$("#add").click(function() {
			var branches = $("<li><span class='folder'>New Sublist</span><ul>" +
				"<li><span class='file'>Item1</span></li>" +
				"<li><span class='file'>Item2</span></li></ul></li>").appendTo("#browser");
			$("#browser").treeview({
				add: branches
			});
		});
	});
</script>
<!-- 조직도 스크립트 끝-->
<link rel="canonical" href="https://www.creative-tim.com/product/soft-ui-dashboard-pro" />

<meta name="keywords" content="creative tim, html dashboard, html css dashboard, web dashboard, bootstrap 5 dashboard, bootstrap 5, css3 dashboard, bootstrap 5 admin, soft ui dashboard bootstrap 5 dashboard, frontend, responsive bootstrap 5 dashboard, soft design, soft dashboard bootstrap 5 dashboard">
<meta name="description" content="Soft UI Dashboard PRO is a beautiful Bootstrap 5 admin dashboard with a large number of components, designed to look beautiful, clean and organized. If you are looking for a tool to manage dates about your business, this dashboard is the thing for you.">

<meta name="twitter:card" content="product">
<meta name="twitter:site" content="@creativetim">
<meta name="twitter:title" content="Soft UI Dashboard PRO by Creative Tim">
<meta name="twitter:description" content="Soft UI Dashboard PRO is a beautiful Bootstrap 5 admin dashboard with a large number of components, designed to look beautiful, clean and organized. If you are looking for a tool to manage dates about your business, this dashboard is the thing for you.">
<meta name="twitter:creator" content="@creativetim">
<meta name="twitter:image" content="https://s3.amazonaws.com/creativetim_bucket/products/487/thumb/opt_sdp_thumbnail.jpg">

<meta property="fb:app_id" content="655968634437471">
<meta property="og:title" content="Soft UI Dashboard PRO by Creative Tim" />
<meta property="og:type" content="article" />
<meta property="og:url" content="https://demos.creative-tim.com/soft-ui-dashboard-pro/pages/dashboards/default.html" />
<meta property="og:image" content="https://s3.amazonaws.com/creativetim_bucket/products/487/thumb/opt_sdp_thumbnail.jpg" />
<meta property="og:description" content="Soft UI Dashboard PRO is a beautiful Bootstrap 5 admin dashboard with a large number of components, designed to look beautiful, clean and organized. If you are looking for a tool to manage dates about your business, this dashboard is the thing for you." />
<meta property="og:site_name" content="Creative Tim" />

<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />

<link href="/resources/maincss/assets/css/nucleo-icons.css" rel="stylesheet" />
<link href="/resources/maincss/assets/css/nucleo-svg.css" rel="stylesheet" />
<script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
<link href="/resources/maincss/assets/css/nucleo-svg.css" rel="stylesheet" />
<link id="pagestyle" href="/resources/maincss/assets/css/soft-ui-dashboard.min.css?v=1.1.1" rel="stylesheet" />

<!-- CSS only -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-wEmeIV1mKuiNpC+IOBjI7aAzPcEZeedi5yW5f2yOq55WWLwNGmvvx4Um1vskeMj0"
	crossorigin="anonymous">
<!-- JavaScript Bundle with Popper -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-p34f1UUtsS3wqzfto5wAAmdvj+osOnFyQFpp4Ua3gs/ZVWx6oOypYoCJhGGScy+8"
	crossorigin="anonymous"></script>




<style>
.async-hide {
	opacity: 0 !important
}
</style>
<script>
	(function(a, s, y, n, c, h, i, d, e) {
		s.className += ' ' + y;
		h.start = 1 * new Date;
		h.end = i = function() {
			s.className = s.className.replace(RegExp(' ?' + y), '')
		};
		(a[n] = a[n] || []).hide = h;
		setTimeout(function() {
			i();
			h.end = null
		}, c);
		h.timeout = c;
	})(window, document.documentElement, 'async-hide', 'dataLayer', 4000, {
		'GTM-K9BGS8K' : true
	});
</script>

<script>
	(function(i, s, o, g, r, a, m) {
		i['GoogleAnalyticsObject'] = r;
		i[r] = i[r] || function() {
			(i[r].q = i[r].q || []).push(arguments)
		}, i[r].l = 1 * new Date();
		a = s.createElement(o), m = s.getElementsByTagName(o)[0];
		a.async = 1;
		a.src = g;
		m.parentNode.insertBefore(a, m)
	})(window, document, 'script',
			'https://www.google-analytics.com/analytics.js', 'ga');
	ga('create', 'UA-46172202-22', 'auto', {
		allowLinker : true
	});
	ga('set', 'anonymizeIp', true);
	ga('require', 'GTM-K9BGS8K');
	ga('require', 'displayfeatures');
	ga('require', 'linker');
	ga('linker:autoLink', [ "2checkout.com", "avangate.com" ]);
</script>


<script>
	(function(w, d, s, l, i) {
		w[l] = w[l] || [];
		w[l].push({
			'gtm.start' : new Date().getTime(),
			event : 'gtm.js'
		});
		var f = d.getElementsByTagName(s)[0], j = d.createElement(s), dl = l != 'dataLayer' ? '&l='
				+ l
				: '';
		j.async = true;
		j.src = 'https://www.googletagmanager.com/gtm.js?id=' + i + dl;
		f.parentNode.insertBefore(j, f);
	})(window, document, 'script', 'dataLayer', 'GTM-NKDMSK6');
</script>

</head>
<body class="g-sidenav-show  bg-gray-100 <c:if test="${pageMain ne 'main'}">g-sidenav-hidden</c:if>">


	<noscript>
		<iframe src="https://www.googletagmanager.com/ns.html?id=GTM-NKDMSK6" height="0" width="0" style="display: none; visibility: hidden"></iframe>
	</noscript>

	<!-- Sidebar //////////aside 시작 //////////
        /WEB-INF/views/tiles/aside.jsp를 include
        -->
	<tiles:insertAttribute name="aside" />
	<!-- End of Sidebar //////////aside 끝 //////////-->

	<main
		class="main-content position-relative max-height-vh-100 h-100 border-radius-lg">

		<!-- Topbar ////////// header 시작////////////////
                /WEB-INF/views/tiles/header.jsp를 include
                -->
		<tiles:insertAttribute name="header" />
		<!-- End of Topbar ////////// header 끝////////////////-->


		<!-- Begin Page Content //////// body 시작 //////////-->
		<div class="container-fluid">
			<tiles:insertAttribute name="body" />
		</div>
		<!-- /.container-fluid //////// body 끝 //////////-->


		<!-- Footer ///////footer 시작////////////
            /WEB-INF/views/tiles/footer.jsp를 include
            -->
		<tiles:insertAttribute name="footer" />
		<!-- End of Footer ///////footer 끝////////////-->
		</div>
	</main>

	<div class="fixed-plugin ps">
		<a class="fixed-plugin-button text-dark position-fixed px-3 py-2" style="background: #ACFFEF">
			<i class="ni ni-single-02 py-2" aria-hidden="true"> </i>
		</a>
		<div class="card shadow-lg blur">
			<div class="card-header pb-0 pt-3  bg-transparent ">
				<div>
					<h4 style="color:#6666FF;">ORGANIZATION</h4>
					<hr class="horizontal dark mt-0">
					<form>
					<div class="row">
					<div class="col-6">
					<input type="text"  id="searchText" class="form-control" placeholder="부서/직책/이름" aria-label="Email" onfocus="focused(this)" onfocusout="defocused(this)" style="width:150px; height:50px; font-size:1.0em;">
					</div>
					<div class="col-6">
						<button type="button" class="btn btn-xm bg-gradient-secondary mb-0" id="orgBtn" style="width:80px;  font-size: 1.0em;">
							검색</button>
					</div>
					</div>
					</form>
				</div>
			</div>
			<div class="card-body pt-sm-3 pt-0">

				<div id="orgList">
	<ul id="browser" class="filetree treeview-famfamfam" >
		<li class="dropdownLi" style="margin-left:-20px;"><i class="ni ni-zoom-split-in fa-lg fa-lg" style="color: #088ff7;"></i>&nbsp;<span class="folder">그루IT</span>
			<ul id="folder21" class="adminEmp">
			</ul>
			<ul>
				<li class="closed dropdownLi group"><i class="ni ni-zoom-split-in fa-lg" style="color: #088ff7;"></i>&nbsp;<span class="folder">경영지원본부</span>
					<ul>
						<li class="closed empList dropdownLi group"><i class="ni ni-zoom-split-in fa-lg" style="color: #088ff7;"></i>&nbsp;<span class="folder" data-deptno="DEPT003">재무팀</span>
							<ul id="folder21">
							</ul>
						</li>
						<li class="closed empList dropdownLi group"><i class="ni ni-zoom-split-in fa-lg" style="color: #088ff7;"></i>&nbsp;<span class="folder" data-deptno="DEPT004">인사팀</span>
							<ul id="folder21">
							</ul>
						</li>
						<li class="closed empList dropdownLi group"><i class="ni ni-zoom-split-in fa-lg" style="color: #088ff7;"></i>&nbsp;<span class="folder" data-deptno="DEPT005">총무팀</span>
							<ul id="folder21">
							</ul>
						</li>
					</ul>
				</li>
				<li class="closed dropdownLi group"><i class="ni ni-zoom-split-in fa-lg" style="color: #088ff7;"></i>&nbsp;<span class="folder">영업본부</span>
					<ul>
						<li class="closed empList dropdownLi group"><i class="ni ni-zoom-split-in fa-lg" style="color: #088ff7;"></i>&nbsp;<span class="folder" data-deptno="DEPT011">영업팀</span>
							<ul id="folder21"></ul>
						</li>
						<li class="closed empList dropdownLi group"><i class="ni ni-zoom-split-in fa-lg" style="color: #088ff7;"></i>&nbsp;<span class="folder" data-deptno="DEPT012">마케팅팀</span>
							<ul id="folder21">
							</ul>
						</li>
						<li class="closed empList dropdownLi group"><i class="ni ni-zoom-split-in fa-lg" style="color: #088ff7;"></i>&nbsp;<span class="folder" data-deptno="DEPT013">CS팀</span>
							<ul id="folder21">
							</ul>
						</li>
					</ul>
				</li>
				<li class="closed group"><i class="ni ni-zoom-split-in fa-lg" style="color: #088ff7;"></i>&nbsp;<span class="folder">개발본부</span>
					<ul>
						<li class="closed empList group"><i class="ni ni-zoom-split-in fa-lg" style="color: #088ff7;"></i>&nbsp;<span class="folder" data-deptno="DEPT007">서비스개발팀</span>
							<ul id="folder21">
							</ul>
						</li>
						<li class="closed empList group"><i class="ni ni-zoom-split-in fa-lg" style="color: #088ff7;"></i>&nbsp;<span class="folder" data-deptno="DEPT008">플랫폼운영팀</span>
							<ul id="folder21">
							</ul>
						</li>
						<li class="closed empList group"><i class="ni ni-zoom-split-in fa-lg" style="color: #088ff7;"></i>&nbsp;<span class="folder" data-deptno="DEPT009">디자인팀</span>
							<ul id="folder21">
							</ul>
						</li>
					</ul>
				</li>
			</ul>
		</li>
	</ul>
	</div>
		<div id="searchResult">

				</div>
			</div>
		</div>
		<div class="ps__rail-x" style="left: 0px; bottom: 0px;">
			<div class="ps__thumb-x" tabindex="0" style="left: 0px; width: 0px;"></div>
		</div>
		<div class="ps__rail-y" style="top: 0px; right: 0px;">
			<div class="ps__thumb-y" tabindex="0" style="top: 0px; height: 0px;"></div>
		</div>
	</div>


<div class='modal fade' id='exampleModalMessage' tabindex='-1' role='dialog' aria-labelledby='exampleModalMessageTitle' aria-hidden='true'>
  <div class='modal-dialog modal-dialog-centered modal-lg' role='document'>
    <div class='modal-content'>
      <div class='modal-body p-0'>
        <div class=''>
		<div class=''>
			<div class='row'>
				<div class='col-sm'>
					<div class='card-body p-3 position-relative'>
						<div class='mb-xl-0 mb-4'>
							<div class='card card-blog card-plain'>
								<div class='position-relative'>
									<a class='d-block shadow-xl border-radius-xl'  id="empImage" >
									</a>
								</div>
								<div class='card-body px-1 pb-0'>
									<div class="row">
									 <h4 class='col-6 text-center' style="margin-left:95px;" id="modal_empNm"></h4>
								 <span style="width:90px; height:40px; margin-left:-50px; margin-top:-7px; font-size:1.1em;"
								 class="col-6 badge badge-pill bg-gradient-primary" id="modal_workSsts"></span>
									</div>
									<p class='text-gradient text-center text-dark mb-2 ' style="font-size:1.2em;" id="modal_deptjpbs"></p>
									<p class='text-gradient text-center text-dark mb-2 ' style="font-size:1.2em;"id="modal_empEmlAddr"></p>
								</div>
								<div class='d-flex align-items-center'>
									<table class='w-100'>
										<tbody><tr>
											<td class='w-50 align-items-center'  id="modal_goEmail">
											</td>
											<td class='w-50 align-items-center'  id="modal_goSchedule"></td>
										</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class='col-sm'>
					<div class='p-2' >
						<div style='border: 2px solid #f5f7ff; margin-top: 50px;' class='p-3 h-auto'>
						<table class='p-3 card card-blog card-plain'>
						<tbody><tr>
						<th style="font-size: 1.4em;">회사명</th>
						<td style="font-size: 1.3em;" id="modal_empOgdpCo"></td>
						</tr>
						<tr>
						<th style="font-size: 1.4em;">부서</th>
						<td style="font-size: 1.3em;" id="modal_deptNm"></td>
						</tr>
						<tr>
						<th style="font-size: 1.4em;">직책</th>
						<td  style="font-size: 1.3em;" id="modal_jbpsNm"></td>
						</tr>

						<tr>
						<th style="font-size: 1.4em;">휴대전화&nbsp;&nbsp;</th>
						<td style="font-size: 1.3em;" id="empMblTelno"></td>
						</tr>
						<tr>
						<th style="font-size: 1.4em;">사내전화&nbsp;&nbsp;</th>
						<td style="font-size: 1.3em;" id="empCoTelno"></td>
						</tr>
						</tbody></table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
   </div>
    </div>
  </div>
</div>



	<!--   Core JS Files   -->
	<script src="/resources/maincss/assets/js/core/popper.min.js"></script>
	<script src="/resources/maincss/assets/js/core/bootstrap.min.js"></script>
	<script src="/resources/maincss/assets/js/plugins/perfect-scrollbar.min.js"></script>
	<script src="/resources/maincss/assets/js/plugins/smooth-scrollbar.min.js"></script>
	<script src="/resources/maincss/assets/js/plugins/fullcalendar.min.js"></script>
	<script src="/resources/maincss/assets/js/plugins/dragula/dragula.min.js"></script>
	<script src="/resources/maincss/assets/js/plugins/jkanban/jkanban.js"></script>
	<script src="/resources/maincss/assets/js/plugins/chartjs.min.js"></script>
	<script src="/resources/maincss/assets/js/plugins/choices.min.js"></script>
	<script src="/resources/maincss/assets/js/plugins/dropzone.min.js"></script>


	<script async defer src="https://buttons.github.io/buttons.js"></script>


	<script>
		var ctx1 = document.getElementById("chart-widgets-1").getContext("2d");

		var gradientStroke1 = ctx1.createLinearGradient(0, 230, 0, 50);

		gradientStroke1.addColorStop(1, 'rgba(203,12,159,0.02)');
		gradientStroke1.addColorStop(0.2, 'rgba(72,72,176,0.0)');
		gradientStroke1.addColorStop(0, 'rgba(203,12,159,0)'); //purple colors

		var ctx2 = document.getElementById("chart-widgets-2").getContext("2d");

		var gradientStroke2 = ctx2.createLinearGradient(0, 230, 0, 50);

		gradientStroke2.addColorStop(1, 'rgba(37,47,64,0.05)');
		gradientStroke2.addColorStop(0.2, 'rgba(37,47,64,0.0)');
		gradientStroke2.addColorStop(0, 'rgba(37,47,64,0)'); //purple colors

		new Chart(ctx1, {
			type : "line",
			data : {
				labels : [ "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct",
						"Nov", "Dec" ],
				datasets : [ {
					label : "Calories",
					tension : 0.5,
					borderWidth : 0,
					pointRadius : 0,
					borderColor : "#252f40",
					borderWidth : 2,
					backgroundColor : gradientStroke2,
					data : [ 50, 45, 60, 60, 80, 65, 90, 80, 100 ],
					maxBarThickness : 6,
					fill : true
				} ],
			},
			options : {
				responsive : true,
				maintainAspectRatio : false,
				plugins : {
					legend : {
						display : false,
					}
				},
				interaction : {
					intersect : false,
					mode : 'index',
				},
				scales : {
					y : {
						grid : {
							drawBorder : false,
							display : false,
							drawOnChartArea : false,
							drawTicks : false,
						},
						ticks : {
							display : false
						}
					},
					x : {
						grid : {
							drawBorder : false,
							display : false,
							drawOnChartArea : false,
							drawTicks : false,
						},
						ticks : {
							display : false
						}
					},
				},
			},
		});

		new Chart(ctx2, {
			type : "line",
			data : {
				labels : [ "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct",
						"Nov", "Dec" ],
				datasets : [ {
					label : "Income",
					tension : 0.5,
					borderWidth : 0,
					pointRadius : 0,
					borderColor : "#252f40",
					borderWidth : 2,
					backgroundColor : gradientStroke2,
					data : [ 50, 45, 60, 60, 80, 65, 90, 80, 100 ],
					maxBarThickness : 6,
					fill : true
				} ],
			},
			options : {
				responsive : true,
				maintainAspectRatio : false,
				plugins : {
					legend : {
						display : false,
					}
				},
				interaction : {
					intersect : false,
					mode : 'index',
				},
				scales : {
					y : {
						grid : {
							drawBorder : false,
							display : false,
							drawOnChartArea : false,
							drawTicks : false,
						},
						ticks : {
							display : false
						}
					},
					x : {
						grid : {
							drawBorder : false,
							display : false,
							drawOnChartArea : false,
							drawTicks : false,
						},
						ticks : {
							display : false
						}
					},
				},
			},
		});

		var ctx3 = document.getElementById("chart-line-widgets").getContext(
				"2d");

		var gradientStroke3 = ctx3.createLinearGradient(0, 230, 0, 50);

		gradientStroke3.addColorStop(1, 'rgba(33,82,255,0.1)');
		gradientStroke3.addColorStop(0.2, 'rgba(33,82,255,0.0)');
		gradientStroke3.addColorStop(0, 'rgba(33,82,255,0)'); //purple colors

		new Chart(ctx3, {
			type : "line",
			data : {
				labels : [ "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct",
						"Nov", "Dec" ],
				datasets : [ {
					label : "Tasks",
					tension : 0.3,
					pointRadius : 2,
					pointBackgroundColor : "#cb0c9f",
					borderColor : "#cb0c9f",
					borderWidth : 2,
					backgroundColor : gradientStroke1,
					data : [ 40, 45, 42, 41, 40, 43, 40, 42, 39 ],
					maxBarThickness : 6,
					fill : true
				} ],
			},
			options : {
				responsive : true,
				maintainAspectRatio : false,
				plugins : {
					legend : {
						display : false,
					}
				},
				interaction : {
					intersect : false,
					mode : 'index',
				},
				scales : {
					y : {
						grid : {
							drawBorder : false,
							display : false,
							drawOnChartArea : false,
							drawTicks : false,
						},
						ticks : {
							display : false
						}
					},
					x : {
						grid : {
							drawBorder : false,
							display : false,
							drawOnChartArea : false,
							drawTicks : false,
						},
						ticks : {
							color : '#252f40',
							padding : 10
						}
					},
				},
			},
		});
	</script>


	<script
		src="/resources/maincss/assets/js/soft-ui-dashboard.min.js?v=1.1.1"></script>
	<script defer
		src="https://static.cloudflareinsights.com/beacon.min.js/vaafb692b2aea4879b33c060e79fe94621666317369993"
		integrity="sha512-0ahDYl866UMhKuYcW078ScMalXqtFJggm7TmlUtp0UlD4eQk0Ixfnm5ykXKvGJNFjLMoortdseTfsRT8oCfgGA=="
		data-cf-beacon='{"rayId":"79fefcf55f4680d1","version":"2023.2.0","r":1,"token":"1b7cbb72744b40c580f8633c6b62637e","si":100}'
		crossorigin="anonymous"></script>
	<script>


$(function(){


	//회사 바로 밑에 대표/이사 사원 출력
	$.ajax({
		url:"/org/orgAdminEmp",
		type:"post",
		beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
               xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success:function(result){
			//result : List<empVO> empVOList
			let str = "";
			console.log(result);


			$.each(result,function(i,v){
				str+= "<li><i class='fas fa-user text-secondary fa-lg' data-bs-toggle='tooltip' data-bs-placement='top' aria-hidden='true' aria-label='Edit Profile' data-bs-original-title='Edit Profile'></i>&nbsp;<a class='file' data-empno='"+v.empNo+"' data-bs-toggle='modal' data-bs-target='#exampleModalMessage'>"+v.empNm+" "+v.jbpsNm+"</a></li>"
			});

			$(".adminEmp").append(str);
		}
	});

	//.empList를 선택하면 (this) 아작스 호출해서 해당 태그 자식에 요소 append
		$('.empList').on('click',function(){

			//부서 번호 변수에 담기
			let deptNo = $(this).children('span').data('deptno');
			let $_target = $(this);
			let data = {"deptNo" : deptNo};

			$.ajax({
				url:"/org/orgEmp",
				type:"post",
				data: JSON.stringify(data),
				contentType:"application/json;charset=utf-8",
				beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
	                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				success:function(result){
					//result : List<empVO> empVOList
					let str = "";
					console.log(result);

					$.each(result,function(i,v){
						str+= "<li><i class='fas fa-user text-secondary fa-lg' data-bs-toggle='tooltip' data-bs-placement='top' aria-hidden='true' aria-label='Edit Profile' data-bs-original-title='Edit Profile'></i>&nbsp;<a class='file' data-empno='"+v.empNo+"' data-bs-toggle='modal' data-bs-target='#exampleModalMessage'>"+v.empNm+" "+v.jbpsNm+"</a></li>"
					});


//	 				console.log("str : " + str);
					//.html() : 새로고침 / .append() : 누적

					$($_target).find('ul').html(str);
				}
			});

		})


		// 검색버튼 누르면 검색 결과를 리스트로 뿌리기
		$('#orgBtn').on('click',function(){

			searchText = $('#searchText').val();

			//만약 검색내용없이 검색버튼을 다시 누를시 조직도만 볼 수 있도록
			if(searchText == ""){
				//검색칸 비우고
				$('#searchResult').html("");
				//함수종료
				return false;
			}

			let data = {"searchText" : searchText};

			$.ajax({
				url:"/org/searchResult",
				type:"post",
				data: JSON.stringify(data),
				contentType:"application/json;charset=utf-8",
				beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
	                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				success:function(result){
					str = "";

				if(result.length < 1){
					str+="	<hr/>                                                                                                                                         ";
					str+="	<span style='font-weight: bolder; font-size:1.2em;'>검색 결과가 없습니다</span>                                                                                           ";
				}else{

				str+="	<hr/>                                                                                                                                         ";
				str+="	<span style='font-weight: bolder; font-size:1.2em;'>검색 결과</span>                                                                                           ";
				str+="				<ul class='list-group'>                                                                                                           ";
				$.each(result,function(i,v){
				str+="					<li                                                                                                                           ";
				str+="						class='list-group-item border-0 d-flex align-items-center px-0 mb-2' style='height:10px; margin-top:15px;'>               ";
				str+="						<div class='avatar me-3'>                                                                                                 ";
				str+="							<i class='fas fa-user text-secondary fa-lg' data-bs-toggle='tooltip'                                                ";
				str+="							data-bs-placement='top' aria-hidden='true'></i>                                                                       ";
				str+="						</div>                                                                                                                    ";
				str+="						<div                                                                                                                      ";
				str+="							class='d-flex align-items-start flex-column justify-content-center' style='margin-left:-15px;'>                       ";
				str+="							<h6 class='mb-0 text-md file' data-empno='"+v.EMP_NO+"' data-bs-toggle='modal' data-bs-target='#exampleModalMessage'>"+v.EMP_NM+"&nbsp;"+v.JBPS_NM+"("+v.DEPT_NM+")</h6>                                                               ";
				str+="						</div>                                                                                                                    ";
				str+="					</li>                                                                                                                         ";
				});
				str+="				</ul>                                                                                                                             ";

				}

				$('#searchResult').html(str);
				$('#searchText').val("");
			}
		})
	})
	//명함 모달창 ajax
	$(document).on('click','.file',function(){
		//사원 번호 변수에 담기
		let empNo = $(this).data('empno');
		let data = {"empNo" : empNo};

		$.ajax({
			url:"/org/empModal",
			type:"post",
			data: JSON.stringify(data),
			contentType:"application/json;charset=utf-8",
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success:function(result){
				console.log(result);
				$('#modal_empNm').text(result.empNm);
				$('#modal_deptjpbs').text(result.deptNm+" "+result.jbpsNm);
				$('#modal_empEmlAddr').text(result.empEmlAddr);
				$('#modal_empOgdpCo').text(result.empOgdpCo);
				$('#modal_deptNm').text(result.deptNm);
				$('#modal_jbpsNm').text(result.jbpsNm);
				$('#empMblTelno').text(result.empMblTelno);
				$('#empCoTelno').text(result.empCoTelno);
				$('#modal_goEmail').html("<a href='/mail/clickWrite?empNo="+result.empNo+"' class='btn btn-lg p-4' data-bypass='true' style='margin-left:30px; width:130px;'>"
						+"<span class='ic_dashboard2 ic_create_survey' title='메일쓰기'>"
                   +"<img class='img' alt='' src='/resources/maincss/assets/img/mail.png' style='width: 25px; margin-right:10px;'></span>"
				+"<span class='txt' style='width:30px; font-size:1.3em;'>이메일</span>"
			+"</a>");

				$('#modal_workSsts').text(result.workMngSsts);
				$('#modal_goSchedule').html("<a href=' /cal/calFrame?empNo="+result.empNo+"&&empNm="+result.empNm+"' class='btn btn-lg p-4' data-bypass='true' style='margin-left:30px;  width:130px;'>"
				+"<span class='type'><span class='ic_dashboard2 ic_create_survey' style='font-size:1.0em;' title='일정등록'>"
				+"<img class='img' alt='' src='/resources/maincss/assets/img/cal.png' style='width: 25px; margin-right:10px;'>"
		+"</span></span> <span class='txt' style='font-size:1.3em;'>일정</span> </a>");

				if(result.empProfile == null){
					$('#empImage').html("<img src='/resources/upload/emp/profile/default.png' class='img-fluid shadow border-radius-xl' >")
				}else if(result.empProfile != null){
					$('#empImage').html("<img src='/resources/upload"+result.empProfile+"' class='img-fluid shadow border-radius-xl' >")
				}
			}
		})
	});
})


</script>
</body>
</html>