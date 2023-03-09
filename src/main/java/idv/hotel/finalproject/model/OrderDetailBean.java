package idv.hotel.finalproject.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "Order_Detail")
public class OrderDetailBean implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer suborderId; // 子訂單
	@ManyToOne(cascade=CascadeType.ALL)
	@JoinColumn(name = "FK_OrderList_Id")
	//@JoinColumn(name = "FK_OrderList_Id", nullable = false)
	private OrderListBean orderId; // 訂單編號
	// 用於sql(數據庫)的:java.sql.Date只能存放年月日，java.sql.Timestamp能存放年月日時分秒
	// 非用於sql的:java.util.Date能夠存放年月日時
	//@Column(nullable = false)
	private Integer roomId; // 房號
	//@Column(nullable = false)
	private Date checkindate; // 入住日期
	private String message; // 備註其他需求

	public OrderDetailBean() {}


	public OrderDetailBean(Integer suborderId, OrderListBean orderId, Integer roomId, Date checkindate,
			String message) {
		super();
		this.suborderId = suborderId;
		this.orderId = orderId;
		this.roomId = roomId;
		this.checkindate = checkindate;
		this.message = message;
	}


	public Integer getSuborderId() {
		return suborderId;
	}


	public void setSuborderId(Integer suborderId) {
		this.suborderId = suborderId;
	}


	public OrderListBean getOrderId() {
		return orderId;
	}


	public void setOrderId(OrderListBean orderId) {
		this.orderId = orderId;
	}


	public Integer getRoomId() {
		return roomId;
	}


	public void setRoomId(Integer roomId) {
		this.roomId = roomId;
	}

	public Date getCheckindate() {
		return checkindate;
	}


	public void setCheckindate(Date checkindate) {
		this.checkindate = checkindate;
	}


	public String getMessage() {
		return message;
	}


	public void setMessage(String message) {
		this.message = message;
	}


	@Override
	public String toString() {
		return "OrderDetailBean [suborderId=" + suborderId + ", orderId=" + orderId + ", roomId=" + roomId  + ", checkindate=" + checkindate + ", roomservice=" + message + "]";
	}
}