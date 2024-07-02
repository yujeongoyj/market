package com.nc13.coupang.service;


import com.nc13.coupang.model.CartDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartService {

    @Autowired
    private SqlSession session;

    private final String NAMESPACE = "com.nc13.mappers.CartMapper";

    public void addToCart(CartDTO cartDTO) {
        session.insert(NAMESPACE + ".insert" , cartDTO);
    }

    public List<CartDTO> selectAll(int userId) {
        return session.selectList( NAMESPACE + ".selectAll", userId);
    }


    public void delete(int id) {
        session.delete(NAMESPACE + ".delete", id);
    }
}
