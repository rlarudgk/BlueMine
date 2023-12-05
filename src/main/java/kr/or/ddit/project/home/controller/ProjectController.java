package kr.or.ddit.project.home.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

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
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.project.home.service.ProjectService;
import kr.or.ddit.project.home.vo.ParticipateVO;
import kr.or.ddit.project.home.vo.ProjectVO;
import kr.or.ddit.ui.PaginationRenderer;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.SearchVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/project")
public class ProjectController {
	
	@Resource(name="bootstrapPaginationRender")
	private PaginationRenderer renderer;
	
	@Inject
	private ProjectService service;
	
	@GetMapping("/project/Home/{proCode}")
	public String pmsProjectView(
			@PathVariable String proCode
			, Model model
			) {
		ProjectVO project = service.retrieveProject(proCode);
		model.addAttribute("project", project);
		return "project/projectHome";
	}
	
	// 프로젝트 프로필 업로드
	@ResponseBody
	@PostMapping("/project/proImgUpload")
	public int projectImgUpload(
		ProjectVO project
	) {
		MultipartFile[] files = project.getFiles();
		MultipartFile file = files[0];
		if(file.isEmpty()) return 0;
		int cnt = service.modifyProAttNo(project);
		return cnt; 
	}
	
	// 프로젝트 하나 조회
	@GetMapping("/project/projectSelect/{proCode}")
	@ResponseBody
	public ProjectVO projectSelect(
			@PathVariable String proCode
			) {
		ProjectVO project = service.retrieveProject(proCode);
		return project;
	}

	// 프로젝트 전체 목록 (검색 기능 추가), 삭제된 프로젝트 제외
	@GetMapping(value="/projectListAll", produces="application/json;charset=utf-8")
	public String projectList(
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("simpleCondition") SearchVO searchVO
			, Model model
			) {
		PagingVO<ProjectVO> pagingVO = new PagingVO<>(4, 5);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(searchVO);
		
		service.retrieveProjectListAll(pagingVO);
		model.addAttribute("pagingVO", pagingVO);
		if(!pagingVO.getDataList().isEmpty()) {
			model.addAttribute("pagingHTML", renderer.renderPagination(pagingVO));
		}

		return "jsonView";
	}
	
	// 프로젝트 전체 목록 (검색 기능 추가), 삭제된 프로젝트 제외
	@GetMapping(value="/deleteProjectListAll", produces="application/json;charset=utf-8")
	public String deleteProjectList(
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("simpleCondition") SearchVO searchVO
			, Model model
			) {
		PagingVO<ProjectVO> pagingVO = new PagingVO<>(4, 5);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(searchVO);
		
		service.retrieveDeleteProjectListAll(pagingVO);
		model.addAttribute("pagingVO", pagingVO);
		if(!pagingVO.getDataList().isEmpty()) {
			model.addAttribute("pagingHTML", renderer.renderPagination(pagingVO));
		}
		
		return "jsonView";
	}
	
	// 내 프로젝트 화면 : 왼쪽 메뉴에서 내 프로젝트 클릭 시 여기로 이동
	@GetMapping("/myProject")
	public String myProjectList(
			Principal principal
			, Model model) {
		List<ProjectVO> projectList = service.retrieveMyProjectListAll(principal.getName());
		model.addAttribute("projectList",projectList);
		return "pms/myproject/projectList";
	}
	
	// 초대받은 프로젝트 화면 
	@GetMapping("/invitedProject")
	public String invitedProjectList(
			Principal principal
			, Model model) {		
		return "pms/myproject/projectInviteList";
	}
	
	// 즐겨찾기 프로젝트 화면
//	@GetMapping("/favorites")
//	public String favoritesList() {
//		return "pms/myproject/projectFavoritesList";
//	}
	
	// 내가 즐겨찾기 한 프로젝트 목록 조회
	@GetMapping(value="/myProject/favoritesList", produces="application/json;charset=utf-8")
	@ResponseBody
	public List<ProjectVO> myProjectFavoritesList(
			Principal principal
			) {
		List<ProjectVO> projectList = service.retrieveMyProjectFavoritesListAll(principal.getName());
		log.info("projectList2323 {}",projectList);
		return projectList;
	}

	// 내 프로젝트 목록 : 전체, 시작전, 진행중, 종료된
	@GetMapping(value="/myProject/{proSelectId}", produces="application/json;charset=utf-8")
	@ResponseBody
	public List<ProjectVO> myProjectSelectList(
			Principal principal
			, @PathVariable String proSelectId
			, Model model
			) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("proSelect",proSelectId);
		List<ProjectVO> projectList = service.retrieveMyProjectSelectList(principal.getName(), map);
		log.info("전체프로젝트 리스트?? {}",projectList);
		model.addAttribute("projectList",projectList);

		return projectList;
	}
	
	// 프로젝트 참여 회원 목록(mention page)
	@GetMapping(value="/mentionMem/{proCode}")
	@ResponseBody
	public List<ParticipateVO> participateMemList(
			 @PathVariable String proCode,
			 Principal principal
			, Model model
			) {
		List<ParticipateVO> proMemList = service.retrieveProMemList(proCode);
		return proMemList;
	}
	
	// 프로젝트 생성
	@PostMapping("/projectInsert")
	public String projectInsert(
			HttpServletRequest req 
			, @ModelAttribute("project") ProjectVO project) {
		String viewName = null;
		ServiceResult result = service.createProject(project);
		
		switch(result) {
		case OK:
			req.setAttribute("message", "프로젝트 생성 성공");
			ParticipateVO participate = new ParticipateVO();
			participate.setMemEmail(project.getMemEmail());
			participate.setProCode(project.getProCode());
			participate.setPartDate(project.getProCdate());
			participate.setProRoleCd("PR001");
			ServiceResult result2 = service.createProjectParticipate(participate);
			viewName = "pms/myproject/projectList";
			break;
		case FAIL:
			req.setAttribute("message", "프로젝트 생성 실패");
			viewName = "pms/myproject/projectList";
			break;
		}
		
		return viewName;
	}
	
	// 프로젝트 수정
	@ResponseBody
	@PostMapping("/projectUpdate")
	public String projectUpdate(
			HttpServletRequest req 
			, @ModelAttribute("project") ProjectVO project) {
		log.info("projectVO2323",project);
		ServiceResult result = service.modifyProject(project);
		String resultStr = "0";
		switch(result) {
		case OK:
			log.info("OK");
			resultStr = "1";
			break;
		case FAIL:
			log.info("FAIL");
			resultStr = "0";
			break;
		}
		return resultStr;
	}
	
	// 프로젝트 즐겨찾기 수정
	@ResponseBody
	@PostMapping("/project/favoritesUpdate")
	public String projectFavoritesUpdate(
			@RequestBody ParticipateVO participate
			) {
		ServiceResult result = service.modifyProjectFavorites(participate);
		String resultStr = "0";
		switch(result) {
		case OK:
			log.info("OK");
			resultStr = "1";
			break;
		case FAIL:
			log.info("FAIL");
			resultStr = "0";
			break;
		}
		return resultStr;
	}
	
	// 프로젝트 삭제
	@ResponseBody
	@PostMapping("/project/delete")
	public String projectDelete(
			@RequestBody ProjectVO project
			) {
		log.info("project2323 {}",project);
		String resultStr = "0";
		ServiceResult result = service.removeProject(project);
		log.info("result {}",result);
		switch(result) {
		case OK:
			resultStr = "1";
			break;
		case FAIL:
			resultStr = "0";
			break;
		}
		return resultStr;
	}
	
	// 삭제된 프로젝트 복구
	@ResponseBody
	@PostMapping("/project/deleteRecover")
	public String projectDeleteRecover(
			@RequestBody ProjectVO project
			) {
		String resultStr = "0";
		ServiceResult result = service.removeRecoverProject(project);
		switch(result) {
		case OK:
			resultStr = "1";
			break;
		case FAIL:
			resultStr = "0";
			break;
		}
		return resultStr;
	}
	
	
	// 초대받은 프로젝트 목록
	@GetMapping(value="/myProject/participateList", produces="application/json;charset=utf-8")
	@ResponseBody
	public List<ProjectVO> projectProInvite(
			Principal principal
			, Model model
			) {
		List<ProjectVO> projectList = service.retrieveProjectParticipateList(principal.getName());
		model.addAttribute("projectList",projectList);
		return projectList;
	};
	
	// 초대 거절한 프로젝트 목록
	@GetMapping(value="/myProject/RefuseList", produces="application/json;charset=utf-8")
	@ResponseBody
	public List<ProjectVO> projectProRefuseList(
			Principal principal
			) {
		List<ProjectVO> projectList = service.retrieveProjectRefuseList(principal.getName());
		return projectList;
	};
	
	// 초대받은 프로젝트 수락 (Update)
	@PostMapping(value="/myProject/participateAccept")
	@ResponseBody
	public String projectParticipateAccept(
			@ModelAttribute("participate") ParticipateVO participate
			) {
		ServiceResult result = service.modifyProjectParticipate(participate);
		String resultStr = "0";
		switch(result) {
		case OK:
			log.info("OK");
			resultStr = "1";
			break;
		case FAIL:
			log.info("FAIL");
			resultStr = "0";
			break;
		}
		return resultStr;
	};
	
}
