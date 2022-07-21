package green_project;

import java.sql.Date;

import model.Board;

/***********************************************************************************/

//담당 : 이인상

/***********************************************************************************/

public class AnnouncementDTO extends Board{

	public AnnouncementDTO(int no, String id, String title, String contents, Date written) {
		super(no, id, title, contents, written);
	}
	
}
