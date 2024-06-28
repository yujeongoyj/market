package com.nc13.coupang.controller;

import com.nc13.coupang.model.ProductDTO;
import com.nc13.coupang.model.UserDTO;
import com.nc13.coupang.service.BoardService;
import jakarta.servlet.http.HttpSession;
import net.coobird.thumbnailator.Thumbnails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import java.util.HashMap;
import java.util.List;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;
import java.util.UUID;


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


        int maxPage = boardService.selectMaxPage();
        model.addAttribute("maxPage", maxPage);


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
    public String showUploaded(HttpSession session) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if (logIn == null) {
            return "redirect:/";
        }
        return "board/write";
    }

    @PostMapping("write")
    public String upload(HttpSession session, ProductDTO productDTO, @RequestParam("file") MultipartFile file ) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if (logIn == null) {
            return "redirect:/";
        }

        if(!file.isEmpty()) {
            String fileName = file.getOriginalFilename();
            String extension = fileName.substring(fileName.lastIndexOf("."));
            String uploadName = UUID.randomUUID() + extension;

            String realPath = session.getServletContext().getRealPath("/board/uploads/");
            Path realDir = Paths.get(realPath);
            if(!Files.exists(realDir)) {
                try {
                    Files.createDirectories(realDir);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            File uploadFile = new File(realPath + uploadName);
            try {

                file.transferTo(uploadFile);
                productDTO.setImagePath("/board/uploads/" + uploadName);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }


        boardService.insert(productDTO);
        System.out.println(productDTO);

        return "redirect:/board/showOne/" + productDTO.getId();
    }

    @GetMapping("showOne/{id}")
    public String showOne(HttpSession session, @PathVariable int id, Model model, RedirectAttributes redirectAttributes) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if (logIn == null) {
            return "redirect:/";
        }

        ProductDTO productDTO = boardService.selectOne(id);
        System.out.println(productDTO);

        if (productDTO == null) {
            redirectAttributes.addFlashAttribute("message", "해당 글 번호는 유효하지 않습니다.");
            return "redirect:/showMessage";
        }

        model.addAttribute("productDTO", productDTO);

        return "board/showOne";

    }

    @ResponseBody
    @PostMapping("uploads")
    public Map<String, Object> uploads(MultipartHttpServletRequest request) {
        Map<String, Object> resultMap = new HashMap<>();

        String uploadPath = "";

        MultipartFile file = request.getFile("upload");
        String fileName = file.getOriginalFilename();
        String extension = fileName.substring(fileName.lastIndexOf("."));
        String uploadName = UUID.randomUUID() + extension;

        String realPath = request.getServletContext().getRealPath("/board/uploads/");
        Path realDir = Paths.get(realPath);
        if (!Files.exists(realDir)) {
            try {
                Files.createDirectories(realDir);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        File uploadFile = new File(realPath + uploadName);
        try {
            file.transferTo(uploadFile);
        } catch (IOException e) {
            System.out.println("파일 전송 중 에러");
            e.printStackTrace();
        }

        uploadPath = "/board/uploads/" + uploadName;

        resultMap.put("uploaded", true);
        resultMap.put("url", uploadPath);
        return resultMap;
    }
}
