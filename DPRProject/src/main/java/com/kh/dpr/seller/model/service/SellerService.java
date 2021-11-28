package com.kh.dpr.seller.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.dpr.order.model.vo.Delivery;
import com.kh.dpr.seller.model.dao.SellerDAO;
import com.kh.dpr.seller.model.vo.Calculate;
import com.kh.dpr.seller.model.vo.Gross;
import com.kh.dpr.seller.model.vo.Seller;
import com.kh.dpr.seller.model.vo.SellerStat;

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

	public int insertDelivery(List<Delivery> list) {
		int totalResult = 0;
		int cnt = 0;
		for(Delivery delivery : list) {
			totalResult = sellerDAO.insertDelivery(delivery);
			if(totalResult > 0) {
				totalResult = sellerDAO.updateOrderDetail(delivery);
			}
			cnt++;
		}
		
		return cnt;
	}
	
	public List<Map<String, String>> searchDeliveryList(Map<String, Object> map, int cPage, int numPerPage) {
		return sellerDAO.searchDeliveryList(map, cPage, numPerPage);
	}
	
	public int countSearched(Map<String, Object> map) {
		return sellerDAO.countSearched(map);
	}
	
	public SellerStat getClaimCnt(String sellerId) {
		return sellerDAO.getClaimCnt(sellerId);
	}

	public SellerStat getProductCnt(String sellerId) {
		return sellerDAO.getProductCnt(sellerId);
	}

	public SellerStat getDeliveryCnt(String sellerId) {
		return sellerDAO.getDeliveryCnt(sellerId);
	}

	public SellerStat getReviewCnt(String sellerId) {
		return sellerDAO.getReviewCnt(sellerId);
	}

	public SellerStat getQnaCnt(String sellerId) {
		return sellerDAO.getQnaCnt(sellerId);
	}

	public List<Gross> getSaleGross(Map setting) {
		return sellerDAO.getSaleGross(setting);
	}


	public String findId(Seller s) {
		return sellerDAO.findId(s);
	}
	public Calculate getCalculate(Map<String, Object> setting) {
		return sellerDAO.getCalculate(setting);
	}

	public List<Calculate> getMontlyGross(Map<String, Object> setting) {
		return sellerDAO.getMontlyGross(setting);

	}
}