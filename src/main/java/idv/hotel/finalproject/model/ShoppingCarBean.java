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
@Table(name="ShoppingCar")
public class ShoppingCarBean implements java.io.Serializable {
	
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer shoppingCarId;

	@ManyToOne(fetch = FetchType.EAGER,cascade =CascadeType.PERSIST)
	@JoinColumn(name="fk_product")
	private ProductBean productShoppingCar; 
	
	@ManyToOne
	@JoinColumn(name="shoppingCarAccountId")
	private LoginBean shoppingCarAccountId;
	

	
	public ShoppingCarBean() {
	}

	public ShoppingCarBean(Integer shoppingCarId, ProductBean productShoppingCar, LoginBean shoppingCarAccountId) {
		super();
		this.shoppingCarId = shoppingCarId;
		this.productShoppingCar = productShoppingCar;
		this.shoppingCarAccountId = shoppingCarAccountId;
	}

	public Integer getShoppingCarId() {
		return shoppingCarId;
	}

	public void setShoppingCarId(Integer shoppingCarId) {
		this.shoppingCarId = shoppingCarId;
	}

	public ProductBean getProductShoppingCar() {
		return productShoppingCar;
	}

	public void setProductShoppingCar(ProductBean productShoppingCar) {
		this.productShoppingCar = productShoppingCar;
	}

	public LoginBean getShoppingCarAccountId() {
		return shoppingCarAccountId;
	}

	public void setShoppingCarAccountId(LoginBean shoppingCarAccountId) {
		this.shoppingCarAccountId = shoppingCarAccountId;
	}

	
	
}