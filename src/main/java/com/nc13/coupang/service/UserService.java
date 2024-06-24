package com.nc13.coupang.service;

// Service
// 기존에는 컨트롤러가 DB 통신까지 담당했지만
// 이제는 컨트롤러한테는 사용자가 보낸 요청을 처리하고 특정 페이지 이동을 해라 라는 책임만을 맡기고
// 실제 데이터베이스와의 통신은 Service 클래스가 담당하게 된다.

import com.nc13.coupang.model.UserDTO;
import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
@RequiredArgsConstructor
public class UserService {

    @Autowired
    private final SqlSession SESSION;

    private final String NAMESPACE = "com.nc13.mappers.UserMapper";


    public UserDTO auth(UserDTO attempt) {

        return SESSION.selectOne(NAMESPACE + ".auth", attempt);
    }

    public boolean validateUsername(String username) {
        return SESSION.selectOne(NAMESPACE + ".selectByUsername", username) == null;
    }

    public void register(UserDTO attempt) {
        SESSION.insert(NAMESPACE + ".register", attempt);
    }
}











