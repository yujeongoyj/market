<%@ page import="com.nc13.coupang.model.UserDTO" %>
<%@ page import="com.nc13.coupang.model.CartDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.nc13.coupang.model.ProductDTO" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>장바구니</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
        <th>이미지</th>
        <th>제품명</th>
        <th>수량</th>
        <th>가격</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${list}" var="cart">
        <tr>
            <td>${cart.productId}</td>
            <td>
                <img src="${cart.imagePath}" alt="${cart.name}" width="100" height="100">
            </td>
            <td>${cart.name}</td>
            <td>${cart.quantity}</td>
            <td>₩ ${cart.price}</td>
            <td>
                <button><a href="/cart/delete/${cart.id}">삭제</a></button>
            </td>
        </tr>
    </c:forEach>
    <tr>
        <td colspan="6" class="text-center">
            <a href="/board/showAll">총 결제금액: </a>
        </td>
    </tr>
    </tbody>
</table>
</body>
</html>
