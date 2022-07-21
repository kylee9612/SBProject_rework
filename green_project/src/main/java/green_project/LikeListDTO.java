package green_project;

public class LikeListDTO {
	
	/***********************************************************************************/

	// 담당 : 이인상

	/***********************************************************************************/
	
	private String id;
	private int code;
	
	public LikeListDTO(String id, int code) {
		this.id = id;
		this.code = code;
	}

	public String getId() {
		return id;
	}

	public int getCode() {
		return code;
	}
}
