<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<jsp:include page="inc/header.jsp"></jsp:include>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<main>
	<div class="container-fluid mt-2">
		<table class="table">
			<thead>
				<tr>
					<th scope="col">#</th>
					<th scope="col">Họ</th>
					<th scope="col">Tên</th>
					<th scope="col">Email</th>
					<th scope="col">Nội Dung</th>
					<th scope="col">Hành Động</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="m" items="${mails }" varStatus="loop">
					<tr>
						<th scope="row">${loop.index }</th>
						<td>${m.firstname }</td>
						<td>${m.lastname }</td>
						<td>${m.email }</td>
						<td>${m.mess }</td>
						<td><a href="/DoAnCuoiKy/admin/send/${m.id }.htm" class="btn btn-success">Trả Lời</a> </td>
					</tr>
				</c:forEach>
				<script>
					
				</script>
			</tbody>
		</table>
	</div>
</main>
<jsp:include page="inc/footer.jsp"></jsp:include>
