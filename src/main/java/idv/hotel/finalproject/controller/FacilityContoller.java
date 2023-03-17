package idv.hotel.finalproject.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

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

import idv.hotel.finalproject.model.FacilityBean;
import idv.hotel.finalproject.model.FacilityPhotoBean;
import idv.hotel.finalproject.model.RoomBean;
import idv.hotel.finalproject.model.RoomPhotoBean;
import idv.hotel.finalproject.service.FacilityPhotoService;
import idv.hotel.finalproject.service.FacilityServive;

@Controller
public class FacilityContoller {

	@Autowired
	private FacilityServive fService;

	@Autowired
	private FacilityPhotoService fPService;

	@Value("${file.upload-dir}")
	private String photoFile;

	@GetMapping("public/facility/show")
	public String findAll(Model model) {
		List<FacilityBean> beans = fService.findAll();

		model.addAttribute("facility", beans);
		return "/facility/facility";
	}

	@GetMapping("admin/facility/showBacksatge")
	public String findBackstage(Model model) {
		List<FacilityBean> beans = fService.findAll();

		model.addAttribute("facility", beans);
		return "/facility/backstageFacility";
	}

	@GetMapping("/admin/facility/create")
	public String create(Model model) {
		FacilityBean facilityBean = new FacilityBean();

		model.addAttribute("facilityBean", facilityBean);
		return "facility/addFacility";
	}

	@PostMapping("/admin/facility/add")
	public String add(@ModelAttribute("facilityBean") FacilityBean fB, @RequestParam("files") MultipartFile[] files,
			Model model, HttpServletRequest request) throws IOException {
		String name = fB.getName();
		FacilityBean fBR = fService.findByname(name);

		if (name.equals(""))
			return "facility/addFacility";
		else if (fBR != null)
			return "facility/addFacility";
		else {

			FacilityBean bean = fService.create(fB);

			for (MultipartFile photo : files) {
				if (!photo.isEmpty()) {

					Integer Id = bean.getId();
					String nameImg = Id + "." + photo.getOriginalFilename();
					FacilityPhotoBean facilityPhotoBean = new FacilityPhotoBean();
					facilityPhotoBean.setFacilityBean(bean);
					facilityPhotoBean.setPhotoFile(nameImg);

					fPService.saveImg(facilityPhotoBean);

					String photoFilePath = request.getServletContext().getRealPath(photoFile);
					File facilityImg = new File(photoFilePath);
					if (!facilityImg.isDirectory())
						facilityImg.mkdirs();

					Path path = Paths.get(photoFilePath, nameImg);
					Files.write(path, photo.getBytes());
				}
			}
			return "redirect:/admin/facility/showBacksatge";
		}
	}

	@GetMapping("/admin/facility/addCheckNamne")
	@ResponseBody
	public String findName(@RequestParam String name) {
		FacilityBean fBR = fService.findByname(name);
		if (fBR == null) {
			return "";
		} else {
			return "此名稱已存在";
		}
	}

	@GetMapping("admin/facility/edit")
	public String edit(@RequestParam("id1") Integer id, Model model) {
		FacilityBean facilityBean = fService.find(id);
		model.addAttribute("facilityBean", facilityBean);
		return "facility/editFacility";
	}

	@PutMapping("admin/facility/update")
	public String update(@ModelAttribute("roomBean") FacilityBean fB, @RequestParam("files") MultipartFile[] files,
			Model model, HttpServletRequest request) throws IOException {
		Integer Id = fB.getId();
		String name = fB.getName();
		FacilityBean fBR = fService.findByname(name);

		if (name.equals(""))
			return "redirect:/admin/facility/showBacksatge";
		else if (fBR != null) {
			if (fBR.getId() == Id) {
				List<FacilityPhotoBean> photoBean = fPService.findByFk(Id);
				fService.create(fB);

				for (MultipartFile photo : files) {

					if (!photo.isEmpty()) {
						String pathImg = request.getServletContext().getRealPath(photoFile);
						for (FacilityPhotoBean ph : photoBean) {
							File file = new File(pathImg + "/" + ph.getPhotoFile());
							System.out.println(file);
							if (file.exists()) {
								file.delete();
							}
						}
						String nameImg = Id + "." + photo.getOriginalFilename();
						FacilityPhotoBean facilityPhotoBean = new FacilityPhotoBean();
						facilityPhotoBean.setFacilityBean(fB);
						facilityPhotoBean.setPhotoFile(nameImg);

						fPService.saveImg(facilityPhotoBean);

						String photoFilePath = request.getServletContext().getRealPath(photoFile);
						File facilityImg = new File(photoFilePath);
						if (!facilityImg.isDirectory())
							facilityImg.mkdirs();

						Path path = Paths.get(photoFilePath, nameImg);
						Files.write(path, photo.getBytes());
					} else {
						for (FacilityPhotoBean ph : photoBean) {
							String pp = ph.getPhotoFile();
							FacilityPhotoBean facilityPhotoBean = new FacilityPhotoBean();
							facilityPhotoBean.setFacilityBean(fB);
							facilityPhotoBean.setPhotoFile(pp);

							fPService.saveImg(facilityPhotoBean);
						}
					}
				}
				return "redirect:/admin/facility/showBacksatge";
			} else {
				return "redirect:/admin/facility/showBacksatge";
			}
		} else {
			List<FacilityPhotoBean> photoBean = fPService.findByFk(Id);
			fService.create(fB);

			for (MultipartFile photo : files) {

				if (!photo.isEmpty()) {
					String pathImg = request.getServletContext().getRealPath(photoFile);
					for (FacilityPhotoBean ph : photoBean) {
						File file = new File(pathImg + "/" + ph.getPhotoFile());
						System.out.println(file);
						if (file.exists()) {
							file.delete();
						}
					}
					String nameImg = Id + "." + photo.getOriginalFilename();
					FacilityPhotoBean facilityPhotoBean = new FacilityPhotoBean();
					facilityPhotoBean.setFacilityBean(fB);
					facilityPhotoBean.setPhotoFile(nameImg);

					fPService.saveImg(facilityPhotoBean);

					String photoFilePath = request.getServletContext().getRealPath(photoFile);
					File facilityImg = new File(photoFilePath);
					if (!facilityImg.isDirectory())
						facilityImg.mkdirs();

					Path path = Paths.get(photoFilePath, nameImg);
					Files.write(path, photo.getBytes());
				} else {
					for (FacilityPhotoBean ph : photoBean) {
						String pp = ph.getPhotoFile();
						FacilityPhotoBean facilityPhotoBean = new FacilityPhotoBean();
						facilityPhotoBean.setFacilityBean(fB);
						facilityPhotoBean.setPhotoFile(pp);

						fPService.saveImg(facilityPhotoBean);
					}
				}
			}
			return "redirect:/admin/facility/showBacksatge";
		}
	}

	@GetMapping("/admin/facility/updataCheckNamne")
	@ResponseBody
	public String updataFindName(@RequestParam String name, @RequestParam Integer Id) {
		FacilityBean fBR = fService.findByname(name);
		System.out.println(Id);
		if (fBR != null) {
			if (fBR.getId() == Id) {

				return "";
			} else {

				return "此名稱已存在";
			}
		} else {
			return "";
		}
	}

	@DeleteMapping("admin/facility/delete")
	public String delete(@RequestParam Integer id, HttpServletRequest request) {

		String path = request.getServletContext().getRealPath(photoFile);
		FacilityBean facilityBean = fService.find(id);
		List<FacilityPhotoBean> images = facilityBean.getFacilityPhotoBeans();
		for (FacilityPhotoBean image : images) {
			File file = new File(path + "/" + image.getPhotoFile());
			if (file.exists()) {
				file.delete();
			}
		}
		fService.delete(id);
		return "redirect:/admin/facility/showBacksatge";
	}
}
