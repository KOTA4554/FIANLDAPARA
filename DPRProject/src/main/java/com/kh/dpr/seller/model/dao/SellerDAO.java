package com.kh.dpr.seller.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.dpr.order.model.vo.Delivery;
import com.kh.dpr.seller.model.vo.Calculate;
import com.kh.dpr.seller.model.vo.Gross;
import com.kh.dpr.seller.model.vo.Seller;
import com.kh.dpr.seller.model.vo.SellerStat;

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

	public int insertDelivery(Delivery delivery) {
		String deliveryName = delivery.getDeliveryName();
		
		
		int delCode = sqlSession.selectOne("deliverySQL.findDeliveryName", deliveryName);
		delivery.setDeliveryCode(delCode);
		
		return sqlSession.insert("deliverySQL.insertDelivery", delivery);
	}
	
	public int updateOrderDetail(Delivery delivery) {
		return sqlSession.update("deliverySQL.updateOrderDetail", delivery);
	}

	public List<Map<String, String>> searchDeliveryList(Map<String, Object> map, int cPage, int numPerPage) {
		RowBounds rows = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sqlSession.selectList("deliverySQL.searchDeliveryList", map, rows);
	}

	public int countSearched(Map<String, Object> map) {
		return sqlSession.selectOne("deliverySQL.countSearched", map);
	}

	public SellerStat getClaimCnt(String sellerId) {
		return sqlSession.selectOne("sellerSQL.getClaimCnt", sellerId);
	}

	public SellerStat getProductCnt(String sellerId) {
		return sqlSession.selectOne("sellerSQL.getProductCnt", sellerId);
	}

	public SellerStat getDeliveryCnt(String sellerId) {
		return sqlSession.selectOne("sellerSQL.getDeliveryCnt", sellerId);
	}

	public SellerStat getReviewCnt(String sellerId) {
		return sqlSession.selectOne("sellerSQL.getReviewCnt", sellerId);
	}

	public SellerStat getQnaCnt(String sellerId) {
		return sqlSession.selectOne("sellerSQL.getQnaCnt", sellerId);
	}

	public List<Gross> getSaleGross(Map setting) {
		return sqlSession.selectList("sellerSQL.getSaleGross", setting);
	}


	public String findId(Seller s) {
		return sqlSession.selectOne("sellerSQL.findId", s);

	public Calculate getCalculate(Map<String, Object> setting) {
		return sqlSession.selectOne("sellerSQL.getCalculate", setting);
	}

	public List<Calculate> getMontlyGross(Map<String, Object> setting) {
		return sqlSession.selectList("sellerSQL.getMonthlyGross", setting);

	}
}