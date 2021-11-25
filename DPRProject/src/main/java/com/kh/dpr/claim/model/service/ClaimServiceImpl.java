package com.kh.dpr.claim.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.kh.dpr.claim.model.dao.ClaimDAO;
import com.kh.dpr.claim.model.vo.Claim;
import com.kh.dpr.order.model.vo.Order;
import com.kh.dpr.order.model.vo.OrderDetail;
import com.kh.dpr.product.model.vo.Product;
import com.kh.dpr.seller.model.vo.Seller;

@Service
public class ClaimServiceImpl implements ClaimService {

   @Autowired
   ClaimDAO ClaimDAO;
   
   @Override
   public Order selectOneOrder(String userId) {
      
      return  ClaimDAO.selectOrder(userId);
   }

   @Override
   public OrderDetail selectOneDetail(String userId) {
      
      return ClaimDAO.selectOrderDetail(userId);
   }

   @Override
   public Seller selectSeller(int detailNo) {
      
      return ClaimDAO.selectSeller(detailNo);
   }

   @Override
   public String selectProduct(int productNo) {
   
      return ClaimDAO.selectProduct(productNo);
   }

   
   @Override
   public int insertClaim(Claim claim) {
      // TODO Auto-generated method stub
      return ClaimDAO.insertClaim(claim);
   }

   @Override
   public int insertClaim1(Claim claim) {
      // TODO Auto-generated method stub
      return ClaimDAO.insertClaim1(claim);
   }

   @Override
   public int insertClaim2(Claim claim) {
      // TODO Auto-generated method stub
      return ClaimDAO.insertClaim2(claim);
   }

   @Override
   public List<Claim> selectClaimList(String sellerId) {
      // TODO Auto-generated method stub
      return ClaimDAO.selectClaimList(sellerId);
   }

   @Override
   public Product selectCproduct(int claimNo) {
      // TODO Auto-generated method stub
      return ClaimDAO.selectCproduct(claimNo);
   }

   @Override
   public int CompleteClaim(int claimNo) {
      // TODO Auto-generated method stub
      return ClaimDAO.CompleteClaim(claimNo);
   }

   @Override
   public List<Claim> selectSearchClaim(Map<String, Object> map) {
      // TODO Auto-generated method stub
      return ClaimDAO.selectSearchClaim(map);
   }

   

}