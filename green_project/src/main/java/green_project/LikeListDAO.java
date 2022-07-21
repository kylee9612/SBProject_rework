package green_project;

import java.util.ArrayList;

public class LikeListDAO {
	/***********************************************************************************/

	// 담당 : 이인상

	/***********************************************************************************/

	private static LikeListDAO instance = new LikeListDAO();
	
	
	private LikeListDAO() {}
	
	public static LikeListDAO getInstance() {
		return instance;
	}
	
	private DBManager dbm = new DBManager(); 
	private ArrayList<LikeListDTO> list;
	
	/**********************************************************************************************/
	
	public boolean addLikeItem(String id,int code) {
		LikeListDTO like = new LikeListDTO(id, code);
		return dbm.addLikeList(like) && dbm.addLikeCount(code);
	}
	
	public boolean deleteLikeItem(String id,int code) {
		LikeListDTO like = new LikeListDTO(id, code);
		return dbm.deleteLikeList(like) && dbm.minusLikeCount(code);
	}
	
	public ArrayList<LikeListDTO> getLikeList(String id){
		return list=dbm.getLikeList(id);
	}
	
	public ArrayList<ItemDTO> getLikeListItem(String id){
		this.list=dbm.getLikeList(id);
		ArrayList<ItemDTO> itemList = new ArrayList<ItemDTO>();
		for(LikeListDTO like : list) {
			ItemDTO item = dbm.getItem(like.getCode());
			itemList.add(item);
		}
		return itemList;
	}
	
	
	/**********************************************************************************************/
}
