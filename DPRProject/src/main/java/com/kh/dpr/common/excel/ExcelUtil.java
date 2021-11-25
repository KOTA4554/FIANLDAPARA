package com.kh.dpr.common.excel;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellReference;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExcelUtil {

	/**
	 * 엑셀파일을 읽어서 Workbook 객체를 리턴한다.
	 * XLS와 XLSX 확장자를 비교한다.
	 * @param filePath
	 * @return
	 */
	public static Workbook getWorkbook(String filePath) {

		/*
         * FileInputStream은 파일의 경로에 있는 파일을
         * 읽어서 Byte로 가져온다.
         *
         * 파일이 존재하지 않는다면은
         * RuntimeException이 발생된다.
         */
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(filePath);
		}catch(FileNotFoundException e) {
			throw new RuntimeException(e.getMessage(), e);
		}

		Workbook workbook = null;

		/*
         * 파일의 확장자를 체크해서 .XLS 라면 HSSFWorkbook에
         * .XLSX라면 XSSFWorkbook에 각각 초기화 한다.
         */
		if(filePath.toUpperCase().endsWith(".XLS")) {
			try {
				workbook = new HSSFWorkbook(fis);
			}catch (IOException  e) {
				throw new RuntimeException(e.getMessage(), e);
			}
		}else if(filePath.toUpperCase().endsWith(".XLSX")) {
			try {
				workbook = new XSSFWorkbook(fis);
			}catch (IOException e) {
				throw new RuntimeException(e.getMessage(), e);
			}
		}

		return workbook;
	}

	/**
     * Cell에 해당하는 Column Name을 가젼온다(A,B,C..)
     * 만약 Cell이 Null이라면 int cellIndex의 값으로
     * Column Name을 가져온다.
     * @param cell
     * @param cellIndex
     * @return
     */
    public static String getName(Cell cell, int cellIndex) {
        int cellNum = 0;
        if(cell != null) {
            cellNum = cell.getColumnIndex();
        }
        else {
            cellNum = cellIndex;
        }
        
        return CellReference.convertNumToColString(cellNum);
    }


    public static String getValue(Cell cell) {
        String value = "";

		if(cell == null) {
		    value = "";
		}else {
			switch(cell.getCellType()) {
				case FORMULA :
					value = cell.getCellFormula();
					break;
				case NUMERIC :
					value = (int)cell.getNumericCellValue() + "";	//(int)형변환 미변환시 소수점 발생가능
					break;
				case STRING :
					value = cell.getStringCellValue();
					break;
				case BOOLEAN :
					value = cell.getBooleanCellValue() + "";
					break;
				case ERROR :
					value = cell.getErrorCellValue() + "";
					break;
				case BLANK :
					value = "";
					break;
				default :
					value = cell.getStringCellValue();
			}

		}
		return value;
    }

    /**
     * 엑셀파일 내용 읽어오기
     * Service에서 이 함수 호출
     * @param excelReadOption
     * @return
     */
    public static List<Map<String, String>> excelRead(ExcelReadOption excelReadOption) {
    	//엑셀 파일 자체
    	//엑셀파일을 읽어 들인다.
		//FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.
    	Workbook wb = getWorkbook(excelReadOption.getFilePath());
    	/**
    	 * 엑셀 파일에서 첫번째 시트를 가지고 온다.
    	 */
    	Sheet sheet = wb.getSheetAt(0);

//    	System.out.println("Sheet 이름: "+ wb.getSheetName(0));
//    	System.out.println("데이터가 있는 Sheet의 수 :" + wb.getNumberOfSheets());
    	/**
    	 * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
    	 */
    	int numOfRows = sheet.getPhysicalNumberOfRows();
    	int numOfCells = 0;

    	Row row = null;
    	Cell cell = null;

    	String cellName = "";
    	/**
    	 * 각 row마다의 값을 저장할 맵 객체
    	 * 저장되는 형식은 다음과 같다.
    	 * put("A", "이름");
    	 * put("B", "게임명");
    	 */
    	Map<String, String> map = null;
    	/*
    	 * 각 Row를 리스트에 담는다.
    	 * 하나의 Row를 하나의 Map으로 표현되며
    	 * List에는 모든 Row가 포함될 것이다.
    	 */
    	List<Map<String, String>> result = new ArrayList<Map<String, String>>();
    	/**
    	 * 각 Row만큼 반복을 한다.
    	 */
    	for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {
    		/*
    		 * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
    		 * 하나의 Row는 여러개의 Cell을 가진다.
    		 */
			row = sheet.getRow(rowIndex);

			if(row != null) {
				//가져온 Row의 Cell의 개수를 구한다.
				//한개의 행마다 몇개의 cell이 있는지 리턴
				//numOfCells = row.getPhysicalNumberOfCells();

				//마지막 셀의 숫자 리턴
				numOfCells = row.getLastCellNum();

				/*
				 * 데이터를 담을 맵 객체 초기화
				 */
				map = new HashMap<String, String>();
				/*
				 * cell의 수 만큼 반복한다.
				 */
				for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {
					/*
					 * Row에서 CellIndex에 해당하는 Cell을 가져온다.
					 */
					cell = row.getCell(cellIndex);
					/*
					 * 현재 Cell의 이름을 가져온다
					 * 이름의 예 : A,B,C,D,......
					 */
					cellName = getName(cell, cellIndex);
					/*
					 * 추출 대상 컬럼인지 확인한다
					 * 추출 대상 컬럼이 아니라면,
					 * for로 다시 올라간다
					 */
					if( !excelReadOption.getOutputColumns().contains(cellName) ) {
						continue;
					}
					/*
					 * map객체의 Cell의 이름을 키(Key)로 데이터를 담는다.
					 */
					map.put(cellName, getValue(cell));
				}
				//행번호 추가
				map.put("rowNum", String.valueOf(rowIndex+1));
				/*
				 * 만들어진 Map객체를 List로 넣는다.
				 */
				result.add(map);
			}
    	}
    	return result;
    }
}