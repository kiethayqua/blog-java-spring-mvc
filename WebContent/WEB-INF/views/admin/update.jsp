<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<jsp:include page="inc/header.jsp"></jsp:include>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<main>
	<div class="container-fluid">
		<h1>Cập Nhật Bài Viết</h1>
		<form:form action="/DoAnCuoiKy/admin/updatepost/${post.id }.htm" method="POST" enctype="multipart/form-data" modelAttribute="post" acceptCharset="UTF-8">
			<div class="form-group">
				<label>Tiêu Đề</label> <form:input type="text" class="form-control w-25" path="title" required="true"/>
			</div>
			<div class="form-group">
				<label>Hình Ảnh</label> 
				<input type="file" class="form-control w-25" name="image"/>
			</div>
			<div class="form-group">
				<label>Danh Mục</label> 
				<form:select path="category" items="${categories }" itemValue="id" itemLabel="category"/>
			</div>
			<div class="form-group">
				<label>Nội Dung</label>
				<script src="/DoAnCuoiKy/admin_assets/ckeditor/ckeditor.js"></script>
				<form:textarea id="editor1" path="body"></form:textarea>
			</div>
			<button type="submit" class="btn btn-primary">Lưu</button>
		</form:form>
	</div>
</main>
<jsp:include page="inc/footer.jsp"></jsp:include>
