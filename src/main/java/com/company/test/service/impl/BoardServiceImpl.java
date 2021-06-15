package com.company.test.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.company.test.dao.BoardDao;
import com.company.test.servie.BoardService;
import com.company.test.vo.Criteria;

@Service("service")
public class BoardServiceImpl implements BoardService {
	@Resource(name="dao")
	private BoardDao boardDao;
	
	@Override
	public List<Map<String, Object>> list(Map<String, Object> map) {
		int curPage = 0;
		int pageScale = 0;
		
		if(map.isEmpty()) {
			curPage = 1;
			pageScale = 10;
		}else {
			curPage = Integer.parseInt(map.get("curPage").toString()) ;
			pageScale = Integer.parseInt(map.get("pageScale").toString()) ;
		}
		
		int pageBegin = (curPage-1) * pageScale + 1;
		int pageEnd = pageBegin+pageScale - 1;
		
		map.put("pageBegin", pageBegin);
		map.put("pageEnd", pageEnd);
		
		return boardDao.list(map);
	}
	
	@Override
	public Map<String, Object> pageMap(Map<String, Object> map) {
		int count = boardDao.pageMap(map);
		
		int PAGE_SCALE = 10;
		
		int BLOCK_SCALE = 5;
		
		int curPage = map.get("curPage") == null ? 1 : Integer.parseInt(map.get("curPage").toString());
		
		int totPage = (int) Math.ceil(count * 1.0 / PAGE_SCALE);
        
        int totBlock = (int) Math.ceil(totPage / BLOCK_SCALE);
        
		 // *현재 페이지가 몇번째 페이지 블록에 속하는지 계산
        int curBlock = (int) Math.ceil((curPage - 1) / BLOCK_SCALE) + 1;
        
        // *현재 페이지 블록의 시작, 끝 번호 계산
        int blockBegin = (curBlock-1) * BLOCK_SCALE + 1;
        
        // 페이지 블록의 끝번호
        int blockEnd = blockBegin + BLOCK_SCALE - 1;
        
        // *마지막 블록이 범위를 초과하지 않도록 계산
        if(blockEnd > totPage) blockEnd = totPage;
        
        // *이전을 눌렀을 때 이동할 페이지 번호
        int prevPage = (curPage == 1) ? 1:(curBlock-1) * BLOCK_SCALE;
        
        // *다음을 눌렀을 때 이동할 페이지 번호
        int nextPage = curBlock > totBlock ? (curBlock * BLOCK_SCALE) : (curBlock * BLOCK_SCALE) + 1;
        
        // 마지막 페이지가 범위를 초과하지 않도록 처리
        if(nextPage >= totPage) nextPage = totPage;
        
        Map<String, Object> pageMap = new HashMap<String, Object>();
        pageMap.put("curBlock", curBlock);
        pageMap.put("prevPage", prevPage);
        pageMap.put("blockBegin", blockBegin);
        pageMap.put("blockEnd", blockEnd);
        pageMap.put("curPage", curPage);
        pageMap.put("totBlock", totBlock);
        pageMap.put("nextPage", nextPage);
        pageMap.put("totPage", totPage);
		
		return pageMap;
	}

	@Override
	public int insert(Map<String, Object> map) {
		return boardDao.insert(map);
	}

	@Override
	public void viewCntAdd(int seq) {
		boardDao.viewCntADD(seq);
	}

	@Override
	public Map<String, Object> readByRom(int seq) {
		return boardDao.readByRow(seq);
	}

	@Override
	public int updateRow(Map<String, Object> map) {
		return boardDao.updateRow(map);
	}

	@Override
	public int delete(List<Integer> checkedList) {
		return boardDao.delete(checkedList);
	}

}
