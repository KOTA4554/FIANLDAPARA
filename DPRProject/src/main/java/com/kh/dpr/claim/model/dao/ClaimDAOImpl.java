package com.kh.dpr.claim.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.dpr.claim.model.vo.Claim;
import com.kh.dpr.order.model.vo.Order;
import com.kh.dpr.order.model.vo.OrderDetail;
import com.kh.dpr.product.model.vo.Product;
import com.kh.dpr.seller.model.vo.Seller;

@Repository
public class ClaimDAOImpl implements ClaimDAO {

   
   @Autowired
   SqlSessionTemplate sqlSession;
   
   
   @Override
   public Order selectOrder(String userId) {
      
      return sqlSession.selectOne("claimSQL.selectOrder",userId);
   }

   @Override
   public OrderDetail selectOrderDetail(String userId) {
      
      return sqlSession.selectOne("claimSQL.selectOrderDetail", userId);
   }

   @Override
   public Seller selectSeller(int detailNo) {
      
      return sqlSession.selectOne("claimSQL.selectSeller",detailNo);
   }

   @Override
   public String selectProduct(int productNo) {
      
      return sqlSession.selectOne("claimSQL.selectProductName",productNo);
   }

   @Override
   public int insertClaim(Claim claim) {
      // TODO Auto-generated method stub
      return sqlSession.insert("claimSQL.insertClaim", claim);
   }

   @Override
   public int insertClaim1(Claim claim) {
      // TODO Auto-generated method stub
      return sqlSession.insert("claimSQL.insertClaim1", claim);
   }

   @Override
   public int insertClaim2(Claim claim) {
      // TODO Auto-generated method stub
      return sqlSession.insert("claimSQL.insertClaim2", claim);
   }

   @Override
   public List<Claim> selectClaimList(String sellerId) {
      // TODO Auto-generated method stub
      return sqlSession.selectList("claimSQL.selectClaimList",sellerId);
   }

   @Override
   public Product selectCproduct(int claimNo) {
      // TODO Auto-generated method stub
      return sqlSession.selectOne("claimSQL.selectCproduct",claimNo);
   }

   @Override
   public int CompleteClaim(int claimNo) {
      // TODO Auto-generated method stub
      return sqlSession.update("claimSQL.completeClaim", claimNo);
   }

   @Override
   public List<Claim> selectSearchClaim(Map<String, Object> map) {
      // TODO Auto-generated method stub
      return sqlSession.selectList("claimSQL.searchClaim",map);
   }

   

}