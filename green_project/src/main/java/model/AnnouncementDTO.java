package model;

import java.sql.Date;

/***********************************************************************************/

//담당 : 이인상

/***********************************************************************************/

public class AnnouncementDTO extends Board{

	public AnnouncementDTO(int no, String id, String title, String contents, Date written) {
		super(no, id, title, contents, written);
	}
	
}
