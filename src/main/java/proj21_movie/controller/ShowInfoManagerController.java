package proj21_movie.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ShowInfoManagerController {
	
	@RequestMapping("/showInfoManager")
	public String showInfoList() {
		return "manager/showInfoList";
	}
}
