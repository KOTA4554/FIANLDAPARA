package com.kh.dpr.product.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.kh.dpr.common.Utils;
import com.kh.dpr.product.model.service.ProductService;
import com.kh.dpr.product.model.vo.Product;
import com.kh.dpr.product.model.vo.ProductImage;
import com.kh.dpr.qna.model.vo.QnA;
import com.kh.dpr.review.model.vo.Review;
import com.kh.dpr.seller.model.vo.Seller;

@Controller
@SessionAttributes({"seller"})
public class ProductController {
	
	String loc = "/";
	String msg = "";
	
	@Autowired
	ProductService productService;
	
	@RequestMapping("seller/addProduct.do")
	public String addProduct(Model model) {
		// 1. 임시 Productinsert
		int result = productService.insertTempProduct();
		
		// 2. 생성된 가장 최근 Product의 번호( MAX(PRODUCTNO) , CURRVAL )를 반환해서 Model에 담기
		int productNo = productService.selectTempProduct();

		System.out.println(productNo + " productNo 임시 상품 테이블 로드 성공");
		model.addAttribute("productNo", productNo);

		return "productManage/addProduct";
	}
	
	@RequestMapping("seller/optionInsert.do")
	@ResponseBody
	public void optionInsert(@RequestBody List<Product> option) {
		System.out.println(option.size());
		for(Product opt : option) {
			System.out.println(opt);
			int result = productService.insertOption(opt);
			if(result > 0) {
				System.out.println("OptionNo" + opt.getOptionNo() + "등록 성공");
			}
		}
	}
	
	@RequestMapping("seller/productInsert.do")
	public String insertProduct(Product product, Model model, HttpServletRequest req,
								@RequestParam(value="mainImg", required=false) MultipartFile mainImg,
								@RequestParam(value="optionalImg", required=false) MultipartFile[] optionalImgs,
								@RequestParam(value="contentImgs", required=false) MultipartFile[] contentImgs) {
		
		int productNo = product.getProductNo();
		System.out.println("product No : " + productNo);
		
		String savePath = req.getServletContext().getRealPath("/resources/productUpload");
		List<ProductImage> imgList = new ArrayList<ProductImage>();
		 
		 
		// 메인이미지 저장 
		if(mainImg.isEmpty() == false) {
			ProductImage mainImage = saveImage(mainImg, 0, productNo, savePath); 
			imgList.add(mainImage);
		}
		
		// 추가이미지 저장 
		for(MultipartFile optionImg : optionalImgs) {
			if(optionImg.isEmpty() == false) {
				ProductImage optionImage = saveImage(optionImg, 1, productNo, savePath);
				imgList.add(optionImage);
			} 
		 }
		 
		// 컨텐츠이미지 저장 
		for(MultipartFile contentImg : contentImgs) {
			System.out.println("컨텐츠이미지");
			if(contentImg.isEmpty() == false) { 
				ProductImage contentImage = saveImage(contentImg, 2, productNo, savePath);
				imgList.add(contentImage); 
			} 
		}
		
		int result = productService.insertProduct(product, imgList);
		if(result > 0) {
			System.out.println("게시글 등록 성공");
		}
		
		return "productManage/productList";
	}
	
	
	public ProductImage saveImage(MultipartFile images, int categroy, int productNo, String savePath) {
		
		String originName = images.getOriginalFilename();
		String changeName = fileRename(productNo, originName);
		
		try {
			images.transferTo(new File(savePath + "/" + changeName));
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		ProductImage img = new ProductImage();
		
		img.setProductNo(productNo);
		img.setImageCategoryNo(categroy);
		img.setProductOldImage(originName);
		img.setProductNewImage(changeName);
		
		return img;
	}

	public String fileRename(int productNo, String oldName) {
		// productNo
		
		String pNo = String.valueOf(productNo);
		String ext = oldName.substring(oldName.lastIndexOf(".") + 1);
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmm");
		int rnd = (int)(Math.random() * 1000);
		
		return pNo + sdf.format(new Date(System.currentTimeMillis())) + "_" + rnd + "." + ext;
	}
	
	
	@RequestMapping("seller/productList.do")
	public String productList(@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
							  Seller seller, Model model) {
		
		int numPerPage = 15;
		String sellerId = seller.getSellerId();
		
		List<Map<String, String>> list = productService.selectProductList(sellerId, cPage, numPerPage);
		
		int totalProduct = productService.selectTotalProduct(sellerId);
		
		String pageBar = Utils.getPageBar(totalProduct, cPage, numPerPage, "productList.do");
		
		model.addAttribute("list", list);
		model.addAttribute("totalProduct", totalProduct);
		model.addAttribute("numPerPage", numPerPage);
		model.addAttribute("pageBar", pageBar);
		
		return "productManage/productList";
	}
	
	@RequestMapping("seller/searchProd.do")
	public String searchProductList(@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
									@RequestParam(value="searchNm", required=false) String searchNm,
									@RequestParam(value="searchCate1", required=false) int searchCate1,
									@RequestParam(value="searchCate2", required=false) int searchCate2,
									@RequestParam(value="startDate", required=false) String startDate,
									@RequestParam(value="endDate", required=false) String endDate,
									@RequestParam(value="saleState", required=false) int saleState,
									@RequestParam(value="searchBrand", required=false) String searchBrand,
									@RequestParam(value="searchPno", required=false, defaultValue="-1") int searchPno,
									Seller seller, Model model) {
		
		int numPerPage = 15;
		String sellerId = seller.getSellerId();
		// Date.valueOf(문자열)  : 문자열 형식(2021-11-23 / 20211123)
				
		Map<String, Object> map= new HashMap<>();
		
		System.out.println(startDate);
		
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
		map.put("searchCate1", searchCate1);
		map.put("searchCate2", searchCate2);
		map.put("saleState", saleState);
		map.put("searchBrand", searchBrand);
		map.put("searchPno", searchPno);
		
		List<Map<String, String>> list = productService.searchProductList(map, cPage, numPerPage);
		
		int totalProduct = productService.selectSearchedProduct(map);
		String pageBar = Utils.getPageBar(totalProduct, cPage, numPerPage, "searchProd.do");
		
		model.addAttribute("list", list);
		model.addAttribute("totalProduct", totalProduct);
		model.addAttribute("numPerPage", numPerPage);
		model.addAttribute("pageBar", pageBar);
		
		return "productManage/productList";
	}
	
	@RequestMapping("seller/modifyProduct.do")
	public String modifyProduct(@RequestParam int productNo, Model model) {
		
		Product detail = productService.selectOneProduct(productNo);
		List<Product> option = productService.selectOptionList(productNo);
		List<ProductImage> image = productService.selectImageList(productNo);
		System.out.println("detail : " + detail);
		System.out.println("option : " + option);
		System.out.println("image : " + image);
		
		model.addAttribute("detail", detail);
		model.addAttribute("option", option);
		model.addAttribute("image", image);
		
		
		
		return "productManage/modifyProduct";
	}

	
	@RequestMapping("/seller/modifyOptEnd.do")
	@ResponseBody
	public void modifyOptEnd(@RequestBody List<Product> option) {
		System.out.println("받아 온 옵션 길이 : " + option.size());
		
		for(Product opt : option) {
			System.out.println("OptionNo" + opt.getOptionNo() + "불러오기 성공");			
			// System.out.println(opt);
			if(opt.getOptionNo() == 0) {
				System.out.println(opt.getOptionNo() + "옵션 추가");
				int result = productService.insertOption(opt);
			} else {
				System.out.println(opt.getOptionNo() + "옵션 수정");
				int result2 = productService.updateOption(opt);
			}
		}

	}
	
	@RequestMapping("/seller/modifyProdEnd.do")
	public String modifyProdEnd(Product product, Model model, HttpServletRequest req,
								@RequestParam(value="mainImg", required=false) MultipartFile mainImg,
								@RequestParam(value="optionalImg", required=false) MultipartFile[] optionalImgs,
								@RequestParam(value="contentImgs", required=false) MultipartFile[] contentImgs) {
		
		int productNo = product.getProductNo();
		System.out.println("product No : " + productNo + "게시글 수정");
		System.out.println(product);

		// 2. 첨부파일 수정하기
		String savePath = req.getServletContext().getRealPath("/resources/productUpload");
		
		Map<String, Integer> setting = new HashMap();
		
		setting.put("productNo", productNo);
		setting.put("category", 0);
		
		List<ProductImage> mainImgList = productService.selectImage(setting); // 기존 이미지 객체 로드
		System.out.println("main : " + setting.get("category"));
		
		setting.put("category", 1);
		List<ProductImage> optionImgList = productService.selectImage(setting);
		System.out.println("option : " + setting.get("category"));
		
		setting.put("category", 2);
		List<ProductImage> contentImgList = productService.selectImage(setting);
		System.out.println("content : " + setting.get("category"));
		
		
		int idx = 0;
		
		if(mainImg.isEmpty() == false) {
			ProductImage temp = null;
			
			File oldFile = new File(savePath + "/" + mainImgList.get(idx).getProductNewImage());
			System.out.println("변경 전 파일 삭제 : " + oldFile.delete());
			
			temp = mainImgList.get(idx); // 새 파일로 ProductImage 객체 생성
			
			String originName = mainImg.getOriginalFilename();
			String changeName = fileRename(productNo, originName);
			
			try {
				mainImg.transferTo(new File(savePath + "/" + changeName));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			temp.setImageCategoryNo(0);
			temp.setProductOldImage(originName);
			temp.setProductNewImage(changeName);
			
			mainImgList.set(idx, temp);
		}
		
		int optIdx = 0;
		
		for(MultipartFile optionImg : optionalImgs) {
			ProductImage temp = null;
			
			if(optionImg.isEmpty() == false) {	
				if(optionImgList.size() > optIdx) {
					File oldFile = new File(savePath + "/" + optionImgList.get(optIdx).getProductNewImage());
					System.out.println("변경 전 파일 삭제 : " + oldFile.delete());
					temp = optionImgList.get(optIdx);
				} else {
					temp = new ProductImage();
					temp.setProductNo(productNo);
					temp.setImageCategoryNo(1);
					optionImgList.add(temp);
				}
				
				String originName = optionImg.getOriginalFilename();
				String changeName = fileRename(productNo, originName);
				
				try {
					optionImg.transferTo(new File(savePath + "/" + changeName));
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
				
				temp.setImageCategoryNo(1);
				temp.setProductOldImage(originName);
				temp.setProductNewImage(changeName);
				
				optionImgList.set(optIdx, temp);				
			}
			optIdx++;
		}
		
		int conIdx = 0;
		
		for(MultipartFile contentImg : contentImgs) {
			ProductImage temp = null;
			
			if(contentImg.isEmpty() == false) {	
				if(contentImgList.size() > conIdx) {
					File oldFile = new File(savePath + "/" + contentImgList.get(conIdx).getProductNewImage());
					System.out.println("변경 전 파일 삭제 : " + oldFile.delete());
					temp = contentImgList.get(conIdx);
				} else {
					temp = new ProductImage();
					temp.setImageCategoryNo(2);
					temp.setProductNo(productNo);
					contentImgList.add(temp);
				}
				
				String originName = contentImg.getOriginalFilename();
				String changeName = fileRename(productNo, originName);
				
				try {
					contentImg.transferTo(new File(savePath + "/" + changeName));
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
				
				temp.setImageCategoryNo(2);
				temp.setProductOldImage(originName);
				temp.setProductNewImage(changeName);
				
				contentImgList.set(conIdx, temp);				
			}
			conIdx++;
		}
		
		int result = productService.updateProduct(product, mainImgList, optionImgList, contentImgList);
		return "seller/sellerMain";
	}
	
	@RequestMapping("/seller/reviewList.do")
	   public String reviewList(HttpServletRequest request, Model model) {

	      HttpSession session = request.getSession(false);
	      
	      Seller s = (Seller)session.getAttribute("seller");
	      
	      String sellerId = s.getSellerId();
	      
	      // 판매자가 올린 상품 리뷰 리스트
	      List<Review> reviewList = productService.selectReivewList(sellerId);
	      
	      // 해당 리뷰의 상품
	      List<Product> rpList = new ArrayList<Product>();

	      for(int i = 0; i < reviewList.size(); i++) {
	         
	         int reviewNo = reviewList.get(i).getReviewNo();
	         
	         Product rp = productService.selectRproduct(reviewNo);
	         
	         rpList.add(rp);
	         
	      }
	      
	      int totalProduct = reviewList.size();
	      
	      model.addAttribute("totalProduct", totalProduct);
	      model.addAttribute("reviewList", reviewList);
	      model.addAttribute("rpList", rpList);
	      
	      return "productManage/reviewList";

	   }
	   

	   @RequestMapping("/seller/searchReviewProd.do")
	   public String searchReview( @RequestParam(value="productName", required=false) String productName,
	                        @RequestParam(value="categoryNo", required=false) int categoryNo,
	                        @RequestParam(value="categoryNo2", required=false) int categoryNo2,
	                        @RequestParam(value="productBrand", required=false) String productBrand,
	                        @RequestParam(value="productNo", required=false, defaultValue="-1") int productNo,
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
	      
	      System.out.println(map);
	      
	      // 조건에 맞는 리뷰 리스트
	      List<Review> reviewList = productService.selectSearchReview(map);
	      
	      System.out.println(reviewList);
	      
	      // 해당 리뷰의 상품
	      List<Product> rpList = new ArrayList<Product>();

	      for(int i = 0; i < reviewList.size(); i++) {
	         
	         int reviewNo = reviewList.get(i).getReviewNo();
	         
	         Product rp = productService.selectRproduct(reviewNo);
	         
	         rpList.add(rp);
	         
	      }
	      
	      int totalProduct = reviewList.size();
	      
	      model.addAttribute("totalProduct", totalProduct);
	      model.addAttribute("reviewList", reviewList);
	      model.addAttribute("rpList", rpList);
	      
	      //return null;
	      return "productManage/reviewList";
	   }
	   
	   @RequestMapping("/seller/qnaList.do")
	   public String qnaList(HttpServletRequest request, Model model) {

	      HttpSession session = request.getSession(false);
	      
	      Seller s = (Seller)session.getAttribute("seller");
	      
	      String sellerId = s.getSellerId();
	      
	      // 판매자가 올린 상품 문의 리스트
	      List<QnA> qnaList = productService.selectQnaList(sellerId);
	      
	      // 해당 문의의 상품
	      List<Product> qpList = new ArrayList<Product>();

	      for(int i = 0; i < qnaList.size(); i++) {
	         
	         int qnaNo = qnaList.get(i).getQNo();
	         
	         Product qp = productService.selectQproduct(qnaNo);
	         
	         qpList.add(qp);
	         
	      }
	      
	      int totalQna = qnaList.size();
	      
	      model.addAttribute("totalQna", totalQna);
	      model.addAttribute("qnaList", qnaList);
	      model.addAttribute("qpList", qpList);
	      
	      return "productManage/qnaList";

	   }
	   
	   @RequestMapping("/seller/searchQnaProd.do")
	   public String searchQna( @RequestParam(value="productName", required=false) String productName,
	                        @RequestParam(value="categoryNo", required=false) int categoryNo,
	                        @RequestParam(value="categoryNo2", required=false) int categoryNo2,
	                        @RequestParam(value="productBrand", required=false) String productBrand,
	                        @RequestParam(value="productNo", required=false, defaultValue="-1") int productNo,
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
	      
	      System.out.println(map);
	      
	      // 조건에 맞는 리뷰 리스트
	      List<QnA> qnaList = productService.selectSearchQna(map);
	      
	      System.out.println(qnaList);
	      
	      // 해당 리뷰의 상품
	      List<Product> qpList = new ArrayList<Product>();

	      for(int i = 0; i < qnaList.size(); i++) {
	         
	         int qNo = qnaList.get(i).getQNo();
	         
	         Product qp = productService.selectRproduct(qNo);
	         
	         qpList.add(qp);
	         
	      }
	      
	      int totalQna = qnaList.size();
	      
	      model.addAttribute("totalQna", totalQna);
	      model.addAttribute("qnaList", qnaList);
	      model.addAttribute("qpList", qpList);
	      
	      //return null;
	      return "productManage/qnaList";
	   }
}











