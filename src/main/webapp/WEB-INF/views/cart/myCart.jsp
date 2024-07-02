<%@ page import="com.nc13.coupang.model.UserDTO" %>
<%@ page import="com.nc13.coupang.model.CartDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.nc13.coupang.model.ProductDTO" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>장바구니</title>
</head>
<body>

<%
    UserDTO logIn = (UserDTO) session.getAttribute("logIn");

%>
<h1><%= logIn.getNickname() %>님 장바구니</h1>
<table border="1">
    <thead>
    <tr>
        <th>제품번호</th>
        <th>제품명</th>
        <th>수량</th>
        <th>가격</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${list}" var="cart">
        <tr>
            <td>${cart.productId}</td>
            <td>${cart.productName}</td> <!-- productDTO에서 productName을 출력 -->
            <td>${cart.quantity}</td>
            <td>${cart.price}</td> <!-- 예시로 ProductDTO의 price도 출력할 수 있음 -->
        </tr>

    </c:forEach>
    </tbody>
</table>
</body>
</html>
