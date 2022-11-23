package com.green.meal.domain;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CartVO {
    private String userId;
    private Integer itemNo;
    private String itemName;
    private Integer cartAmount;
    private Integer itemPrice;
    private String fileName;

}