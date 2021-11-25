
package com.kh.dpr.product.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.dpr.product.model.vo.Product;
import com.kh.dpr.product.model.vo.ProductImage;
import com.kh.dpr.qna.model.vo.QnA;
import com.kh.dpr.review.model.vo.Review;

@Repository
public class ProductDAO {

	@Autowired
	SqlSessionTemplate sqlSession;

	public int insertProduct(Product product) {
		// TODO Auto-generated method stub
		return sqlSession.update("manageSQL.insertProduct", product);
	}

	public int insertImage(ProductImage img) {
		return sqlSession.insert("manageSQL.insertImage", img);
	}

	public int selectPno() {
		return sqlSession.selectOne("manageSQL.selectPno");
	}

	public int insertTempProduct() {
		return sqlSession.insert("manageSQL.insertTempProduct");
	}

	public int selectTempProduct() {
		return sqlSession.selectOne("manageSQL.selectTempProduct");
	}

	public int insertOption(Product opt) {
		return sqlSession.insert("manageSQL.insertOption", opt);
	}

	public List<Map<String, String>> selectProductList(String sellerId, int cPage, int numPerPage) {		
		RowBounds rows = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sqlSession.selectList("manageSQL.selectProductList", sellerId, rows);
	}

	public int selectTotalProduct(String sellerId) {
		return sqlSession.selectOne("manageSQL.selectTotalProduct", sellerId);
	}

	public List<Map<String, String>> searchProductList(Map map, int cPage, int numPerPage) {
		RowBounds rows = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sqlSession.selectList("manageSQL.searchProductList", map, rows);
	}

	public int selectSearchedProduct(Map<String, Object> map) {
		return sqlSession.selectOne("manageSQL.selectSearchedProduct", map);
	}

	public Product selectOneProduct(int productNo) {
		return sqlSession.selectOne("manageSQL.selectOneProduct", productNo);
	}

	public List<Product> selectOptionList(int productNo) {
		return sqlSession.selectList("manageSQL.selectOptionList", productNo);
	}

	public List<ProductImage> selectImageList(int productNo) {
		return sqlSession.selectList("manageSQL.selectImageList", productNo);
	}

	public List<Review> selectReviewList(String sellerId) {
	      
	    return sqlSession.selectList("manageSQL.selectReviewList", sellerId);
	}

	public Product selectRproduct(int reviewNo) {
	      
		return sqlSession.selectOne("manageSQL.selectRproduct", reviewNo);
	}


	public List<Review> selectSearchReview(Map<String, Object> map) {
	      
		return sqlSession.selectList("manageSQL.selectSearchReview", map);
	}

	public List<QnA> selectQnaList(String sellerId) {
	      
		return sqlSession.selectList("manageSQL.selectQnaList", sellerId);
	}

	public Product selectQproduct(int qnaNo) {
	      
		return sqlSession.selectOne("manageSQL.selectQproduct", qnaNo);
	}

	public List<QnA> selectSearchQna(Map<String, Object> map) {
	      
		return sqlSession.selectList("manageSQL.selectSearchQna", map);
	}


	public int updateOption(Product opt) {
		return sqlSession.update("manageSQL.updateOption", opt);
	}

	public List<ProductImage> selectImage(Map<String, Integer> setting) {
		return sqlSession.selectList("manageSQL.selectImage", setting);
	}

	public int deleteImage(Map<String, Integer> setting) {
		return sqlSession.delete("manageSQL.deleteImage", setting);
	}


}

