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

@Entity(name = "roomPhoto")
@Table(name = "roomPhoto")
public class RoomPhotoBean {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	@Column(columnDefinition = "nvarchar(255)")
	private String photoFile;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "fk_room_id")
	private RoomBean roomBean;

	public RoomPhotoBean() {
	}

	public RoomPhotoBean(Integer id, String photoFile) {
		this.id = id;
		this.photoFile = photoFile;
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

	public RoomBean getRoomBean() {
		return roomBean;
	}

	public void setRoomBean(RoomBean roomBean) {
		this.roomBean = roomBean;
	}

	@Override
	public String toString() {
		return "RoomPhotoBean [id=" + id + ", photoFile=" + photoFile + ", roomBean=" + roomBean + "]";
	}

}
