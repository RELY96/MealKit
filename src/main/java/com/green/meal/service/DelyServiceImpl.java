package com.green.meal.service;

import com.green.meal.domain.DeliveryVO;
import com.green.meal.mapper.DeliveryMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Service
public class DelyServiceImpl implements DelyService {

    private final DeliveryMapper mapper;

    @Override
    public List<DeliveryVO> selectDelivery(String userId){
        return mapper.selectDelivery(userId);
    }

    @Override
    public int delyProc(DeliveryVO dely){
        return mapper.delyProc(dely);
    }

    @Override
    public int updateDelivery(DeliveryVO dely0, DeliveryVO dely1){
        Map map = new HashMap();
        map.put("dely0", dely0);
        map.put("dely1", dely1);
        return mapper.updateDelivery(map);
    }

    @Override
    public int updateDelivery2(String userId){
        return mapper.updateDelivery2(userId);
    }

    @Override
    public int deleteDelivery(DeliveryVO dely){
        return mapper.deleteDelivery(dely);
    }

    @Override
    public int selectBase(String userId){
        return mapper.selectBase(userId);
    }



}
