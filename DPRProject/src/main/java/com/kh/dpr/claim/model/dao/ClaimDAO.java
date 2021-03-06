package com.kh.dpr.claim.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.dpr.claim.model.vo.Claim;
import com.kh.dpr.order.model.vo.Order;
import com.kh.dpr.order.model.vo.OrderDetail;
import com.kh.dpr.product.model.vo.Product;
import com.kh.dpr.seller.model.vo.Seller;

public interface ClaimDAO {

    Order selectOrder(String userId);

    OrderDetail selectOrderDetail(int detailNo);

    Seller selectSeller(int detailNo); 

    String selectProduct(int productNo);

   int insertClaim(Claim claim);

   int insertClaim1(Claim claim);

   int insertClaim2(Claim claim);

   List<Claim> selectClaimList(String sellerId);

   Product selectCproduct(int claimNo);

   int CompleteClaim(int claimNo);

   List<Claim> selectSearchClaim(Map<String, Object> map);

String selectProdImg(int productNo);
}