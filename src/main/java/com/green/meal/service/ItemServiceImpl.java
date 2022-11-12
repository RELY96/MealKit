package com.green.meal.service;

import com.green.meal.domain.ItemVO;
import com.green.meal.domain.SearchCondition;
import com.green.meal.mapper.ItemMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class ItemServiceImpl implements ItemService {

    @Autowired
    ItemMapper mapper;

    @Override
    public ItemVO itemAdmin(Integer itemNo) {
        return mapper.selectOne(itemNo);
    }

    @Override
    public int itemUpload(ItemVO vo) {
        return mapper.insert(vo);
    }

    @Override
    public int itemRemove(Integer itemNo) {
        return mapper.delete(itemNo);
    }

    @Override
    public int itemModify(ItemVO vo) {

        return mapper.update(vo);

    }

    @Override
    public List<ItemVO> selectAll() {
        return mapper.selectAll();
    }

    //나중에 검색설정 하게될 때 매개변수 넣어줘야돼
    @Override
    public int getSearchResultCnt(SearchCondition sc) throws Exception {
        return mapper.searchResultCnt(sc);
    }

    @Override
    public List<ItemVO> getSearchResultPage(SearchCondition sc) throws Exception {
        return mapper.searchSelectPage(sc);
    }

}
