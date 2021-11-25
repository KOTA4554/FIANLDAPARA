package com.kh.dpr.product.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.dpr.product.model.dao.ProductDAO;
import com.kh.dpr.product.model.vo.Product;
import com.kh.dpr.product.model.vo.ProductImage;
import com.kh.dpr.qna.model.vo.QnA;
import com.kh.dpr.review.model.vo.Review;

@Service
public class ProductService {

   @Autowired
   ProductDAO productDAO;
   
   public int insertProduct(Product product, List<ProductImage> imgList) {
      
      int productResult = productDAO.insertProduct(product);
      
      if(productResult < 0) {
         System.out.println("게시글 등록 실패");
      } else {         
         for(ProductImage img : imgList) {
            int imageResult = productDAO.insertImage(img);
            if(imageResult == 0) {
               System.out.println("첨부파일 전송 실패");
            }
         }
      }
      
      return productResult;
   }

   public int selectPno() {
      return productDAO.selectPno();
   }

   public int insertTempProduct() {
      return productDAO.insertTempProduct();
   }

   public int selectTempProduct() {
      return productDAO.selectTempProduct();
   }

   public int insertOption(Product opt) {
      return productDAO.insertOption(opt);
   }

   public List<Map<String, String>> selectProductList(String sellerId, int cPage, int numPerPage) {
      return productDAO.selectProductList(sellerId, cPage, numPerPage);
   }

   public int selectTotalProduct(String sellerId) {
      return productDAO.selectTotalProduct(sellerId);
   }

   public List<Map<String, String>> searchProductList(Map map, int cPage, int numPerPage) {
      return productDAO.searchProductList(map, cPage, numPerPage);
   }

   public int selectSearchedProduct(Map<String, Object> map) {
      return productDAO.selectSearchedProduct(map);
   }

   public Product selectOneProduct(int productNo) {
      return productDAO.selectOneProduct(productNo);
   }

   public List<Product> selectOptionList(int productNo) {
      return productDAO.selectOptionList(productNo);
   }

   public List<ProductImage> selectImageList(int productNo) {
      return productDAO.selectImageList(productNo);
   }
   
   public List<Review> selectReivewList(String sellerId) {      
      return productDAO.selectReviewList(sellerId);
   }

   public Product selectRproduct(int reviewNo) {
      return productDAO.selectRproduct(reviewNo);

   }

   public int updateOption(Product opt) {
      return productDAO.updateOption(opt);
   }

   public List<ProductImage> selectImage(Map<String, Integer> setting) {
      return productDAO.selectImage(setting);
   }

   public int updateProduct(Product product, List<ProductImage> mainImgList, List<ProductImage> optionImgList,
         List<ProductImage> contentImgList) {
      
      int totalResult = 0;
      
      // 1. 게시글 업데이트
      totalResult = productDAO.insertProduct(product);
      
      Map<String, Integer> setting = new HashMap();
      setting.put("productNo", product.getProductNo());

      setting.put("category", 0);
      List<ProductImage> originMain = selectImage(setting);
      if(originMain.size() > 0) {
         totalResult = productDAO.deleteImage(setting);
      }
      if(mainImgList.size() > 0) {
         for(ProductImage img : mainImgList) {
            img.setImageCategoryNo(0);
            totalResult = productDAO.insertImage(img);
         }
      }
      
      setting.put("category", 1);
      List<ProductImage> originOpt = selectImage(setting);
      if(originOpt.size() > 0) {
         totalResult = productDAO.deleteImage(setting);
      }
      if(optionImgList.size() > 0) {
         for(ProductImage img : optionImgList) {
            img.setImageCategoryNo(1);
            totalResult = productDAO.insertImage(img);
         }
      }
      
      setting.put("category", 2);
      List<ProductImage> originCon = selectImage(setting);
      if(originCon.size() > 0) {
         totalResult = productDAO.deleteImage(setting);
      }
      if(contentImgList.size() > 0) {
         for(ProductImage img : contentImgList) {
            img.setImageCategoryNo(2);
            totalResult = productDAO.insertImage(img);
         }
      }

      return totalResult;
   }


   public List<Review> selectSearchReview(Map<String, Object> map) {
         
      return productDAO.selectSearchReview(map);
   }

   public List<QnA> selectQnaList(String sellerId) {
         
      return productDAO.selectQnaList(sellerId);
   }

   public Product selectQproduct(int qnaNo) {
         
      return productDAO.selectQproduct(qnaNo);
   }

   public List<QnA> selectSearchQna(Map<String, Object> map) {
         
      return productDAO.selectSearchQna(map);
   }
}