package com.kh.dpr.board.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.dpr.product.model.vo.Product;

public interface ProductDAO {


   List<Product> selectProductList(int cPage, int numPerPage);

   int selectProductTotalContents();

   List<Product> seletList(int maxpage);

   List<Product> seletListTop(int maxpage);

   List<Map<String, String>> selectTopList(int cPage, int numPerPage);

   List<Map<String, String>> seletKnitList(int cPage, int numPerPage);

   List<Map<String, String>> selectJacketList(int cPage, int numPerPage);

   List<Map<String, String>> selectSearchList(int cPage, int numPerPage, String sresult);

   String selectImage(int productNo);


}

