package idv.hotel.finalproject.service.impl;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import idv.hotel.finalproject.service.EmailSenderService;

@Service
public class EmailSenderServiceImpl implements EmailSenderService {

    private final JavaMailSender mailSender;
    @Autowired
    public EmailSenderServiceImpl(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }
    
    
    
    
    
    @Override
    public void sendEmail(String to, String subject,String verificationLink) throws MessagingException {
   	 	MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true);

        helper.setFrom("springbootemailsender8@gmail.com");
        helper.setTo(to);
        helper.setSubject("驗證連結");
        helper.setText("<html><body><p>請點擊此連結進行email驗證:</p><a href=\"" + verificationLink + "\">" + verificationLink + "</a></body></html>", true);

        mailSender.send(message);
   }

	

	
    
 
    
}

