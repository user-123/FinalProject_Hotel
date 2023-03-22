package idv.hotel.finalproject.service.impl;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import idv.hotel.finalproject.dao.LoginDao;
import idv.hotel.finalproject.dao.MemberDao;
import idv.hotel.finalproject.model.MemberBean;
import idv.hotel.finalproject.service.MemberService;


@Transactional
@Service
public class MemberServiceImpl implements MemberService {
	
	MemberDao memberDao;
	LoginDao loginDao;
	
	
	@Autowired
	public MemberServiceImpl(MemberDao memberDao,LoginDao loginDao) {
		this.memberDao = memberDao;
		this.loginDao = loginDao;
	}

//	@Override
//	public String checkEmailDuplicate(String email) {
//		try{
//			memberDao.findByEmail(email).getEmail();
//			return "此帳號已被註冊,請更換";
//		}catch(Exception e) {
//			return "";
//		}
//	}
	
	@Override
	public String addinfo(MemberBean mb,HttpSession session,HttpServletRequest request, HttpServletResponse response,@RequestParam("uploadedFile") MultipartFile uploadedFile) throws IOException, ServletException{
		//String filetime = loginDao.findById((Integer)session.getAttribute("id")).get().getSignupDate().toString();
		MemberBean mbnew = memberDao.findByAccountId(loginDao.findById((Integer)session.getAttribute("id")).get());
		if(mbnew!=null)
			mb.setMemberId(mbnew.getMemberId());
		String fileemail = loginDao.findById((Integer)session.getAttribute("id")).get().getEmail();
		String filenamesql;
		Part part = request.getPart("uploadedFile");
		if(uploadedFile.isEmpty()) {	
			if(loginDao.findById((Integer)session.getAttribute("id")).get().getMember()==null)
				filenamesql="";
			else 
				filenamesql=loginDao.findById((Integer)session.getAttribute("id")).get().getMember().getPhotoPath();
		}
		else 
			filenamesql=fileemail+part.getSubmittedFileName();
		mb.setPhotoPath(filenamesql);
		mb.setAccountId(loginDao.findById((Integer)session.getAttribute("id")).get());
		
		
		
		memberDao.save(mb);
		String photo="";
		if(part == null  || part.getSize() == 0 ) {
			photo = String.format("<div><img src='%s' width='375' class='m-1 border rounded' /></div>",
        			"/main/images/default2.jpg");	
			
		}
		else {
		String uploadDir = "/uploadDir";
		String uploadDirRealPath = request.getServletContext().getRealPath(uploadDir);
	        File _uploadDir = new File( uploadDirRealPath );	        
	        if(!_uploadDir.isDirectory())
	        	_uploadDir.mkdirs();	
				
//			try {
        	Path outputPath = Paths.get(uploadDirRealPath, filenamesql);
			
        	//Files.copy(part.getInputStream(), outputPath,StandardCopyOption.REPLACE_EXISTING); 	        	
        	Files.write(outputPath, uploadedFile.getBytes());	        	
        	photo = String.format("<div><img src='%s/%s' width='375' class='m-1 border rounded' /></div>", 
	        		 request.getContextPath()+uploadDir, filenamesql);
//			}catch(IOException ex) {
//				photo = String.format("<div><img src='%s' width='80' class='m-1 border rounded' /></div>",
//	        			"/main/images/default2.jpg");	
//			}
		}
	    return photo;     
		
	}	
	
	@Override
	public String showPhoto(HttpSession session,HttpServletRequest request) {
		MemberBean mb = memberDao.findByAccountId(loginDao.findById((Integer)session.getAttribute("id")).get());
		String photo;
		if(mb.getPhotoPath().equals("")) 
			photo = String.format("<div><img src='%s' width='375' class='m-1 border rounded' /></div>",
        			"/main/images/default2.jpg");	
		else {
		photo = String.format("<div><img src='%s/%s' width='375' class='m-1 border rounded' /></div>", 
       		 request.getContextPath()+"/uploadDir", mb.getPhotoPath());
		}
		return photo;
	}
	
	
	@Override
	public MemberBean showInfo(HttpSession session,HttpServletRequest request) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		session.setAttribute("id", loginDao.findIdByEmail(auth.getName()));
		return memberDao.findByAccountId(loginDao.findById((Integer)session.getAttribute("id")).get());
	}
	
	@Override
	public void deleteMb(Integer deleteId) {
		memberDao.deleteById(deleteId);
	};
	
}
