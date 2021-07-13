package proj21_movie.service;

import java.util.List;

import org.springframework.stereotype.Service;
import proj21_movie.dto.Member;
import proj21_movie.dto.Withdrawal;

@Service
public interface MemberService {

	Member getMember(String memEmail);
	List<Member> getLists();

	int registerMember(Member member);
	// 회원수정
	int modifyMember(Member member);
	int removeMember(String memEmail);

	Member selectMemberBymemEmail(String memEmail);

	// 로그인
	public Member memberLogin(Member member) throws Exception;
	// 아이디 중복 검사
	public int idCheck(String memEmail) throws Exception;
	// 아이디 찾기
	public Member findId(Member member);

	/* 비밀번호 찾기(비로그인) */
	// 회원조회
	public String selectMember(Member member);
	// 패스워드 변경
	public int pwUpdate_M(Member member);
	
	// 패스워드 체크
	public Member checkPw(Member member) throws Exception;
	
	//회원정보 수정
	public void update(Member member) throws Exception;
}