package com.kh.dpr.common;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.TypeHandler;

/**
 * TypeHandler는 3개의 getter 메소드와 1개의 setter메소드로 이루어져 있다.
 * 
 * setter :
 *   String[] ==> String
 *   
 * getter :
 *   1. ResultSet에서 컬럼 이름으로 값을 가져오는 방법
 *   2. ResultSet에서 컬럼 숫자로 값을 가져오는 방법
 *   3. PL/SQL 프로시저를 위한 값을 가져오는 방법
 * @author user1
 *
 */
public class MyTypeHandler implements TypeHandler<String[]> {

	@Override
	public void setParameter(PreparedStatement ps, int i, String[] parameter, JdbcType jdbcType) throws SQLException {
		// String[] --> join 메소드 --> String
		
		if( parameter != null ) {
			ps.setString(i, String.join(",", parameter));
		} else {
			ps.setString(i, "");
		}
		
	}

	// String --> split 메소드 --> String[]
	@Override
	public String[] getResult(ResultSet rs, String columnName) throws SQLException {
		String value = rs.getString( columnName );
		String[] result = null;
		
		if(value != null) {
			result = value.split(",");
		}
		
		return result;
	}

	@Override
	public String[] getResult(ResultSet rs, int columnIndex) throws SQLException {
		String value = rs.getString( columnIndex );
		String[] result = null;
		
		if(value != null) {
			result = value.split(",");
		}
		
		return result;
	}

	@Override
	public String[] getResult(CallableStatement cs, int columnIndex) throws SQLException {
		String value = cs.getString( columnIndex );
		String[] result = null;
		
		if(value != null) {
			result = value.split(",");
		}
		
		return result;
	}

}
