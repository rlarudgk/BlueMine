package kr.or.ddit.project.home.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(of="proCode")
@AllArgsConstructor
@NoArgsConstructor
public class ProjectVO implements Serializable{

//	--PRO_CODE   NOT NULL VARCHAR2(100)  
//	--MEM_NO     NOT NULL NUMBER         
//	--PRO_TITLE  NOT NULL VARCHAR2(400)  
//	--PRO_CDATE  NOT NULL VARCHAR2(8)    
//	--PRO_SDATE  NOT NULL VARCHAR2(8)    
//	--PRO_EDATE  NOT NULL VARCHAR2(8)    
//	--PRO_DETAIL NOT NULL VARCHAR2(4000) 
//	--PRO_END_YN          VARCHAR2(1)    
//	--PRO_DEL_YN          VARCHAR2(1)    
//	--PRO_CLS_CD          VARCHAR2(10)  
	
	@NotBlank
	private String proCode;
	@NotNull
	private String memEmail;
	@NotBlank
	private String proTitle;
	@NotBlank
	private String proCdate;
	@NotBlank
	private String proSdate;
	@NotBlank
	private String proEdate;
	@NotBlank
	private String proDetail;
	private String proEndYn;
	private String proDelYn;
	private String proClsCd;
	/* private String proFavorites; */
	private Integer proProgress;
	
	private String memName;
	private String memAttPath;
	
	// 프로젝트 상태 ( 시작전, 진행중, 종료된  )에 해당되는 목록을 가져오기 위한 코드
	private String proSelect;
	
	// 프로젝트 참여 회원 List 
	private List<ParticipateVO> participateMemberList;
	
	// 프로젝트 프로필 이미지
	private Integer proAttNo;
	private MultipartFile[] files;
	private String proAttPath;
	
}
