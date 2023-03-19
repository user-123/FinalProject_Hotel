package idv.hotel.finalproject.model;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.ForeignKey;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name="member")
public class MemberBean implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer memberId;
	private String userName;
	private String address;
	private String phone;
	@Temporal(TemporalType.DATE)
	private java.util.Date birthDate;
	private String gender;
	private String photoPath;
	//@JsonBackReference("login_member")
	@OneToOne(cascade =CascadeType.PERSIST)
	@JoinColumn(name="accountId", foreignKey=@ForeignKey(name = "fk_mem_log"))
	private LoginBean accountId;


	public MemberBean(Integer memberId, String userName, String address, String phone, Date birthDate,
			String gender, String photoPath, LoginBean accountId) {
		super();
		this.memberId = memberId;
		this.userName = userName;
		this.address = address;
		this.phone = phone;
		this.birthDate = birthDate;
		this.gender = gender;
		this.photoPath = photoPath;
		this.accountId = accountId;
	}
	public MemberBean() {}
	public Integer getMemberId() {
		return memberId;
	}
	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public java.util.Date getBirthDate() {
		return birthDate;
	}
	public void setBirthDate(Date birthDate) {
		this.birthDate = birthDate;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getPhotoPath() {
		return photoPath;
	}
	public void setPhotoPath(String photoPath) {
		this.photoPath = photoPath;
	}
	public LoginBean getAccountId() {
		return accountId;
	}
	public void setAccountId(LoginBean accountId) {
		this.accountId = accountId;
	}

	@Override
	public String toString() {
		return "MemberBean [memberId=" + memberId + ", userName=" + userName + ", address=" + address  + ", phone=" + phone + ", birthDate=" + birthDate + ", gender=" + gender + ", photoPath=" + photoPath + "]";
	}



}

