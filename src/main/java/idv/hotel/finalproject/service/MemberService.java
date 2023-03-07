package idv.hotel.finalproject.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import idv.hotel.finalproject.model.MemberBean;

public interface MemberService {
	String addinfo(MemberBean mb,HttpSession session,HttpServletRequest request, HttpServletResponse response ,@RequestParam("uploadedFile") MultipartFile uploadedFile)  throws IOException, ServletException;
	String showPhoto(HttpSession session,HttpServletRequest request);
	MemberBean showInfo(HttpSession session,HttpServletRequest request);
	void deleteMb(Integer deleteId);
}
