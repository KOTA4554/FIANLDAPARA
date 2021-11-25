package com.kh.dpr.claim.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.dpr.claim.model.service.ClaimService;
import com.kh.dpr.claim.model.vo.Claim;
import com.kh.dpr.member.model.vo.Member;
import com.kh.dpr.order.model.vo.Order;
import com.kh.dpr.order.model.vo.OrderDetail;
import com.kh.dpr.product.model.vo.Product;
import com.kh.dpr.review.model.vo.Review;
import com.kh.dpr.seller.model.vo.Seller;



@Controller
public class ClaimController {
   @Autowired
   ClaimService ClaimService;
   @RequestMapping("/claim/claim.do")
   public String selectClaim(HttpServletRequest request, Model model) {
      
   HttpSession session = request.getSession(false);
      
      Member member = (Member)session.getAttribute("member");
      
      String userId = member.getUserId();
      
      // userId 일치하는 order
      

      Order order = ClaimService.selectOneOrder(userId);
            
      // orderNo 일치하는 orderDetail
      OrderDetail orderDetail = ClaimService.selectOneDetail(userId); 
            
      
      //seller 조회
      int productNo = orderDetail.getProductNo();
            
      // detailNo
      int detailNo = orderDetail.getDetailNo();
               
      Seller seller3 = ClaimService.selectSeller(detailNo);
               
      String prodName = ClaimService.selectProduct(productNo);
      
         
      
      model.addAttribute("order", order);
      model.addAttribute("orderDetail", orderDetail);
      model.addAttribute("seller3", seller3);
      model.addAttribute("prodName", prodName);
      
      
      
      return "claim/claim";
   }
   
   @RequestMapping("/claim/change.do")
   public String insertClaimInfo(Claim claim, Model model) {
      
      int result = ClaimService.insertClaim(claim);
      
      String loc = "/myPage/myPage.do";
      String msg = "";
      
      // orderDetail db에 넣기
      if(result > 0) {
         msg = " 교환 등록 성공!";
      } else {
         msg = "클레임 등록 실패!";
      
      }
      
      model.addAttribute("loc",loc);
      model.addAttribute("msg",msg);
      
      return "common/msg";
      
      
   }
   @RequestMapping("/claim/refund.do")
   public String insertClaimInfo1(Claim claim,Model model) {
      
      int result = ClaimService.insertClaim1(claim);
      
      String loc = "/myPage/myPage.do";
      String msg = "";
      
      // orderDetail db에 넣기
      if(result > 0) {
         msg = " 환불 등록 성공!";
      } else {
         msg = "클레임 등록 실패!";
      
      }
      
      model.addAttribute("loc",loc);
      model.addAttribute("msg",msg);
      
      return "common/msg";
      
      
   }
   
   @RequestMapping("/claim/cancel.do")
   public String insertClaimInfo2(Claim claim, Model model) {
      
      int result = ClaimService.insertClaim2(claim);
      
      String loc = "/myPage/myPage.do";
      String msg = "";
      
      // orderDetail db에 넣기
      if(result > 0) {
         msg = " 취소 등록 성공!";
      } else {
         msg = "클레임 등록 실패!";
      
      }
      
      model.addAttribute("loc",loc);
      model.addAttribute("msg",msg);
      
      return "common/msg";
      
      
   }
   
   @RequestMapping("/seller/claimList.do")
   public String cliamList(HttpServletRequest request, Model model) {
      
   
   HttpSession session = request.getSession(false);
   
   Seller s = (Seller)session.getAttribute("seller");
   
   String sellerId = s.getSellerId();
   
   List<Claim> ClaimList = ClaimService.selectClaimList(sellerId);
   
   List<Product> cpList = new ArrayList<Product>();
   
   for(int i = 0; i < ClaimList.size(); i++) {
      
      int claimNo = ClaimList.get(i).getClaimNo();
      
      Product cp = ClaimService.selectCproduct(claimNo);
      
      cpList.add(cp);
      }
   System.out.println(ClaimList);
   System.out.println(cpList);
   int totalProduct = ClaimList.size();
   
   model.addAttribute("totalProduct",totalProduct);
   model.addAttribute("claimList", ClaimList);
   model.addAttribute("cpList",cpList);

   return "productManage/claimList";
   }
   
   @RequestMapping("/claim/claimcomplete.do")
   public String ClaimComplete(@RequestParam int claimNo, Model model) {
      
      int result = ClaimService.CompleteClaim(claimNo);
      
      String loc = "/seller/claimList.do";
      String msg = "";
      
      
      if(result > 0) {
         msg = " 취소 등록 성공!";
      } else {
         msg = "클레임 등록 실패!";
      }
      
      model.addAttribute("loc",loc);
      model.addAttribute("msg",msg);
      
      
      
      return "common/msg";
      
   }
   
   @RequestMapping("/seller/searchClaimList.do")
   public String searchReview( @RequestParam(value="productName", required=false) String productName,
                        @RequestParam(value="categoryNo", required=false) int categoryNo,
                        @RequestParam(value="categoryNo2", required=false) int categoryNo2,
                        @RequestParam(value="productBrand", required=false) String productBrand,
                        @RequestParam(value="productNo", required=false, defaultValue="-1") int productNo,
                        @RequestParam(value="claimCode", required=false ) int claimCode,
                        HttpServletRequest request,
                        Model model) {
      
      HttpSession session = request.getSession(false);
      
      String sellerId = ((Seller)session.getAttribute("seller")).getSellerId();
      
      Map<String, Object> map= new HashMap<>();
      
      map.put("sellerId", sellerId);
      map.put("productName", productName);
      map.put("categoryNo", categoryNo);
      map.put("categoryNo2", categoryNo2);
      map.put("productBrand", productBrand);
      map.put("productNo", productNo);
      map.put("claimCode", claimCode);
      
      System.out.println(map);
      
      // 조건에 맞는 리뷰 리스트
      List<Claim> claimList = ClaimService.selectSearchClaim(map);
      
      
      
      // 해당 리뷰의 상품
      List<Product> cpList = new ArrayList<Product>();

      for(int i = 0; i < claimList.size(); i++) {
         
         int claimNo = claimList.get(i).getClaimNo();
         
         Product cp = ClaimService.selectCproduct(claimNo);
         
         cpList.add(cp);
         
      }
      
      
      int totalProduct = claimList.size();
      
      model.addAttribute("totalProduct", totalProduct);
      model.addAttribute("claimList", claimList);
      model.addAttribute("cpList", cpList);
      
      //return null;
      return "productManage/claimList";
   }
}