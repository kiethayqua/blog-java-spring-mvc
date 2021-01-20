<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<jsp:include page="inc/header.jsp"></jsp:include>
<div data-aos="fade-up" data-aos-delay="0">
	<div class="container">
		<form class="contact-form bg-white p-5" method="POST" action="/DoAnCuoiKy/contact.htm">
			<div class="row">
				<div class="col-6">
					<div class="form-group">
						<label class="text-black" for="fname">First name</label> <input
							type="text" class="form-control" id="fname" name="firstname" required> 
					</div>
				</div>
				<div class="col-6">
					<div class="form-group">
						<label class="text-black" for="lname">Last name</label> <input
							type="text" class="form-control" id="lname" name="lastname" required>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="text-black" for="email">Email address</label> <input
					type="email" class="form-control" id="email" name="email" required>
			</div>
			<div class="form-group">
				<label class="text-black" for="message">Message</label>
				<textarea class="form-control" id="message" cols="30"
					rows="5" name="mess"></textarea>
			</div>
			<button type="submit" class="btn btn-primary">Send Message</button>
		</form>
	</div>
</div>
<jsp:include page="inc/footer.jsp"></jsp:include>