package idv.hotel.finalproject.controller;



import java.util.Base64;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import idv.hotel.finalproject.model.UserVerifyBean;
import idv.hotel.finalproject.service.EmailSenderService;
import idv.hotel.finalproject.service.UserVerifyService;
@Controller
public class EmailController {
	private final EmailSenderService emailSenderService;
	private UserVerifyService userVerifyService;
	@Autowired
	public EmailController(EmailSenderService emailSenderService, UserVerifyService userVerifyService) {
		super();
		this.emailSenderService = emailSenderService;
		this.userVerifyService = userVerifyService;
	}



	@ModelAttribute("UserVerifyBean")
	public UserVerifyBean init() {
		UserVerifyBean ub = new UserVerifyBean();
		return ub; 
	}
	
	
	
	
    




	@PostMapping(value={"/public/send-email","/admin/send-email"})
    @ResponseBody
    public String sendEmail(@ModelAttribute UserVerifyBean ub,@RequestParam String email,HttpServletRequest request) {
    	try {
    		if(userVerifyService.findByEmail(email,true)!=null) {
    			return "此email已經過驗證";
    		}
    		else {
    			// 生成驗證連結
    			if(userVerifyService.findByEmail(email,false)!=null) {
    				ub = userVerifyService.findByEmail(email,false);
    			}
    			String verificationToken = generateVerificationToken(email);
    			String verificationLink = "http://localhost:8080"+request.getContextPath()+"/public/verifyEmail?userEmail="+email+"&token=" + verificationToken;
    			// 發送帶有驗證連結的電子郵件
    			ub.setEmail(email);
    			ub.setToken(verificationToken);
    			ub.setIsVerified(false);
    			ub.setUsed(false);
    			userVerifyService.saveUserVerifyBean(ub);
    			emailSenderService.sendEmail(email, "請點擊此連結進行驗證", verificationLink);
    			return "已成功寄送,請點擊連結進行email驗證";
    			
    		}
		} catch (Exception e) {
		// 處理發送電子郵件時出現的錯誤
		return "寄送電子郵件驗證信失敗,請檢查您的網路連線,如有問題,請洽管理員";
		}
    }
    
    private String generateVerificationToken(String userEmail) {
        String uuid = UUID.randomUUID().toString();
        String verificationToken = Base64.getEncoder().encodeToString((userEmail + ":" + uuid).getBytes());
        return verificationToken;
    }
    
    
    
    
    
    @GetMapping("/public/verifyEmail")
    @ResponseBody
    public String verifyEmail(@ModelAttribute UserVerifyBean ub,@RequestParam String token,@RequestParam String userEmail) {
    	if(userVerifyService.findByEmailAndToken(userEmail, token)!=null)
    		ub = userVerifyService.findByEmailAndToken(userEmail, token);
    		ub.setIsVerified(true);
    		userVerifyService.saveUserVerifyBean(ub);
        return "已收到您的驗證,請填寫完表單後即可進行註冊";
    }

    @GetMapping("/public/checkEmail")
    @ResponseBody
    public String checkEmail(@RequestParam String email,@ModelAttribute UserVerifyBean ub) {
    	if(userVerifyService.findByEmail(email,false)!=null) {
    		ub = userVerifyService.findByEmail(email,false);
    		if(ub.getIsVerified().equals(true)) {
	    		ub.setUsed(true);
	    		userVerifyService.saveUserVerifyBean(ub);
	    		return "驗證成功";
    		}
    		else {
    			return "您尚未進行驗證";
    		}
    	}
    	else if(userVerifyService.findByEmail(email,true)!=null){
    		return "驗證成功";
    	}
        else 
            return "您尚未進行驗證";
        
    }
    
    
    
}
