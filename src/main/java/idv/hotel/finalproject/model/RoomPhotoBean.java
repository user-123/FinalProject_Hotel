package idv.hotel.finalproject.model;

import java.util.Arrays;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity(name = "roomPhoto")
@Table(name = "roomPhoto")
public class RoomPhotoBean {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	@Lob
	@JsonIgnore // 不要進行序列化
	private byte[] photoFile;

	public RoomPhotoBean() {}

	public RoomPhotoBean(Integer id, byte[] photoFile) {
		this.id = id;
		this.photoFile = photoFile;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public byte[] getPhotoFile() {
		return photoFile;
	}

	public void setPhotoFile(byte[] photoFile) {
		this.photoFile = photoFile;
	}

	@Override
	public String toString() {
		return "RoomPhotoBean [id=" + id + ", photoFile=" + Arrays.toString(photoFile) + "]";
	}

}
