package com.nc13.coupang.controller;

import com.nc13.coupang.model.ProductDTO;
import com.nc13.coupang.model.UserDTO;
import com.nc13.coupang.service.BoardService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/board/")
public class BoardController {

    @Autowired
    private BoardService boardService;

    @GetMapping("showAll")
    public String moveToFirstPage() {
        return "redirect:/board/showAll/1";
    }

    @GetMapping("showAll/{pageNo}")
    public String showAll(HttpSession session, Model model, @PathVariable int pageNo) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if (logIn == null) {
            return "redirect:/";
        }

        // 전체 페이지 수
        int maxPage = boardService.selectMaxPage();
        model.addAttribute("maxPage", maxPage);

        // 시작 페이지, 끝 페이지 계산
        int startPage;
        int endPage;

        if (maxPage < 5) {
            startPage = 1;
            endPage = maxPage;
        } else if (pageNo <= 3) {
            startPage = 1;
            endPage = 5;
        } else if (pageNo >= maxPage - 2) {
            startPage = maxPage - 4;
            endPage = maxPage;
        } else {
            startPage = pageNo - 2;
            endPage = pageNo + 2;
        }

        // 현재 페이지 정보 전달
        model.addAttribute("curPage", pageNo);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);

        // 해당 페이지의 상품 목록 조회 및 전달
        List<ProductDTO> list = boardService.selectAll(pageNo);
        model.addAttribute("list", list);

        return "board/showAll";
    }

    @GetMapping("write")
    public String showWrite(HttpSession session) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if (logIn == null) {
            return "redirect:/";
        }
        return "board/write";
    }

    @GetMapping("showOne/{id}")
    public String showOne(HttpSession session, @PathVariable int id, Model model, RedirectAttributes redirectAttributes) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if (logIn == null) {
            return "redirect:/";
        }

        ProductDTO productDTO = boardService.selectOne(id);

        if (productDTO == null) {
            redirectAttributes.addFlashAttribute("message", "해당 글 번호는 유효하지 않습니다.");
            return "redirect:/showMessage";
        }

        model.addAttribute("productDTO", productDTO);

        return "board/showOne";
    }
}
