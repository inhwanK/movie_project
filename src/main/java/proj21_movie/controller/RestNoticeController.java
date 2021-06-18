package proj21_movie.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import proj21_movie.dto.AttachImage;
import proj21_movie.dto.Notice;
import proj21_movie.service.NoticeService;

@RestController
@RequestMapping("/api")
public class RestNoticeController {

	@Autowired
	private NoticeService service;
	
	@GetMapping("/notice") // 리스트 전체 빼오는 건데 . 곧 삭제 예정.
	public ResponseEntity<Object> getNoticeList() {
		List<Notice> listNotice = service.showNoticeList();
		return ResponseEntity.status(HttpStatus.OK).body(listNotice); 
	}
	
	@GetMapping("/notice/{notNo}")
	public ResponseEntity<Object> getNoticeByNo(@PathVariable("notNo") int notNo) {
		Notice notice = service.showNoticeDetail(notNo);
		return ResponseEntity.status(HttpStatus.OK).body(notice);
	}
	
	@GetMapping("/noticelist/{selectPage}") //공지 페이지마다 10개씩 불러오기.
	public ResponseEntity<Object> getNoticeByPage(@PathVariable("selectPage") int selectPage) {
		List<Notice> listNotice = service.showNoticeListByPage(selectPage); // 범위 지정해야함.
		return ResponseEntity.status(HttpStatus.OK).body(listNotice);
	}
	
}