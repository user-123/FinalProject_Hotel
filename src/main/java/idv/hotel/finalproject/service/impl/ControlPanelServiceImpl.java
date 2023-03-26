package idv.hotel.finalproject.service.impl;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import idv.hotel.finalproject.service.ControlPanelService;
import idv.hotel.finalproject.dao.OrderDetailDao;
import idv.hotel.finalproject.dao.RoomDao;
import idv.hotel.finalproject.dto.ControlPanelDto;

@Service
public class ControlPanelServiceImpl implements ControlPanelService {

	@Autowired
	private OrderDetailDao odDao;
	@Autowired
	private RoomDao rDao;



	@Override
	public Integer countAllRoom() {
		return (int)rDao.count();
	}

	@Override
	public Integer countDayAllOrderDetail(Date date) {
		return odDao.countBylivingDate(date);
	}

	@Override
	public Integer countMonthAllOrderDetail(Date date) {
		Calendar dateStart = Calendar.getInstance();
		dateStart.setTime(date);
		dateStart.set(Calendar.DAY_OF_MONTH, 1);
		Calendar dateEnd = Calendar.getInstance();
		dateEnd.setTime(date);
		dateEnd.add(Calendar.MONTH, 1);
		//dateEnd.set(Calendar.DAY_OF_MONTH, 0);	//等同下面兩句
		dateEnd.set(Calendar.DAY_OF_MONTH, 1);
		dateEnd.add(Calendar.DATE, -1);

		Date startDate = dateStart.getTime();
		Date endDate = dateEnd.getTime();
		return odDao.countBylivingDate(startDate, endDate);
	}

	/*
	@Override
	public ControlPanelDto calculateOccupancyRateOfDay() {
		ControlPanelDto cpDto = new ControlPanelDto();
		cpDto.setTotalOfBookedRooms(odDao.countBylivingDate(new Date()));

		System.out.println(cpDto);
		return cpDto;
	}
	*/
	@Override
	public ControlPanelDto calculateOccupancyRateOfDay(Date date) {
		ControlPanelDto cpDto = new ControlPanelDto();
		cpDto.setTotalOfRooms(countAllRoom());
		cpDto.setTotalOfBookedRooms(countDayAllOrderDetail(date));
		cpDto.setTotalOfNotBookedRooms(countAllRoom() - countDayAllOrderDetail(date));
		cpDto.setPercentOfOccupancyRate((float)countDayAllOrderDetail(date)/countAllRoom()*100);
		System.out.println(cpDto);
		return cpDto;
	}

	/*
	@Override
	public ControlPanelDto calculateOccupancyRateOfMonth() {
		Calendar currentDate_Start = Calendar.getInstance();
		currentDate_Start.set(Calendar.DAY_OF_MONTH, 1);
		Calendar currentDate_End = Calendar.getInstance();
		currentDate_End.add(Calendar.MONTH, 1);
		currentDate_End.set(Calendar.DAY_OF_MONTH, 1);
		currentDate_End.add(Calendar.DATE, -1);

		Date startDate = currentDate_Start.getTime();
		Date endDate = currentDate_End.getTime();

		ControlPanelDto cpDto = new ControlPanelDto();
		cpDto.setTotalOfBookedRooms(odDao.countBylivingDate(startDate, endDate));

		System.out.println(cpDto);
		return cpDto;
	}
	*/
	@Override
	public ControlPanelDto calculateOccupancyRateOfMonth(Date date) {
		Calendar dateCal = Calendar.getInstance();
		dateCal.setTime(date);
		dateCal.add(Calendar.MONTH, 1);
		dateCal.set(Calendar.DAY_OF_MONTH, 0);
		System.out.println(dateCal.getTime());
		System.out.println(dateCal.get(Calendar.DAY_OF_MONTH));
		ControlPanelDto cpDto = new ControlPanelDto();
		cpDto.setTotalOfRooms(countAllRoom()*dateCal.get(Calendar.DAY_OF_MONTH));
		cpDto.setTotalOfBookedRooms(countMonthAllOrderDetail(date));
		cpDto.setTotalOfNotBookedRooms(countAllRoom()*dateCal.get(Calendar.DAY_OF_MONTH) - countMonthAllOrderDetail(date));
		cpDto.setPercentOfOccupancyRate((float)countMonthAllOrderDetail(date)/(countAllRoom()*dateCal.get(Calendar.DAY_OF_MONTH))*100);
		System.out.println(cpDto);
		return cpDto;
	}
}
