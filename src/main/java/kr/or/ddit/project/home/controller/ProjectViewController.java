package kr.or.ddit.project.home.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.commons.api.service.PapagoService;
import kr.or.ddit.commons.api.vo.PapagoVO;
import kr.or.ddit.project.sidemenu.service.MemoService;
import kr.or.ddit.project.sidemenu.vo.MemoVO;
import kr.or.ddit.ui.PaginationRenderer;
import kr.or.ddit.vo.PagingVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 
 *<pre>
 *
 *</pre>
 * 프로젝트 메인 페이지 컨트롤러
 * @author 이찬영
 * @since 2023. 2. 3.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2023. 2. 3.      이찬영       메모장 상세정보 수정중..
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */
@Slf4j
@Controller
@RequestMapping("/project")
public class ProjectViewController {
	
	@Inject
	PapagoService PapagoService;
	
	@Resource(name="bootstrapPaginationRender")
	private PaginationRenderer renderer;
	
	@Inject
	private MemoService MemoService;
	
	@GetMapping("/pmsIndex")
	public String pmsView() {
		return "pmsIndex";
	}
	// 메모 리스트 
	@ResponseBody
	@GetMapping("/memoList")
	public List memoList(
			Principal principal
			) {
		log.info("principal : {}",principal.getName());
		List<MemoVO> list = MemoService.retrieveMemoList(principal.getName());
		log.info("list : {}",list);
		return list;
	}
	
	// 메모 검색 리스트 
	@ResponseBody
	@PostMapping(value="/memoSearch")
	public List memoSelectList(
		@RequestBody Map<String, String> map	
		,Model model
		,Principal principal
			) {
		log.info("searchOption : " + map.get("searchOption"));
	    log.info("searchWord :" + map.get("searchWord"));
	    map.put("memEmail", principal.getName());
	    log.info("map :" + map);
	    
	    List<MemoVO> list =  MemoService.retrieveMemoSelectList(map);
		return list;
		
		
	
	}
	
	// 메모 상세조회
	@GetMapping(value="/memoDetail/{memoNo}",produces="application/json;charset=utf-8")
	@ResponseBody
	public MemoVO memoDetail(
		@PathVariable("memoNo")int memoNo
		,Model model) {
		
		log.info("메모상세조회왔다.");
		MemoVO memo = MemoService.retrieveMemo(memoNo);
		model.addAttribute("memo",memo);
		
		return memo;
		
	}
	
	// 메모 등록
	@PostMapping(value="/memoInsert",produces="application/json;charset=utf-8")
	public String memoInsert(
		@ModelAttribute("memo") MemoVO memoVO
		,Model model
		) {
		log.info("등록 컨트롤러 들어옴");
		log.info("memoVO : {}",memoVO);
		String viewName = "";
		int result = MemoService.createMemo(memoVO);
		log.info("result : {}",result);
		if(result > 0) {
			viewName = "redirect:/project/memoList";
		}
		else {
			model.addAttribute("message","서버 오류, 쫌다 다시");
			
		}
		return viewName;
	}
	
	//메모 수정
	@PostMapping("/memoUpdate/{memoNo}")
	public String memoUpdate(
		@PathVariable int memoNo	
		,@ModelAttribute MemoVO memoVO
		,Model model
			) {
		log.info("memoUpdate 왔다");
		int result = MemoService.modifyMemo(memoVO);
		System.out.println("result "+result);
		
		if(result > 0) {
			return "redirect:/project/memoList";
		}
		else {
			model.addAttribute("message","서버 오류, 쫌다 다시");
			return "redirect:/pms/myproject/projectList";
			
		}
		
	}
	
	// 메모 삭제
	@ResponseBody
	@PostMapping(value="/memoDelete/{memoNo}")
	public Map<String, String> memoDelete(
		@PathVariable int memoNo
		,@RequestBody MemoVO memoVO
		,Model model
		) {
		memoVO.setMemoNo(memoNo);
		
		Map<String, String> map = new HashMap<String, String>();
		
		int result = MemoService.removeMemo(memoNo);
		
		if(result > 0) {
			map.put("result",result+"");
			return map;
		}
		else {
			model.addAttribute("message","서버 오류, 쫌다 다시");
			map.put("result",model+"");
		}
		return map;
		
	}
	
	// 중국어 번역
	@GetMapping(value="/chinese",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public String Chinese(
			PapagoVO vo
			,@RequestParam(value = "english", defaultValue = "-") String english
			,@RequestParam(value = "korean", defaultValue = "-") String korean, Model model)
					throws Exception {
		log.info("english : {}",english);
		vo.setKorean(korean);
		vo.setEnglish(english);
		
		if(korean != null && english.equals("-")) {
			String china = PapagoService.koGetChinese(vo);
			china = china.substring(china.indexOf("{"));
			log.info("한국어대상 : {}",china);
			return china;
		}
		else if(english != null && korean.equals("-")) {
			String china = PapagoService.enGetChinese(vo);
			china = china.substring(china.indexOf("{"));
			log.info("영어대상 : {}",china);
			return china;
		}
		return null;
		
	}
	
	// 영어 번역
	@GetMapping("/english")
	@ResponseBody
	public String English(
			PapagoVO vo
			,@RequestParam(value = "english", defaultValue = "-") String english
			,@RequestParam(value = "korean", defaultValue = "-") String korean, Model model)
					throws Exception {
		vo.setKorean(korean);
		vo.setEnglish(english);
		
		if(korean != null && english.equals("-")) {
			String getEnglish = PapagoService.koGetEnglish(vo);
			getEnglish = getEnglish.substring(getEnglish.indexOf("{"));
			log.info("한국어대상 : {}",getEnglish);
			return getEnglish;
		}
		return null;
		
	}
	
	// 일본어 번역
	@GetMapping(value="/japanese",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public String japanese(
			PapagoVO vo
			,@RequestParam(value = "english", defaultValue = "-") String english
			,@RequestParam(value = "korean", defaultValue = "-") String korean, Model model)
					throws Exception {
		vo.setKorean(korean);
		vo.setEnglish(english);
		if(korean != null && english.equals("-")) {
			String china = PapagoService.koGetJapanes(vo);
			china = china.substring(china.indexOf("{"));
			log.info("한국어대상 : {}",china);
			return china;
		}
		else if(english != null && korean.equals("-")) {
			String china = PapagoService.enGetJapanes(vo);
			china = china.substring(china.indexOf("{"));
			log.info("영어대상 : {}",china);
			return china;
		}
		return null;
	}
	
	// 한국어 번역
	@GetMapping(value="/korean",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public String korean(
			PapagoVO vo
			,@RequestParam(value = "english", defaultValue = "-") String korean, Model model)
					throws Exception {
		vo.setKorean(korean);
		String korea = PapagoService.enGetKorea(vo);
		korea = korea.substring(korea.indexOf("{"));
		log.info("english : {}",korea);
		return korea;
	}
	
	
}
