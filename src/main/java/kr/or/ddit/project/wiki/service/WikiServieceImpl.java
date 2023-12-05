package kr.or.ddit.project.wiki.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.project.attach.service.AttatchService;
import kr.or.ddit.project.wiki.dao.WikiDAO;
import kr.or.ddit.project.wiki.vo.WikiVO;
import lombok.extern.slf4j.Slf4j;
/**
 * 
 * Wiki ServiceImpl
 * @author 전혜수
 * @since 2023. 2. 20.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                  수정자               수정내용
 * --------     --------    ----------------------
 * 2023. 2. 20.      PC-21       최초작성
 * 
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */
@Slf4j
@Service
public class WikiServieceImpl implements WikiService{
	
	@Inject
	private WikiDAO wikiDAO;
	
	@Inject
	private AttatchService attService;
	
	
	
	//위키 목록 
	@Override
	public List<WikiVO> retrieveWikiList(String proCode) {
		List<WikiVO> wikiList = wikiDAO.selectWikiList(proCode); 
		return wikiList;
	}
	
	
	//위키 생성
	@Override
	public ServiceResult createWiki(WikiVO wiki) {
		
		//첨부파일 처리
		MultipartFile[] files = wiki.getFiles();
		
		log.info("files11111{}",files[0]);
		
		if(files!=null && files.length > 0) {
			
		   log.info("files22222{}",files[0]);
		   
			int wikiAttNo = attService.createAttatch(files,"wikiFile");
		    wiki.setWikiAttNo(wikiAttNo);
		}
		int rowcnt =  wikiDAO.insertWiki(wiki);
		return  rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		 
	}

	//위키 1건 조회 
	@Override
	public WikiVO retrieveWiki(WikiVO wiki) {
		WikiVO wikiVO = wikiDAO.selectWiki(wiki);
		return wikiVO;
	}

	//위키 삭제 
	@Override
	public ServiceResult deleteWiki(WikiVO wiki) {
		ServiceResult result = null; 
		int rowcnt = wikiDAO.deleteWiki(wiki);
		result = rowcnt > 0 ?ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	//위키 수정
	@Override
	public ServiceResult modifyWiki(WikiVO wiki) {
		ServiceResult result = null;
		log.info("위키서비스");
		int rowcnt = wikiDAO.updateWiki(wiki);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	//위키 분류별 정렬 
	@Override
	public List<WikiVO> retrieveWikiListSort(String proCode) {
		List<WikiVO> wikiListSort = wikiDAO.selectWikiListSort(proCode);
		return wikiListSort;
	}

	//위키 답글 생성
	@Override
	public ServiceResult createWikiComm(WikiVO wiki) {
		
		
		MultipartFile[] files = wiki.getFiles();
		if(files!=null && files.length > 0) {
		   int wikiAttNo = attService.createAttatch(files,"wikiFile");
		   wiki.setWikiAttNo(wikiAttNo);
		}
		
		ServiceResult result = null;
		int rowcnt = wikiDAO.insertWikiComm(wiki);
		result = rowcnt > 0 ?ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}


	@Override
	public List<WikiVO> retrieveWikiListOne(String proCode) {
		List<WikiVO> list = wikiDAO.selectWikiListSort1(proCode);
		return  list;
	}


	@Override
	public List<WikiVO> retrieveWikiListTwo(String proCode) {
		List<WikiVO> list = wikiDAO.selectWikiListSort2(proCode);
		return  list;
	}


	@Override
	public List<WikiVO> retrieveWikiListThree(String proCode) {
		List<WikiVO> list = wikiDAO.selectWikiListSort3(proCode);
		return  list;
	}
	
	
	

}
