<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="inc/header.jsp"></jsp:include>
<div class="featured-post single-article">
	<div class="container">
		<div class="post-slide single-page"
			style="background-image: url(/DoAnCuoiKy/${post.image})">
			<div class="text-wrap">
				<div class="share">
					<ul class="list-unstyled">
						<li><a href="#"><span class="icon-facebook"></span></a></li>
						<li><a href="#"><span class="icon-twitter"></span></a></li>
						<li><a href="#"><span class="icon-pinterest"></span></a></li>
					</ul>
				</div>
				<div class="meta-cat">
					<a href="#">${post.category.category }</a>
				</div>
				<h2>${post.title }</h2>
				<div class="meta">
					<f:formatDate pattern="MMM dd, yyyy" value="${post.updateTime}"
						var="parsedDate" />
					<span>${parsedDate }</span> <span>&bullet;</span> 
					<span>${Math.ceil(fn:length(post.body.split(" ")) / 130).toString().replaceAll("0*$", "").replaceAll("\\.$", "")} mins read</span>
				</div>
			</div>
		</div>
		<!-- .post-slide -->
	</div>
</div>
<div class="container article">
	<div class="row justify-content-center align-items-stretch">
		<article class="col-lg-8 order-lg-2 px-lg-5">
			${post.body }
			<hr>
			<div id="fb-root"></div>
			<div class="fb-comments"
				data-href="http://localhost:8080/DoAnCuoiKy/post/${id }.htm"
				data-numposts="10" data-width="" ></div>
		</article>
		<div class="col-md-12 col-lg-1 order-lg-1">
			<div class="share sticky-top">
				<h3>Share</h3>
				<ul class="list-unstyled share-article">
					<li><a href="#"><span class="icon-facebook"></span></a></li>
					<li><a href="#"><span class="icon-twitter"></span></a></li>
					<li><a href="#"><span class="icon-pinterest"></span></a></li>
				</ul>
			</div>
		</div>
		<div class="col-lg-3 mb-5 mb-lg-0 order-lg-3">
			<div class="share floating-block sticky-top">
				<jsp:include page="inc/subscribe.jsp"></jsp:include>
			</div>
		</div>
	</div>

</div>
<div class="section-more-posts mb-0">
	<div class="container">
		<div class="row gutter-v1">
			<div class="col-12 text-center">
				<h2 class="section-title text-center">Related Articles</h2>
			</div>
			<c:forEach var="p" items="${related_posts }">
				<div class="col-6 col-md-6 col-lg-3">
					<div class="post-entry">
						<div class="media">
							<img src="/DoAnCuoiKy/${p.image }" alt="Image" class="img-fluid">
						</div>
						<div class="text">
							<div class="meta-cat">
								<a href="#">${p.category.category }</a>
							</div>
							<h2>
								<a href="/DoAnCuoiKy/post/${p.id }.htm">${p.title }</a>
							</h2>
							<div class="meta">
								<f:formatDate pattern="MMM dd, yyyy" value="${p.updateTime}"
									var="parsedDate" />
								<span>${parsedDate }</span> <span>&bullet;</span> 
								<span>${Math.ceil(fn:length(p.body.split(" ")) / 130).toString().replaceAll("0*$", "").replaceAll("\\.$", "")} mins read</span>
							</div>
							<p>${p.body.replaceAll("(?s)<[^>]*>(\\s*<[^>]*>)*", " ").substring(0, 100) }
								...</p>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</div>
<jsp:include page="inc/footer.jsp"></jsp:include>