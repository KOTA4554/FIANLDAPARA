
package com.kh.dpr.seller.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
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
import com.kh.dpr.seller.model.vo.Calculate;
import com.kh.dpr.seller.model.vo.Gross;
import com.kh.dpr.seller.model.vo.Seller;
import com.kh.dpr.seller.model.vo.SellerStat;

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
   public String sellerMain(Seller seller, Model model) {
      
	  String sellerId = seller.getSellerId();
	  
	  SellerStat claim = sellerService.getClaimCnt(sellerId); 
	  SellerStat product = sellerService.getProductCnt(sellerId);
	  SellerStat delivery = sellerService.getDeliveryCnt(sellerId);
	  SellerStat review = sellerService.getReviewCnt(sellerId);
	  SellerStat qna = sellerService.getQnaCnt(sellerId);
	  
	  model.addAttribute("claim", claim);
	  model.addAttribute("product", product);
	  model.addAttribute("delivery", delivery);
	  model.addAttribute("review", review);
	  model.addAttribute("qna", qna);
	  System.out.println(product);
	  
	  Map setting = new HashMap();
	  // String currentDate = new SimpleDateFormat("yy-MM-dd").format(new java.util.Date());
	  Date today = new Date(System.currentTimeMillis());
	  
	  setting.put("sellerId", sellerId);
	  setting.put("today", today);
	  
	  
	  List<Gross> gross = sellerService.getSaleGross(setting);
	  model.addAttribute("gross", gross);	  

      return "seller/sellerMain";
   }
   
   @RequestMapping("member/sellerSignUpEnd.do")
   public String sellerSingUpEnd(Seller seller, Model model) {
      
      System.out.println("???????????? ?????? ??????");
      System.out.println("Seller ?????? ??????" + seller);
      
      String beforePw = seller.getSellerPw();
      String encryptPw = bcryptPasswordEncoder.encode(beforePw);
      seller.setSellerPw(encryptPw);
      
      int result = sellerService.insertSeller(seller);
      
      if(result > 0) {
         return "seller/sellerMain";
      } else {
         msg = "??????????????? ??????????????????.";

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
            loc = "/seller/sellerMain.do";
            msg = "????????? ???????????????.";
            
            model.addAttribute("loc", loc);
            model.addAttribute("msg", msg);
            
         } else {
            // ???????????? ????????? ??? ??????
        	 
            msg = "??????????????? ???????????? ????????????.";
            model.addAttribute("loc", loc);
            model.addAttribute("msg", msg);
         }
         
      } else {
         
         msg = "???????????? ?????? ??????????????????.";
         model.addAttribute("loc", loc);
         model.addAttribute("msg", msg);
      }      

      return "common/msg";
   }
   
   @RequestMapping("seller/logout.do")
   public String sellerLogout(SessionStatus status) {
      
      if(!status.isComplete()) {
         status.setComplete();
         System.out.println("???????????? ??????");
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
         msg = "?????? ?????? ?????? ??????!";
         model.addAttribute("seller", seller);
         System.out.println(seller);
      } else {
         msg = "?????? ?????? ?????? ??????!";
      }
      
      model.addAttribute("loc", loc);
      model.addAttribute("msg", msg);
      
      return "redirect:/";
   }
   
   @RequestMapping("/myPage/sellerDelete.do")
   public String sellerDelete(Seller seller, SessionStatus status, Model model) {
      
      int result = sellerService.deleteSeller(seller.getSellerId());
      
      if(result > 0) {
         msg = "?????? ?????? ??????!";
         status.setComplete();
      } else {
         msg = "?????? ?????? ??????!";
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
      System.out.println(list);
      
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
      Sheet sheet = wb.createSheet("????????? ??????");
      Row row = null;
        Cell cell = null;
        int rowNum = 0;
        
        String[] header = {"??????????????????", "?????????", "???????????????", "????????????", "?????????",
                           "?????????", "?????????", "?????????", "?????????", "????????????", "??????????????????"};
        
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
           cell.setCellValue(del.getDetailNo());
           cell = row.createCell(cellNum++);
           cell.setCellValue(del.getDeliveryName());
           
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
        
        // ????????? ????????? ????????? ??????
        response.setContentType("ms-vnd/excel");
        response.setHeader("Content-type", "ms-vnd/excel");
        response.setHeader("Content-Disposition", "attachment; filename=\"example.xlsx\";");

        // Excel File Output
        wb.write(response.getOutputStream());
        wb.close();
    }
   
    @RequestMapping("seller/uploadExcel.do")
    public String uploadExcel(@RequestParam(value="excelFile", required=false) MultipartFile excelFile,
		   				   Model model) {
	    
    	List<Delivery> list = new ArrayList<>();
    	
    	String originName = excelFile.getOriginalFilename();
    	int colNum = 0;
    	try {
    		OPCPackage opcPackage = OPCPackage.open(excelFile.getInputStream());
    		XSSFWorkbook workbook = new XSSFWorkbook(opcPackage);
    	  
    		XSSFSheet sheet = workbook.getSheetAt(0);
    		
    		for(int i = 1; i < sheet.getLastRowNum()+1; i++) {
    			Delivery delivery = new Delivery();
    			XSSFRow row = sheet.getRow(i);
    			
    			if(row == null) { continue; }
    			
    			XSSFCell cell = row.getCell(0);
    			if(cell != null) { delivery.setDetailNo((int)cell.getNumericCellValue()); }

    			cell = row.getCell(1);
    			if(cell != null) { delivery.setDeliveryName(cell.getStringCellValue()); }
    			
    			cell = row.getCell(2);
    			if(cell != null) { delivery.setDeliveryNo((long)(cell.getNumericCellValue())); }
    			
    			cell = row.getCell(3);
    			if(cell != null) { delivery.setProductNo((int)cell.getNumericCellValue()); }
    			
    			list.add(delivery);
    			
    		}
		
    	} catch (InvalidFormatException | IOException e) {
    		e.printStackTrace();
    	}
    	
    	System.out.println(list);
    	
    	int result = sellerService.insertDelivery(list);
    	if(result > 0) {
    		loc = "/seller/delivery.do";
    		msg = result + "??? ????????? ?????? ????????? ?????????????????????.";
    	} else {
    		loc = "/seller/delivery.do";
    		msg = "?????? ?????? ????????? ?????????????????????.";
    	}
    	
    	model.addAttribute("loc", loc);
    	model.addAttribute("msg", msg);
    	
    	return "common/msg";
    }
    
    @RequestMapping("seller/deliverySearch.do")
	public String searchDeliveryList(@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
									 @RequestParam(value="startDate", required=false) String startDate,
									 @RequestParam(value="endDate", required=false) String endDate,
									 @RequestParam(value="delState", required=false, defaultValue="999") int delState,
									 @RequestParam(value="searchNm", required=false) String searchNm,
									 @RequestParam(value="searchPno", required=false, defaultValue="-1") int searchPno,
									 Seller seller, Model model) {
    	
    	int numPerPage = 50;
		String sellerId = seller.getSellerId();
		
		Map<String, Object> map= new HashMap<>();
		
		if( startDate != null && !startDate.equals("")) {
			Date startD = Date.valueOf(startDate);			
			map.put("startDate", startD);
		}
		
		if( endDate != null && !endDate.equals("")) {
			Date endD = Date.valueOf(endDate);
			map.put("endDate", endD);
			
		}
		
		map.put("sellerId", sellerId);
		map.put("searchNm", searchNm);
		map.put("delState", delState);
		map.put("searchPno", searchPno);
    	
		List<Map<String, String>> list = sellerService.searchDeliveryList(map, cPage, numPerPage);
		int totalDelivery = sellerService.countSearched(map);
		
		String pageBar = Utils.getPageBar(totalDelivery, cPage, numPerPage, "delivery.do");
		
		model.addAttribute("list", list);
		model.addAttribute("totalDelivery", totalDelivery);
		model.addAttribute("numPerPage", numPerPage);
		model.addAttribute("pageBar", pageBar);
		
    	return "seller/delivery";
    }
    

    @RequestMapping("member/sellerSearchInfo.do")
    public String searchInfo(@RequestParam String sellerName, @RequestParam String sellerPhone, @RequestParam String sellerCompany, Model model) {
    	
    	Seller s = new Seller(sellerName, sellerCompany, sellerPhone);
    	System.out.println(s);
    	String result = sellerService.findId(s);
    	System.out.println(result);
    	
    	if(result == null) {
    		msg = "???????????? ????????????!";
    	} else {
    		msg = "????????????" + result + "?????????!";
    	}
    	
    	model.addAttribute("msg", msg);
    	
    	return "common/msg";
    }
    

    @RequestMapping("/seller/calculate.do")
    public String sellerCalculate() {
    	
    	return "seller/calculate";
    }
    
    @RequestMapping("/seller/inquireCal.do")
    public String inquireCalculate(Seller seller, Model model,
    							@RequestParam(value="startDate", required=false) String startDate,
    							@RequestParam(value="endDate", required=false) String endDate) {
    	
    	System.out.println(seller);
    	System.out.println(startDate);
    	System.out.println(endDate);
		
		Map<String, Object> setting= new HashMap<>();

		String sellerId = seller.getSellerId();
		setting.put("sellerId", sellerId);
		
		if( startDate != null && !startDate.equals("")) {
			Date startD = Date.valueOf(startDate);			
			setting.put("startDate", startD);
		}
		
		if( endDate != null && !endDate.equals("")) {
			Date endD = Date.valueOf(endDate);
			setting.put("endDate", endD);
		}
		
		List<Calculate> monthly = sellerService.getMontlyGross(setting);
		System.out.println(monthly);
		model.addAttribute("monthly", monthly);
		
		Calculate total = sellerService.getCalculate(setting);
		System.out.println(total);
		
		total.setRealGross(total.getTotalGross() - total.getCancleGross());
		total.setCommission((int)(total.getRealGross() * 0.1));
		total.setDiscount(0);
		
		model.addAttribute("total", total);
		
		return "seller/calculate";
    }

}