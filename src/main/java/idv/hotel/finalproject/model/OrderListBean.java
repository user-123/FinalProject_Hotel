package idv.hotel.finalproject.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
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

@Entity
@Table(name = "Order_List")
public class OrderListBean implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@Column(unique = true, nullable = false)
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;	// 單純主鍵
	private String orderid;	// 訂單編號
	// 用於sql(數據庫)的:java.sql.Date只能存放年月日，java.sql.Timestamp能存放年月日時分秒
	// 非用於sql的:java.util.Date能夠存放年月日時分秒
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "FK_Logininfo_Id")
	private LoginBean userid;	// 會員
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "FK_Room_Id")
	private RoomBean roomid;	// 房號
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = "yyyy/MM/dd HH:mm:ss")
	//@Column(nullable = false)
	private Date orderdate;	// 訂單日期
	//@Column(nullable = false)
	private Timestamp checkindate;	// 入住日期
	//@Column(nullable = false)
	private Timestamp checkoutdate;	// 退房日期
	private String message;	// 備註其他需求

	public OrderListBean() {}

	//---------------------生成訂單時間(下訂時間)-----------------------------
	@PrePersist
	public void onCreateorderdate() {
		if (orderdate == null) {
			orderdate = new Date();
		}
	}

	public OrderListBean(Integer id, String orderid, LoginBean userid, RoomBean roomid, Date orderdate,
			Timestamp checkindate, Timestamp checkoutdate, String message) {
		super();
		this.id = id;
		this.orderid = orderid;
		this.userid = userid;
		this.roomid = roomid;
		this.orderdate = orderdate;
		this.checkindate = checkindate;
		this.checkoutdate = checkoutdate;
		this.message = message;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getOrderid() {
		return orderid;
	}

	public void setOrderid(String orderid) {
		this.orderid = orderid;
	}

	public LoginBean getUserid() {
		return userid;
	}

	public void setUserid(LoginBean userid) {
		this.userid = userid;
	}

	public RoomBean getRoomid() {
		return roomid;
	}

	public void setRoomid(RoomBean roomid) {
		this.roomid = roomid;
	}

	public Date getOrderdate() {
		return orderdate;
	}

	public void setOrderdate(Date orderdate) {
		this.orderdate = orderdate;
	}

	public Timestamp getCheckindate() {
		return checkindate;
	}

	public void setCheckindate(Timestamp checkindate) {
		this.checkindate = checkindate;
	}

	public Timestamp getCheckoutdate() {
		return checkoutdate;
	}

	public void setCheckoutdate(Timestamp checkoutdate) {
		this.checkoutdate = checkoutdate;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "OrderListBean [id=" + id + ", orderid=" + orderid + ", userid=" + userid  + ", roomid=" + roomid + ", orderdate=" + orderdate + ", checkindate=" + checkindate + ", checkoutdate=" + checkoutdate + ", message=" + message + "]";
	}

	public String getRoomIdtoString() {
		return roomid.getRoomIdToString();
	}
}