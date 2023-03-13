//package idv.hotel.finalproject.model;
//
//import java.util.Date;
//
//import javax.persistence.CascadeType;
//import javax.persistence.Entity;
//import javax.persistence.GeneratedValue;
//import javax.persistence.GenerationType;
//import javax.persistence.Id;
//import javax.persistence.JoinColumn;
//import javax.persistence.ManyToOne;
//import javax.persistence.PrePersist;
//import javax.persistence.Table;
//import javax.persistence.Temporal;
//import javax.persistence.TemporalType;
//
//import org.springframework.format.annotation.DateTimeFormat;
//
//@Entity
//@Table(name = "messages")
//public class Messages {
//
//	@Id
//	@GeneratedValue(strategy = GenerationType.IDENTITY)
//	private Integer id;
//	
//	private Integer star; //評論的星數(滿分5星)
//	
//	@ManyToOne(cascade = CascadeType.ALL)
//	@JoinColumn(name = "FK_Logininfo_Id")
//	private LoginBean userid;	// 會員
//	
//	private String usertext;        //住客評論
//	private String admintext;       //業主回應
//
//	@Temporal(TemporalType.TIMESTAMP)
//	@DateTimeFormat(pattern = "yyyy/MM/dd HH:mm:ss")
//	private Date messagetime;
//	
//	@PrePersist
//	public void onCreate() {
//		if(messagetime ==null) {
//			messagetime = new Date();
//		}
//	}
//
//	public Messages(Integer id, Integer star, LoginBean userid, String usertext, String admintext, Date messagetime) {
//		super();
//		this.id = id;
//		this.star = star;
//		this.userid = userid;
//		this.usertext = usertext;
//		this.admintext = admintext;
//		this.messagetime = messagetime;
//	}
//
//	public Integer getId() {
//		return id;
//	}
//
//	public void setId(Integer id) {
//		this.id = id;
//	}
//
//	public Integer getStar() {
//		return star;
//	}
//
//	public void setStar(Integer star) {
//		this.star = star;
//	}
//
//	public LoginBean getUserid() {
//		return userid;
//	}
//
//	public void setUserid(LoginBean userid) {
//		this.userid = userid;
//	}
//
//	public String getUsertext() {
//		return usertext;
//	}
//
//	public void setUsertext(String usertext) {
//		this.usertext = usertext;
//	}
//
//	public String getAdmintext() {
//		return admintext;
//	}
//
//	public void setAdmintext(String admintext) {
//		this.admintext = admintext;
//	}
//
//	public Date getMessagetime() {
//		return messagetime;
//	}
//
//	public void setMessagetime(Date messagetime) {
//		this.messagetime = messagetime;
//	}
//	
//
//}