package com.kh.dpr.board.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;
import com.kh.dpr.board.model.service.ProductService;
import com.kh.dpr.product.model.vo.Product;
import com.kh.dpr.common.Utils;

@Controller

public class MainController {

   @Inject
   ProductService productService;

   @RequestMapping("/product/clothes.do")
   public String selectBoardList(
         @RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
         Model model
         ) {
      
      // 한 페이지당 게시글 수
      int numPerPage = 12;
      
      // 현재 페이지의 게시글 수
      List<Product> list = productService.selectProductList(cPage, numPerPage);
      
      // 전체 게시글 수
      int totalContents = productService.selectProductTotalContents();
      
      
      List<String> imageList = new ArrayList<>();

     
      for(int i=0; i<list.size();i++) {
    	  int productNo = list.get(i).getProductNo();

    	  String image = productService.selectImage(productNo);
    	  imageList.add(image);
    	  System.out.println(productNo);
      }
      // 페이지 처리 Utils 사용하기
      String pageBar = Utils.getPageBar(totalContents, cPage, numPerPage, "boardList.do");
      
      System.out.println(imageList);
      System.out.println("list : " + list);
      System.out.println("pageBar : " + pageBar);
      
      model.addAttribute("image", imageList);
      model.addAttribute("list", list);
      model.addAttribute("totalContents", totalContents);
      model.addAttribute("numPerPage", numPerPage);
      model.addAttribute("pageBar", pageBar);
      
      return "product/clothes";
   }
   
   

   @RequestMapping(value="/main.do", method = RequestMethod.POST, produces = "application/text; charset=UTF-8")
   public void ajaxMain(HttpServletResponse response) throws IOException {
      
      
      int maxpage = 4;
      List<Product> product = productService.selectList(maxpage);
      
      response.setContentType("application/json");
      response.setCharacterEncoding("UTF-8");
      new Gson().toJson(product, response.getWriter());
      
      System.out.println(product);
      
      if(product != null) {
         
      }else {
         
      }
      
      
   }
   
   
   @RequestMapping(value="/top.do", method = RequestMethod.POST, produces = "application/text; charset=UTF-8")
      public void ajaxMain2(HttpServletResponse response) throws IOException {
         
         
         
         
         
         int maxpage = 4;
         List<Product> product = productService.selectListTop(maxpage);
         
         response.setContentType("application/json");
         response.setCharacterEncoding("UTF-8");
         new Gson().toJson(product, response.getWriter());

         System.out.println(product);
         
         if(product != null) {
            
         }else {
            
         }

   
   }
   
   @RequestMapping("/product/top.do")
   public String selectTopList(
         @RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
         Model model
         ) {
      
      // 한 페이지당 게시글 수
      int numPerPage = 12;
      
      // 현재 페이지의 게시글 수
      List<Map<String, String>> list = productService.selectTopList(cPage, numPerPage);
      
      // 전체 게시글 수
      int totalContents = productService.selectProductTotalContents();
      
      // 페이지 처리 Utils 사용하기
      String pageBar = Utils.getPageBar(totalContents, cPage, numPerPage, "boardList.do");
      
      System.out.println("list : " + list);
      System.out.println("pageBar : " + pageBar);
      
      
      model.addAttribute("list", list);
      model.addAttribute("totalContents", totalContents);
      model.addAttribute("numPerPage", numPerPage);
      model.addAttribute("pageBar", pageBar);
      
      return "product/top";
   }
   
      
      @RequestMapping("/product/knit.do")
   public String selectKnitList(
         @RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
         Model model
         ) {
      
      // 한 페이지당 게시글 수
      int numPerPage = 12;
      
      // 현재 페이지의 게시글 수
      List<Map<String, String>> list = productService.selectKnitList(cPage, numPerPage);
      
      // 전체 게시글 수
      int totalContents = productService.selectProductTotalContents();
      
      // 페이지 처리 Utils 사용하기
      String pageBar = Utils.getPageBar(totalContents, cPage, numPerPage, "boardList.do");
      
      System.out.println("list : " + list);
      System.out.println("pageBar : " + pageBar);
      
      
      model.addAttribute("list", list);
      model.addAttribute("totalContents", totalContents);
      model.addAttribute("numPerPage", numPerPage);
      model.addAttribute("pageBar", pageBar);
      
      return "product/Knit";
   }
      
      @RequestMapping("/product/jacket.do")
      public String selectJacketList(
            @RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
            Model model
            ) {
         
         // 한 페이지당 게시글 수
         int numPerPage = 12;
         
         // 현재 페이지의 게시글 수
         List<Map<String, String>> list = productService.selectJacketList(cPage, numPerPage);
         
         // 전체 게시글 수
         int totalContents = productService.selectProductTotalContents();
         
         // 페이지 처리 Utils 사용하기
         String pageBar = Utils.getPageBar(totalContents, cPage, numPerPage, "boardList.do");
         
         System.out.println("list : " + list);
         System.out.println("pageBar : " + pageBar);
         
         
         model.addAttribute("list", list);
         model.addAttribute("totalContents", totalContents);
         model.addAttribute("numPerPage", numPerPage);
         model.addAttribute("pageBar", pageBar);
         
         return "product/jacket";
      }
      
      @RequestMapping("/product/search.do")
      public String selectSearchList(
            @RequestParam(value="cPage", required=false, defaultValue="1") int cPage, @RequestParam String sresult,
            Model model
            ) {
         
         // 한 페이지당 게시글 수
         int numPerPage = 12;
         System.out.println(sresult);
         // 현재 페이지의 게시글 수
         List<Map<String, String>> list = productService.selectSearchList(cPage, numPerPage, sresult);
         
         // 전체 게시글 수
         int totalContents = productService.selectProductTotalContents();
         
         // 페이지 처리 Utils 사용하기
         String pageBar = Utils.getPageBar(totalContents, cPage, numPerPage, "boardList.do");
         
         System.out.println("list : " + list);
         System.out.println("pageBar : " + pageBar);
         
         
         model.addAttribute("list", list);
         model.addAttribute("totalContents", totalContents);
         model.addAttribute("numPerPage", numPerPage);
         model.addAttribute("pageBar", pageBar);
         
         return "product/search";
      }
}