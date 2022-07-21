package green_project;

import java.sql.Date;

import model.Board;

/***********************************************************************************/

//담당 : 이인상

/***********************************************************************************/

public class AnswerDTO extends Board{
	private int code;
	public AnswerDTO(int no, String id, String title, String contents ,int code , Date written) {
		super(no, id, title, contents, written);
		this.code = code;
	}
	
	public int getCode() {
		return code;
	}
}
