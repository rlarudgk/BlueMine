package kr.or.ddit.project.statistics.vo;

import kr.or.ddit.project.sidemenu.vo.MemoVO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(of="proCode")
@AllArgsConstructor
@NoArgsConstructor
public class StatisticVO {
	
	private String proCode;
	private String proSdate;
	private String proEdate;
	private int newscount;
	private int wikicount;
	private int boardcount;
	private int workcount;
	private int isscount;
	private int memcount;
	private int isscgcount;
	private int chatroomcount;
	
	private String memEmail;
	private String partDate;
	private String proRoleCd;
	private String attSavename;
	
}
