package idv.hotel.finalproject.validate;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import idv.hotel.finalproject.model.LoginBean;

public class LoginValidator implements Validator {
	//private static final Pattern EMAIL_REGEX = Pattern.compile("^[\\w\\d._-]+@[\\w\\d.-]+\\.[\\w\\d]{2,6}$");  
	@Override
	public boolean supports(Class<?> clazz) {
		return LoginBean.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "accountName", "loginBean.name.empty");
		ValidationUtils.rejectIfEmpty(errors, "password", "loginBean.password.empty");
//		ValidationUtils.rejectIfEmpty(errors, "password1", "customerBean.password1.empty");
		ValidationUtils.rejectIfEmpty(errors, "email", "loginBean.email.empty");
		LoginBean login = (LoginBean) target;

		
		if (login.getAccountName() != null && login.getAccountName().length() < 2 || login.getAccountName().length() > 10) {
			errors.rejectValue("accountName", "loginBean.name.size");
		}

//		if (login.getPassword() != null && login.getPassword().contains(" ")) {
//			errors.rejectValue("password", "loginBean.password.space");
//		}

//		if (login.getPassword1() != null && login.getPassword1().contains(" ")) {
//			errors.rejectValue("password1", "loginBean.password1.space");
//		}
		
//		if (login.getPassword1() != null && login.getPassword1().length() < 5 && login.getPassword1().length() > 15) {
//			errors.rejectValue("password1", "loginBean.password1.size");
//		}
		
//		if (login.getPassword1() != null && login.getPassword() != null &&
//			!login.getPassword1().equals(login.getPassword())
//		) {
//			errors.rejectValue("password", "loginBean.password.mustEqual");
//		}
		
//		if ( !errors.hasFieldErrors("email") && login.getEmail() != null 
//						&& !EMAIL_REGEX.matcher(login.getEmail()).matches()) {
//			errors.rejectValue("email", "loginBean.email.invalid");
//		}
	}

}
