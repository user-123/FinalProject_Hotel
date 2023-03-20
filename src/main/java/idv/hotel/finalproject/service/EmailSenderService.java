package idv.hotel.finalproject.service;

import javax.mail.MessagingException;

public interface EmailSenderService {
	void sendEmail(String to, String subject,String verificationLink) throws MessagingException;
	
}