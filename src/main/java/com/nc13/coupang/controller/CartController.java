package com.nc13.coupang.controller;


import com.nc13.coupang.model.CartDTO;
import com.nc13.coupang.model.UserDTO;
import com.nc13.coupang.service.CartService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/cart/")
public class CartController {
    @Autowired
    private CartService cartService;


    @GetMapping("myCart")
    public String myCart(HttpSession session, Model model) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if (logIn == null) {
            return "redirect:/";
        }


        List<CartDTO> list = cartService.selectAll(logIn.getId());
        model.addAttribute("list", list);

        return "/cart/myCart";
    }

}
