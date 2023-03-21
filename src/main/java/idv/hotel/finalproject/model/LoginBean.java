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
	private String roles;
	private String title;
	@Transient
	private String confirm;
	//@JsonManagedReference("login_member")
	@OneToOne(mappedBy = "accountId")
	private MemberBean member;


	public LoginBean(Integer accountId, String accountName, String password, String email, Timestamp signupDate,
			String roles, String title, String confirm, MemberBean member) {
		super();
		this.accountId = accountId;
		this.accountName = accountName;
		this.password = password;
		this.email = email;
		this.signupDate = signupDate;
		this.roles = roles;
		this.title = title;
		this.confirm = confirm;
		this.member = member;
	}

	public LoginBean() {}

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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Timestamp getSignupDate() {
		return signupDate;
	}

	public void setSignupDate(Timestamp signupDate) {
		this.signupDate = signupDate;
	}

	public String getRoles() {
		return roles;
	}

	public void setRoles(String roles) {
		this.roles = roles;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getConfirm() {
		return confirm;
	}

	public void setConfirm(String confirm) {
		this.confirm = confirm;
	}

	public MemberBean getMember() {
		return member;
	}

	public void setMember(MemberBean member) {
		this.member = member;
	}

	@Override
	public String toString() {
		return "LoginBean [accountId=" + accountId + ", accountName=" + accountName + ", password=" + password
				+ ", email=" + email + ", signupDate=" + signupDate + ", roles=" + roles + ", title=" + title
				+ ", confirm=" + confirm + ", member=" + member + "]";
	}



}