package com.nc13.coupang.RestController;


import com.nc13.coupang.model.CartDTO;
import com.nc13.coupang.model.UserDTO;
import com.nc13.coupang.service.CartService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/cart")
public class CartRestController {

    @Autowired
    CartService cartService;


    @PostMapping("/add")
    public String addToCart(@RequestParam("productId") int productId,
                            @RequestParam("quantity") int quantity, HttpSession session) {
        UserDTO userDTO = (UserDTO) session.getAttribute("logIn");
        CartDTO cartDTO = new CartDTO();
        cartDTO.setUserId(userDTO.getId());
        cartDTO.setProductId(productId);
        cartDTO.setProductName(cartDTO.getProductName());
        cartDTO.setQuantity(quantity);

        cartService.addToCart(cartDTO);

        return "redirect:/board/showOne/${productId}";
    }

}
