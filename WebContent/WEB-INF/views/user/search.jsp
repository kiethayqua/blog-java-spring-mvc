<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="kietnguyen.entity.Post"%>
<%@page import="java.util.List"%>
<jsp:include page="inc/header.jsp"></jsp:include>

<div class="section-latest">
	<div class="container">
		<div class="row gutter-v1 align-items-stretch">
			<h3>${search_title }</h3>
			<div class="col-md-9 pr-md-5">
				<!-- Bai tim kiem o day -->
				<c:forEach var="p" items="${search_list }">
					<div class="col-12">
						<div class="post-entry horizontal d-flex">
							<div class="media">
								<a href="/DoAnCuoiKy/post/${p.id }.htm"><img
									src="/DoAnCuoiKy/${p.image }" alt="Image"
									class="img-fluid"></a>
							</div>
							<div class="text">
								<div class="meta-cat">
									<a href="#">${p.category.category }</a>
								</div>
								<h2>
									<a href="/DoAnCuoiKy/post/${p.id }.htm">${p.title }</a>
								</h2>
								<div class="meta">
									<f:formatDate pattern="MMM dd, yyyy"
										value="${p.updateTime }" var="parsedDate" />
									<span>${parsedDate }</span> <span>&bullet;</span> 
									<span>${Math.ceil(fn:length(p.body.split(" ")) / 130).toString().replaceAll("0*$", "").replaceAll("\\.$", "")} mins read</span>
								</div>
								<p>${p.body.replaceAll("(?s)<[^>]*>(\\s*<[^>]*>)*", " ").substring(0, 100) } ...</p>
							</div>
						</div>
					</div>
				</c:forEach>
				
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