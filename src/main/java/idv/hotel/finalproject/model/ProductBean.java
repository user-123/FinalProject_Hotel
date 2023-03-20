package idv.hotel.finalproject.model;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.ForeignKey;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.Digits;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name="product")
public class ProductBean implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer productId;
	@NotBlank(message = "商品名稱必填")
	private String  productName;
	@NotNull(message = "商品價格必填")
	@Min(value = 10, message = "商品價格至少10元")
	@Max(value = 100000, message = "商品價格要小於100000元")
	@Digits(integer = 6,fraction = 0, message = "請輸入整數!")
	private Integer price;
	private Integer status;
	private String photo;
	
	
	@ManyToOne(cascade =CascadeType.PERSIST)
	@JoinColumn(name="FK_category", foreignKey=@ForeignKey(name = "fkc_pro_cat"))
	@JsonIgnore
	CategoryBean category;

	public ProductBean() {
		super();
	}

	public ProductBean(Integer productId, String productName, Integer price, Integer status, String photo, CategoryBean category) {
		super();
		this.productId = productId;
		this.productName = productName;
		this.price = price;
		this.status = status;
		this.photo = photo;
		this.category = category;
	}

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public Integer getPrice() {
		return price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	
	public CategoryBean getCategory() {
		return category;
	}

	public void setCategory(CategoryBean category) {
		this.category = category;
	}

	@Override
	public String toString() {
		return "ProductBean [productId=" + productId + ", productName=" + productName + ", price=" + price + ", status="
				+ status + ", photo=" + photo + ", category=" + category + "]";
	}

	
	
}
