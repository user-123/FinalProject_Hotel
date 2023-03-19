package idv.hotel.finalproject.model;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrePersist;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

@Entity(name = "messages")
@Table(name = "messages")
public class MessageBean {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	private BigDecimal stars;          //評論的星數(滿分5星)
	
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "FK_Logininfo_Id")
	private LoginBean userid;	    // 會員
	
	private String usertext;        //住客評論
	private String admintext;       //業主回應

	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "yyyy/MM/dd HH:mm:ss")
	private Date messagetime;       //會員留言時間
	
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "yyyy/MM/dd HH:mm:ss")
	private Date replytime;       //業主回覆時間
	@PrePersist
	public void onCreate() {
		if(messagetime ==null) {
			messagetime = new Date();
		}
	}
	
	public MessageBean() {}

	public MessageBean(Integer id, BigDecimal stars, LoginBean userid, String usertext, String admintext,
			Date messagetime, Date replytime) {
		super();
		this.id = id;
		this.stars = stars;
		this.userid = userid;
		this.usertext = usertext;
		this.admintext = admintext;
		this.messagetime = messagetime;
		this.replytime = replytime;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public BigDecimal getStars() {
		return stars;
	}

	public void setStars(BigDecimal stars) {
		this.stars = stars;
	}

	public LoginBean getUserid() {
		return userid;
	}

	public void setUserid(LoginBean userid) {
		this.userid = userid;
	}

	public String getUsertext() {
		return usertext;
	}

	public void setUsertext(String usertext) {
		this.usertext = usertext;
	}

	public String getAdmintext() {
		return admintext;
	}

	public void setAdmintext(String admintext) {
		this.admintext = admintext;
	}

	public Date getMessagetime() {
		return messagetime;
	}

	public void setMessagetime(Date messagetime) {
		this.messagetime = messagetime;
	}

	public Date getReplytime() {
		return replytime;
	}

	public void setReplytime(Date replytime) {
		this.replytime = replytime;
	}

	@Override
	public String toString() {
		return "MessageBean [id=" + id + ", stars=" + stars + ", userid=" + userid + ", usertext=" + usertext
				+ ", admintext=" + admintext + ", messagetime=" + messagetime + ", replytime=" + replytime + "]";
	}
	
}