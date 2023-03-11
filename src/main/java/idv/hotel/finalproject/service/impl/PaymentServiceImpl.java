package idv.hotel.finalproject.service.impl;

import java.util.Date;

import org.springframework.stereotype.Service;

import ecpay.payment.integration.AllInOne;
import ecpay.payment.integration.domain.AioCheckOutALL;
import idv.hotel.finalproject.service.PaymentService;

@Service
public class PaymentServiceImpl implements PaymentService {
	private static AllInOne all = new AllInOne("");

	@Override
	public String genAioCheckOutALL(String ItemName, String TradeDesc, String TotalAmount) {

		AioCheckOutALL obj = new AioCheckOutALL();
		obj.setMerchantTradeNo(String.format("III%d", new Date().getTime())); // 特店交易編號均為唯一值，不可重複使用。英數字大小寫混合。
		obj.setMerchantTradeDate(String.format("%tY/%<tm/%<td %<tH:%<tM:%<tS", new Date())); // 特店交易時間。格式為：yyyy/MM/dd
																								// HH:mm:ss。
		obj.setTotalAmount(TotalAmount); // 交易金額。請帶整數，不可有小數點。僅限新台幣。
		obj.setTradeDesc(TradeDesc); // 交易描述。請勿帶入特殊字元。
		obj.setItemName(ItemName); // 商品名稱
									// 1. 如果商品名稱有多筆，需在金流選擇頁一行一行顯示商品名稱的話，商品名稱請以符號#分隔。
									// 2. 商品名稱字數限制為中英數 400 字內，超過此限制系統將自動截斷。

		obj.setNeedExtraPaidInfo("N");

		// ***付款結果通知我們伺服端的方式(可二選一)***//
		// A.以Server端(綠界)方式直接回傳付款結果通知
		obj.setReturnURL("https://220.133.103.95/main/ECPayEnd");
		// 當消費者付款完成後，綠界會將付款結果參數以幕後(Server POST)回傳到該網址(該網址須是一個固定IP且使用https協定)。
		// 必設欄位。但我們可以忽略相關的後續處理作業。
		// B.以Client端(消費者)方式回傳付款結果通知
		obj.setOrderResultURL("http://localhost:8080/main/ECPayEnd");
		// 當消費者付款完成後，綠界會將付款結果參數以幕前(Client POST)回傳到該網址。
		// 若與下面[ClientBackURL]同時設定，將會以此參數為主。
		// ********************************//

		// obj.setClientBackURL("http://localhost:8080/ecpay/ECPayServer3");
		// 綠界付款成功畫面會增加「返回商店」按鈕，消費者點選此按鈕後，會將頁面導回到此設定的網址
		// (注意：導回時不會帶付款結果到此網址，只是將頁面(以GET方法)導回而已。)

		String form = all.aioCheckOut(obj, null);
		return form;
	}

}
