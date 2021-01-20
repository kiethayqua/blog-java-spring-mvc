<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<jsp:include page="inc/header.jsp"></jsp:include>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<main>
	<div class="container-fluid mt-2">
		<div class="d-flex mb-2">
			<h3 class="mr-2">Posts</h3>
			<a class="btn btn-secondary" href="admin/newpost.htm">Add New</a>
		</div>
		<table class="table">
			<thead>
				<tr>
					<th scope="col">#</th>
					<th scope="col">Tiêu Đề</th>
					<th scope="col">Danh Mục</th>
					<th scope="col">Ngày Cập Nhật</th>
					<th scope="col">Hành Động</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="p" items="${posts }" varStatus="loop">
					<tr>
						<th scope="row">${loop.index }</th>
						<td>${p.title }</td>
						<td>${p.category.category }</td>
						<td>${p.updateTime }</td>
						<td><a href="/DoAnCuoiKy/admin/updatepost/${p.id }.htm" class="btn btn-warning">Sửa</a> 
						<a class="btn btn-danger" onclick="deletePost(${p.id})">Xóa</a></td>
					</tr>
				</c:forEach>
				<script>
					function deletePost(id){
						Swal.fire({
							  title: 'Are you sure?',
							  text: "You won't be able to revert this!",
							  type: 'warning',
							  showCancelButton: true,
							  confirmButtonColor: '#3085d6',
							  cancelButtonColor: '#d33',
							  confirmButtonText: 'Yes, delete it!'
							}).then((result) => {
							  if (result.value) {
							    Swal.fire(
							      'Deleted!',
							      'Your file has been deleted.',
							      'success'
							    );
							    window.location.href = "http://localhost:8080/DoAnCuoiKy/admin/deletepost/" + id + ".htm";
							  }
							})
					}
				</script>
			</tbody>
		</table>
	</div>
</main>
<jsp:include page="inc/footer.jsp"></jsp:include>
