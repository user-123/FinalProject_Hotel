package idv.hotel.finalproject.service;

public interface EmailSenderService {
    void sendEmail(String to, String subject, String message);
}