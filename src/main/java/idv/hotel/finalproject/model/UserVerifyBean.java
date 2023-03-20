package idv.hotel.finalproject.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="user_verify")
public class UserVerifyBean implements java.io.Serializable {
	
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer userVerifyId;
	
	private String email;
	
	private String token;

	private Boolean isVerified;

	private Boolean used;
	
	public UserVerifyBean() {
	}


	public UserVerifyBean(Integer userVerifyId, String email, String token, Boolean isVerified, Boolean used) {
		super();
		this.userVerifyId = userVerifyId;
		this.email = email;
		this.token = token;
		this.isVerified = isVerified;
		this.used = used;
	}



	public Integer getUserVerifyId() {
		return userVerifyId;
	}

	public void setUserVerifyId(Integer userVerifyId) {
		this.userVerifyId = userVerifyId;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public Boolean getIsVerified() {
		return isVerified;
	}

	public void setIsVerified(Boolean isVerified) {
		this.isVerified = isVerified;
	}


	public Boolean getUsed() {
		return used;
	}


	public void setUsed(Boolean used) {
		this.used = used;
	}
	
	
	
	
	
	
	
	
	
}