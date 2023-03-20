package idv.hotel.finalproject.service;

import java.util.List;

import org.springframework.data.domain.Page;

import idv.hotel.finalproject.model.CategoryBean;
import idv.hotel.finalproject.model.ProductBean;

public interface CategoryService {
	List<CategoryBean> showAllCategory();
	Page<ProductBean> findByPage(Integer categoryId,Integer pageNumber);
}
