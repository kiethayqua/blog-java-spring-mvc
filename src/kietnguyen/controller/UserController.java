package kietnguyen.controller;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kietnguyen.entity.Category;
import kietnguyen.entity.Mail;
import kietnguyen.entity.Post;

@Controller
@Transactional
public class UserController {
	@Autowired
	SessionFactory factory;

	@RequestMapping("/index")
	public String index(ModelMap model) {
		Session session = factory.getCurrentSession();
		// truy van lay so luong Category
		String catHql = "FROM Category";
		Query query = session.createQuery(catHql);
		List<Category> catList = query.list();
		model.addAttribute("categories", catList);
			
		// truy van lay 3 bai viet gan nhat hien thi vao slide
		String slidePostHql = "FROM Post ORDER BY update_time DESC";
		query = session.createQuery(slidePostHql);
		query.setMaxResults(3);
		List<Post> postListSlide = query.list();
		model.addAttribute("slide_posts", postListSlide);

		// truy van lay 5 bai viet gan nhat hien thi vao today's highlight
		String todayPostHql = "FROM Post ORDER BY update_time DESC";
		query = session.createQuery(todayPostHql);
		query.setMaxResults(5);
		List<Post> todayPostList = query.list();
		model.addAttribute("today_posts", todayPostList);

		// truy van cac bai viet theo the loai (3 the loai de them vao layout) 
		String categoryPostsHql = "FROM Category ORDER BY id ASC";
		query = session.createQuery(categoryPostsHql);
		query.setMaxResults(3);
		List<Category> categoryPostsList = query.list();
		model.addAttribute("category_posts", categoryPostsList);
		
		return "user/home";
	}

	@RequestMapping("/post/{id}")
	public String post(ModelMap model, @PathVariable("id") int id) {
		Session session = factory.getCurrentSession();
		// truy van lay so luong Category
		String catHql = "FROM Category";
		Query query = session.createQuery(catHql);
		List<Category> catList = query.list();
		model.addAttribute("categories", catList);

		// lay post tu id
		Post post = (Post) session.get(Post.class, id);
		model.addAttribute("post", post);

		// truy van lay 4 bai viet gan nhat hien thi vao slide
		String relatedPostHql = "FROM Post ORDER BY update_time DESC";
		query = session.createQuery(relatedPostHql);
		query.setMaxResults(4);
		List<Post> postList = query.list();
		model.addAttribute("related_posts", postList);
		return "user/inner-page";
	}

	@RequestMapping(value = "/contact", method = RequestMethod.GET)
	public String contact(ModelMap model) {
		Session session = factory.getCurrentSession();
		// truy van lay so luong Category
		String catHql = "FROM Category";
		Query query = session.createQuery(catHql);
		List<Category> catList = query.list();
		model.addAttribute("categories", catList);
		return "user/contact";
	}
	
	@RequestMapping(value = "/contact", method = RequestMethod.POST)
	public String contact(ModelMap model, @RequestParam("firstname") String firstName, @RequestParam("lastname") String lastName, @RequestParam("email") String email, @RequestParam("mess") String mess) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		
		Mail sendMail = new Mail();
		sendMail.setFirstname(firstName);
		sendMail.setLastname(lastName);
		sendMail.setEmail(email);
		sendMail.setMess(mess);
		
		try {
			session.save(sendMail);
			t.commit();
		} catch (Exception e) {
			t.rollback();
		} finally {
			session.close();
		}
		return "redirect: /DoAnCuoiKy/contact.htm";
	}
	
	@RequestMapping(value= "/subcribe", method = RequestMethod.POST)
	public String subscribe(ModelMap model, @RequestParam("email") String email) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		
		Mail sendMail = new Mail();
		sendMail.setEmail(email);
		
		try {
			session.save(sendMail);
			t.commit();
		} catch (Exception e) {
			t.rollback();
		} finally {
			session.close();
		}
		return "redirect: /DoAnCuoiKy/index.htm";
	}

	@RequestMapping(value = "/category/{id}", method = RequestMethod.GET)
	public String category(ModelMap model, @PathVariable int id) {
		Session session = factory.getCurrentSession();
		// truy van lay so luong Category
		String catHql = "FROM Category";
		Query query = session.createQuery(catHql);
		List<Category> catList = query.list();
		model.addAttribute("categories", catList);

		// truy van lay 3 bai viet gan nhat theo the loai hien thi vao slide 
		String slidePostHql = "FROM Post WHERE category.id=" + id +  " ORDER BY update_time DESC";
		query = session.createQuery(slidePostHql);
		query.setMaxResults(3);
		List<Post> postListSlide = query.list();
		model.addAttribute("slide_posts", postListSlide);

		// truy van tat ca bai viet gan nhat theo the loai hien thi vao 
		String catPostHql = "FROM Post WHERE category.id=" + id + " ORDER BY update_time DESC";
		query = session.createQuery(catPostHql);
		List<Post> catPostList = query.list();
		model.addAttribute("cat_posts", catPostList);

		return "user/category";
	}
	
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public String search(ModelMap model, @RequestParam("title") String text) {
		Session session = factory.getCurrentSession();
		// truy van lay bai viet theo tu khoa
		String searchHql = "FROM Post WHERE title LIKE '%" + text + "%'";
		Query query = session.createQuery(searchHql);
		List<Post> searchList = query.list();
		model.addAttribute("search_list", searchList);
		if(searchList.size() > 0) {
			model.addAttribute("search_title", "Bài viết tìm được cho " + "'" + text + "'");
		}else {
			model.addAttribute("search_title", "Không tìm thấy bài viết!");
		}
		
		return "user/search";
	}
}
