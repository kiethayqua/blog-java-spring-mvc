<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="kietnguyen.entity.Post"%>
<%@page import="java.util.List"%>
<jsp:include page="inc/header.jsp"></jsp:include>
<div class="featured-post">
	<div class="container main-slider owl-single owl-carousel">
		<c:forEach var="post" items="${slide_posts }">
			<div class="post-slide"
				style="background-image: url('/DoAnCuoiKy/${post.image}');">
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
					<h2>
						<a href="/DoAnCuoiKy/post/${post.id }.htm" class="text-black">${post.title }</a>
					</h2>
					<p>${post.body.replaceAll("(?s)<[^>]*>(\\s*<[^>]*>)*", " ").substring(0,100) }...</p>
					<div class="meta">
						<f:formatDate pattern="MMM dd, yyyy" value="${post.updateTime}"
							var="parsedDate" />
						<span>${parsedDate }</span> <span>&bullet;</span> 
						<span>${Math.ceil(fn:length(post.body.split(" ")) / 130).toString().replaceAll("0*$", "").replaceAll("\\.$", "")} mins read</span>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
<div class="section-latest">
	<div class="container">
		<div class="row gutter-v1 align-items-stretch">
			<div class="col-12">
				<h2 class="section-title">Today's Highlight</h2>
			</div>
			<div class="col-md-9 pr-md-5">
				<div class="row mb-5">
					<%
						List<Post> postList = (List<Post>) request.getAttribute("cat_posts");
						int posts = postList.size();
					%>
					<%
						for (int i = 0; i < 2; i++) {
					%>
					<div class="col-md-6">
						<div class="post-entry">
							<div class="media">
								<a href="/DoAnCuoiKy/post/<%=postList.get(i).getId() %>.htm"><img
									src="/DoAnCuoiKy/<%=postList.get(i).getImage()%>" alt="Image"
									class="img-fluid"></a>
							</div>
							<div class="text">
								<div class="meta-cat">
									<a href="#"><%=postList.get(i).getCategory().getCategory()%></a>
								</div>
								<h2>
									<a href="/DoAnCuoiKy/post/<%=postList.get(i).getId() %>.htm"><%=postList.get(i).getTitle()%></a>
								</h2>
								<div class="meta">
									<f:formatDate pattern="MMM dd, yyyy"
										value="<%=postList.get(i).getUpdateTime()%>" var="parsedDate" />
									<span>${parsedDate }</span> <span>&bullet;</span> 
									<span><%=String.valueOf(Math.ceil(postList.get(i).getBody().split(" ").length / 130)).replaceAll("0*$", "").replaceAll("\\.$", "") %> mins read</span>
								</div>
								<p><%=postList.get(i).getBody().replaceAll("(?s)<[^>]*>(\\s*<[^>]*>)*", " ").substring(0, 100) + "..."%></p>
							</div>
						</div>
					</div>
					<%
						}
					%>
				</div>
				<div class="row">
					<%
						for (int i = 2; i < posts; i++) {
					%>
					<div class="col-12">
						<div class="post-entry horizontal d-flex">
							<div class="media">
								<a href="/DoAnCuoiKy/post/<%=postList.get(i).getId() %>.htm"><img
									src="/DoAnCuoiKy/<%=postList.get(i).getImage()%>" alt="Image"
									class="img-fluid"></a>
							</div>
							<div class="text">
								<div class="meta-cat">
									<a href="#"><%=postList.get(i).getCategory().getCategory()%></a>
								</div>
								<h2>
									<a href="/DoAnCuoiKy/post/<%=postList.get(i).getId() %>.htm"><%=postList.get(i).getTitle()%></a>
								</h2>
								<div class="meta">
									<f:formatDate pattern="MMM dd, yyyy"
										value="<%=postList.get(i).getUpdateTime()%>" var="parsedDate" />
									<span>${parsedDate }</span> <span>&bullet;</span> 
									<span><%=String.valueOf(Math.ceil(postList.get(i).getBody().split(" ").length / 130)).replaceAll("0*$", "").replaceAll("\\.$", "") %> mins read</span>
								</div>
								<p><%=postList.get(i).getBody().replaceAll("(?s)<[^>]*>(\\s*<[^>]*>)*", " ").substring(0, 100) + "..."%></p>
							</div>
						</div>
					</div>
					<%
						}
					%>
				</div>
			</div>
			<div class="col-md-3">
				<div class="floating-block sticky-top text-center">
					<jsp:include page="inc/subscribe.jsp"></jsp:include>
				</div>
			</div>
			
		</div>
	</div>
</div>
<jsp:include page="inc/footer.jsp"></jsp:include>