package idv.hotel.finalproject.dto;

import java.io.Serializable;
import java.text.DecimalFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;

public class ControlPanelDto implements Serializable {

	private static final long serialVersionUID = 1L;

	//@JsonProperty("id")
	//private Integer id;

	@JsonProperty("totalOfRooms")
	private Integer totalOfRooms;

	@JsonProperty("bookedRooms")
	private Integer totalOfBookedRooms;

	@JsonProperty("notBookedRooms")
	private Integer totalOfNotBookedRooms;

	@JsonProperty(value="percent")
	//@JsonFormat()
	private Float percentOfOccupancyRate;

	public ControlPanelDto() {
		super();
	}

	public ControlPanelDto(Integer totalOfRooms, Integer totalOfBookedRooms, Integer totalOfNotBookedRooms,
			Float percentOfOccupancyRate) {
		super();
		this.totalOfRooms = totalOfRooms;
		this.totalOfBookedRooms = totalOfBookedRooms;
		this.totalOfNotBookedRooms = totalOfNotBookedRooms;
		this.percentOfOccupancyRate = percentOfOccupancyRate;
	}

	public Integer getTotalOfRooms() {
		return totalOfRooms;
	}

	public void setTotalOfRooms(Integer totalOfRooms) {
		this.totalOfRooms = totalOfRooms;
	}

	public Integer getTotalOfBookedRooms() {
		return totalOfBookedRooms;
	}

	public void setTotalOfBookedRooms(Integer totalOfBookedRooms) {
		this.totalOfBookedRooms = totalOfBookedRooms;
	}

	public Integer getTotalOfNotBookedRooms() {
		return totalOfNotBookedRooms;
	}

	public void setTotalOfNotBookedRooms(Integer totalOfNotBookedRooms) {
		this.totalOfNotBookedRooms = totalOfNotBookedRooms;
	}

	public Float getPercentOfOccupancyRate() {
		//DecimalFormat df = new DecimalFormat("#,###.##");
		DecimalFormat df = new DecimalFormat("#.##");
		String percentOfOccupancyRateDf = df.format(percentOfOccupancyRate);
		return Float.parseFloat(percentOfOccupancyRateDf);
	}

	public void setPercentOfOccupancyRate(Float percentOfOccupancyRate) {
		this.percentOfOccupancyRate = percentOfOccupancyRate;
	}

	@Override
	public String toString() {
		return "ControlPanelDto [totalOfRooms=" + totalOfRooms + ", totalOfBookedRooms=" + totalOfBookedRooms + ", totalOfNotBookedRooms=" + totalOfNotBookedRooms + ", percentOfOccupancyRate=" + percentOfOccupancyRate + "]";
	}



}
