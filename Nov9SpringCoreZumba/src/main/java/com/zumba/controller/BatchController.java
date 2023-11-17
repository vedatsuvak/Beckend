
package com.zumba.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.gms.DAO.BatchDAO;
import com.gms.DAO.ParticipantsDAO;
import com.gms.DAO.UsersDAO;
import com.gms.model.Batch;
import com.gms.model.Participants;
import com.gms.model.User;

@Controller
public class BatchController {

	//DONE
    @RequestMapping("/batches")
    public ModelAndView Batches(HttpServletRequest request, HttpServletResponse response) 
    		throws ClassNotFoundException, SQLException, IOException, ServletException {
    	ApplicationContext ac = new ClassPathXmlApplicationContext("zumba.xml");
    	ModelAndView mv = new ModelAndView();
        BatchDAO bdao = ac.getBean(BatchDAO.class);
        List<Batch> batchlist = bdao.displayBatches();
        if (batchlist != null) {
            System.out.println("[C] All Batches listed...!");
            mv.addObject("batchlist", batchlist);
            mv.setViewName("indexBtc.jsp");
        } else {
            System.out.println("[C] Display batches failed...!");
            mv.addObject("error", "Error occurred while listing Batches...!");
            mv.setViewName("error.jsp");
        }
        return mv;
    }

    //DONE
    @RequestMapping("/addBatch")
    public ModelAndView AddBatch(HttpServletRequest request, HttpServletResponse response) 
    		throws ClassNotFoundException, SQLException, IOException, ServletException {
    	ApplicationContext ac = new ClassPathXmlApplicationContext("zumba.xml");
    	ModelAndView mv = new ModelAndView();
        BatchDAO bdao = ac.getBean(BatchDAO.class);
        Batch batch = ac.getBean(Batch.class);
        batch.setBname(request.getParameter("bname").toUpperCase());
        batch.setInstructor(request.getParameter("instructor"));
        batch.setStartDate(request.getParameter("startDate"));
        batch.setStartTime(request.getParameter("startTime"));
        int result = 0;
        result = bdao.insertBatch(batch);
        if (result > 0) {
            System.out.println("[C] Batch added...!");
            mv.addObject("success", "Batch added Successfully..!");
            mv.setViewName("success.jsp");
        } else {
            System.out.println("[C] Display batches failed...!");
            mv.addObject("error", "Error occurred while adding Batch...!");
            mv.setViewName("error.jsp");
        }
        return mv;
    }
    
	//DONE
	@RequestMapping("/editBatch")
	public ModelAndView EditBatch(HttpServletRequest request,HttpServletResponse response) 
			throws ClassNotFoundException, SQLException, IOException, ServletException {
		ApplicationContext ac = new ClassPathXmlApplicationContext("zumba.xml");
		ModelAndView mv = new ModelAndView();
		BatchDAO bdao = ac.getBean(BatchDAO.class);
		Batch batch = ac.getBean(Batch.class);
		batch.setBid(Integer.parseInt(request.getParameter("bid")));
		batch.setBname(request.getParameter("bname"));
		batch.setInstructor(request.getParameter("instructor"));
		batch.setStartDate(request.getParameter("startDate"));
		batch.setStartTime(request.getParameter("startTime"));
		if(bdao.editBatch(batch) > 0){
		    System.out.println("[C] Batch edited...!");
		    mv.addObject("success", "Batch Edited Successfully..!");
	        mv.setViewName("success.jsp");
	        return mv;
		    }else{
		    	System.out.println("[C] Batch edit failed...!");
		    };
		return mv;
		}
    
	//DONE
	@RequestMapping("/deleteBatch")
	public ModelAndView DeleteBatch(HttpServletRequest request,HttpServletResponse response) 
			throws ClassNotFoundException, SQLException, IOException, ServletException {
		ApplicationContext ac = new ClassPathXmlApplicationContext("zumba.xml");
		ModelAndView mv = new ModelAndView();
		BatchDAO bdao = ac.getBean(BatchDAO.class);
		int batchId = Integer.parseInt(request.getParameter("bid"));
	    if (bdao.deleteBatch(batchId) > 0) {
	        System.out.println("[C] Batch deleted...!");
	        mv.addObject("success", "Batch Deleted Successfully..!");
		    mv.setViewName("success.jsp");
		} else {
		    System.out.println("[C] Batch delete failed...!");
		    mv.addObject("error", "<p>Error occured while deleting Batch...!</p>"
		    		+ "<p>Batch has registered Participant or Participants</p>"
		    		+ "<p>You need to delete Participants first</p>");
		    mv.setViewName("error.jsp");
		    }
	    return mv;
	}
	
	//DONE
    @RequestMapping("/showParticipants")
    public ModelAndView ShowParticipants(HttpServletRequest request, HttpServletResponse response) 
    		throws ClassNotFoundException, SQLException, IOException, ServletException {
    	ApplicationContext ac = new ClassPathXmlApplicationContext("zumba.xml");
    	ModelAndView mv = new ModelAndView();
        ParticipantsDAO pdao = ac.getBean(ParticipantsDAO.class);
        int bid = Integer.parseInt(request.getParameter("bid"));
        List<Participants> participantslist = pdao.BatchParticipants(bid);
        if (participantslist != null) {
            System.out.println("[C] Batch: "+ bid +"'s Participants listed...!");
            mv.addObject("bid", bid);
            mv.addObject("participantslist", participantslist);
            mv.setViewName("showParticipants.jsp");
        } else {
            System.out.println("[C] Display participants of batch failed...!");
            mv.addObject("error", "Error occurred while listing participants...!");
            mv.setViewName("error.jsp");
        }
        return mv;
    }

    //DONE
    @RequestMapping("/addParticipant")
    public ModelAndView AddParticipant(HttpServletRequest request, HttpServletResponse response) 
    		throws ClassNotFoundException, SQLException, IOException, ServletException {
    	ApplicationContext ac = new ClassPathXmlApplicationContext("zumba.xml");
    	ModelAndView mv = new ModelAndView();
    	ParticipantsDAO pdao = ac.getBean(ParticipantsDAO.class);
    	UsersDAO udao = ac.getBean(UsersDAO.class);
    	Participants participant = ac.getBean(Participants.class);
    	String pname = request.getParameter("name");
    	User user = udao.displayUser(pname);
    	
        if (user != null) {
            String email = user.getEmail();
            int age = Integer.parseInt(request.getParameter("age"));
            String gender = request.getParameter("gender");
            String phone = request.getParameter("phone");
            int bid = Integer.parseInt(request.getParameter("bid"));
            Participants result = null;
            participant.setPname(pname);
            participant.setAge(age);
            participant.setGender(gender);
            participant.setPhone(phone);
            participant.setEmail(email);
            participant.setBid(bid);
            //Check the participants if already added
            result = pdao.getParticipant(pname, bid);
            if(result.getPname() != null) {
            	System.out.println("[C] Adding Participant failed...!");
                mv.addObject("error", "Participant already registered to this batch...!");
                mv.setViewName("error.jsp");
            //If not added then
            }else {
            	int add = pdao.insertParticipant(participant);	
                if (add > 0) {
                	System.out.println("[C] Participant added...!");
                    mv.addObject("success", "Participant added Successfully..!");
                    mv.setViewName("success.jsp");
                    } else {
                    // Display an error message
                	System.out.println("[C] Adding Participant failed...!");
                    mv.addObject("error", "Error occurred while adding Participant...!");
                    mv.setViewName("error.jsp");
                }
            }
        }else {
            // Display an error message
        	System.out.println("[C] Adding Participant failed...!");
            mv.addObject("error", "User not found...!");
            mv.setViewName("error.jsp");
        }
		return mv;
    }
    
    //DONE
    @RequestMapping("/startBtc")
    public ModelAndView StartBatch(HttpServletRequest request, HttpServletResponse response) 
    		throws ClassNotFoundException, SQLException, IOException, ServletException {
    	ApplicationContext ac = new ClassPathXmlApplicationContext("zumba.xml");
    	ModelAndView mv = new ModelAndView();
    	BatchDAO bdao = ac.getBean(BatchDAO.class);
    	int result = 0;
    	int bid = 0;
    	try {
    		bid = Integer.parseInt(request.getParameter("bid"));
    		result = bdao.startBatch(bid);
    		if(result >0){
    			System.out.println("[C] Batch started...!");
                mv.addObject("success", "<p>Batch started Successfully..!</p>"
                		+ "<p>SMS Sent to All Participants..!</p>"
                		+ "<p>EMAIL Sent to All Participants..!<p/>");
                mv.setViewName("success.jsp");    			
    		}else {
    			System.out.println("[C] Starting Batch failed...!");
                mv.addObject("error", "<p>Starting Batch failed...!</p>"
                		+ "<p>There is no Participant in the Batch</p>");
                mv.setViewName("error.jsp");
    		}
    	} catch (ClassNotFoundException | SQLException e) {
    		System.out.println("[C] Starting Batch failed...!");
            mv.addObject("error", "Starting Batch failed...!");
            mv.setViewName("error.jsp");
    	}
		return mv;
    }
}