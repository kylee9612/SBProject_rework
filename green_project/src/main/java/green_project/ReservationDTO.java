package green_project;

import java.sql.Date;
import java.text.SimpleDateFormat;

public class ReservationDTO {
	
	/***********************************************************************************/

	// 담당 : 이인상

	/***********************************************************************************/
	
	private Date reserve_date;
	private Date checkin_date;
	private Date checkout_date;
	private int price;
	private String id;
	private int code;
	private int review;
	private int reservation_code;
	
	public ReservationDTO (Date checkin_date, Date checkout_date, int price, String id, int code) {
		Date reserve_date = new Date(System.currentTimeMillis());
		SimpleDateFormat sim = new SimpleDateFormat("yyyy-mm-dd");
		reserve_date = Date.valueOf(sim.format(reserve_date));
		this.reserve_date = reserve_date;
		this.checkin_date = checkin_date;
		this.checkout_date = checkout_date;
		this.price = price;
		this.id = id;
		this.code = code;
	}
	
	public ReservationDTO (Date checkin_date, Date checkout_date, int price, String id, int code, int reservation_code) {
		Date reserve_date = new Date(System.currentTimeMillis());
		SimpleDateFormat sim = new SimpleDateFormat("yyyy-mm-dd");
		reserve_date = Date.valueOf(sim.format(reserve_date));
		this.reserve_date = reserve_date;
		this.checkin_date = checkin_date;
		this.checkout_date = checkout_date;
		this.price = price;
		this.id = id;
		this.code = code;
		this.reservation_code = reservation_code;
	}
	
	public ReservationDTO (Date reserve_date,Date checkin_date, Date checkout_date, int price, String id, int code,int review, int reservation_code) {
		this.reserve_date = reserve_date;
		this.checkin_date = checkin_date;
		this.checkout_date = checkout_date;
		this.price = price;
		this.id = id;
		this.code = code;
		this.review = review;
		this.reservation_code = reservation_code;
	}

	public Date getReserve_date() {
		return reserve_date;
	}

	public Date getCheckin_date() {
		return checkin_date;
	}

	public Date getCheckout_date() {
		return checkout_date;
	}

	public int getPrice() {
		return price;
	}

	public String getId() {
		return id;
	}

	public int getCode() {
		return code;
	}

	public int getReview() {
		return review;
	}

	public int getReservationCode() {
		return reservation_code;
	}
	public void setReview(int review) {
		this.review = review;
	}
	
}
