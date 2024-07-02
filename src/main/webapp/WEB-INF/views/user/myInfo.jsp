<%@ page import="com.nc13.coupang.model.UserDTO" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>나의 정보</title>
</head>
<body>
<%
    UserDTO logIn = (UserDTO) session.getAttribute("logIn");
    if (logIn == null) {
        response.sendRedirect("/logIn");
        return;
    }
%>
<table border="1">
    <tr>
        <th>아이디</th>
        <td>${logIn.username}</td>
    </tr>
    <tr>
        <th>닉네임</th>
        <td>${logIn.nickname}</td>
    </tr>
    <tr>
        <th>가입종류</th>
        <td><c:choose>
            <c:when test="${logIn.isSeller == 'true'}">판매자</c:when>
            <c:otherwise>구매자</c:otherwise>
        </c:choose></td>
    </tr>
    <tr>
        <td>
            <a href="/board/showAll">목록으로</a>
        </td>
    </tr>
</table>
</body>
</html>
