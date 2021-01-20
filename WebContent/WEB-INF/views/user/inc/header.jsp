<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!doctype html>
<html>

<!-- Mirrored from preview.colorlib.com/theme/content/ by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 09 Nov 2020 09:59:06 GMT -->
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="" />
<meta name="keywords" content="" />
<link
	href="https://fonts.googleapis.com/css2?family=Jost&amp;family=Playfair+Display:wght@400;700&amp;display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="/DoAnCuoiKy/assets/css/bootstrap.min.css.pagespeed.ce.gWrw7d07SC.css">
<link rel="stylesheet"
	href="/DoAnCuoiKy/assets/css/owl.carousel.min.css%2bowl.theme.default.min.css.pagespeed.cc.MjwVL-AL32.css" />
<link rel="stylesheet"
	href="/DoAnCuoiKy/assets/css/jquery.fancybox.min.css.pagespeed.ce.otQlhCkvZM.css">
<link rel="stylesheet"
	href="/DoAnCuoiKy/assets/fonts/icomoon/A.style.css.pagespeed.cf.g4KcKN4wlL.css">
<style>
@font-face {
	font-family: "Flaticon";
	src: url(/DoAnCuoiKy/assets/fonts/flaticon/font/Flaticon.eot);
	src: url(/DoAnCuoiKy/assets/fonts/flaticon/font/Flaticond41d.eot?#iefix)
		format("embedded-opentype"), url(/DoAnCuoiKy/assets/fonts/flaticon/font/Flaticon.woff2)
		format("woff2"), url(/DoAnCuoiKy/assets/fonts/flaticon/font/Flaticon.woff) format("woff"),
		url(/DoAnCuoiKy/assets/fonts/flaticon/font/Flaticon.ttf) format("truetype"),
		url(/DoAnCuoiKy/assets/fonts/flaticon/font/Flaticon.svg#Flaticon) format("svg");
	font-weight: normal;
	font-style: normal
}

@media screen and (-webkit-min-device-pixel-ratio:0) {
	@font-face {
		font-family: "Flaticon";
		src: url(/DoAnCuoiKy/assets/fonts/flaticon/font/Flaticon.svg#Flaticon) format("svg")
	}
}

[class^="flaticon-"]:before, [class*=" flaticon-"]:before, [class^="flaticon-"]:after,
	[class*=" flaticon-"]:after {
	font-family: Flaticon;
	font-style: normal;
	font-weight: normal;
	font-variant: normal;
	text-transform: none;
	line-height: 1;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale
}

.flaticon-square:before {
	content: "\f100"
}

.flaticon-technology:before {
	content: "\f101"
}

.flaticon-illumination:before {
	content: "\f102"
}

.flaticon-blueprint:before {
	content: "\f103"
}

.flaticon-columns:before {
	content: "\f104"
}

.flaticon-worker:before {
	content: "\f105"
}
</style>
<link rel="stylesheet" href="/DoAnCuoiKy/assets/css/aos.css.pagespeed.ce.vcWvsuCzCE.css">
<link rel="stylesheet"
	href="/DoAnCuoiKy/assets/css/A.style.css.pagespeed.cf.hNK6DGcSnX.css">
<title>KietNguyenBlog</title>
</head>
<body>
	<div class="site-mobile-menu site-navbar-target">
		<div class="site-mobile-menu-header">
			<div class="site-mobile-menu-close">
				<span class="icofont-close js-menu-toggle"></span>
			</div>
		</div>
		<div class="site-mobile-menu-body"></div>
	</div>
	<div class="container">
		<nav class="site-nav">
			<div class="row justify-content-between align-items-center">
				<div class="d-none d-lg-block col-lg-3 top-menu">
				</div>
				<div class="col-3 col-md-6 col-lg-6 text-lg-center logo">
					<a href="/DoAnCuoiKy/">KietNguyenBlog<span class="text-primary">.</span>
					</a>
				</div>
				<div class="col-9 col-md-6 col-lg-3 text-right top-menu">
					<div class="d-inline-flex align-items-center">
						<div class="search-wrap">
							<button
								class="d-inline-flex align-items-center js-search-toggle"><span
								class="icon-search2 mr-2"></span><span>Search</span></button>
							<form action="/DoAnCuoiKy/search.htm" class="d-flex" method="get">
								<input type="text" id="s" class="form-control"
									placeholder="Enter keyword and hit enter..." name="title">
							</form>
						</div>
						<span class="mx-2 d-inline-block d-lg-none"></span><a href="#"
							class="burger ml-3 site-menu-toggle js-menu-toggle d-inline-block d-lg-none"
							data-toggle="collapse" data-target="#main-navbar"> <span></span>
						</a>
					</div>
				</div>
			</div>
			<div class="d-none d-lg-block row align-items-center py-5">
				<div class="col-12 col-sm-12 col-lg-12 site-navigation text-center">
					<ul
						class="js-clone-nav d-none d-lg-inline-block text-left site-menu">
						<li class="active"><a href="/DoAnCuoiKy/">Home</a></li>
						<li class="has-children"><a href="#">Categories</a>
							<ul class="dropdown">
								<c:forEach var="cat" items="${categories }">
									<li><a href="/DoAnCuoiKy/category/${cat.id }.htm">${cat.category}</a></li>
								</c:forEach>
							</ul></li>
						<li><a href="/DoAnCuoiKy/contact.htm">Contact us</a></li>
					</ul>
				</div>
			</div>
		</nav>
		<!-- END nav -->
	</div>
	<!-- END container -->
