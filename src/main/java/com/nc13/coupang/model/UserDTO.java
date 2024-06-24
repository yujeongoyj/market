package com.nc13.coupang.model;

import lombok.Data;

@Data
public class UserDTO {
    private int id;
    private String username;
    private String password;
    private String nickname;
    private boolean isAdmin;
    private String address;

}
