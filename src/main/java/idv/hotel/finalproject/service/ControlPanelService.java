package idv.hotel.finalproject.service;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import idv.hotel.finalproject.dto.ControlPanelDto;
import idv.hotel.finalproject.model.AttractionBean;

@Service
public interface ControlPanelService {

	/*
	Occupancy Rate 入住率(OCC)=已售客房數/可售客房數
	Average Daily Rate 平均房價(ADR)=客房總收入/已售客房數
	Revenue Per Available 平均客房收益(RevPAR)=客房總收入/可售客房數
	Gross Operating Profit Per Available Room 每天每間客房經營毛利(GOPPAR)=(飯店總營業收入- 營業成本)/可售客房數
	Total Revenue Per Available Room 每間可售客房總收入(TRevPAR)=飯店總收入/可售客房數
	*/

	//獲取所有房間
	public Integer countAllRoom();
	//獲取日訂單
	//public Integer countTodayAllOrderDetail();
	public Integer countDayAllOrderDetail(Date date);
	//獲取月訂單
	//public Integer countThisMonthAllOrderDetail();
	public Integer countMonthAllOrderDetail(Date date);
	//計算日訂房率
	//public ControlPanelDto calculateOccupancyRateOfDay();
	public ControlPanelDto calculateOccupancyRateOfDay(Date date);
	//計算月訂房率
	//public ControlPanelDto calculateOccupancyRateOfMonth();
	public ControlPanelDto calculateOccupancyRateOfMonth(Date date);



}
