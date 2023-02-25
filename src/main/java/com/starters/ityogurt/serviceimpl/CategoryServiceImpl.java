package com.starters.ityogurt.serviceimpl;

import com.starters.ityogurt.dto.UserDTO;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.starters.ityogurt.dao.CategoryDAO;
import com.starters.ityogurt.dto.CategoryDTO;
import com.starters.ityogurt.service.CategoryService;

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
	public int countAllSub() {
		return dao.countAllSub();
	}

	@Override
	public List<CategoryDTO> getCategoryByType(String type, String typeValue) {
		return dao.getCategoryByType(type, typeValue);
	}

	@Override
	public CategoryDTO getCategoryByAllType(CategoryDTO categoryDTO) {
		return dao.getCategoryByAllType(categoryDTO);

	}


    @Override
    public int findWeakCategoryByCategorySeq(int userSeq) {
        return dao.findWeakCategoryByCategorySeq(userSeq);
    }


   

  @Override
	public void insertCategory(CategoryDTO categoryDTO) {
		dao.insertCategory(categoryDTO);
	}

	@Override
	public CategoryDTO getCategoryByUserSeq(int userSeq) {
		return dao.getCategoryByUserSeq(userSeq);
	}
		@Override
		public int countAllCategory() {
			return dao.countAllCategory();
		}
}