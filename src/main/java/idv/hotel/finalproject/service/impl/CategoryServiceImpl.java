package idv.hotel.finalproject.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import idv.hotel.finalproject.dao.CategoryDao;
import idv.hotel.finalproject.dao.ProductDao;
import idv.hotel.finalproject.model.CategoryBean;
import idv.hotel.finalproject.model.ProductBean;
import idv.hotel.finalproject.service.CategoryService;
@Transactional
@Service
public class CategoryServiceImpl implements CategoryService{
	CategoryDao categoryDao;
	ProductDao productDao;
	@Autowired
	public CategoryServiceImpl(CategoryDao categoryDao,ProductDao productDao) {
		super();
		this.categoryDao = categoryDao;
		this.productDao = productDao;
	}

	@Override
	public List<CategoryBean> showAllCategory() {
		return categoryDao.findAll();
	}
	
	
	
	public Page<ProductBean> findByPage(Integer categoryId,Integer pageNumber){
//		Integer categoryNum = categoryDao.findAll().size();
//		ArrayList<Page<ProductBean>> categoryPages = new ArrayList<Page<ProductBean>>();
//		for(int i=0;i<categoryNum;i++) {
//			Pageable pgb = PageRequest.of(pageNumber-1, 16, Sort.Direction.DESC, "productId");
//			Page<ProductBean> temp = productDao.findByCategory(categoryId,pgb);
//			categoryPages.add(temp);
//		}
//		return categoryPages;
		Pageable pgb = PageRequest.of(pageNumber-1, 16, Sort.Direction.DESC, "productId");
		Page<ProductBean> categoryPages = productDao.findByCategory(categoryId,pgb);
		System.out.println(categoryPages.getNumber());
		System.out.println(categoryPages.getSize());
		System.out.println(categoryPages.getTotalPages());
		return categoryPages;
	}
	
	
	
	
}
