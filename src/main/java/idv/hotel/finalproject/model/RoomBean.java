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

@Entity(name = "room")
@Table(name = "room")
public class RoomBean {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer Id;
	private Integer roomId;
	@Column(columnDefinition = "varchar(255) NOT NULL")
	private String name;
	@Column(columnDefinition = "varchar(255) NOT NULL")
	private String type;
	@Column(columnDefinition = "int NOT NULL")
	private Integer price;
	private String roomNameIntroduction;
<<<<<<< HEAD
	@Column(columnDefinition = "nvarchar(255)")
=======
	@Column(columnDefinition = "varchar(255) NOT NULL")
	private String img;
>>>>>>> origin/rebeccadevelope
	private String introduce;
	private String equipment;
	private String service;
	private String remark;

//	@JsonManagedReference // 主要序列化方
	@OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
	@JoinColumn(name = "fk_room_id")
	private List<RoomPhotoBean> roomPhotoBeans = new ArrayList<>();

	public RoomBean() {}

<<<<<<< HEAD
	public RoomBean(Integer Id, Integer roomId, String name, String type, Integer price, String roomNameIntroduction,
			String introduce, String equipment, String service, String remark) {
		this.Id = Id;
=======
	public RoomBean(Integer id, Integer roomId, String name, String type, Integer price, String roomNameIntroduction,
			String img, String introduce, String equipment, String service, String remark) {
		super();
		Id = id;
>>>>>>> origin/rebeccadevelope
		this.roomId = roomId;
		this.name = name;
		this.type = type;
		this.price = price;
		this.roomNameIntroduction = roomNameIntroduction;
		this.introduce = introduce;
		this.equipment = equipment;
		this.service = service;
		this.remark = remark;
	}

	@Override
	public String toString() {
		return "RoomBean [Id=" + Id + ", roomId=" + roomId + ", name=" + name + ", type=" + type + ", price=" + price
				+ ", roomNameIntroduction=" + roomNameIntroduction + ", img=" + img + ", introduce=" + introduce
				+ ", equipment=" + equipment + ", service=" + service + ", remark=" + remark + "]";
	}

	public Integer getId() {
		return Id;
	}

	public void setId(Integer id) {
		Id = id;
	}

	public Integer getRoomId() {
		return roomId;
	}

	public void setRoomId(Integer roomId) {
		this.roomId = roomId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Integer getPrice() {
		return price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}

	public String getRoomNameIntroduction() {
		return roomNameIntroduction;
	}

	public void setRoomNameIntroduction(String roomNameIntroduction) {
		this.roomNameIntroduction = roomNameIntroduction;
	}

	public String getIntroduce() {
		return introduce;
	}

	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}

	public String getEquipment() {
		return equipment;
	}

	public void setEquipment(String equipment) {
		this.equipment = equipment;
	}

	public String getService() {
		return service;
	}

	public void setService(String service) {
		this.service = service;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

<<<<<<< HEAD
	public List<RoomPhotoBean> getRoomPhotoBeans() {
		return roomPhotoBeans;
	}

	public void setRoomPhotoBeans(List<RoomPhotoBean> roomPhotoBeans) {
		this.roomPhotoBeans = roomPhotoBeans;
	}

	@Override
	public String toString() {
		return "RoomBean [Id=" + Id + ", roomId=" + roomId + ", name=" + name + ", type=" + type + ", price=" + price
				+ ", roomNameIntroduction=" + roomNameIntroduction + ", introduce=" + introduce + ", equipment="
				+ equipment + ", service=" + service + ", remark=" + remark + ", roomPhotoBeans=" + roomPhotoBeans
				+ "]";
	}

}
=======
}
>>>>>>> origin/rebeccadevelope
