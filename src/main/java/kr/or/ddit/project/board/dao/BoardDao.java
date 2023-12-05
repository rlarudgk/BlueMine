package kr.or.ddit.project.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.project.board.vo.BoardCommVO;
import kr.or.ddit.project.board.vo.BoardVO;
import kr.or.ddit.project.news.vo.NewsCommVO;

/**
 * BoardDao
 * @author 이수현
 * @since 2023. 3. 3.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2023. 3. 3.       PC-       최초작성 
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */

@Mapper
public interface BoardDao {
	
	/**
	 * 게시판 목록 조회 
	 * @param
	 * @return
	 */
	public List<BoardVO> selectBoardList(@Param("proCode") String proCode);
	
	/**
	 * 게시판 상세 조회
	 * @param boardNo
	 * @return
	 */
	public BoardVO selectBoard(int boardNo);
	
	/**
	 * 게시글 작성
	 * @param boardNo
	 * @return
	 * <insert id="insertBoard" parameterType="BoardVO">
	 */
	public int insertBoard(BoardVO boardVO);
	
	/**
	 * 게시글 수정
	 * @param boardNo
	 * @return
	 */
	public int updateBoard(BoardVO boardVO);
	
	/**
	 * 게시글 삭제 
	 * @param boardNo
	 * @return
	 */
	public int deleteBoard(int boardNo);
	
	/**
	 * 조회수 증가
	 * @param boardNo
	 */
	public void incrementHit(int boardNo);
	
	/**
	 * 게시판 댓글 목록 조회
	 * @param boardCommVO
	 * @return
	 */
	public List<BoardCommVO> selectBoardCommList(int boardNo);
	
	/**
	 * 게시판 검색 목록 조회
	 * @param map
	 * @return
	 */
	public List<BoardVO> selectBoardSearchList(Map<String, String> map);

	/**
	 * 게시판 댓글 생성
	 * @param boardCommVO
	 * @return
	 */
	public int insertBoardComm(BoardCommVO boardCommVO);
	
	/**
	 * 게시판 댓글 수정
	 * @param boardNo
	 * @return
	 */
	public int updateBoardComm(BoardCommVO boardCommVO);
	
	/**
	 * 게시판 댓글 삭제 
	 * @param boardNo
	 * @return
	 */
	public int deleteBoardComm(int boardCommNo);
	
	
}