package com.kh.dpr.board.model.service;

import java.util.List;
import java.util.Map;

import com.kh.dpr.product.model.vo.Product;

public interface ProductService {


   List<Product> selectProductList(int cPage, int numPerPage);

   int selectProductTotalContents();

   List<Product> selectList(int maxpage);

	List<Product> selectListTop(int maxpage);

	List<Map<String, String>> selectTopList(int cPage, int numPerPage);

	List<Map<String, String>> selectKnitList(int cPage, int numPerPage);

	List<Map<String, String>> selectJacketList(int cPage, int numPerPage);

	List<Map<String, String>> selectSearchList(int cPage, int numPerPage, String sresult);

	String selectImage(int productNo);

	
	
	
}

