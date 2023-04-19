<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<style>
	@font-face {
    font-family: 'LINESeedKR-Bd';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/LINESeedKR-Bd.woff2') format('woff2');
    font-weight: 700;
    font-style: normal;
}

p, h, span, div, a{
	font-family: 'LINESeedKR-Bd';
}
</style>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="apple-touch-icon" sizes="76x76"
	href="/resources/maincss/assets/img/apple-icon.png">
<link rel="icon" type="image/png"
	href="/resources/maincss/assets/img/bear2.png">
<title>GruOffice</title>


<script src="/resources/js/jquery-3.6.0.js"></script>

<link rel="canonical"
	href="https://www.creative-tim.com/product/soft-ui-dashboard-pro" />

<meta name="keywords"
	content="creative tim, html dashboard, html css dashboard, web dashboard, bootstrap 5 dashboard, bootstrap 5, css3 dashboard, bootstrap 5 admin, soft ui dashboard bootstrap 5 dashboard, frontend, responsive bootstrap 5 dashboard, soft design, soft dashboard bootstrap 5 dashboard">
<meta name="description"
	content="Soft UI Dashboard PRO is a beautiful Bootstrap 5 admin dashboard with a large number of components, designed to look beautiful, clean and organized. If you are looking for a tool to manage dates about your business, this dashboard is the thing for you.">

<meta name="twitter:card" content="product">
<meta name="twitter:site" content="@creativetim">
<meta name="twitter:title"
	content="Soft UI Dashboard PRO by Creative Tim">
<meta name="twitter:description"
	content="Soft UI Dashboard PRO is a beautiful Bootstrap 5 admin dashboard with a large number of components, designed to look beautiful, clean and organized. If you are looking for a tool to manage dates about your business, this dashboard is the thing for you.">
<meta name="twitter:creator" content="@creativetim">
<meta name="twitter:image"
	content="https://s3.amazonaws.com/creativetim_bucket/products/487/thumb/opt_sdp_thumbnail.jpg">

<meta property="fb:app_id" content="655968634437471">
<meta property="og:title"
	content="Soft UI Dashboard PRO by Creative Tim" />
<meta property="og:type" content="article" />
<meta property="og:url"
	content="https://demos.creative-tim.com/soft-ui-dashboard-pro/pages/dashboards/default.html" />
<meta property="og:image"
	content="https://s3.amazonaws.com/creativetim_bucket/products/487/thumb/opt_sdp_thumbnail.jpg" />
<meta property="og:description"
	content="Soft UI Dashboard PRO is a beautiful Bootstrap 5 admin dashboard with a large number of components, designed to look beautiful, clean and organized. If you are looking for a tool to manage dates about your business, this dashboard is the thing for you." />
<meta property="og:site_name" content="Creative Tim" />

<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700"
	rel="stylesheet" />

<link href="/resources/maincss/assets/css/nucleo-icons.css"
	rel="stylesheet" />
<link href="/resources/maincss/assets/css/nucleo-svg.css"
	rel="stylesheet" />

<script src="https://kit.fontawesome.com/42d5adcbca.js"
	crossorigin="anonymous"></script>
<link href="/resources/maincss/assets/css/nucleo-svg.css"
	rel="stylesheet" />

<link id="pagestyle"
	href="/resources/maincss/assets/css/soft-ui-dashboard.min.css?v=1.1.1"
	rel="stylesheet" />



<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-wEmeIV1mKuiNpC+IOBjI7aAzPcEZeedi5yW5f2yOq55WWLwNGmvvx4Um1vskeMj0" crossorigin="anonymous">
<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-p34f1UUtsS3wqzfto5wAAmdvj+osOnFyQFpp4Ua3gs/ZVWx6oOypYoCJhGGScy+8" crossorigin="anonymous"></script>
	
	


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
<body class="g-sidenav-show  bg-gray-100">


	<noscript>
		<iframe src="https://www.googletagmanager.com/ns.html?id=GTM-NKDMSK6"
			height="0" width="0" style="display: none; visibility: hidden"></iframe>
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
	</main>

	<script src="/resources/maincss/assets/js/core/popper.min.js"></script>
	<script src="/resources/maincss/assets/js/core/bootstrap.min.js"></script>
	<script
		src="/resources/maincss/assets/js/plugins/perfect-scrollbar.min.js"></script>
	<script
		src="/resources/maincss/assets/js/plugins/smooth-scrollbar.min.js"></script>
	<script
		src="/resources/maincss/assets/js/plugins/fullcalendar.min.js"></script>

	<script
		src="/resources/maincss/assets/js/plugins/dragula/dragula.min.js"></script>
	<script
		src="/resources/maincss/assets/js/plugins/jkanban/jkanban.js"></script>
	<script
		src="/resources/maincss/assets/js/plugins/chartjs.min.js"></script>
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

	<script src="/resources/maincss/assets/js/plugins/chartjs.min.js"></script>
	<script async defer src="https://buttons.github.io/buttons.js"></script>

	<script
		src="/resources/maincss/assets/js/soft-ui-dashboard.min.js?v=1.1.1"></script>
	<script defer
		src="https://static.cloudflareinsights.com/beacon.min.js/vaafb692b2aea4879b33c060e79fe94621666317369993"
		integrity="sha512-0ahDYl866UMhKuYcW078ScMalXqtFJggm7TmlUtp0UlD4eQk0Ixfnm5ykXKvGJNFjLMoortdseTfsRT8oCfgGA=="
		data-cf-beacon='{"rayId":"79fefcf55f4680d1","version":"2023.2.0","r":1,"token":"1b7cbb72744b40c580f8633c6b62637e","si":100}'
		crossorigin="anonymous"></script>
</body>
</html>