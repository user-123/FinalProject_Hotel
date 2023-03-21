package idv.hotel.finalproject.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity(name = "facilityPhoto")
@Table(name = "facilityPhoto")
public class FacilityPhotoBean {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	@Column(columnDefinition = "nvarchar(255)")
	private String photoFile;
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "fk_facility_id")
	private FacilityBean facilityBean;

	public FacilityPhotoBean() {
		super();
	}

	public FacilityPhotoBean(Integer id, String photoFile, FacilityBean facilityBean) {
		super();
		this.id = id;
		this.photoFile = photoFile;
		this.facilityBean = facilityBean;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getPhotoFile() {
		return photoFile;
	}

	public void setPhotoFile(String photoFile) {
		this.photoFile = photoFile;
	}

	public FacilityBean getFacilityBean() {
		return facilityBean;
	}

	public void setFacilityBean(FacilityBean facilityBean) {
		this.facilityBean = facilityBean;
	}

	@Override
	public String toString() {
		return "FacilityPhotoBean [id=" + id + ", photoFile=" + photoFile + ", facilityBean=" + facilityBean + "]";
	}

}
