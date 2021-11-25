package com.kh.dpr.seller.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.dpr.order.model.vo.Delivery;
import com.kh.dpr.seller.model.dao.SellerDAO;
import com.kh.dpr.seller.model.vo.Seller;

@Service
public class SellerService {

   @Autowired
   SellerDAO sellerDAO;

   public int insertSeller(Seller seller) {
      return sellerDAO.insertSeller(seller);
   }

   public int checkSellerDuplicate(String sellerId) {
      return sellerDAO.checkSellerDuplicate(sellerId);
   }

   public Seller selectOneSeller(String sellerId) {
      return sellerDAO.selectOneSeller(sellerId);
   }

   public List<Delivery> selectDelList(String sellerId, int cPage, int numPerPage) {
      return sellerDAO.selectDelList(sellerId, cPage, numPerPage);
   }

   public int selectTotalOrder(String sellerId) {
      return sellerDAO.selectTotalOrder(sellerId);
   }
   
   public int updateSeller(Seller seller) {
      return sellerDAO.updateSeller(seller);
   }

   public int deleteSeller(String sellerId) {
      return sellerDAO.deleteSeller(sellerId);
   }
}