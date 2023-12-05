package kr.or.ddit.project.statistics.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.project.statistics.dao.StatisticDAO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/pms")
public class StatisticController {
	
	@Inject
	private StatisticDAO statisticDAO;
	
	@GetMapping("/total")
	public String statisticList() {
		return "project/statistics/adminStatistics";
	}
	
	@GetMapping("/dashBoard/{proCode}")
	@ResponseBody
	public Map<String, Object> loadAnalytics(
			@PathVariable String proCode) {
			
		List<Map<String,Object>> members = statisticDAO.selectProjectMemStatistic(proCode);
		Map<String, Object> project = statisticDAO.selectProjectStatistic(proCode);
		Map<String, Object> result = new HashMap<>();
		result.put("members", members);
		result.put("project", project);
		log.info("result : {}",result);
		return result;
	}
	
}
