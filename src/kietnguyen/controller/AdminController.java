package kietnguyen.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.apache.jasper.tagplugins.jstl.core.ForEach;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kietnguyen.entity.Category;
import kietnguyen.entity.Mail;
import kietnguyen.entity.Post;
import kietnguyen.entity.User;

class RandomString { 
	  
    // function to generate a random string of length n 
    static String getAlphaNumericString(int n) 
    { 
  
        // chose a Character random from this String 
        String AlphaNumericString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                                    + "0123456789"
                                    + "abcdefghijklmnopqrstuvxyz"; 
  
        // create StringBuffer size of AlphaNumericString 
        StringBuilder sb = new StringBuilder(n); 
  
        for (int i = 0; i < n; i++) { 
  
            // generate a random number between 
            // 0 to AlphaNumericString variable length 
            int index 
                = (int)(AlphaNumericString.length() 
                        * Math.random()); 
  
            // add Character one by one in end of sb 
            sb.append(AlphaNumericString 
                          .charAt(index)); 
        } 
  
        return sb.toString(); 
    }
} 

@Controller
@Transactional
@RequestMapping("/admin/")
public class AdminController {
	@Autowired
	SessionFactory factory;
	
	@Autowired
	ServletContext context;

	@RequestMapping(value="login", method=RequestMethod.GET)
	public String login() {
		return "admin/login";
	}
	
	@RequestMapping(value="login", method=RequestMethod.POST)
	public String login(@RequestParam("username") String username, @RequestParam("password") String password, HttpSession session) {
		Session s = factory.getCurrentSession();
		// truy van danh sach user
		String hql = "FROM User";
		Query query = s.createQuery(hql);
		List<User> userList = query.list();
		for(User user : userList) {
			if(user.getUsername().equals(username)) {
				if(user.getPassword().equals(password)) {
					session.setAttribute("username", username);
					return "redirect:/admin/dashboard.htm";
				}
			}
		}
		
		return "admin/login";
	}
	
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		session.removeAttribute("username");
		return "redirect:/admin/dashboard.htm";
	}
	
	@RequestMapping("dashboard")
	public String admin(HttpSession session, ModelMap model) {
		Object v = session.getAttribute ("username");
		if (v != null){ 
			Session s = factory.getCurrentSession();
			// truy van lay so luong bai viet
			String hql = "SELECT count(*) FROM Post";
			Query query = s.createQuery(hql);
			List numberPosts = query.list();
			model.addAttribute("numberPosts", numberPosts);
			// lay so luong danh muc
			hql = "SELECT count(*) FROM Category";
			query = s.createQuery(hql);
			List numberCategories = query.list();
			model.addAttribute("numberCategories", numberCategories);
			return "admin/dashboard";
		}
		return "redirect:/admin/login.htm";
	}
	
	@RequestMapping("posts")
	public String posts(HttpSession session, ModelMap model) {
		Object v = session.getAttribute ("username");
		if (v != null){ 
			Session s = factory.getCurrentSession();
			// truy van lay danh sach tat ca bai viet
			String hql = "FROM Post ORDER BY update_time DESC";
			Query query = s.createQuery(hql);
			List<Category> postList = query.list();
			model.addAttribute("posts", postList);
			return "admin/posts";
		}
		return "redirect:/admin/login.htm";
	}
	
	@RequestMapping(value = "newpost", method = RequestMethod.GET)
	public String newPost(ModelMap model, HttpSession session) {
		Object v = session.getAttribute ("username");
		if (v != null){ 
			Session s = factory.getCurrentSession();
			// truy van lay danh sach category
			String catHql = "FROM Category";
			Query query = s.createQuery(catHql);
			List<Category> catList = query.list();
			model.addAttribute("categories", catList);

			return "admin/newpost";
		}
		return "redirect:/admin/login.htm";	
	}

	@RequestMapping(value = "newpost", method = RequestMethod.POST)
	public String newPost(ModelMap model, @RequestParam("title") String title, @RequestParam("image") MultipartFile image,
			@RequestParam("category") String id, @RequestParam("editor1") String body) throws IllegalStateException, IOException, ParseException {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		Session session1 = factory.getCurrentSession();
		
		Post post = new Post();
		String imagePath = "";
		String setImagePath = "";
		String randomString = RandomString.getAlphaNumericString(20);
		if (image.isEmpty()) {
			model.addAttribute("message", "Vui lòng chọn file!");
		} else {
			imagePath = context.getRealPath("/uploads/" + randomString + image.getOriginalFilename());
			image.transferTo(new File(imagePath));
			setImagePath = "uploads/" + randomString + image.getOriginalFilename();
		}
		
		post.setTitle(title);
		post.setImage(setImagePath);
		post.setBody(body);
		
		Date date = new SimpleDateFormat("yyyy-MM-dd").parse(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));  
		post.setCreateTime(date);
		post.setUpdateTime(date);
		// lay danh sach Category
		String catHql = "FROM Category";
		Query query = session.createQuery(catHql);
		List<Category> catList = query.list();
		for(Category cat : catList) {
			if(cat.getId() == Integer.valueOf(id)) {
				post.setCategory(cat);
			}
		}
		
		// lay danh sach User
		String userHql = "FROM User";
		query = session.createQuery(userHql);
		List<User> userList = query.list();
		for(User user  : userList) {
			if(user.getId() == 1) {
				post.setUser(user);
			}
		}
		
		try {
			session.save(post);
			t.commit();
			model.addAttribute("alert", "const Toast = Swal.mixin({\r\n"
					+ "  toast: true,\r\n"
					+ "  position: 'top-end',\r\n"
					+ "  showConfirmButton: false,\r\n"
					+ "  timer: 3000,\r\n"
					+ "  timerProgressBar: true,\r\n"
					+ "  didOpen: (toast) => {\r\n"
					+ "    toast.addEventListener('mouseenter', Swal.stopTimer)\r\n"
					+ "    toast.addEventListener('mouseleave', Swal.resumeTimer)\r\n"
					+ "  }\r\n"
					+ "})\r\n"
					+ "\r\n"
					+ "Toast.fire({\r\n"
					+ "  icon: 'success',\r\n"
					+ "  title: 'Thêm bài viết thành công!'\r\n"
					+ "})");
		} catch (Exception e) {
			t.rollback();
			model.addAttribute("alert", "const Toast = Swal.mixin({\r\n"
					+ "  toast: true,\r\n"
					+ "  position: 'top-end',\r\n"
					+ "  showConfirmButton: false,\r\n"
					+ "  timer: 3000,\r\n"
					+ "  timerProgressBar: true,\r\n"
					+ "  didOpen: (toast) => {\r\n"
					+ "    toast.addEventListener('mouseenter', Swal.stopTimer)\r\n"
					+ "    toast.addEventListener('mouseleave', Swal.resumeTimer)\r\n"
					+ "  }\r\n"
					+ "})\r\n"
					+ "\r\n"
					+ "Toast.fire({\r\n"
					+ "  icon: 'error',\r\n"
					+ "  title: 'Thêm bài viết thất bại!'\r\n"
					+ "})");
		} finally {
			session.close();
		}

		return "admin/newpost";
	}
	
	@RequestMapping(value = "updatepost/{id}", method = RequestMethod.GET)
	public String updatePost(ModelMap model, HttpSession session, @PathVariable("id") int id) {
		Object v = session.getAttribute ("username");
		if (v != null){ 
			Session s = factory.getCurrentSession();
			// truy van lay danh sach category
			String catHql = "FROM Category";
			Query query = s.createQuery(catHql);
			List<Category> catList = query.list();
			model.addAttribute("categories", catList);
			
			// lay post tu id
			Post post = (Post) s.get(Post.class, id);
			model.addAttribute("post", post);
			return "admin/update";
		}
		return "redirect:/admin/login.htm";	
	}
	
	
	@RequestMapping(value = "updatepost/{id}", method = RequestMethod.POST)
	public String updatePost(ModelMap model, @RequestParam("title") String title, @RequestParam("image") MultipartFile image,
			@RequestParam("category") String id, @RequestParam("body") String body, @PathVariable("id") int postId) throws IllegalStateException, IOException, ParseException {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		Session session1 = factory.getCurrentSession();
		
		Post updatePost = (Post) session.get(Post.class, postId);
		String imagePath = "";
		String setImagePath = "";
		String randomString = RandomString.getAlphaNumericString(20);
		if (image.isEmpty()) {
			String getOldImagePathHql = "SELECT image FROM Post WHERE id=" + postId;
			Query q = session1.createQuery(getOldImagePathHql);
			setImagePath = (String) q.uniqueResult();
		} else {
			imagePath = context.getRealPath("/uploads/" + randomString + image.getOriginalFilename());
			image.transferTo(new File(imagePath));
			setImagePath = "uploads/" + randomString + image.getOriginalFilename();
		}
		
		updatePost.setTitle(title);
		updatePost.setImage(setImagePath);
		updatePost.setBody(body);
		
		Date date = new SimpleDateFormat("yyyy-MM-dd").parse(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));  
		//updatePost.setCreateTime();
		// lay ngay tao
		String getCreateDateHql = "SELECT createTime FROM Post WHERE id=" + postId;
		Query query = session1.createQuery(getCreateDateHql);
		Date createDate = (Date) query.uniqueResult();
		
		updatePost.setCreateTime(createDate);
		updatePost.setUpdateTime(date);
		// lay danh sach Category
		String catHql = "FROM Category";
		query = session1.createQuery(catHql);
		List<Category> catList = query.list();
		for(Category cat : catList) {
			if(cat.getId() == Integer.valueOf(id)) {
				updatePost.setCategory(cat);
			}
		}
		
		// lay danh sach User
		String userHql = "FROM User";
		query = session1.createQuery(userHql);
		List<User> userList = query.list();
		for(User user  : userList) {
			if(user.getId() == 1) {
				updatePost.setUser(user);
			}
		}
		
		try {
			session.update(updatePost);
			t.commit();
			model.addAttribute("alert", "const Toast = Swal.mixin({\r\n"
					+ "  toast: true,\r\n"
					+ "  position: 'top-end',\r\n"
					+ "  showConfirmButton: false,\r\n"
					+ "  timer: 3000,\r\n"
					+ "  timerProgressBar: true,\r\n"
					+ "  didOpen: (toast) => {\r\n"
					+ "    toast.addEventListener('mouseenter', Swal.stopTimer)\r\n"
					+ "    toast.addEventListener('mouseleave', Swal.resumeTimer)\r\n"
					+ "  }\r\n"
					+ "})\r\n"
					+ "\r\n"
					+ "Toast.fire({\r\n"
					+ "  icon: 'success',\r\n"
					+ "  title: 'Cập nhật bài viết thành công!'\r\n"
					+ "})");
			model.addAttribute("categories", catList);
			model.addAttribute("post", updatePost);
		} catch (Exception e) {
			t.rollback();
			model.addAttribute("alert", "const Toast = Swal.mixin({\r\n"
					+ "  toast: true,\r\n"
					+ "  position: 'top-end',\r\n"
					+ "  showConfirmButton: false,\r\n"
					+ "  timer: 3000,\r\n"
					+ "  timerProgressBar: true,\r\n"
					+ "  didOpen: (toast) => {\r\n"
					+ "    toast.addEventListener('mouseenter', Swal.stopTimer)\r\n"
					+ "    toast.addEventListener('mouseleave', Swal.resumeTimer)\r\n"
					+ "  }\r\n"
					+ "})\r\n"
					+ "\r\n"
					+ "Toast.fire({\r\n"
					+ "  icon: 'error',\r\n"
					+ "  title: 'Cập nhật bài viết thất bại!'\r\n"
					+ "})");
		} finally {
			session.close();
		}

		return "admin/update";
	}
	
	@RequestMapping(value = "deletepost/{id}", method = RequestMethod.GET)
	public String deletePost(@PathVariable("id") int postId, HttpSession session) {
		Object v = session.getAttribute ("username");
		if(v != null) {
			Session s = factory.openSession();
			Transaction t = s.beginTransaction();
			Post deletePost = (Post) s.get(Post.class, postId);
			
			try {
				s.delete(deletePost);
				t.commit();
			} catch (Exception e) {
				t.rollback();
			} finally {
				s.close();
			}
			return "redirect: /DoAnCuoiKy/admin/posts.htm";
		}
		
		return "redirect:/admin/login.htm";
		
	}
	
	@RequestMapping("categories")
	public String categories(HttpSession session, ModelMap model) {
		Object v = session.getAttribute ("username");
		if (v != null){ 
			Session s = factory.getCurrentSession();
			// truy van lay danh sach tat ca danh muc
			String hql = "FROM Category";
			Query query = s.createQuery(hql);
			List<Category> categoryList = query.list();
			model.addAttribute("categories", categoryList);
			return "admin/categories";
		}
		return "redirect:/admin/login.htm";
	}
	
	@RequestMapping(value = "newcategory", method = RequestMethod.POST)
	public String newCategory(ModelMap model, @RequestParam("category") String category) throws IllegalStateException, IOException, ParseException {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		
		Category cat = new Category();
		cat.setCategory(category);
		
		try {
			session.save(cat);
			t.commit();
		} catch (Exception e) {
			t.rollback();
		} finally {
			session.close();
		}

		return "redirect:/admin/categories.htm";
	}
	
	@RequestMapping(value = "updatecategory/{id}", method = RequestMethod.POST)
	public String updateCategory(ModelMap model, @RequestParam("category") String category, @PathVariable("id") int catId) throws IllegalStateException, IOException, ParseException {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		
		Category updateCategory = (Category) session.get(Category.class, catId);
		updateCategory.setCategory(category);
		
		try {
			session.update(updateCategory);
			t.commit();
		} catch (Exception e) {
			t.rollback();
		} finally {
			session.close();
		}

		return "redirect: /DoAnCuoiKy/admin/categories.htm";
	}
	
	@RequestMapping(value = "deletecategory/{id}", method = RequestMethod.GET)
	public String deleteCategory(ModelMap model, @PathVariable("id") int catId, HttpSession session) {
		Object v = session.getAttribute ("username");
		if(v != null) {
			Session s = factory.openSession();
			Transaction t = s.beginTransaction();
			Category deleteCategory = (Category) s.get(Category.class, catId);
			
			try {
				s.delete(deleteCategory);
				t.commit();
				model.addAttribute("alert", "const Toast = Swal.mixin({\r\n"
						+ "  toast: true,\r\n"
						+ "  position: 'top-end',\r\n"
						+ "  showConfirmButton: false,\r\n"
						+ "  timer: 3000,\r\n"
						+ "  timerProgressBar: true,\r\n"
						+ "  didOpen: (toast) => {\r\n"
						+ "    toast.addEventListener('mouseenter', Swal.stopTimer)\r\n"
						+ "    toast.addEventListener('mouseleave', Swal.resumeTimer)\r\n"
						+ "  }\r\n"
						+ "})\r\n"
						+ "\r\n"
						+ "Toast.fire({\r\n"
						+ "  icon: 'success',\r\n"
						+ "  title: 'Xoá danh mục thành công!'\r\n"
						+ "})");
			} catch (Exception e) {
				t.rollback();
				model.addAttribute("alert", "const Toast = Swal.mixin({\r\n"
						+ "  toast: true,\r\n"
						+ "  position: 'top-end',\r\n"
						+ "  showConfirmButton: false,\r\n"
						+ "  timer: 3000,\r\n"
						+ "  timerProgressBar: true,\r\n"
						+ "  didOpen: (toast) => {\r\n"
						+ "    toast.addEventListener('mouseenter', Swal.stopTimer)\r\n"
						+ "    toast.addEventListener('mouseleave', Swal.resumeTimer)\r\n"
						+ "  }\r\n"
						+ "})\r\n"
						+ "\r\n"
						+ "Toast.fire({\r\n"
						+ "  icon: 'error',\r\n"
						+ "  title: 'Xoá danh mục thất bại!'\r\n"
						+ "})");
			} finally {
				s.close();
			}
			Session s1 = factory.getCurrentSession();
			// truy van lay danh sach tat ca danh muc
			String hql = "FROM Category";
			Query query = s1.createQuery(hql);
			List<Category> categoryList = query.list();
			model.addAttribute("categories", categoryList);
			
			return "admin/categories";
		}
		
		return "redirect:/admin/login.htm";
	}
	
	@RequestMapping("mails")
	public String mails(HttpSession session, ModelMap model) {
		Object v = session.getAttribute ("username");
		if (v != null){ 
			Session s = factory.getCurrentSession();
			// truy van lay danh sach tat ca mail
			String hql = "FROM Mail";
			Query query = s.createQuery(hql);
			List<Category> mailList = query.list();
			model.addAttribute("mails", mailList);
			return "admin/mails";
		}
		return "redirect:/admin/login.htm";
	}
	
	// gui mail
	@Autowired
	JavaMailSender mailer;
	
	
	@RequestMapping("send/{id}")
	public String sendMail(HttpSession checkSession, ModelMap model, @PathVariable("id") int mailId) {
		Object v = checkSession.getAttribute ("username");
		if (v != null) {
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			Mail sendMail = (Mail) session.get(Mail.class, mailId);
			String to = sendMail.getEmail();
			String ho = sendMail.getFirstname();
			String ten = sendMail.getLastname();
			try {
				// tao mail
				MimeMessage mail = mailer.createMimeMessage();
				// su dung tro giup
				MimeMessageHelper helper = new MimeMessageHelper(mail);
				helper.setFrom("nguyenkiet193@gmail.com", "KietNguyenBlog");
				helper.setTo(to);
				helper.setReplyTo("nguyenkiet193@gmail.com", "KietNguyenBlog");
				helper.setSubject("Cảm ơn từ BlogKietNguyen ");
				String text = "Xin chào " + ho + " " + ten + ", Cảm ơn bạn đã quan tâm đến KietNguyenBlog!";
				if(ho == null || ten == null) text = "Xin chào, Cảm ơn bạn đã quan tâm đến KietNguyenBlog!";
				helper.setText(text, true);
				// gui mail
				mailer.send(mail);
				
				// tra loi mail xong xoa 
				Mail deleteMail = (Mail) session.get(Mail.class, mailId);
				Session s = factory.getCurrentSession();
				try {
					session.delete(deleteMail);
					t.commit();
					model.addAttribute("alert", "const Toast = Swal.mixin({\r\n"
							+ "  toast: true,\r\n"
							+ "  position: 'top-end',\r\n"
							+ "  showConfirmButton: false,\r\n"
							+ "  timer: 3000,\r\n"
							+ "  timerProgressBar: true,\r\n"
							+ "  didOpen: (toast) => {\r\n"
							+ "    toast.addEventListener('mouseenter', Swal.stopTimer)\r\n"
							+ "    toast.addEventListener('mouseleave', Swal.resumeTimer)\r\n"
							+ "  }\r\n"
							+ "})\r\n"
							+ "\r\n"
							+ "Toast.fire({\r\n"
							+ "  icon: 'success',\r\n"
							+ "  title: 'Gửi mail thành công!'\r\n"
							+ "})");
				} catch (Exception e) {
					t.rollback();
					model.addAttribute("alert", "const Toast = Swal.mixin({\r\n"
							+ "  toast: true,\r\n"
							+ "  position: 'top-end',\r\n"
							+ "  showConfirmButton: false,\r\n"
							+ "  timer: 3000,\r\n"
							+ "  timerProgressBar: true,\r\n"
							+ "  didOpen: (toast) => {\r\n"
							+ "    toast.addEventListener('mouseenter', Swal.stopTimer)\r\n"
							+ "    toast.addEventListener('mouseleave', Swal.resumeTimer)\r\n"
							+ "  }\r\n"
							+ "})\r\n"
							+ "\r\n"
							+ "Toast.fire({\r\n"
							+ "  icon: 'error',\r\n"
							+ "  title: 'Gửi mail thất bại!'\r\n"
							+ "})");
				} finally {
					session.close();
				}
				// truy van lay danh sach tat ca mail
				String hql = "FROM Mail";
				Query query = s.createQuery(hql);
				List<Category> mailList = query.list();
				model.addAttribute("mails", mailList);
			}catch(Exception e) {
				
			}
			return "admin/mails";
		}
		return "redirect:/admin/login.htm";
		
	}
	
}
