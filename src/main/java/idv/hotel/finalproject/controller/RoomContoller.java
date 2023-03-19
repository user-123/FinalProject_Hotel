package idv.hotel.finalproject.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import idv.hotel.finalproject.model.RoomBean;
import idv.hotel.finalproject.model.RoomPhotoBean;
import idv.hotel.finalproject.service.RoomService;
import idv.hotel.finalproject.service.RoomPhotoService;

@Controller
public class RoomContoller {
	@Autowired
	private RoomService rService;
	@Autowired
	private RoomPhotoService rpService;

	@GetMapping("admin/backstage/room")
	public String finAllBackstage(Model model) {
		List<RoomBean> roomBs = rService.findAll();
		model.addAttribute("room", roomBs);
		return "room/backstageRoom";
	}

	@GetMapping("admin/backstage/roomShowType")
	public String findTypebackstage(@RequestParam String type, Model model) {
		if (type == "") {
			return "redirect:/admin/backstage/room";
		} else {
			List<RoomBean> roomType = rService.findType(type);
			model.addAttribute("room", roomType);
			return "room/backstageRoom";
		}
	}

	@GetMapping("/public/room/orderAllShow")
	public String findAllOrder(Model model) {
		List<RoomBean> roomAll = rService.findAll();
		model.addAttribute("room", roomAll);
		return "room/orderShowAllRoom";
	}

	@GetMapping("/public/room/orderShow") // 照片無法顯示
	public String findOrder(@RequestParam Integer Id, Model model) {
		System.out.println("測試1");
		System.out.println(Id);
		RoomBean roomBean = rService.ReferenceById(Id);
		System.out.println("測試2");
		System.out.println(roomBean);
		List<RoomPhotoBean> photos = roomBean.getRoomPhotoBeans();
		System.out.println("測試3");
		System.out.println(photos);

		for (RoomPhotoBean onePhoto : photos) {
			Integer oneId = onePhoto.getId();
			System.out.println("測試4");
			System.out.println(oneId);
			Optional<RoomPhotoBean> optional = Optional.ofNullable(rpService.find(oneId));
			System.out.println("測試5");
			System.out.println(optional);
			if (optional.isPresent()) {
				RoomPhotoBean photo = optional.get();
				System.out.println("測試6");
				System.out.println(photo);
				byte[] photoFile = photo.getPhotoFile();
				System.out.println("測試7");
				System.out.println(photoFile);

				System.out.println("測試8");
				System.out.println(ResponseEntity.ok().contentType(MediaType.IMAGE_JPEG).body(photoFile));

//				model.addAttribute("msg",msg);

			}
		}

		RoomBean room = rService.find(Id);
		model.addAttribute("room", room);
		return "room/orderShowRoom";
	}

	@GetMapping("/public/room/OrdershowType")
	public String findOrderType(@RequestParam String type, Model model) {
		if (type == "") {
			return "redirect:/public/room/orderAllShow";
		} else {
			List<RoomBean> roomType = rService.findType(type);
			model.addAttribute("room", roomType);
			return "room/orderShowAllRoom";
		}
	}

	@GetMapping("/public/room/allShow")
	public String findAll(Model model) {
		List<RoomBean> roomAll = rService.findAll();
		model.addAttribute("room", roomAll);
		return "room/showAllRoom";
	}

	@GetMapping("/public/room/show") // 照片無法顯示
	public String find(@RequestParam Integer Id, Model model) {
		System.out.println("測試1");
		System.out.println(Id);
		RoomBean roomBean = rService.ReferenceById(Id);
		System.out.println("測試2");
		System.out.println(roomBean);
		List<RoomPhotoBean> photos = roomBean.getRoomPhotoBeans();
		System.out.println("測試3");
		System.out.println(photos);

		for (RoomPhotoBean onePhoto : photos) {
			Integer oneId = onePhoto.getId();
			System.out.println("測試4");
			System.out.println(oneId);
			Optional<RoomPhotoBean> optional = Optional.ofNullable(rpService.find(oneId));
			System.out.println("測試5");
			System.out.println(optional);
			if (optional.isPresent()) {
				RoomPhotoBean photo = optional.get();
				System.out.println("測試6");
				System.out.println(photo);
				byte[] photoFile = photo.getPhotoFile();
				System.out.println("測試7");
				System.out.println(photoFile);

				System.out.println("測試8");
				System.out.println(ResponseEntity.ok().contentType(MediaType.IMAGE_JPEG).body(photoFile));

//				model.addAttribute("msg",msg);

			}
		}

		RoomBean room = rService.find(Id);
		model.addAttribute("room", room);
		return "room/showRoom";
	}

	@GetMapping("/public/room/ShowType")
	public String findType(@RequestParam String type, Model model) {
		if (type == "") {
			return "redirect:/public/room/allShow";
		} else {
			List<RoomBean> roomType = rService.findType(type);
			model.addAttribute("room", roomType);
			return "room/showAllRoom";
		}
	}

	@GetMapping("/admin/room/create")
	public String create(Model model) {
		RoomBean roomBean = new RoomBean();
		model.addAttribute("roomBean", roomBean);
		return "room/addRoom";

	}

	@PostMapping("/admin/room/add")
	public String add(@ModelAttribute("roomBean") RoomBean rB, @RequestParam("files") MultipartFile[] files,
			Model model) throws IOException {
		Integer roomId = rB.getRoomId();
		String name = rB.getName();
		String type = rB.getType();
		Integer price = rB.getPrice();
		RoomBean rbi = rService.findByroomId(roomId);
		RoomBean rbn = rService.findByname(name);
		if (roomId == null || name.equals("")) {
			return "room/addRoom";
		} else if (type.equals("") || price == null) {
			return "room/addRoom";
		} else if (rbi != null || rbn != null) {
			return "room/addRoom";
		} else {

			List<RoomPhotoBean> photos = new LinkedList<>();

			for (MultipartFile file : files) {
				RoomPhotoBean roomPhotoBean = new RoomPhotoBean();
				byte[] photoByte = file.getBytes();
				roomPhotoBean.setPhotoFile(photoByte);

				photos.add(roomPhotoBean);
			}
			rB.setRoomPhotoBeans(photos);

			System.out.println(rB);
			rService.create(rB);
			return "redirect:/admin/backstage/room";
		}

	}

	@GetMapping("/admin/room/addCheckId")
	@ResponseBody
	public String findRoomId(@RequestParam Integer roomId) {
		RoomBean rbi = rService.findByroomId(roomId);
		if (rbi == null) {
			return "";
		} else {
			return "此房號已存在";
		}
	}

	@GetMapping("/admin/room/addCheckNamne")
	@ResponseBody
	public String findName(@RequestParam String name) {
		RoomBean rbn = rService.findByname(name);
		if (rbn == null) {
			return "";
		} else {
			return "此房名已存在";
		}
	}

	@DeleteMapping("admin/room/delete")
	public String delete(@RequestParam Integer id) {
		rService.delete(id);
		return "redirect:/admin/backstage/room";
	}

	@GetMapping("admin/room/edit")
	public String edit(@RequestParam("id1") Integer id, Model model) {
		RoomBean roomBean = rService.find(id);
		model.addAttribute("roomBean", roomBean);
		return "room/editRoom";
	}

	@PutMapping("admin/room/update")
	public String update(@ModelAttribute("roomBean") RoomBean roomBean, @RequestParam("files") MultipartFile[] files,
			Model model) throws IOException {
		Integer Id = roomBean.getId();
		Integer roomId = roomBean.getRoomId();
		String name = roomBean.getName();
		String type = roomBean.getType();
		Integer price = roomBean.getPrice();
		RoomBean rbi = rService.findByroomId(roomId);
		RoomBean rbn = rService.findByname(name);
		if (roomId == null || name.equals("")) {
			return "redirect:/admin/backstage/room";
		} else if (type.equals("") || price == null) {
			return "redirect:/admin/backstage/room";

		} else if (rbi != null) {
			if (rbi.getId() == Id) {
				if (rbn != null) {
					if (rbn.getId() == Id) {

						rService.create(roomBean);

						return "redirect:/admin/backstage/room";
					} else {

						return "redirect:/admin/backstage/room";
					}
				}
				rService.create(roomBean);

				return "redirect:/admin/backstage/room";
			} else {

				return "redirect:/admin/backstage/room";
			}

		} else if (rbn != null) {
			if (rbn.getId() == Id) {

				rService.create(roomBean);

				return "redirect:/admin/backstage/room";
			} else {

				return "redirect:/admin/backstage/room";
			}
		} else {

//			List<RoomPhotoBean> photos = new LinkedList<>();
//
//			for (MultipartFile file : files) {
//				RoomPhotoBean roomPhotoBean = new RoomPhotoBean();
//				byte[] photoByte = file.getBytes();
//				roomPhotoBean.setPhotoFile(photoByte);
//
//				photos.add(roomPhotoBean);
//			}
//			roomBean.setRoomPhotoBeans(photos);
			System.out.println(roomBean);
			rService.create(roomBean);

			return "redirect:/admin/backstage/room";
		}
	}

	@GetMapping("/admin/room/updataCheckId")
	@ResponseBody
	public String updataFindRoomId(@RequestParam Integer roomId, @RequestParam Integer Id) {
		RoomBean rbi = rService.findByroomId(roomId);
		System.out.println(Id);
		if (rbi != null) {
			if (rbi.getId() == Id) {

				return "";
			} else {

				return "此房號已存在";
			}
		} else {
			return "";
		}
	}

	@GetMapping("/admin/room/updataCheckNamne")
	@ResponseBody
	public String updataFindName(@RequestParam String name, @RequestParam Integer Id) {
		RoomBean rbn = rService.findByname(name);
		System.out.println(Id);
		if (rbn != null) {
			if (rbn.getId() == Id) {

				return "";
			} else {

				return "此房名已存在";
			}
		} else {
			return "";
		}
	}
}
