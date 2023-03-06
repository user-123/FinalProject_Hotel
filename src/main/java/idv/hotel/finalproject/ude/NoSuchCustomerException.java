package idv.hotel.finalproject.ude;

@SuppressWarnings("serial")
public class NoSuchCustomerException extends RuntimeException {
	private Integer id;
	
	public NoSuchCustomerException() {
	}

	public NoSuchCustomerException(String message) {
		super(message);
	}

	public NoSuchCustomerException(Throwable cause) {
		super(cause);
	}

	public NoSuchCustomerException(String message, Throwable cause) {
		super(message, cause);
	}

	public NoSuchCustomerException(String message, Throwable cause, boolean enableSuppression,
			boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

	public NoSuchCustomerException(int id) {
		this.id = id;
	}

	public Integer getId() {
		return id;
	}

}
