package green_project;

public class UserDTO {
	/***********************************************************************************/

	// 담당 : 이인상

	/***********************************************************************************/
	private String id;
	private String pw;
	private String name;
	private int age;
	private String mobile;
	private String email;
	private int point;
	private int authority;
	
	public UserDTO(String id, String pw, String name, int age, String mobile, String email,int point, int authority) {
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.age = age;
		this.email = email;
		this.mobile = mobile;
		this.point = point;
		this.authority = authority;
	}

	public String getId() {
		return id;
	}

	public String getPw() {
		return pw;
	}

	public String getName() {
		return name;
	}

	public int getAge() {
		return age;
	}

	public String getMobile() {
		return mobile;
	}

	public String getEmail() {
		return email;
	}

	public int getPoint() {
		return point;
	}

	public int getAuthority() {
		return authority;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setPoint(int point) {
		this.point = point;
	}
	
	
}
