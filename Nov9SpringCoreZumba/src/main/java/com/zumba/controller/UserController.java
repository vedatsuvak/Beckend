package com.zumba.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


import com.gms.DAO.UsersDAO;
import com.gms.model.User;


@Controller
public class UserController {

	//DONE
	@RequestMapping("/login")
	public ModelAndView Login(HttpServletRequest request,HttpServletResponse response) 
			throws ClassNotFoundException, SQLException, IOException {
		ApplicationContext ac = new ClassPathXmlApplicationContext("zumba.xml");
		ModelAndView mv = new ModelAndView();
		User user = ac.getBean(User.class);
		UsersDAO udao = ac.getBean(UsersDAO.class);
		String username = request.getParameter("user");
		String password = request.getParameter("pwd");
		user = udao.login(username, password);
		System.out.println(user);
		String email = user.getEmail();
		if(email != null) {
			HttpSession session = request.getSession();
	        session.setAttribute("username", username);
	        System.out.println("[C] Logged in!");
			mv.setViewName("/profile");
		}else {
			System.out.println("[C] Login failed!");
			mv.addObject("error", "Invalid username or password..!");
            mv.setViewName("error.jsp");
		}
		return mv;
	}
	
	//DONE
	@RequestMapping("/logout")
	public ModelAndView Logout(HttpServletRequest request,HttpServletResponse response) 
			throws ClassNotFoundException, SQLException, IOException, ServletException {
		HttpSession session=request.getSession();
		session.invalidate();
		ModelAndView mv = new ModelAndView();
		System.out.println("[C] Logged out...!");
		mv.addObject("success", "Logged out..!");
        mv.setViewName("success.jsp");
		return mv;
	}
	
	//DONE
	@RequestMapping("/register")
	public ModelAndView Register(HttpServletRequest request, HttpServletResponse response) 
			throws ClassNotFoundException, SQLException {
	    ApplicationContext ac = new ClassPathXmlApplicationContext("zumba.xml");
	    String username = request.getParameter("user");
	    String password = request.getParameter("pwd");
	    String confirmPassword = request.getParameter("confirmPwd");
	    String email = request.getParameter("email");
	    ModelAndView mv = new ModelAndView();
	    User user = ac.getBean(User.class);
	    UsersDAO udao = ac.getBean(UsersDAO.class);
	    if (username == null || password == null || confirmPassword == null 
	    		|| email == null || !password.equals(confirmPassword)) {
	    	System.out.println("[C] Register failed...!");
	    	mv.addObject("error", "One or more field is missing or password does not match...!");
	        mv.setViewName("error.jsp");
	        return mv;
	    } else {
	        user = udao.login(username, password);
	        String oldusername = user.getUsername();
	        if (oldusername != null && oldusername.equals(username)) {
	        	System.out.println("[C] Register found in DB...!");
	            mv.addObject("error", "User already Registered..!");
	            mv.setViewName("error.jsp");
	            return mv;
	        }if (udao.insertUser(username, password, email) > 0) {
	        	System.out.println("[C] Registered successfully...!");
	            mv.addObject("success", "User Registered Successfully..!");
	            mv.setViewName("success.jsp");
	            return mv;
	        }
	    }
	    return mv;
	}

	//DONE
	@RequestMapping("/profile")
	public ModelAndView Profile(HttpServletRequest request,HttpServletResponse response) 
			throws ClassNotFoundException, SQLException, IOException, ServletException {
		ApplicationContext ac = new ClassPathXmlApplicationContext("zumba.xml");
		ModelAndView mv = new ModelAndView();
		User user = ac.getBean(User.class);
		UsersDAO udao = ac.getBean(UsersDAO.class);
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");
        user = udao.displayUser(username);
        if (user != null) {
        	System.out.println("[C] User profile viewed...!");
	        mv.setViewName("profile.jsp");
	        mv.addObject("user", user);
	    } else {
	    	System.out.println("[C] User profile failed...!");
	        mv.setViewName("Main.jsp");
	    }
	    return mv;
	}
	
	//DONE
	@RequestMapping("/editUser")
	public ModelAndView EditUser(HttpServletRequest request,HttpServletResponse response) 
			throws ClassNotFoundException, SQLException, IOException, ServletException {
		ApplicationContext ac = new ClassPathXmlApplicationContext("zumba.xml");
		ModelAndView mv = new ModelAndView();
		UsersDAO udao = ac.getBean(UsersDAO.class);
		HttpSession session = request.getSession();
		String holder = (String) session.getAttribute("username");
		String oldUserName = request.getParameter("userName");
		String newUsername = request.getParameter("newUsername");
	    String newPassword = request.getParameter("newPassword");
	    String confirmPassword = request.getParameter("confirmPassword");
	    String newEmail = request.getParameter("newEmail");
	    if(newUsername == null || newPassword == null || confirmPassword == null 
	    		|| newEmail == null || !newPassword.equals(confirmPassword)) {
	    	System.out.println("[C] Edit failed...!");
	    	mv.addObject("error", "One or more field is missing or password does not match...!");
	        mv.setViewName("error.jsp");
	        return mv;
	    }if(udao.editUser(oldUserName, newUsername, newPassword, newEmail) > 0){
	    	System.out.println("[C] User edited...!");
	    	if (!holder.equalsIgnoreCase("admin")) {
	    		session.setAttribute("username", newUsername);
	    	}
	    	mv.addObject("success", "User Edited Successfully..!");
            mv.setViewName("success.jsp");
            return mv;
	    	}else{
	    		System.out.println("[C] Edit failed...!");
	    	};
		return mv;
	}
	
	//DONE
	@RequestMapping("/allUsers")
	public ModelAndView AllUsers(HttpServletRequest request,HttpServletResponse response) 
			throws ClassNotFoundException, SQLException, IOException, ServletException {
		ApplicationContext ac = new ClassPathXmlApplicationContext("zumba.xml");
		ModelAndView mv = new ModelAndView();
		UsersDAO udao = ac.getBean(UsersDAO.class);
		List <User> userlist = udao.displayUsers();
        if(userlist != null) {
        	System.out.println("[C] All Users displayed...!");
	        mv.addObject("userlist", userlist);
        	mv.setViewName("allUsers.jsp");
	    }else {
	    	System.out.println("[C] Display users failed...!");
	    	mv.addObject("error", "Error occured while displaying Users...!");
	        mv.setViewName("error.jsp");
	    }
	    return mv;
	}
	
	//DONE
	@RequestMapping("/deleteUser")
	public ModelAndView DeleteUser(HttpServletRequest request,HttpServletResponse response) 
			throws ClassNotFoundException, SQLException, IOException, ServletException {
		ApplicationContext ac = new ClassPathXmlApplicationContext("zumba.xml");
		ModelAndView mv = new ModelAndView();
		UsersDAO udao = ac.getBean(UsersDAO.class);
		HttpSession session = request.getSession();
		String username = (String) request.getParameter("username");
		String holder = (String) session.getAttribute("username");
		if (!username.equalsIgnoreCase("admin")) {
	        if (udao.deleteUser(username) > 0) {
	        	System.out.println("[C] User deleted...!");
	        	if(!holder.equalsIgnoreCase("admin")) {
	        		session.invalidate();
	        	}
	        	mv.addObject("success", "User Deleted Successfully..!");
		        mv.setViewName("success.jsp");
		    } else {
		    	System.out.println("[C] User delete failed...!");
		    	mv.addObject("error", "Error occured while deleting user...!");
		        mv.setViewName("error.jsp");
		    }
		}else {
			System.out.println("[C] User delete failed...!");
	    	mv.addObject("error", "You can not delete admin...!");
	        mv.setViewName("error.jsp");
		}
	    return mv;
	}
}
