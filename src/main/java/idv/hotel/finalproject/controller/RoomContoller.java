package idv.hotel.finalproject.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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


	@Value("${file.upload-dir}")
	private String photoFile;

	@GetMapping("/admin/room/backstage")
	public String finAllBackstage(Model model) {
		List<RoomBean> roomBs = rService.findAll();
		model.addAttribute("room", roomBs);
		return "room/backstageRoom";
	}

	@GetMapping("admin/room/backstageShowType")
	public String findTypebackstage(@RequestParam String type, Model model) {
		if (type == "") {
			return "redirect:/admin/room/backstage";
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

	@GetMapping("/public/room/orderShow")
	public String findOrder(@RequestParam Integer Id, Model model) {
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

	@GetMapping("/public/room/show")
	public String find(@RequestParam Integer Id, Model model) {
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
			Model model, HttpServletRequest request) throws IOException {
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
			RoomBean bean = rService.create(rB);
		
			for (MultipartFile photo : files) {
				if (!photo.isEmpty()) {
					Integer Id = bean.getId();
					String nameImg = Id + "." + photo.getOriginalFilename();
					RoomPhotoBean roomPhotoBean = new RoomPhotoBean();
					roomPhotoBean.setRoomBean(bean);
					roomPhotoBean.setPhotoFile(nameImg);
				
					
					rpService.saveImg(roomPhotoBean);
					
					String photoFilePath = request.getServletContext().getRealPath(photoFile);
					
					File roomImg = new File(photoFilePath);
					
					if (!roomImg.isDirectory())
						roomImg.mkdirs();
				
					Path path = Paths.get(photoFilePath, nameImg);
					Files.write(path, photo.getBytes());
				}
			}


			return "redirect:/admin/room/backstage";

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
	public String delete(@RequestParam Integer id, HttpServletRequest request) {

		String path = request.getServletContext().getRealPath(photoFile);
		RoomBean roomBean = rService.find(id);
		List<RoomPhotoBean> images = roomBean.getRoomPhotoBeans();
		for (RoomPhotoBean image : images) {
			File file = new File(path + "/" + image.getPhotoFile());
			if (file.exists()) {
				file.delete();
			}
		}
		rService.delete(id);
		return "redirect:/admin/room/backstage";
	}

	@GetMapping("admin/room/edit")
	public String edit(@RequestParam("id1") Integer id, Model model) {
		RoomBean roomBean = rService.find(id);
		model.addAttribute("roomBean", roomBean);
		return "room/editRoom";
	}

	@PutMapping("admin/room/update")
	public String update(@ModelAttribute("roomBean") RoomBean roomBean, @RequestParam("files") MultipartFile[] files,
			Model model, HttpServletRequest request) throws IOException {
		Integer Id = roomBean.getId();
		Integer roomId = roomBean.getRoomId();
		String name = roomBean.getName();
		String type = roomBean.getType();
		Integer price = roomBean.getPrice();
		RoomBean rbi = rService.findByroomId(roomId);
		RoomBean rbn = rService.findByname(name);
		if (roomId == null || name.equals("")) {
			return "redirect:/admin/room/backstage";
		} else if (type.equals("") || price == null) {
			return "redirect:/admin/room/backstage";

		} else if (rbi != null) {
			if (rbi.getId() == Id) {
				if (rbn != null) {
					if (rbn.getId() == Id) {
						List<RoomPhotoBean> photoBean = rpService.findByFk(Id);
						rService.create(roomBean);
						for (MultipartFile photo : files) {

							if (!photo.isEmpty()) {
								String pathImg = request.getServletContext().getRealPath(photoFile);
								for (RoomPhotoBean ph : photoBean) {
									File file = new File(pathImg + "/" + ph.getPhotoFile());
									System.out.println(file);
									if (file.exists()) {
										file.delete();
									}
								}
								String nameImg = Id + "." + photo.getOriginalFilename();
								RoomPhotoBean roomPhotoBean = new RoomPhotoBean();
								roomPhotoBean.setRoomBean(roomBean);
								roomPhotoBean.setPhotoFile(nameImg);

								rpService.saveImg(roomPhotoBean);

								String photoFilePath = request.getServletContext().getRealPath(photoFile);
								File roomImg = new File(photoFilePath);
								if (!roomImg.isDirectory())
									roomImg.mkdirs();

								Path path = Paths.get(photoFilePath, nameImg);
								Files.write(path, photo.getBytes());
							} else {
								for (RoomPhotoBean ph : photoBean) {
									String pp = ph.getPhotoFile();
									RoomPhotoBean roomPhotoBean = new RoomPhotoBean();
									roomPhotoBean.setRoomBean(roomBean);
									roomPhotoBean.setPhotoFile(pp);

									rpService.saveImg(roomPhotoBean);
								}
							}
						}

						return "redirect:/admin/room/backstage";

					} else {

						return "redirect:/admin/room/backstage";
					}
				}
				List<RoomPhotoBean> photoBean = rpService.findByFk(Id);
				rService.create(roomBean);


		for (MultipartFile photo : files) {

					if (!photo.isEmpty()) {
						String pathImg = request.getServletContext().getRealPath(photoFile);
						for (RoomPhotoBean ph : photoBean) {
							File file = new File(pathImg + "/" + ph.getPhotoFile());
							System.out.println(file);
							if (file.exists()) {
								file.delete();
							}
						}
						String nameImg = Id + "." + photo.getOriginalFilename();
						RoomPhotoBean roomPhotoBean = new RoomPhotoBean();
						roomPhotoBean.setRoomBean(roomBean);
						roomPhotoBean.setPhotoFile(nameImg);

						rpService.saveImg(roomPhotoBean);

						String photoFilePath = request.getServletContext().getRealPath(photoFile);
						File roomImg = new File(photoFilePath);
						if (!roomImg.isDirectory())
							roomImg.mkdirs();

						Path path = Paths.get(photoFilePath, nameImg);
						Files.write(path, photo.getBytes());
					} else {
						for (RoomPhotoBean ph : photoBean) {
							String pp = ph.getPhotoFile();
							RoomPhotoBean roomPhotoBean = new RoomPhotoBean();
							roomPhotoBean.setRoomBean(roomBean);
							roomPhotoBean.setPhotoFile(pp);

							rpService.saveImg(roomPhotoBean);
						}
					}
				}

				return "redirect:/admin/room/backstage";
			} else {

				return "redirect:/admin/room/backstage";
			}

		} else if (rbn != null) {
			if (rbn.getId() == Id) {
				List<RoomPhotoBean> photoBean = rpService.findByFk(Id);
				rService.create(roomBean);


				for (MultipartFile photo : files) {

					if (!photo.isEmpty()) {
						String pathImg = request.getServletContext().getRealPath(photoFile);
						for (RoomPhotoBean ph : photoBean) {
							File file = new File(pathImg + "/" + ph.getPhotoFile());
							System.out.println(file);
							if (file.exists()) {
								file.delete();
							}
						}
						String nameImg = Id + "." + photo.getOriginalFilename();
						RoomPhotoBean roomPhotoBean = new RoomPhotoBean();
						roomPhotoBean.setRoomBean(roomBean);
						roomPhotoBean.setPhotoFile(nameImg);

						rpService.saveImg(roomPhotoBean);

						String photoFilePath = request.getServletContext().getRealPath(photoFile);
						File roomImg = new File(photoFilePath);
						if (!roomImg.isDirectory())
							roomImg.mkdirs();

						Path path = Paths.get(photoFilePath, nameImg);
						Files.write(path, photo.getBytes());
					} else {
						for (RoomPhotoBean ph : photoBean) {
							String pp = ph.getPhotoFile();
							RoomPhotoBean roomPhotoBean = new RoomPhotoBean();
							roomPhotoBean.setRoomBean(roomBean);
							roomPhotoBean.setPhotoFile(pp);

							rpService.saveImg(roomPhotoBean);
						}
					}
				}

				return "redirect:/admin/room/backstage";

			} else {

				return "redirect:/admin/room/backstage";
			}
		} else {

			List<RoomPhotoBean> photoBean = rpService.findByFk(Id);
			rService.create(roomBean);


			for (MultipartFile photo : files) {

				if (!photo.isEmpty()) {
					String pathImg = request.getServletContext().getRealPath(photoFile);
					for (RoomPhotoBean ph : photoBean) {
						File file = new File(pathImg + "/" + ph.getPhotoFile());
						System.out.println(file);
						if (file.exists()) {
							file.delete();
						}
					}
					String nameImg = Id + "." + photo.getOriginalFilename();
					RoomPhotoBean roomPhotoBean = new RoomPhotoBean();
					roomPhotoBean.setRoomBean(roomBean);
					roomPhotoBean.setPhotoFile(nameImg);

					rpService.saveImg(roomPhotoBean);

					String photoFilePath = request.getServletContext().getRealPath(photoFile);
					File roomImg = new File(photoFilePath);
					if (!roomImg.isDirectory())
						roomImg.mkdirs();

					Path path = Paths.get(photoFilePath, nameImg);
					Files.write(path, photo.getBytes());
				} else {
					for (RoomPhotoBean ph : photoBean) {
						String pp = ph.getPhotoFile();
						RoomPhotoBean roomPhotoBean = new RoomPhotoBean();
						roomPhotoBean.setRoomBean(roomBean);
						roomPhotoBean.setPhotoFile(pp);

						rpService.saveImg(roomPhotoBean);
					}
				}
			}

			return "redirect:/admin/room/backstage";

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
