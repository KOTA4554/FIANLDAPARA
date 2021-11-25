package com.kh.dpr.seller.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.dpr.order.model.vo.Delivery;
import com.kh.dpr.seller.model.vo.Seller;

@Repository
public class SellerDAO {

   @Autowired
   SqlSessionTemplate sqlSession;

   public int insertSeller(Seller seller) {
      return sqlSession.insert("sellerSQL.insertSeller", seller);
   }

   public int checkSellerDuplicate(String sellerId) {
      return sqlSession.selectOne("sellerSQL.checkSellerDuplicate",sellerId);
   }

   public Seller selectOneSeller(String sellerId) {
      return sqlSession.selectOne("sellerSQL.selectOneSeller", sellerId);
   }

   public List<Delivery> selectDelList(String sellerId, int cPage, int numPerPage) {
      RowBounds rows = new RowBounds((cPage-1)*numPerPage, numPerPage);
      return sqlSession.selectList("deliverySQL.selectDelList", sellerId, rows);
   }

   public int selectTotalOrder(String sellerId) {
      return sqlSession.selectOne("deliverySQL.selectTotalOrder", sellerId);
   }

   public int updateSeller(Seller seller) {
      return sqlSession.update("sellerSQL.updateSeller", seller);
   }

   public int deleteSeller(String sellerId) {
      return sqlSession.delete("sellerSQL.deleteSeller", sellerId);
   }
}