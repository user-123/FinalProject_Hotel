package idv.hotel.finalproject.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import idv.hotel.finalproject.model.HomeBean;
import idv.hotel.finalproject.service.HomeService;
import idv.hotel.finalproject.service.LoginService;
import idv.hotel.finalproject.service.MemberService;

@Controller
public class HomeController {
	@Autowired
	HomeService hService;
	@Autowired
	LoginService loginService;
	@Autowired
	MemberService memberService;
	@Autowired
	ServletContext context;

	public HomeController(MemberService memberService, LoginService loginService, ServletContext context) {
		super();
		this.loginService = loginService;
		this.memberService = memberService;
		this.context = context;
	}

	@Value("${file.upload-dir}")
	private String photoFile;

	@PostMapping("/")
	public String home(Model model) {
		HomeBean homeBean = hService.find(1);
		model.addAttribute("homeBean", homeBean);
		return "home";
	}

	@PutMapping("/admin/edit")
	public String edit(@ModelAttribute HomeBean homeBean, @RequestParam MultipartFile aboutPhotoOne,
			@RequestParam MultipartFile aboutPhotoTwo, HttpServletRequest request) throws IOException {

		if (!aboutPhotoOne.isEmpty()) {
			Integer Id = homeBean.getId();
			String nameImg = Id + "." + aboutPhotoOne.getOriginalFilename();
			homeBean.setAboutPhoto1(nameImg);

			String photoFilePath = request.getServletContext().getRealPath(photoFile);
			File roomImg = new File(photoFilePath);
			if (!roomImg.isDirectory())
				roomImg.mkdirs();

			Path path = Paths.get(photoFilePath, nameImg);
			Files.write(path, aboutPhotoOne.getBytes());
		} else {
			Integer Id = homeBean.getId();
			HomeBean hB = hService.find(Id);
			String pB = hB.getAboutPhoto1();
			homeBean.setAboutPhoto1(pB);
		}
		if (!aboutPhotoTwo.isEmpty()) {
			Integer Id = homeBean.getId();
			String nameImg = Id + "." + aboutPhotoTwo.getOriginalFilename();
			homeBean.setAboutPhoto2(nameImg);

			String photoFilePath = request.getServletContext().getRealPath(photoFile);
			File roomImg = new File(photoFilePath);
			if (!roomImg.isDirectory())
				roomImg.mkdirs();

			Path path = Paths.get(photoFilePath, nameImg);
			Files.write(path, aboutPhotoTwo.getBytes());
		} else {
			Integer Id = homeBean.getId();
			HomeBean hB = hService.find(Id);
			String pB = hB.getAboutPhoto2();
			homeBean.setAboutPhoto2(pB);
		}
//		List<HomePhotoBean> homePhotoBeans = new ArrayList<>();
//		for (MultipartFile photo : home) {
//			if (!photo.isEmpty()) {
//				Integer Id = homeBean.getId();
//				String nameImg = Id + "." + photo.getOriginalFilename();
//				HomePhotoBean photoBean = new HomePhotoBean();
//				photoBean.setIndexPhoto(nameImg);
//				photoBean.setHomeBean(homeBean);
//				homePhotoBeans.add(photoBean);
//			}
//		}
//		homeBean.setHomePhotoBeans(homePhotoBeans);
		hService.create(homeBean);
		return "redirect:/admin/backstage";
	}

	@GetMapping("/")
	public String home(HttpServletRequest request, HttpSession session) {
//		if(session.getAttribute("email")!=null) {
//			session.setAttribute("id",loginService.findIdByEmail((String)session.getAttribute("email")) );
////			session.setAttribute("lb", loginService.findById((Integer)session.getAttribute("id")));
//        	request.setAttribute("login", true);
//        }
//		return "home";

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null && auth.isAuthenticated()) {
			if (!auth.getName().equals("anonymousUser")) {
				if (loginService.findIdByEmail(auth.getName()) != null) {
					session.setAttribute("email", auth.getName());
					session.setAttribute("login", true);
					session.setAttribute("id", loginService.findIdByEmail(auth.getName()));
					session.setAttribute("lb", loginService.findById((Integer) session.getAttribute("id")));
				} else {
					return "redirect:/logout";
				}
			}
			System.out.println(session.getAttribute("email"));
		}
		return "home";
	}

	@GetMapping("/public/about")
	public String about(Model model) {
		HomeBean homeBean = hService.find(1);
		model.addAttribute("homeBean", homeBean);
		return "about";
	}

	@GetMapping("/admin/backstage")
	public String backstage(Model model) {
		HomeBean homeBean = hService.find(1);
		model.addAttribute("homeBean", homeBean);
		return "backstage";
	}

}
