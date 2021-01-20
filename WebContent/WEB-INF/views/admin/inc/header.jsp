<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="${pageContext.servletContext.contextPath }/">
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Admin</title>
<link href="/DoAnCuoiKy/admin_assets/css/styles.css" rel="stylesheet" />
<link
	href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css"
	rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script type="text/javascript" src="/DoAnCuoiKy/admin_assets/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="/DoAnCuoiKy/admin_assets/ckfinder/ckfinder.js"></script>
</head>
<body class="sb-nav-fixed">
	<nav
		class="sb-topnav navbar navbar-expand navbar-dark bg-dark d-flex justify-content-between">
		<div>
			<a class="navbar-brand" href="/DoAnCuoiKy/admin/dashboard.htm">Admin KietNguyenBlog</a>
			<button class="btn btn-link btn-sm order-1 order-lg-0"
				id="sidebarToggle" href="#">
				<i class="fas fa-bars"></i>
			</button>
		</div>
		<!-- Navbar-->
		<ul class="navbar-nav ml-auto ml-md-0">
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" id="userDropdown" href="#"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"><i class="fas fa-user fa-fw"></i> Nguyen
					Phuc Kiet</a>
				<div class="dropdown-menu dropdown-menu-right"
					aria-labelledby="userDropdown">
					<a class="dropdown-item" href="/DoAnCuoiKy/admin/logout.htm">Logout</a>
				</div></li>
		</ul>
	</nav>
	<div id="layoutSidenav">
		<div id="layoutSidenav_nav">
			<nav class="sb-sidenav accordion sb-sidenav-dark"
				id="sidenavAccordion">
				<div class="sb-sidenav-menu">
					<div class="nav">
						<div class="sb-sidenav-menu-heading">Chính</div>
						<a class="nav-link" href="/DoAnCuoiKy/admin/dashboard.htm">
							<div class="sb-nav-link-icon">
								<i class="fas fa-tachometer-alt"></i>
							</div> Thống Kê
						</a>
						<div class="sb-sidenav-menu-heading">Chức Năng</div>
						<a class="nav-link collapsed" href="#" data-toggle="collapse"
							data-target="#collapseLayouts" aria-expanded="false"
							aria-controls="collapseLayouts">
							<div class="sb-nav-link-icon">
								<i class="fas fa-columns"></i>
							</div> Quản Lí
							<div class="sb-sidenav-collapse-arrow">
								<i class="fas fa-angle-down"></i>
							</div>
						</a>
						<div class="collapse" id="collapseLayouts"
							aria-labelledby="headingOne" data-parent="#sidenavAccordion">
							<nav class="sb-sidenav-menu-nested nav">
								<a class="nav-link" href="/DoAnCuoiKy/admin/posts.htm">Bài Viết</a> 
								<a class="nav-link" href="/DoAnCuoiKy/admin/categories.htm">Danh Mục</a>
								<a class="nav-link" href="/DoAnCuoiKy/admin/mails.htm">Nhận Email</a>
							</nav>
						</div>

					</div>
				</div>
				<div class="sb-sidenav-footer">
					<div class="small">Logged in as:</div>
					Admin
				</div>
			</nav>
		</div>
		<div id="layoutSidenav_content">