package green_project;

import java.util.ArrayList;


public class ItemDAO {
	/**********************************************************************************************/
	
	//	담당 : 이인상
	
	/**********************************************************************************************/
	DBManager dbm = new DBManager();
	
	private static ItemDAO instance = new ItemDAO();

	private ItemDAO() {
	}

	public static ItemDAO getInstance() {
		return instance;
	}

	/**********************************************************************************************/
	
	public ArrayList<ItemDTO> getItemList(String id ,String address){
		ArrayList<ItemDTO> itemList = dbm.getItemList(id,address);
		return itemList;
	}
	
	public ArrayList<ItemDTO> getItemList(String address){
		ArrayList<ItemDTO> itemList = dbm.getItemList(address);
		return itemList;
	}
	//park 오류나면 바로 지우겠습니다
	public ArrayList<ItemDTO> getItemLists(String id){
		ArrayList<ItemDTO> itemLists = dbm.getItemLists(id);
		return itemLists;
	}
	
	public ArrayList<ItemDTO> getItemList(){
		return dbm.getItemList();
	}
	
	public ItemDTO getItem(int code) {
		ItemDTO item = dbm.getItem(code);
		return item;
	}
	
	public boolean uploadItem(String id, String name, String address, String category, int price, String thumbnail, String contents, int max_people) {
		System.out.println("여기냐?1");
		ItemDTO item = new ItemDTO(id, name, address,dbm.getRanCode(), 0, 0, category, price, thumbnail, contents,0, max_people);
		System.out.println("여기냐?2");
		return dbm.addItem(item);
	}
	
	public boolean deleteItem(String id, int code) {
		ItemDTO item = dbm.getItem(code);
		if(checkValidId(id, item)){
			return dbm.deleteItem(item);
		}
		else {
			return false;
		}
	}
	
	//	type : 변경할 항목 (name,thumbnail, price 등등)
	public boolean updateItem(String type, String id, int code) {
		ItemDTO item = dbm.getItem(code);
		if(checkValidId(id,item)){
			return true;
		}
		else
			return false;
	}
	
	public ArrayList<ItemDTO> getBestViewItem(){
		return dbm.getBestViewItemList();
	}
	
	public ArrayList<ItemDTO> getBestLikeItem(){
		return dbm.getBestLikeItemList();
	}
	
	public boolean addViewCount(int code) {
		return dbm.addViewCount(code);
	}
	
	public boolean addLikeCount(int code) {
		return dbm.addLikeCount(code);
	}
	
	public boolean minusLikeCount(int code) {
		return dbm.minusLikeCount(code);
	}

	/**********************************************************************************************/
	
	private boolean checkValidId(String id, ItemDTO item) {
		return id.equals(item.getId());
	}
}
