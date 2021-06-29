package proj21_movie.service;

import java.util.List;

import org.springframework.stereotype.Service;

import proj21_movie.dto.Notice;

@Service
public interface NoticeService {
	
	List<Notice> showNoticeList();
	List<Notice> showNoticeListByPage(String notTitle, int selectPage); // 파라미터가 더 필요할 듯.
	List<Notice> showNoticeByTitle(String notTitle, int selectPage); // 제목 검색. 아직 구현안함.
	
	Notice showNoticeDetail(int notNo);
	
	int getNumberOfNotices(String notTitle);
	
	int removeNotice(int notNo);
	int modifyNotice(Notice notice);
	int registerNotice(Notice notice);
	
}
