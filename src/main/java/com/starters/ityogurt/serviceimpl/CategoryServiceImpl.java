package com.starters.ityogurt.serviceimpl;

import com.starters.ityogurt.dao.CategoryDAO;
import com.starters.ityogurt.dto.CategoryDTO;
import com.starters.ityogurt.service.CategoryService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("categoryservice")
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    CategoryDAO dao;

    @Override
    public List<CategoryDTO> getAllCategoryList() {
        return dao.getAllCategoryList();
    }

    public CategoryDTO getCategoryByCategorySeq(String categorySeq) {
        return dao.getCategoryByCategorySeq(categorySeq);
    }

    @Override
    public List<CategoryDTO> getCategoryByType(String type, String typeValue) {
        return dao.getCategoryByType(type, typeValue);
    }

    @Override
    public CategoryDTO getCategoryByAllType(String main, String middle, String sub) {
        return dao.getCategoryByAllType(main, middle, sub);
    }

}
