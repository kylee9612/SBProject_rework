package model;

import java.sql.Date;

public class QuestionDTO extends Board{
	/***********************************************************************************/

	// 담당 : 이인상

	/***********************************************************************************/
	
	public QuestionDTO(int no, String id, String title, String contents, Date written) {
		super(no, id, title, contents, written);
	}
}
