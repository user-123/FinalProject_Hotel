package idv.hotel.finalproject.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity(name = "home")
@Table(name = "home")
public class HomeBean {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer Id;

	@Column(columnDefinition = "nvarchar(255) NOT NULL")
	private String about;

	@Column(columnDefinition = "nvarchar(255) NOT NULL")
	private String aboutPhoto1;

	@Column(columnDefinition = "nvarchar(255) NOT NULL")
	private String aboutPhoto2;

	public HomeBean() {
		super();
	}

	public HomeBean(Integer id, String about, String aboutPhoto1, String aboutPhoto2) {
		super();
		Id = id;
		this.about = about;
		this.aboutPhoto1 = aboutPhoto1;
		this.aboutPhoto2 = aboutPhoto2;
	}

	public Integer getId() {
		return Id;
	}

	public void setId(Integer id) {
		Id = id;
	}

	public String getAbout() {
		return about;
	}

	public void setAbout(String about) {
		this.about = about;
	}

	public String getAboutPhoto1() {
		return aboutPhoto1;
	}

	public void setAboutPhoto1(String aboutPhoto1) {
		this.aboutPhoto1 = aboutPhoto1;
	}

	public String getAboutPhoto2() {
		return aboutPhoto2;
	}

	public void setAboutPhoto2(String aboutPhoto2) {
		this.aboutPhoto2 = aboutPhoto2;
	}

	@Override
	public String toString() {
		return "HomeBean [Id=" + Id + ", about=" + about + ", aboutPhoto1=" + aboutPhoto1 + ", aboutPhoto2="
				+ aboutPhoto2 + "]";
	}

}
