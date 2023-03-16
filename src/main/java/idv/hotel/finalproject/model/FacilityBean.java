package idv.hotel.finalproject.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity(name = "facility")
@Table(name = "facility")
public class FacilityBean {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer Id;
	@Column(columnDefinition = "nvarchar(255) NOT NULL")
	private String name;
	@Column(columnDefinition = "nvarchar(255)")
	private String introduce;
	@Column(columnDefinition = "nvarchar(255)")
	private String service;
	@OneToMany(mappedBy = "facilityBean", cascade = CascadeType.ALL, orphanRemoval = true)
	private List<FacilityPhotoBean> facilityPhotoBeans = new ArrayList<>();

	public FacilityBean() {
		super();
	}

	public FacilityBean(Integer id, String name, String introduce, String service,
			List<FacilityPhotoBean> facilityPhotoBeans) {
		super();
		Id = id;
		this.name = name;
		this.introduce = introduce;
		this.service = service;
		this.facilityPhotoBeans = facilityPhotoBeans;
	}

	public Integer getId() {
		return Id;
	}

	public void setId(Integer id) {
		Id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIntroduce() {
		return introduce;
	}

	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}

	public String getService() {
		return service;
	}

	public void setService(String service) {
		this.service = service;
	}

	public List<FacilityPhotoBean> getFacilityPhotoBeans() {
		return facilityPhotoBeans;
	}

	public void setFacilityPhotoBeans(List<FacilityPhotoBean> facilityPhotoBeans) {
		this.facilityPhotoBeans = facilityPhotoBeans;
	}

	@Override
	public String toString() {
		return "FacilityBean [Id=" + Id + ", name=" + name + ", introduce=" + introduce + ", service=" + service
				+ ", facilityPhotoBeans=" + facilityPhotoBeans + "]";
	}

}
