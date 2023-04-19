<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="apple-touch-icon" sizes="76x76" href="/resources/maincss/assets/img/apple-icon.png">
<link rel="icon" type="image/png" href="/resources/maincss/assets/img/bear2.png">
<title>GruOffice</title>

<script src="/resources/js/jquery-3.6.0.js"></script>
 
<link rel="canonical" href="https://www.creative-tim.com/product/soft-ui-dashboard-pro" />

<!-- <meta name="keywords" content="creative tim, html dashboard, html css dashboard, web dashboard, bootstrap 5 dashboard, bootstrap 5, css3 dashboard, bootstrap 5 admin, soft ui dashboard bootstrap 5 dashboard, frontend, responsive bootstrap 5 dashboard, soft design, soft dashboard bootstrap 5 dashboard"> -->
<!-- <meta name="description" content="Soft UI Dashboard PRO is a beautiful Bootstrap 5 admin dashboard with a large number of components, designed to look beautiful, clean and organized. If you are looking for a tool to manage dates about your business, this dashboard is the thing for you."> -->

<!-- <meta name="twitter:card" content="product"> -->
<!-- <meta name="twitter:site" content="@creativetim"> -->
<!-- <meta name="twitter:title" content="Soft UI Dashboard PRO by Creative Tim"> -->
<!-- <meta name="twitter:description" content="Soft UI Dashboard PRO is a beautiful Bootstrap 5 admin dashboard with a large number of components, designed to look beautiful, clean and organized. If you are looking for a tool to manage dates about your business, this dashboard is the thing for you."> -->
<!-- <meta name="twitter:creator" content="@creativetim"> -->
<!-- <meta name="twitter:image" content="https://s3.amazonaws.com/creativetim_bucket/products/487/thumb/opt_sdp_thumbnail.jpg"> -->

<!-- <meta property="fb:app_id" content="655968634437471"> -->
<!-- <meta property="og:title" content="Soft UI Dashboard PRO by Creative Tim" /> -->
<!-- <meta property="og:type" content="article" /> -->
<!-- <meta property="og:url" content="https://demos.creative-tim.com/soft-ui-dashboard-pro/pages/dashboards/default.html" /> -->
<!-- <meta property="og:image" content="https://s3.amazonaws.com/creativetim_bucket/products/487/thumb/opt_sdp_thumbnail.jpg" /> -->
<!-- <meta property="og:description" content="Soft UI Dashboard PRO is a beautiful Bootstrap 5 admin dashboard with a large number of components, designed to look beautiful, clean and organized. If you are looking for a tool to manage dates about your business, this dashboard is the thing for you." /> -->
<!-- <meta property="og:site_name" content="Creative Tim" /> -->

<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />

<link href="/resources/maincss/assets/css/nucleo-icons.css" rel="stylesheet" />
<link href="/resources/maincss/assets/css/nucleo-svg.css" rel="stylesheet" />

<script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
<link href="/resources/maincss/assets/css/nucleo-svg.css" rel="stylesheet" />

<link id="pagestyle" href="/resources/maincss/assets/css/soft-ui-dashboard.min.css?v=1.1.1" rel="stylesheet" />


<style>
	@font-face {
    font-family: 'LINESeedKR-Bd';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/LINESeedKR-Bd.woff2') format('woff2');
    font-weight: 700;
    font-style: normal;
}

p, h1, h2, h3, h4, h5, h6, span, div, a, button{
	font-family: 'LINESeedKR-Bd';
}
</style>

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
      'GTM-K9BGS8K': true
    });
  </script>

<script>
    (function(i, s, o, g, r, a, m) {
      i['GoogleAnalyticsObject'] = r;
      i[r] = i[r] || function() {
        (i[r].q = i[r].q || []).push(arguments)
      }, i[r].l = 1 * new Date();
      a = s.createElement(o),
        m = s.getElementsByTagName(o)[0];
      a.async = 1;
      a.src = g;
      m.parentNode.insertBefore(a, m)
    })(window, document, 'script', 'https://www.google-analytics.com/analytics.js', 'ga');
    ga('create', 'UA-46172202-22', 'auto', {
      allowLinker: true
    });
    ga('set', 'anonymizeIp', true);
    ga('require', 'GTM-K9BGS8K');
    ga('require', 'displayfeatures');
    ga('require', 'linker');
    ga('linker:autoLink', ["2checkout.com", "avangate.com"]);
  </script>


<script>
    (function(w, d, s, l, i) {
      w[l] = w[l] || [];
      w[l].push({
        'gtm.start': new Date().getTime(),
        event: 'gtm.js'
      });
      var f = d.getElementsByTagName(s)[0],
        j = d.createElement(s),
        dl = l != 'dataLayer' ? '&l=' + l : '';
      j.async = true;
      j.src =
        'https://www.googletagmanager.com/gtm.js?id=' + i + dl;
      f.parentNode.insertBefore(j, f);
    })(window, document, 'script', 'dataLayer', 'GTM-NKDMSK6');
  </script>
</head>
<body>
	<tiles:insertAttribute name="content"/>
</body>
<!-- <footer class="footer py-5"> -->
<!--     <div class="container"> -->
<!--       <div class="row"> -->
<!--         <div class="col-lg-8 mb-4 mx-auto text-center"> -->
<!--           <a href="javascript:;" target="_blank" class="text-secondary me-xl-5 me-3 mb-sm-0 mb-2"> -->
<!--             Company -->
<!--           </a> -->
<!--           <a href="javascript:;" target="_blank" class="text-secondary me-xl-5 me-3 mb-sm-0 mb-2"> -->
<!--             About Us -->
<!--           </a> -->
<!--           <a href="javascript:;" target="_blank" class="text-secondary me-xl-5 me-3 mb-sm-0 mb-2"> -->
<!--             Team -->
<!--           </a> -->
<!--           <a href="javascript:;" target="_blank" class="text-secondary me-xl-5 me-3 mb-sm-0 mb-2"> -->
<!--             Products -->
<!--           </a> -->
<!--           <a href="javascript:;" target="_blank" class="text-secondary me-xl-5 me-3 mb-sm-0 mb-2"> -->
<!--             Blog -->
<!--           </a> -->
<!--           <a href="javascript:;" target="_blank" class="text-secondary me-xl-5 me-3 mb-sm-0 mb-2"> -->
<!--             Pricing -->
<!--           </a> -->
<!--         </div> -->
<!--         <div class="col-lg-8 mx-auto text-center mb-4 mt-2"> -->
<!--           <a href="javascript:;" target="_blank" class="text-secondary me-xl-4 me-4"> -->
<!--             <span class="text-lg fab fa-dribbble"></span> -->
<!--           </a> -->
<!--           <a href="javascript:;" target="_blank" class="text-secondary me-xl-4 me-4"> -->
<!--             <span class="text-lg fab fa-twitter"></span> -->
<!--           </a> -->
<!--           <a href="javascript:;" target="_blank" class="text-secondary me-xl-4 me-4"> -->
<!--             <span class="text-lg fab fa-instagram"></span> -->
<!--           </a> -->
<!--           <a href="javascript:;" target="_blank" class="text-secondary me-xl-4 me-4"> -->
<!--             <span class="text-lg fab fa-pinterest"></span> -->
<!--           </a> -->
<!--           <a href="javascript:;" target="_blank" class="text-secondary me-xl-4 me-4"> -->
<!--             <span class="text-lg fab fa-github"></span> -->
<!--           </a> -->
<!--         </div> -->
<!--       </div> -->
<!--       <div class="row"> -->
<!--         <div class="col-8 mx-auto text-center mt-1"> -->
<!--           <p class="mb-0 text-secondary"> -->
<!--             Copyright © <script> -->
<!-- //               document.write(new Date().getFullYear()) -->
<!--             </script> Soft by Creative Tim. -->
<!--           </p> -->
<!--         </div> -->
<!--       </div> -->
<!--     </div> -->
<!--   </footer> -->
  
<!--   Core JS Files   -->
<script src="/resources/maincss/assets/js/core/popper.min.js"></script>
<script src="/resources/maincss/assets/js/core/bootstrap.min.js"></script>
<script
	src="/resources/maincss/assets/js/plugins/perfect-scrollbar.min.js"></script>
<script
	src="/resources/maincss/assets/js/plugins/smooth-scrollbar.min.js"></script>
<!-- Kanban scripts -->
<script
	src="/resources/maincss/assets/js/plugins/dragula/dragula.min.js"></script>
<script
	src="/resources/maincss/assets/js/plugins/jkanban/jkanban.js"></script>
<script>
	var win = navigator.platform.indexOf('Win') > -1;
	if (win && document.querySelector('#sidenav-scrollbar')) {
		var options = {
			damping : '0.5'
		}
		Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
	}
</script>



<!-- Github buttons -->
<script async defer src="https://buttons.github.io/buttons.js"></script>
<!-- Control Center for Soft Dashboard: parallax effects, scripts for the example pages etc -->
<script
	src="/resources/maincss/assets/js/soft-ui-dashboard.min.js?v=1.1.1"></script>
</html>