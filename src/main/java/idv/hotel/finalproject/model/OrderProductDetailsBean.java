package idv.hotel.finalproject.model;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="OrderProductDetails")
public class OrderProductDetailsBean implements java.io.Serializable {
	
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer orderProductDetailsId;
	
	private Integer Quant;

	@ManyToOne(fetch = FetchType.EAGER,cascade =CascadeType.PERSIST)
	@JoinColumn(name="fk_details_product")
	private ProductBean productDetails; 
	
	
	@ManyToOne(fetch = FetchType.EAGER,cascade =CascadeType.PERSIST)
	@JoinColumn(name="fk_details_order")
	private OrderProductBean orderProduct;


	public OrderProductDetailsBean() {
		super();
	}


	public OrderProductDetailsBean(Integer orderProductDetailsId, Integer quant, ProductBean productDetails,
			OrderProductBean orderProduct) {
		super();
		this.orderProductDetailsId = orderProductDetailsId;
		Quant = quant;
		this.productDetails = productDetails;
		this.orderProduct = orderProduct;
	}


	public Integer getOrderProductDetailsId() {
		return orderProductDetailsId;
	}


	public void setOrderProductDetailsId(Integer orderProductDetailsId) {
		this.orderProductDetailsId = orderProductDetailsId;
	}


	public Integer getQuant() {
		return Quant;
	}


	public void setQuant(Integer quant) {
		Quant = quant;
	}


	public ProductBean getProductDetails() {
		return productDetails;
	}


	public void setProductDetails(ProductBean productDetails) {
		this.productDetails = productDetails;
	}


	public OrderProductBean getOrderProduct() {
		return orderProduct;
	}


	public void setOrderProduct(OrderProductBean orderProduct) {
		this.orderProduct = orderProduct;
	} 

	
	

	
	
}