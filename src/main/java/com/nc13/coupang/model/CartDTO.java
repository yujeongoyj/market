package com.nc13.coupang.model;

import lombok.Data;

@Data
public class CartDTO {
    private int id;
    private int userId;
    private int productId;
    private int quantity;
    private ProductDTO productDTO;
    private String productName;
    private int price;

}
