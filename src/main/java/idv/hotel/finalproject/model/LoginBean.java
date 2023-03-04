package idv.hotel.finalproject.model;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.persistence.UniqueConstraint;
@Entity
@Table(name="login_info",uniqueConstraints = @UniqueConstraint(name = "unique_email", columnNames = "email"))
public class LoginBean implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer accountId;
	private String accountName;
	private String password;
	private String email;
	private Timestamp signupDate;
	private String status;
	private String title;
	@Transient
	private String confirm;
	@OneToOne(mappedBy = "accountId")
	private MemberBean member;
<<<<<<< HEAD


=======
	
	
	
	
>>>>>>> origin/rebeccadevelope
	public LoginBean(Integer accountId, String accountName, String password, String email, Timestamp signupDate,
			String status, String title, String confirm, MemberBean member) {
		super();
		this.accountId = accountId;
		this.accountName = accountName;
		this.password = password;
		this.email = email;
		this.signupDate = signupDate;
		this.status = status;
		this.title = title;
		this.confirm = confirm;
		this.member = member;
	}
<<<<<<< HEAD

	public LoginBean() {}

=======
	public LoginBean() {
	}
>>>>>>> origin/rebeccadevelope
	public Integer getAccountId() {
		return accountId;
	}
	public void setAccountId(Integer accountId) {
		this.accountId = accountId;
	}
	public String getAccountName() {
		return accountName;
	}
	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Timestamp getSignupDate() {
		return signupDate;
	}
	public void setSignupDate(Timestamp signupDate) {
		this.signupDate = signupDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public MemberBean getMember() {
		return member;
	}
	public void setMember(MemberBean member) {
		this.member = member;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	
	
	public String getConfirm() {
		return confirm;
	}
	public void setConfirm(String confirm) {
		this.confirm = confirm;
	}
	@Override
	public String toString() {
		return "LoginBean [accountId=" + accountId + ", accountName=" + accountName + ", password=" + password
				+ ", email=" + email + ", signupDate=" + signupDate + ", status=" + status + ", title=" + title
				+ ", confirm=" + confirm + ", member=" + member + "]";
	}
<<<<<<< HEAD



}
=======
	
	
	
	
	
}

>>>>>>> origin/rebeccadevelope
