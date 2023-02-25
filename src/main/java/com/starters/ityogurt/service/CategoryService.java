package com.starters.ityogurt.service;

import com.starters.ityogurt.dto.CategoryDTO;
import java.util.List;

public interface CategoryService {

    List<CategoryDTO> getAllCategoryList();
    CategoryDTO getCategoryByCategorySeq(String categorySeq);
    int countAllSub();

    List<CategoryDTO> getCategoryByType(String type, String typeValue);
    CategoryDTO getCategoryByAllType(CategoryDTO categoryDTO);

    void insertCategory(CategoryDTO categoryDTO);
    
	CategoryDTO getCategoryByUserSeq(int userSeq);
    
}
