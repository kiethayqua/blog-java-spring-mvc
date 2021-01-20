<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<jsp:include page="inc/header.jsp"></jsp:include>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<main>
	<div class="container-fluid">
		<h1>Thêm Bài Viết</h1>
		<form action="" method="POST" enctype="multipart/form-data">
			<div class="form-group">
				<label>Tiêu Đề</label> <input type="text" class="form-control w-25"
					name="title" required/>
			</div>
			<div class="form-group">
				<label>Hình Ảnh</label> <input type="file" class="form-control w-25"
					name="image" required/>
			</div>
			<div class="form-group">
				<label>Danh Mục</label> <select class="form-control w-25"
					name="category">
					<c:forEach var="cate" items="${categories }">
						<option value="${cate.id }">${cate.category }</option>
					</c:forEach>
				</select>
			</div>
			<div class="form-group">
				<label>Nội Dung</label>
				<textarea name="editor1" id="editor1"></textarea>
			</div>
			<button type="submit" class="btn btn-primary">Lưu</button>
		</form>
	</div>
</main>
<jsp:include page="inc/footer.jsp"></jsp:include>
