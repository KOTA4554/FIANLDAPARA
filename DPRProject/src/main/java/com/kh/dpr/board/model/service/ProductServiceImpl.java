package com.kh.dpr.board.model.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.dpr.board.model.dao.ProductDAO;
import com.kh.dpr.product.model.vo.Product;

@Service
public class ProductServiceImpl implements ProductService {
   
   @Inject
   ProductDAO productDAO;

   @Override
   public List<Product> selectProductList(int cPage, int numPerPage) {
      
      return productDAO.selectProductList(cPage, numPerPage);
   }

   @Override
   public int selectProductTotalContents() {
      
      return productDAO.selectProductTotalContents();
   }

	@Override
	public List<Product> selectList(int maxpage) {
		
		return productDAO.seletList(maxpage);
	}

	@Override
	   public List<Product> selectListTop(int maxpage) {
	  
	      return productDAO.seletListTop(maxpage);
	   }

	@Override
	public List<Map<String, String>> selectTopList(int cPage, int numPerPage) {
		
		return productDAO.selectTopList(cPage,numPerPage);
	}

	@Override
	public List<Map<String, String>> selectKnitList(int cPage, int numPerPage) {
		
		return productDAO.seletKnitList(cPage,numPerPage);
	}

	@Override
	public List<Map<String, String>> selectJacketList(int cPage, int numPerPage) {

		return productDAO.selectJacketList(cPage,numPerPage);
	}

	@Override
	public List<Map<String, String>> selectSearchList(int cPage, int numPerPage, String sresult) {
		
		return productDAO.selectSearchList(cPage,numPerPage,sresult);
	}


	@Override
	public String selectImage(int productNo) {
		// TODO Auto-generated method stub
		return productDAO.selectImage(productNo);
	}
	
	
}

