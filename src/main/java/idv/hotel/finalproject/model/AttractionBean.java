package idv.hotel.finalproject.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.beans.factory.annotation.Autowired;

//spring - jap生成表如何按照自己写的属性顺序来建表呢？ - SegmentFault 思否
//https://segmentfault.com/q/1010000004955087

@Entity(name = "Attraction")
@Table(name = "Attraction")
public class AttractionBean {
	@Id
	@Column(name="Id", columnDefinition="int")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer attractionId;

	@Column(name="Num", columnDefinition="int", nullable=true, unique=false)
	private Integer attractionNum;

	//@Column(columnDefinition="nvarchar(255) NOT NULL", name="Name")
	@Column(name="Name", columnDefinition="nvarchar(255)", nullable=false)
	private String attractionName;

	@Column(name="Category", columnDefinition="nvarchar(255)", nullable=true)
	private String attractionCategory;

	@Column(name="Address", columnDefinition="nvarchar(255)", nullable=true)
	private String attractionAddress;

	@Column(name="Distance", columnDefinition="float", nullable=true, precision=6, scale=3)
	private Float attractionDistance;

	@Column(name="Introduction", columnDefinition="nvarchar(MAX)", nullable=true)
	private String attractionIntroduction;

	@Column(name="PhotoPath", columnDefinition="nvarchar(MAX)", nullable=true)
	private String attractionPhotoPath = "default.jpg";

	//@JsonManagedReference
	//@OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
	//@JoinColumn(name = "XXXXX")
	//private List<AttractionCategoryBean> attractionCategoryBeans = new ArrayList<>();

	@Autowired
	public AttractionBean() {}

	public AttractionBean(Integer attractionId, Integer attractionNum, String attractionName, String attractionCategory,
			String attractionAddress, Float attractionDistance, String attractionIntroduction,
			String attractionPhotoPath) {
		super();
		this.attractionId = attractionId;
		this.attractionNum = attractionNum;
		this.attractionName = attractionName;
		this.attractionCategory = attractionCategory;
		this.attractionAddress = attractionAddress;
		this.attractionDistance = attractionDistance;
		this.attractionIntroduction = attractionIntroduction;
		this.attractionPhotoPath = attractionPhotoPath;
	}

	public Integer getAttractionId() {
		return attractionId;
	}

	public void setAttractionId(Integer attractionId) {
		this.attractionId = attractionId;
	}

	public Integer getAttractionNum() {
		return attractionNum;
	}

	public void setAttractionNum(Integer attractionNum) {
		this.attractionNum = attractionNum;
	}

	public String getAttractionName() {
		return attractionName;
	}

	public void setAttractionName(String attractionName) {
		this.attractionName = attractionName;
	}

	public String getAttractionCategory() {
		return attractionCategory;
	}

	public void setAttractionCategory(String attractionCategory) {
		this.attractionCategory = attractionCategory;
	}

	public String getAttractionAddress() {
		return attractionAddress;
	}

	public void setAttractionAddress(String attractionAddress) {
		this.attractionAddress = attractionAddress;
	}

	public Float getAttractionDistance() {
		return attractionDistance;
	}

	public void setAttractionDistance(Float attractionDistance) {
		this.attractionDistance = attractionDistance;
	}

	public String getAttractionIntroduction() {
		return attractionIntroduction;
	}

	public void setAttractionIntroduction(String attractionIntroduction) {
		this.attractionIntroduction = attractionIntroduction;
	}

	public String getAttractionPhotoPath() {
		return attractionPhotoPath;
	}

	public void setAttractionPhotoPath(String attractionPhotoPath) {
		this.attractionPhotoPath = attractionPhotoPath;
	}

	@Override
	public String toString() {
		return "AttractionBean [attractionId=" + attractionId + ", attractionNum=" + attractionNum + ", attractionName=" + attractionName + ", attractionCategory=" + attractionCategory + ", attractionAddress=" + attractionAddress + ", attractionDistance=" + attractionDistance + ", attractionIntroduction=" + attractionIntroduction + ", attractionPhotoPath=" + attractionPhotoPath + "]";
	}

}