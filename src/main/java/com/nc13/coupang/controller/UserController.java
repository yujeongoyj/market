package com.nc13.coupang.controller;


import com.nc13.coupang.model.UserDTO;
import com.nc13.coupang.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.apache.catalina.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/user/")
@RequiredArgsConstructor
public class UserController {

    // 실제 SQL 통신을 담당할 Service 객체
    @Autowired
    private UserService userService;


    // 사용자가 로그인을 할 시 실행할
    // auth 메소드
    @PostMapping("auth")
    // POST 혹은 GET 방식으로 웹페이지의 값을 받아올 때에는
    // 파라미터에 해당 form의 name 어트리뷰트와 같은 이름을 가진
    // 파라미터를 적어주면 된다.
    // 또한, 해당 name 어트리뷰트를 필드로 가진 클래스 객체를 파라미터로 잡아주면
    // 자동으로 데이터가 바인딩 된다.
    public String auth(UserDTO userDTO, HttpSession session) {
        UserDTO result = userService.auth(userDTO);

        if (result != null && result.getUsername().equals("admin") && result.getPassword().equals("1234")) {
            result.setIsSeller("true");
        }

        if (result != null) {
            session.setAttribute("logIn", result);
            if ("true".equals(result.getIsSeller())) {
                System.out.println("판매자");
                result.setIsSeller("true");
            } else {
                System.out.println("구매자");
                result.setIsSeller("false");

            }
            return "redirect:/board/showAll";
        }

        // 만약 우리가 해당 메소드를 실행시키고 나서 특정 URL로 이동시킬때에는 다음과 같이 적어준다.
        return "redirect:/";
    }

    @GetMapping("register")
    public String showRegister() {
        return "user/register";
    }

    @PostMapping("register")
    public String register(UserDTO userDTO,@RequestParam("role") String role, RedirectAttributes redirectAttributes) {
        if (userService.validateUsername(userDTO.getUsername())) {
            userDTO.setIsSeller(role);
            userService.register(userDTO);
        } else {
            redirectAttributes.addFlashAttribute("message", "중복된 아이디로는 가입하실 수 없습니다.");

            return "redirect:/showMessage";
        }
        return "redirect:/";

    }

    @GetMapping("myInfo")
    public String myInfo(HttpSession session) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if (logIn == null) {
            return "redirect:/login"; // 로그인 페이지로 리디렉션
        }
        return "/user/myInfo";
    }
}