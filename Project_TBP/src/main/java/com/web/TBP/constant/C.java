package com.web.TBP.constant;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.support.TransactionTemplate;

public class C {

	public static SqlSession sqlSession;
	public static TransactionTemplate transactionTemplate;
	
	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		C.sqlSession = sqlSession;
	}

	@Autowired
	public void setTransactionTemplate(TransactionTemplate transactionTemplate) {
		C.transactionTemplate = transactionTemplate;
	}
	
}
