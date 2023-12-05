package kr.or.ddit.project.home.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.project.attach.service.AttatchService;
import kr.or.ddit.project.home.dao.ProjectDAO;
import kr.or.ddit.project.home.vo.ParticipateVO;
import kr.or.ddit.project.home.vo.ProjectVO;
import kr.or.ddit.vo.PagingVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ProjectServiceImpl implements ProjectService {
	
	@Inject
	private ProjectDAO projectDAO;
	@Inject
	private AttatchService attService;

	@Override
	public ProjectVO retrieveProject(String proCode) {
		ProjectVO project = projectDAO.selectProject(proCode);
		return project;
	}

	@Override
	public List<ProjectVO> retrieveProjectListAll(PagingVO<ProjectVO> pagingVO) {
		int totalRecord = projectDAO.selectTotalRecord(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<ProjectVO> projectList = projectDAO.selectProjectListAll(pagingVO);
		pagingVO.setDataList(projectList);
		
		return projectList;
	}

	@Override
	public List<ProjectVO> retrieveMyProjectListAll(String memEmail) {
		List<ProjectVO> projectList = projectDAO.selectMyProjectListAll(memEmail);
		return projectList;
	}
	
	@Override
	public List<ProjectVO> retrieveMyProjectSelectList(String memEmail, Map<String, String> map) {
		List<ProjectVO> projectList = projectDAO.selectMyProjectSelectList(memEmail, map);
		return projectList;
	}

	@Override
	public ServiceResult createProject(ProjectVO project) {
		ServiceResult result = null;
		int rowcnt = projectDAO.insertProject(project);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}
	
	@Override
	public ServiceResult createProjectParticipate(ParticipateVO participate) {
		ServiceResult result = null;
		int rowcnt = projectDAO.insertProjectParticipate(participate);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	@Override
	public ServiceResult modifyProject(ProjectVO project) {
		ServiceResult result = null;
		int rowcnt = projectDAO.updateProject(project);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	@Override
	public ServiceResult removeProject(ProjectVO project) {
		ServiceResult result = null;
		log.info("여기까지 오나여 {}1", project);
		int rowcnt = projectDAO.deleteProject(project);
		log.info("여기까지 오나여 {}", rowcnt);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	@Override
	public List<ProjectVO> retrieveProjectParticipateList(String memEmail) {
		List<ProjectVO> projectList = projectDAO.selectProjectParticipateList(memEmail);
		return projectList;
	}

	@Override
	public ServiceResult modifyProjectParticipate(ParticipateVO participate) {
		ServiceResult result = null;
		int rowcnt = projectDAO.updateProjectParticipate(participate);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	@Override
	public List<ParticipateVO> retrieveProMemList(String proCode) {
		List<ParticipateVO> memList = projectDAO.selectProMemList(proCode);
		return memList;
	}

	@Override
	public ServiceResult modifyProjectFavorites(ParticipateVO participate) {
		ServiceResult result = null;
		if(participate.getProFavorites().equals("0")) {
			participate.setProFavorites("1");
		}else {
			participate.setProFavorites("0");
		}
		int rowcnt = projectDAO.updateProjectFavorites(participate);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	@Override
	public List<ProjectVO> retrieveMyProjectFavoritesListAll(String memEmail) {
		List<ProjectVO> projectList = projectDAO.selectMyProjectFavoritesListAll(memEmail);
		return projectList;
	}

	@Override
	public int modifyProAttNo(ProjectVO project) {
		MultipartFile[] files = project.getFiles();
		if(files!=null && files.length > 0) {
			int proAttNo = attService.createAttatch(files,"projectfileImg");
			project.setProAttNo(proAttNo);
		} 
		log.info("project123123{}", project);
		return projectDAO.updateProAttNo(project);
	}

	@Override
	public List<ProjectVO> retrieveProjectRefuseList(String memEmail) {
		List<ProjectVO> projectList = projectDAO.selectProjectRefuseList(memEmail);
		return projectList;
	}

	@Override
	public List<ProjectVO> retrieveDeleteProjectListAll(PagingVO<ProjectVO> pagingVO) {
		int totalRecord = projectDAO.selectTotalRecord(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<ProjectVO> projectList = projectDAO.selectDeleteProjectListAll(pagingVO);
		pagingVO.setDataList(projectList);
		
		return projectList;
	}

	@Override
	public ServiceResult removeRecoverProject(ProjectVO project) {
		ServiceResult result = null;
		int rowcnt = projectDAO.deleteRecoverProject(project);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}







}
