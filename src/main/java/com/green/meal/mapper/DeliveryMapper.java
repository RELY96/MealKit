package com.green.meal.mapper;

import com.green.meal.domain.DeliveryVO;
import com.green.meal.domain.UserVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


public interface DeliveryMapper {
    List<DeliveryVO> selectDelivery(String userId);

    int delyProc(DeliveryVO dely);

    int updateDelivery(Map map);

    int updateDelivery2(String userId);

    int updateDelivery3(DeliveryVO vo);

    int deleteDelivery(DeliveryVO dely);

    int selectBase(String userId);

    List<DeliveryVO> delyList(String userId);

    DeliveryVO selectedDely(HashMap map);

    int insertDely(UserVO user);

    int countDelyPlace(Map map);

}
