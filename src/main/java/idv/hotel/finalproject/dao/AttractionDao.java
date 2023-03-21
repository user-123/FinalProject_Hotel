package idv.hotel.finalproject.dao;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import idv.hotel.finalproject.model.AttractionBean;
import idv.hotel.finalproject.model.LoginBean;
import idv.hotel.finalproject.model.RoomBean;

public interface AttractionDao extends JpaRepository<AttractionBean, Integer> {

	//基礎查詢
	//List<AttractionBean> findAll();
	//AttractionBean findById(Integer attractionId);
	AttractionBean findByAttractionId(Integer attractionId);
	AttractionBean findByAttractionNum(Integer attractionNum);
	List<AttractionBean> findByAttractionName(String attractionName);
	//@Query(value = "from Attraction where attractionCategory = ?1")
	List<AttractionBean> findByAttractionCategory(String category);
	List<AttractionBean> findByAttractionAddress(String address);
	List<AttractionBean> findByAttractionDistance(Float distance);
	List<AttractionBean> findByAttractionIntroduction(String introduction);
	void deleteByAttractionId(Integer attractionId);

	//客製查詢
	List<AttractionBean> findByAttractionNameContaining(String attractionName);
	List<AttractionBean> findByAttractionCategoryContaining(String category);
	List<AttractionBean> findByAttractionAddressContaining(String address);
	//List<AttractionBean> findByAttractionDistanceBetWeen(Float attractionDistance);
	List<AttractionBean> findByAttractionIntroductionContaining(String attractionIntroduction);





	/*interface PersonRepository extends Repository<Person, Long> {

		  List<Person> findByEmailAddressAndLastname(EmailAddress emailAddress, String lastname);

		  // Enables the distinct flag for the query
		  List<Person> findDistinctPeopleByLastnameOrFirstname(String lastname, String firstname);
		  List<Person> findPeopleDistinctByLastnameOrFirstname(String lastname, String firstname);

		  // Enabling ignoring case for an individual property
		  List<Person> findByLastnameIgnoreCase(String lastname);
		  // Enabling ignoring case for all suitable properties
		  List<Person> findByLastnameAndFirstnameAllIgnoreCase(String lastname, String firstname);

		  // Enabling static ORDER BY for a query
		  List<Person> findByLastnameOrderByFirstnameAsc(String lastname);
		  List<Person> findByLastnameOrderByFirstnameDesc(String lastname);
		}*/



}
