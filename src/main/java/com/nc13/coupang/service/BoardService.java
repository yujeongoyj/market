package com.nc13.coupang.service;

import com.nc13.coupang.model.ProductDTO;
import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;


@Service
@RequiredArgsConstructor
public class BoardService {

    private final String NAMESPACE = "com.nc13.mappers.BoardMapper";

    private final int PAGE_SIZE = 20;

    @Autowired
    private SqlSession session;


    public List<ProductDTO> selectAll(int pageNo) {

        HashMap<String, Integer> paramMap = new HashMap<>();
        paramMap.put("startRow", (pageNo - 1) * PAGE_SIZE);
        paramMap.put("size", PAGE_SIZE);

        return session.selectList(NAMESPACE + ".selectAll", paramMap);
    }


    public int selectMaxPage() {
        int maxRow = session.selectOne(NAMESPACE + ".selectMaxRow");
        int maxPage = maxRow / PAGE_SIZE;

        if (maxRow % PAGE_SIZE != 0) {
            maxPage++;
        }

        return maxPage;
    }

    public ProductDTO selectOne(int id) {
        return session.selectOne(NAMESPACE + ".selectOne", id);
    }

    public void insert(ProductDTO productDTO) {
        session.insert(NAMESPACE + ".insert", productDTO);
    }

    public void update(ProductDTO attempt) {
        session.update(NAMESPACE + ".update",attempt);
    }

    public void delete(int id) {
        session.delete(NAMESPACE + ".delete", id);
    }
}
