package kr.or.ddit.member.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.member.service.MemberService;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.project.attach.service.AttatchService;
import kr.or.ddit.validate.InsertGroup;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member")
public class MemberController {
	@Inject
	private MemberService service;
	@Inject
	private PasswordEncoder encoder;
	
	@ModelAttribute("member")
	public MemberVO member() {
		return new MemberVO();
	}
	
	// 회원가입 폼
	@GetMapping("/join")
	public String joinMember() {
		return "member/join";
	}
	
	// 이메일 중복 체크
	@PostMapping("/emailCheck")
	@ResponseBody
    public int idcheck(@RequestBody String memEmail) {
        int cnt = 0;
        cnt = service.emailCheck(memEmail);
        return cnt;
    }
	// 이메일 인증 여부
	@PostMapping("/emailAuth")
	@ResponseBody
	public Integer emailAuth(@RequestBody String memEmail) {
		log.info("받은 메일 : {}",memEmail);
		Integer auth = service.emailAuth(memEmail);
		log.info("받은 auth : {}",auth);
		return auth;
	}
	
	// 이메일 인증 등록
	@GetMapping("/registerEmail")
	public String emailConfirm(MemberVO member)throws Exception{
	    service.updateMailAuth(member);
	    return "member/emailAuthSuccess";
	}
	
	@GetMapping("/mypageList")
	public String mypageList() {
		return "pms/mypage/mypageList";
	}
	
	@GetMapping("/mypageDetail")
	public String mypageDetail() {
		return "pms/mypage/mypageDetail";
	}
	
	// 프로필 사진 업로드
	@ResponseBody
	@PostMapping(value = "/imgUpload")
	public int imgUpload(
		MemberVO member
	) {
		MultipartFile[] files = member.getFiles();
		MultipartFile file = files[0];
		if(file.isEmpty()) return 0;
		int cnt = service.modifyMemAttNo(member);
		return cnt; 
	}
	 
	// 멤버 선택적 업데이트
	@ResponseBody
	@PostMapping(value = "/memberSomeUpdate")
	public ServiceResult statusUpdate(
			Principal principal
			,MemberVO member
			) {
		log.info("멤버에 입력 받은 값 : {}",member);
		member.setMemEmail(principal.getName());
		ServiceResult result = service.modifySomeThing(member);
		log.info("ServiceResult{}", result);
		return result; 
	}
	
	@PostMapping("/memberInsert")
	public String memberInsert(
		HttpServletRequest req 
		, @Validated(InsertGroup.class) @ModelAttribute("member") MemberVO member
		, Errors errors
	) throws Exception{
		
		boolean valid = !errors.hasErrors();
		log.info("{}",valid);
		String viewName = null;
		
		if(true) {
			ServiceResult result = service.createMember(member);
			switch (result) {
			case PKDUPLICATED:
				req.setAttribute("message", "아이디가 중복됩니다.");
				viewName = "member/join";
				break;
			case FAIL:
				req.setAttribute("message", "서버 오류 발생! 다시 시도해 주세요.");
				viewName = "member/join";
				break;

			default:
				viewName = "redirect:/";
				break;
			}
		}else {
			viewName = "member/join";
		}
		return viewName;
	}
	
	@PostMapping("/memberUpdate")
	public String memberUpdate(
			MemberVO member
			,Principal principal
			,RedirectAttributes rttr
	) {
		MemberVO oriMember = service.retrieveMember(member.getMemEmail());
		String newPass = member.getMemPass();
		String oriPass = oriMember.getMemPass();
		boolean matches = encoder.matches(newPass, oriPass);
		if(!matches) {
			rttr.addFlashAttribute("message", "비밀번호를 다시 확인해 주세요.");
			return "redirect:/member/mypageList";
		}
		ServiceResult result = service.modifyMember(member);
		String viewName = null;
		switch (result) {
		case FAIL:
			rttr.addFlashAttribute("message", "서버 오류 발생! 다시 시도해 주세요.");
			viewName = "redirect:/member/mypageList";
			break;

		default:
			rttr.addFlashAttribute("message", "회원 정보 수정 성공!");
			viewName = "redirect:/member/mypageList";
			break;
		}
		return viewName;
	}
	
	@ResponseBody
	@GetMapping("/memberDetail")
	public MemberVO memberDetail(
			Principal principal
	) {
		String memEmail = principal.getName();
		MemberVO member = service.retrieveMember(memEmail);
		return member;
	}
	
	@ResponseBody
	@PostMapping("/memberProDetail")
	public MemberVO memberProDetail(
			Principal principal
			,@RequestBody String proCode
			) {
		log.info("멤버프로디테일 : {}",proCode);
		String memEmail = principal.getName();
		Map<String, String> proMap = new HashMap<>();
		proMap.put("proCode", proCode);
		proMap.put("memEmail", memEmail);
		
		MemberVO member = service.retrieveProjectMember(proMap);
		return member;
	}
	
}
