package idv.hotel.finalproject.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import idv.hotel.finalproject.service.EmailSenderService;
@Controller
public class EmailController {
	private final EmailSenderService emailSenderService;

    public EmailController(EmailSenderService emailSenderService) {
        this.emailSenderService = emailSenderService;
    }

    @PostMapping(value={"/public/send-email","/admin/send-email"})
    @ResponseBody
    public String sendEmail(@RequestParam String email) {
            this.emailSenderService.sendEmail(email, "歡迎光臨", "歡迎您");
            return "已寄送";
    }
    
    
}
