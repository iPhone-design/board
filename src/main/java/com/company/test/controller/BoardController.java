package com.company.test.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.company.test.servie.BoardService;

@Controller
public class BoardController {
	@Resource(name="service")
	private BoardService boardService;
	
	@RequestMapping("list")
	public String list(@RequestParam Map<String, Object> map, Model model) {
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		list = boardService.list(map);
		Map<String, Object> pageMap = boardService.pageMap(map);
		 
		model.addAttribute("list", list);
		model.addAttribute("dataMap", map);
		model.addAttribute("pageMap", pageMap);
		return "list";
	}
	
	@RequestMapping("write")
	public String write() {
		return "write";
	}
	
	@RequestMapping("insert")
	public String insert(@RequestParam Map<String, Object> map) {
		int insert = boardService.insert(map);
//		forward:list;
		return "redirect:list";
	}
	
	@RequestMapping("detail")
	public String update(@RequestParam("seq") int seq, Model model) {
		boardService.viewCntAdd(seq);
		Map<String, Object> rowList = new HashMap<String, Object>();
		rowList = boardService.readByRom(seq);
		model.addAttribute("rowList", rowList);
		return "write";
	}
	
	@RequestMapping("updateRow")
	public String updateRow(@RequestParam Map<String, Object> map) {
		int updateRow = boardService.updateRow(map);
		return "redirect:list";
	}
	
	@RequestMapping("delete")
	public String delete(@RequestParam Integer[] chk) {
		List<Integer> checkedList = Arrays.asList(chk);
		int delete = boardService.delete(checkedList);
		return "redirect:list";
	}
}
