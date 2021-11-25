
package com.kh.dpr.seller.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;

import com.kh.dpr.common.Utils;
import com.kh.dpr.order.model.vo.Delivery;
import com.kh.dpr.seller.model.service.SellerService;
import com.kh.dpr.seller.model.vo.Seller;

@Controller
@SessionAttributes({"seller"})
public class SellerController {
   
   String loc = "/";
   String msg = "";
   
   @Autowired
   SellerService sellerService;
   
   @Autowired
   BCryptPasswordEncoder bcryptPasswordEncoder;
   
   @RequestMapping("member/memberSignUp.do")
   public String memberSignUp() {
      
      return "member/memberSignUp";
   }
   
   @RequestMapping("member/memberLoginView.do")
   public String memberLogin() {
      
      return "member/memberLogin";
   }
   
   @RequestMapping("seller/sellerMain.do")
   public String sellerMain() {
      
      return "seller/sellerMain";
   }
   
   @RequestMapping("member/sellerSignUpEnd.do")
   public String sellerSingUpEnd(Seller seller, Model model) {
      
      System.out.println("컨트롤러 도착 확인");
      System.out.println("Seller 정보 확인" + seller);
      
      String beforePw = seller.getSellerPw();
      String encryptPw = bcryptPasswordEncoder.encode(beforePw);
      seller.setSellerPw(encryptPw);
      
      int result = sellerService.insertSeller(seller);
      
      if(result > 0) {
         return "seller/sellerMain";
      } else {
         msg = "회원가입에 실패했습니다.";

         model.addAttribute("loc", loc);
         model.addAttribute("msg", msg);
         
         return "common/msg";
      }
      
   }
   
   @RequestMapping("member/checkSellerDuplicate.do")
   public void sellerDuplicate(@RequestParam String sellerId,
                        HttpServletResponse response) throws IOException {
      
      int check = sellerService.checkSellerDuplicate(sellerId);
      
      boolean result = (check == 0 ? true : false);
      response.getWriter().print(result);
   }
   
   @RequestMapping("member/sellerLogin.do")
   public String sellerLogin(@RequestParam String sellerId, @RequestParam String sellerPw, 
                     Model model) {
      
      Seller seller = sellerService.selectOneSeller(sellerId);
      
      if(seller != null) {
         if(bcryptPasswordEncoder.matches(sellerPw, seller.getSellerPw())) {
            
            model.addAttribute("seller", seller);
            System.out.println("seller : " + seller);
            return "seller/sellerMain";

         } else {
            // 비밀번호 불일치 시 로직
            msg = "비밀번호가 일치하지 않습니다.";
            model.addAttribute("loc", loc);
            model.addAttribute("msg", msg);
            return "common/msg";
         }
      } else {
         msg = "존재하지 않는 아이디입니다.";
         model.addAttribute("loc", loc);
         model.addAttribute("msg", msg);
         return "common/msg";
      }      
   }
   
   @RequestMapping("seller/logout.do")
   public String sellerLogout(SessionStatus status) {
      
      if(!status.isComplete()) {
         status.setComplete();
         System.out.println("로그아웃 완료");
      }
            
      return "redirect:/";
   }
   
   @RequestMapping("/myPage/sellerInfo.do")
   public String sellerInfo(String sellerId, Model model) {
      
      Seller result = sellerService.selectOneSeller(sellerId);
      
      model.addAttribute("seller", result);
      
      return "myPage/sellerInfo";
   }
   
   @RequestMapping("/myPage/updateSeller.do")
   public String updateSeller(Seller seller, Model model) {
      
      int result = sellerService.updateSeller(seller);
      
      if(result > 0) {
         msg = "회원 정보 수정 완료!";
         model.addAttribute("seller", seller);
         System.out.println(seller);
      } else {
         msg = "회원 정보 수정 실패!";
      }
      
      model.addAttribute("loc", loc);
      model.addAttribute("msg", msg);
      
      return "redirect:/";
   }
   
   @RequestMapping("/myPage/sellerDelete.do")
   public String sellerDelete(Seller seller, SessionStatus status, Model model) {
      
      int result = sellerService.deleteSeller(seller.getSellerId());
      
      if(result > 0) {
         msg = "회원 탈퇴 완료!";
         status.setComplete();
      } else {
         msg = "회원 탈퇴 실패!";
      }
      
      model.addAttribute("loc", loc);
      model.addAttribute("msg", msg);
      
      return "common/msg";
      
   }
   
   @RequestMapping("seller/delivery.do")
   public String delivery(@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
                      Seller seller, Model model) {
      
      int numPerPage = 50;
      String sellerId = seller.getSellerId();
      
      List<Delivery> list = sellerService.selectDelList(sellerId, cPage, numPerPage);
      
      int totalOrder = sellerService.selectTotalOrder(sellerId);
      String pageBar = Utils.getPageBar(totalOrder, cPage, numPerPage, "productList.do");
      
      model.addAttribute("list", list);
      model.addAttribute("totalOrder", totalOrder);
      model.addAttribute("numPerPage", numPerPage);
      model.addAttribute("pageBar", pageBar);
      
      return "seller/delivery";
   }
   
   @RequestMapping("seller/downloadExcel.do")
   public void downloadExcel(Delivery delivery, HttpServletResponse response) throws IOException {
      
      System.out.println(delivery);
      List<Delivery> list = delivery.getDeliveryList();
      System.out.println(list);

      Workbook wb = new XSSFWorkbook();
      Sheet sheet = wb.createSheet("첫번째 시트");
      Row row = null;
        Cell cell = null;
        int rowNum = 0;
        
        String[] header = {"주문번호", "주문상세번호", "택배사", "운송장번호", "상품번호", "상품명",
                           "결제일", "아이디", "수령인", "연락처", "배송주소", "배송요청사항"};
        
        System.out.println(list);
        
        row = sheet.createRow(rowNum++);
        for(int i=0; i < header.length; i++) {
           cell = row.createCell(i);
           cell.setCellValue(header[i]);
        }
                       
        for(Delivery del : list) {
           int cellNum = 0;
           
           row = sheet.createRow(rowNum++);
           cell = row.createCell(cellNum++);
           cell.setCellValue(del.getOrderNo());
           cell = row.createCell(cellNum++);
           cell.setCellValue(del.getDetailNo());
           cell = row.createCell(cellNum++);
           cell.setCellValue(del.getDeliveryCode());
           
           cell = row.createCell(cellNum++);
           
           String delNo = (del.getDeliveryNo() == 0) ? "" : String.valueOf(del.getDeliveryNo());
           cell.setCellValue(delNo);
           
           cell = row.createCell(cellNum++);
           cell.setCellValue(del.getProductNo());
           cell = row.createCell(cellNum++);
           cell.setCellValue(del.getProductName());
           cell = row.createCell(cellNum++);
           cell.setCellValue(del.getPayDate());
           cell = row.createCell(cellNum++);
           cell.setCellValue(del.getUserId());
           cell = row.createCell(cellNum++);
           cell.setCellValue(del.getOrderReceiver());
           cell = row.createCell(cellNum++);
           cell.setCellValue(del.getOrderPhone());
           cell = row.createCell(cellNum++);
           cell.setCellValue(del.getOrderAddress());
           cell = row.createCell(cellNum++);
           cell.setCellValue(del.getOrderRequest());
        }
        
        // 컨텐츠 타입과 파일명 지정
        response.setContentType("ms-vnd/excel");
        response.setHeader("Content-type", "ms-vnd/excel");
        response.setHeader("Content-Disposition", "attachment; filename=\"example.xlsx\";");

        // Excel File Output
        wb.write(response.getOutputStream());
        wb.close();
    }
   
   @RequestMapping("seller/uploadExcel.do")
   public void uploadExcel(@RequestParam(value="fileSelector", required=false) MultipartFile excelFile) {
      
      System.out.println(excelFile);
      
   }
}