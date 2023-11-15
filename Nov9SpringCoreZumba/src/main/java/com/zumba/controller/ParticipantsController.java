package com.zumba.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
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

import com.gms.DAO.BatchDAO;
import com.gms.DAO.ParticipantsDAO;
import com.gms.model.Batch;
import com.gms.model.Participants;

@Controller
public class ParticipantsController {
	
	//DONE
    @RequestMapping("/registeredBtc")
    public ModelAndView RegisteredBatches(HttpServletRequest request, HttpServletResponse response) 
    		throws ClassNotFoundException, SQLException, IOException, ServletException {
    	ApplicationContext ac = new ClassPathXmlApplicationContext("zumba.xml");
    	ModelAndView mv = new ModelAndView();
        BatchDAO bdao = ac.getBean(BatchDAO.class);
        ParticipantsDAO pdao = ac.getBean(ParticipantsDAO.class);
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        List<Integer> bids = new ArrayList<>();
        List<Integer> pids = new ArrayList<>();
        List<Participants> plist = pdao.BatchParticipants(username);
        List<Batch> blist = new ArrayList<>();
        for (Participants p : plist){
        	int bid = p.getBid();
        	int pid = p.getPid();
        	bids.add(bid);
        	pids.add(pid);
        	blist.add(bdao.displayBatch(bid));
        }	
        System.out.println("[C] Registered Batches listed...!");
        mv.addObject("batchlist", blist);
        mv.setViewName("registeredBtc.jsp");      
        return mv;
    }	
    	
	//DONE
    @RequestMapping("/listParticipant")
    public ModelAndView ListParticipants(HttpServletRequest request, HttpServletResponse response) 
    		throws ClassNotFoundException, SQLException, IOException, ServletException {
    	ApplicationContext ac = new ClassPathXmlApplicationContext("zumba.xml");
    	ModelAndView mv = new ModelAndView();
    	ParticipantsDAO pdao = ac.getBean(ParticipantsDAO.class);
        List<Participants> listParticipant = pdao.displayParticipants();
        if (listParticipant != null) {
            System.out.println("[C] All Participants listed...!");
            mv.addObject("listparticipant", listParticipant);
            mv.setViewName("indexPrt.jsp");
        } else {
            System.out.println("[C] Display Participants failed...!");
            mv.addObject("error", "Error occurred while listing Participants...!");
            mv.setViewName("error.jsp");
        }
        return mv;
    }	

	//DONE
	@RequestMapping("/deleteParticipant")
	public ModelAndView DeleteParticipant(HttpServletRequest request,HttpServletResponse response) 
			throws ClassNotFoundException, SQLException, IOException, ServletException {
		ApplicationContext ac = new ClassPathXmlApplicationContext("zumba.xml");
		ModelAndView mv = new ModelAndView();
		ParticipantsDAO pdao = ac.getBean(ParticipantsDAO.class);
		int pid = Integer.parseInt(request.getParameter("pid"));
	    if (pdao.deleteParticipant(pid) > 0) {
	        System.out.println("[C] Participant deleted...!");
	        mv.addObject("success", "Participant Deleted Successfully..!");
		    mv.setViewName("success.jsp");
		} else {
		    System.out.println("[C] Participant delete failed...!");
		    mv.addObject("error", "<p>Error occured while deleting Participant...!</p>");
		    mv.setViewName("error.jsp");
		    }
	    return mv;
	}
	
	//DONE
	@RequestMapping("/unregisterParticipant")
	public ModelAndView UnregisterParticipant(HttpServletRequest request,HttpServletResponse response) 
			throws ClassNotFoundException, SQLException, IOException, ServletException {
		ApplicationContext ac = new ClassPathXmlApplicationContext("zumba.xml");
		ModelAndView mv = new ModelAndView();
		ParticipantsDAO pdao = ac.getBean(ParticipantsDAO.class);
		int pid = Integer.parseInt(request.getParameter("bid"));
		String username = request.getParameter("username");
	    if (pdao.unregisterParticipant(username, pid) > 0) {
	        System.out.println("[C] Participant Unregistered...!");
	        mv.addObject("success", "Participant Unregistered Successfully..!");
		    mv.setViewName("success.jsp");
		} else {
		    System.out.println("[C] Participant Unregister failed...!");
		    mv.addObject("error", "<p>Error occured while Unregister Participant...!</p>");
		    mv.setViewName("error.jsp");
		    }
	    return mv;
	}

	//DONE
	@RequestMapping("/editParticipant")
	public ModelAndView EditParticipant(HttpServletRequest request,HttpServletResponse response) 
			throws ClassNotFoundException, SQLException, IOException, ServletException {
		ApplicationContext ac = new ClassPathXmlApplicationContext("zumba.xml");
		ModelAndView mv = new ModelAndView();
		ParticipantsDAO pdao = ac.getBean(ParticipantsDAO.class);
		Participants participant = ac.getBean(Participants.class);
		
		String pname = request.getParameter("pname");
		int age = Integer.parseInt(request.getParameter("age"));
		String gender = request.getParameter("gender");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		int bid = Integer.parseInt(request.getParameter("bid"));
		int pid = Integer.parseInt(request.getParameter("pid"));	
		participant.setPname(pname);
		participant.setAge(age);
		participant.setGender(gender);
		participant.setPhone(phone);
		participant.setEmail(email);
		participant.setBid(bid);
		participant.setPid(pid);		
		try {
			int result = pdao.updateParticipant(participant);
			if (result > 0) {
				System.out.println("[C] Participant Edited...!");
		        mv.addObject("success", "Participant Edited Successfully..!");
			    mv.setViewName("success.jsp");
			} else {
				System.out.println("[C] Participant Edit failed...!");
			    mv.addObject("error", "<p>Error occured while Editing Participant...!</p>");
			    mv.setViewName("error.jsp");
				}
			} catch (ClassNotFoundException | SQLException e) {
				e.printStackTrace();
				System.out.println("[C] Participant Edit failed...!");
			    mv.addObject("error", "<p>Error occured while Editing Participant...!</p>");
			    mv.setViewName("error.jsp");
			}
		return mv;
		}
}
