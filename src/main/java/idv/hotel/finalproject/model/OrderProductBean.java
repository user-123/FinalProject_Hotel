package idv.hotel.finalproject.model;

import java.sql.Timestamp;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="OrderProduct")
public class OrderProductBean implements java.io.Serializable {
	
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer orderProductId;
	
	private Timestamp buyTime;
	
	

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "orderProduct",cascade =CascadeType.PERSIST)
	private List<OrderProductDetailsBean> OrderProductDetails; 
	
	
	
	
	@ManyToOne(fetch = FetchType.EAGER,cascade =CascadeType.PERSIST)
	@JoinColumn(name="fk_order_login")
	private LoginBean loginOrder;

	public OrderProductBean() {
		super();
	}

	public OrderProductBean(Integer orderProductId, Timestamp buyTime, List<OrderProductDetailsBean> orderProductDetails,
			LoginBean loginOrder) {
		super();
		this.orderProductId = orderProductId;
		this.buyTime = buyTime;
		this.OrderProductDetails = orderProductDetails;
		this.loginOrder = loginOrder;
	}

	public Integer getOrderProductId() {
		return orderProductId;
	}

	public void setOrderProductId(Integer orderProductId) {
		this.orderProductId = orderProductId;
	}

	public Timestamp getBuyTime() {
		return buyTime;
	}

	public void setBuyTime(Timestamp buyTime) {
		this.buyTime = buyTime;
	}

	public List<OrderProductDetailsBean> getOrderProductDetails() {
		return OrderProductDetails;
	}

	public void setOrderProductDetails(List<OrderProductDetailsBean> orderProductDetails) {
		OrderProductDetails = orderProductDetails;
	}

	public LoginBean getLoginOrder() {
		return loginOrder;
	}

	public void setLoginOrder(LoginBean loginOrder) {
		this.loginOrder = loginOrder;
	}


	
}