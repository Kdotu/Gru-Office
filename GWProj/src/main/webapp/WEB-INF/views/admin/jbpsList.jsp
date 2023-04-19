<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="row">
	<div class="col-12">
		<div class="card">

			<div class="card-header pb-0">
				<div class="d-lg-flex">
					<div>
						<h5 class="mb-0">직위목록</h5>
					</div>
					<div class="ms-auto my-auto mt-lg-0 mt-4">
						<div class="ms-auto my-auto">
							<a href="./new-product.html"
								class="btn bg-gradient-primary btn-sm mb-0" target="_blank" style="font-size: 1.1em;">+&nbsp;
								직위 추가</a>
							<button
								class="btn btn-outline-primary btn-sm export mb-0 mt-sm-0 mt-1"
								data-type="csv" type="button" name="button" style="font-size: 1.1em;">-&nbsp;직위 삭제</button>
						</div>
					</div>
				</div>
			</div>
			<div class="card-body px-0 pb-0">
				<div class="table-responsive">
					<div
						class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
						<div class="dataTable-container">
							<table class="table table-flush dataTable-table"
								id="products-list" style="text-align: center;">
								<thead class="thead-light" >
									<tr >
										<th data-sortable="" style="width: 33%; font-size: 1.3em; text-align: center;"><a href="#"
											class="dataTable-sorter">명칭</a></th>
										<th data-sortable="" style="width: 33%; font-size: 1.3em; text-align: center;"><a href="#"
											class="dataTable-sorter">코드</a></th>
										<th data-sortable="" style="width: 33%; font-size: 1.3em; text-align: center;"><a href="#"
											class="dataTable-sorter">사용 사원(명)</a></th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="text-lg">대표</td>
										<td class="text-lg">001</td>
										<td class="text-lg">1</td>
									</tr>
									
								</tbody>

							</table>
						</div>
						<div class="dataTable-bottom">
							<nav class="dataTable-pagination">
								<ul class="dataTable-pagination-list">
									<li class="pager"><a href="#" data-page="1">‹</a></li>
									<li class="active"><a href="#" data-page="1">1</a></li>
									<li class=""><a href="#" data-page="2">2</a></li>
									<li class=""><a href="#" data-page="3">3</a></li>
									<li class="pager"><a href="#" data-page="2">›</a></li>
								</ul>
							</nav>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>