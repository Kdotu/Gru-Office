<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="row" style="margin-bottom: 25px;">
	<div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
		<div class="card">
			<div class="card-body p-3">
				<div class="col-8">
					<h4 class="mb-0">4월 매출 현황</h4>
				</div>
			</div>
		</div>
	</div>
	<div class="col-xl-9 col-sm-6 mb-xl-0 mb-4">
		<div class="card" style="height: 67px;">
			<div class="card-body p-3">
				<dl class="row">
				  <dt class="col-sm-9" style="font-size: 1.4em; font-weight: bolder;">4월 전사 매출</dt>
				  <dd class="col-sm-3" id="status" style="font-size: 1.6em; font-weight: bolder;">₩56,760,000</dd>
				</dl>
			</div>
		</div>
	</div>
</div>

<div class="row mt-4">
	<div class="col-lg-6 col-md-12">
		<div class="card">
			<div class="card-header pb-0 p-3">
				<h4 class="mb-0">월별 매출 현황</h4>
			</div>
			<div class="card-body p-3">
				<div class="chart">
                <canvas id="bar-chart" class="chart-canvas" height="620"></canvas>
              </div>
			</div>
		</div>
	</div>
	<div class="col-lg-6 col-md-12 mt-4 mt-lg-0">
		<div class="card h-100">
			<div class="card-header pb-0 p-3">
				<h4 class="mb-0">거래처별 매출 현황</h4>
			</div>
			<div class="card-body p-3">
				<div class="chart">
                <canvas id="bar-chart2" class="chart-canvas" height="620"></canvas>
              </div>
			</div>
		</div>
	</div>
</div>

<script src="/resources/maincss/assets/js/plugins/chartjs.min.js"></script>
<script>
// Bar chart
    var ctx5 = document.getElementById("bar-chart").getContext("2d");

    new Chart(ctx5, {
      type: "bar",
      data: {
        labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        datasets: [{
          label: "Sales by month",
          weight: 5,
          borderWidth: 0,
          borderRadius: 4,
          backgroundColor: '#3A416F',
          data: [12, 21, 27, 30, 0, 0, 0, 0, 0, 0, 0, 0],
          fill: false,
          maxBarThickness: 35
        }],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            display: false,
          }
        },
        scales: {
          y: {
            grid: {
              drawBorder: false,
              display: true,
              drawOnChartArea: true,
              drawTicks: false,
              borderDash: [5, 5]
            },
            ticks: {
              display: true,
              padding: 10,
              color: '#9ca2b7'
            }
          },
          x: {
            grid: {
              drawBorder: false,
              display: false,
              drawOnChartArea: true,
              drawTicks: true,
            },
            ticks: {
              display: true,
              color: '#9ca2b7',
              padding: 10
            }
          },
        },
      },
    });


    var ctx6 = document.getElementById("bar-chart2").getContext("2d");

    new Chart(ctx6, {
      type: "bar",
      data: {
        labels: ['웅진식품', '탑엔지니어링', '텔레칩스', 'KCC정보통신', '세스코', '스마트비전'],
        datasets: [{
          label: "Sales by dept",
          weight: 5,
          borderWidth: 0,
          borderRadius: 4,
          backgroundColor: '#3A416F',
          data: [15, 20, 12, 60, 40, 25],
          fill: false,
          maxBarThickness: 35
        }],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            display: false,
          }
        },
        scales: {
          y: {
            grid: {
              drawBorder: false,
              display: true,
              drawOnChartArea: true,
              drawTicks: false,
              borderDash: [5, 5]
            },
            ticks: {
              display: true,
              padding: 10,
              color: '#9ca2b7'
            }
          },
          x: {
            grid: {
              drawBorder: false,
              display: false,
              drawOnChartArea: true,
              drawTicks: true,
            },
            ticks: {
              display: true,
              color: '#9ca2b7',
              padding: 10
            }
          },
        },
      },
    });
</script>