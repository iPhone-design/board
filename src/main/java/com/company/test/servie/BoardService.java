package com.company.test.servie;

import java.util.List;
import java.util.Map;


public interface BoardService {

	List<Map<String, Object>> list(Map<String, Object> map);

	int insert(Map<String, Object> map);

	void viewCntAdd(int seq);

	Map<String, Object> readByRom(int seq);

	int updateRow(Map<String, Object> map);

	int delete(List<Integer> checkedList);

	Map<String, Object> pageMap(Map<String, Object> map);

}
