<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<jsp:include page="inc/header.jsp"></jsp:include>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<main>
	<div class="container-fluid mt-2">
		<div class="d-flex mb-2">
			<h3 class="mr-2">Categories</h3>
			<a class="btn btn-secondary" onclick="addCategory()">Add New</a>
		</div>
		<table class="table">
			<thead>
				<tr>
					<th scope="col">#</th>
					<th scope="col">Tên Danh Mục</th>
					<th scope="col">Số Bài Viết</th>
					<th scope="col">Hành Động</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="c" items="${categories }" varStatus="loop">
					<tr>
						<th scope="row">${loop.index }</th>
						<td>${c.category }</td>
						<td>${c.posts.size() }</td>
						<td><a class="btn btn-warning" onclick="updateCategory(${c.id})">Sửa</a> 
						<a class="btn btn-danger" onclick="deleteCategory(${c.id})">Xóa</a></td>
					</tr>
				</c:forEach>
				<script>
					function addCategory(){
						const cat = Swal.fire({
							  title: 'Enter your Category',
							  input: 'text',
							  showCancelButton: true,
							  inputValidator: (value) => {
							    if (!value) {
							      return 'You need to write something!'
							    }else{
							    	$.ajax({
							    		  type: "POST",
							    		  url: 'http://localhost:8080/DoAnCuoiKy/admin/newcategory.htm',
							    		  data: {category: value},
							    		  success: function(){
							    			  const Toast = Swal.mixin({
							    				  toast: true,
							    				  position: 'top-end',
							    				  showConfirmButton: false,
							    				  timer: 3000,
							    				  timerProgressBar: true,
							    				  didOpen: (toast) => {
							    				    toast.addEventListener('mouseenter', Swal.stopTimer)
							    				    toast.addEventListener('mouseleave', Swal.resumeTimer)
							    				  }
							    				});

							    				Toast.fire({
							    				  icon: 'success',
							    				  title: 'Thêm danh mục thành công!'
							    				});
							    				setTimeout(function(){
							    					window.location.href = "http://localhost:8080/DoAnCuoiKy/admin/categories.htm";
							    				}, 1000);
							    		  }
							    		});
							    }
							  }
							}
						)
					}
					
					function updateCategory(id){
						const cat = Swal.fire({
							  title: 'Enter your Category',
							  input: 'text',
							  showCancelButton: true,
							  inputValidator: (value) => {
							    if (!value) {
							      return 'You need to write something!'
							    }else{
							    	$.ajax({
							    		  type: "POST",
							    		  url: 'http://localhost:8080/DoAnCuoiKy/admin/updatecategory/' + id + '.htm',
							    		  data: {category: value},
							    		  success: function(){
							    			  const Toast = Swal.mixin({
							    				  toast: true,
							    				  position: 'top-end',
							    				  showConfirmButton: false,
							    				  timer: 3000,
							    				  timerProgressBar: true,
							    				  didOpen: (toast) => {
							    				    toast.addEventListener('mouseenter', Swal.stopTimer)
							    				    toast.addEventListener('mouseleave', Swal.resumeTimer)
							    				  }
							    				});

							    				Toast.fire({
							    				  icon: 'success',
							    				  title: 'Cập nhật danh mục thành công!'
							    				});
							    				setTimeout(function(){
							    					window.location.href = "http://localhost:8080/DoAnCuoiKy/admin/categories.htm";
							    				}, 1000);
							    		  }
							    		});
							    }
							  }
							}
						)
					}
				
					function deleteCategory(id){
						Swal.fire({
							  title: 'Are you sure?',
							  text: "You won't be able to revert this!",
							  type: 'warning',
							  showCancelButton: true,
							  timer: 3000,
							  confirmButtonColor: '#3085d6',
							  cancelButtonColor: '#d33',
							  confirmButtonText: 'Yes, delete it!'
							}).then((result) => {
							  if (result.value) {
								/* Swal.fire(
									'Deleted!',
									'Your file has been deleted.',
									'success'
								); */
							   /*  setTimeout(function(){
							    	window.location.href = "http://localhost:8080/DoAnCuoiKy/admin/deletecategory/" + id + ".htm";
							    }, 2000); */
								  window.location.href = "http://localhost:8080/DoAnCuoiKy/admin/deletecategory/" + id + ".htm";
							  }
							})
					}
				</script>
			</tbody>
		</table>
	</div>
</main>
<jsp:include page="inc/footer.jsp"></jsp:include>
