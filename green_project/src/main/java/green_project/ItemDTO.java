package green_project;

public class ItemDTO {
	/***********************************************************************************/

	// 담당 : 이인상

	/***********************************************************************************/
	
	private String id;
	private String name;
	private String address;
	private int code;
	private int view_count;
	private int like_count;
	private String category;
	private int price;
	private String thumbnail;
	private String contents;
	private float rate;
	private int max_people;
	
	public ItemDTO (String id, String name, String address, int code, int view_count,int like_count, String category, int price, String thumbnail, String contents, float rate, int max_people) {
		this.id = id;
		this.name = name;
		this.address = address;
		this.code = code;
		this.view_count = view_count;
		this.like_count = like_count;
		this.category = category;
		this.price = price;
		this.thumbnail = thumbnail;
		this.contents = contents;
		this.rate = rate;
		this.max_people =  max_people;
	}

	public String getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public String getAddress() {
		return address;
	}

	public int getCode() {
		return code;
	}

	public int getView_count() {
		return view_count;
	}

	public int getLike_count() {
		return like_count;
	}

	public String getCategory() {
		return category;
	}
	
	public int getPrice() {
		return price;
	}

	public String getThumbnail() {
		return thumbnail;
	}

	public String getContents() {
		return contents;
	}

	public float getRate() {
		return rate;
	}

	public int getMax_people() {
		return max_people;
	}
	
	public void setName(String name) {
		this.name = name;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public void setView_count(int view_count) {
		this.view_count = view_count;
	}
	public void plusView_count() {
		this.view_count++;
	}

	public void setLike_count(int like_count) {
		this.like_count = like_count;
	}
	public void plusLike_count() {
		this.like_count++;
	}
	public void minusLike_count() {
		this.like_count--;
	}
	
	public void setPrice(int price) {
		this.price = price;
	}

	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public void setRate(float rate) {
		this.rate = rate;
	}

	public void setMax_people(int max_people) {
		this.max_people = max_people;
	}
}
