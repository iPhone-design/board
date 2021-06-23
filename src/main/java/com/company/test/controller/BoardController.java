package com.company.test.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.company.test.servie.BoardService;

@Controller
public class BoardController {
	@Resource(name = "service")
	private BoardService boardService;

	@RequestMapping("list")
	public String list(@RequestParam Map<String, Object> map, Model model) {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		list = boardService.list(map);

		Map<String, Object> pageMap = boardService.pageMap(map);

		model.addAttribute("list", list);
		model.addAttribute("dateMap", map);
		model.addAttribute("pageMap", pageMap);

		return "list";
	}

	@RequestMapping("write")
	public String write() {
		return "write";
	}


	private static final String FILEPATH = "C:/Users/dev/Desktop/spring/board/src/main/webapp/resources/image/";
	@RequestMapping("insert")
	public String insert(@RequestParam Map<String, Object> map, MultipartHttpServletRequest mRequest)
			throws IllegalStateException, IOException {

		int seq = boardService.seq();
		map.put("seq", seq);

		Iterator<String> iterator = mRequest.getFileNames(); // 단일 업로드 input

		File file = new File(FILEPATH);
		if (file.exists() == false) {
			file.mkdirs();
		}

		while (iterator.hasNext()) {
			MultipartFile mFile = mRequest.getFile(iterator.next());
			if (mFile.getSize() > 0) {
				UUID one = UUID.randomUUID();
				String realName = mFile.getOriginalFilename();
				String saveName = one + "_" + mFile.getOriginalFilename();

				Map<String, Object> uploadMap = new HashMap<String, Object>();
				uploadMap.put("realName", realName);
				uploadMap.put("saveName", saveName);
				uploadMap.put("savePath", FILEPATH);
				uploadMap.put("seq", seq);
				mFile.transferTo(new File(FILEPATH + saveName));
				int fileInsert = boardService.upload(uploadMap);
			}
		}

		int insert = boardService.insert(map);

		return "redirect:list";
	}

//		forward:list;
	@RequestMapping("detail")
	public String update(@RequestParam("seq") int seq, Model model) {
		boardService.viewCntAdd(seq);
		Map<String, Object> rowList = new HashMap<String, Object>();
		List<Map<String, Object>> fileList = new ArrayList<Map<String, Object>>();
		rowList = boardService.readByRom(seq);
		fileList = boardService.readByFile(seq);
		model.addAttribute("rowList", rowList);
		model.addAttribute("fileList", fileList);
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

	@RequestMapping("ajax")
	public String ajax(@RequestParam Map<String, Object> map, Model model) {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		list = boardService.list(map);

		Map<String, Object> pageMap = boardService.pageMap(map);

		model.addAttribute("list", list);
		model.addAttribute("dateMap", map);
		model.addAttribute("pageMap", pageMap);

		return "ajaxView";
	}
	@RequestMapping("downLoad")
	public void fileDown(@RequestParam String saveName, @RequestParam String realName, HttpServletResponse response) throws Exception {
		// 파일을 저장했던 위치에서 첨부파일을 읽어 byte[]형식으로 변환한다.
		byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File("C:/Users/dev/Desktop/spring/board/src/main/webapp/resources/image/" + saveName));

		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(realName, "UTF-8") + "\";");
		response.getOutputStream().write(fileByte);
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}

	@RequestMapping("excel")
	public String excel(@RequestParam Map<String, Object> map, HttpServletResponse response, Model model) throws IOException {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		list = boardService.excel(map);
		model.addAttribute("list", list);
		return "excelView3";
	}
}
