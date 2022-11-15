package com.green.meal.controller;

import com.green.meal.domain.ItemVO;
import com.green.meal.domain.OrderDetailDto;
import com.green.meal.domain.OrderDetailVO;
import com.green.meal.service.ItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ItemDetailController {
    @Autowired
    ItemService itemService;

    // item 상세페이지------------------------------------------------------------- //
    @RequestMapping(value="/itemDetail")
    public String itemDetail(ItemVO vo, Model m) {
        try {
            vo = itemService.itemdetail(vo);
            m.addAttribute("itemResult",vo);

            return "itemDetail" ;

        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("message", "item_detail error");

            return "redirect:home";
        }
    } //itemDetail

    // ** itemDetailPage(Ajax)
    @RequestMapping(value="/itemDetailPage")
    public String itemDetailPage(ItemVO vo, Model m) {
        try {
            vo = itemService.itemdetail(vo);
            m.addAttribute("itemResult",vo);

            return "itemDetailPage" ;

        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("message", "item_detail_page error");

            return "redirect:itemDetail?itemNo="+vo.getItemNo();
        }
    }

    // ** DeliInfo(Ajax)
    @RequestMapping(value="/deliInfo")
    public String itemDetailPage(Model m) {
        return "itemDelyInfo";
    }


    //    ========= 상세페이지->결제페이지 작업 중 코드(정무혁) =============

    @RequestMapping("/buy")
    public String buy(OrderDetailDto dto, Model m) {
        m.addAttribute("dto", dto);
        return "payment";
    }

    @PostMapping("/paymentConfirm")
    public String paymentConfirm() {
        return "paymentConfirm";
    }

} //itemDetailController
