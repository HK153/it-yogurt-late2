package com.starters.ityogurt.dao;

import com.starters.ityogurt.dto.CategoryDTO;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface CategoryDAO {
	List<CategoryDTO> getAllCategoryList();
	CategoryDTO getCategoryByCategorySeq(String categorySeq);

	int countAllSub();
	List<CategoryDTO> getCategoryByType(String type, String typeValue);
	CategoryDTO getCategoryByAllType(CategoryDTO categoryDTO);
	
	void insertCategory(CategoryDTO categoryDTO);
}
