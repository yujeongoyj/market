package com.nc13.coupang.model;

import lombok.Data;

@Data
public class ProductDTO {
    private int id;
    private String name;
    private String description;
    private int price;
    private int amount;


}
