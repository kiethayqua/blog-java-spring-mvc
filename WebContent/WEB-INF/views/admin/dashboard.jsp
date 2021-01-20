<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<jsp:include page="inc/header.jsp"></jsp:include>
<main>
	<div class="container-fluid">
		<h1 class="mt-4">Thống Kê</h1>
		<ol class="breadcrumb mb-4">
			<li class="breadcrumb-item active">Thống Kê</li>
		</ol>
		<div class="row">
			<div class="col-xl-3 col-md-6">
				<div class="card bg-primary text-white mb-4">
					<div class="card-body">
						<h2>Bài Viết</h2>
						<h4>${numberPosts[0]}</h4>
					</div>
					<div
						class="card-footer d-flex align-items-center justify-content-between">
						<a class="small text-white stretched-link" href="/DoAnCuoiKy/admin/posts.htm">View
							Details</a>
						<div class="small text-white">
							<i class="fas fa-angle-right"></i>
						</div>
					</div>
				</div>
			</div>
			<div class="col-xl-3 col-md-6">
				<div class="card bg-warning text-white mb-4">
					<div class="card-body">
						<h2>Danh Mục</h2>
						<h4>${numberCategories[0]}</h4>
					</div>
					<div
						class="card-footer d-flex align-items-center justify-content-between">
						<a class="small text-white stretched-link" href="/DoAnCuoiKy/admin/categories.htm">View
							Details</a>
						<div class="small text-white">
							<i class="fas fa-angle-right"></i>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</main>
<jsp:include page="inc/footer.jsp"></jsp:include>
