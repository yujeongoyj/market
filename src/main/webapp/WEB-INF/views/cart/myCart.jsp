<%@ page import="com.nc13.coupang.model.UserDTO" %>
<%@ page import="com.nc13.coupang.model.CartDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.nc13.coupang.model.ProductDTO" %>
<%@ page import="org.springframework.beans.factory.annotation.Autowired" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>장바구니</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>

    </style>
</head>
<body>

<%
    UserDTO logIn = (UserDTO) session.getAttribute("logIn");
    double totalAmount = 0.0;
%>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-10">
            <h1 class="text-center"><%= logIn.getNickname() %>님 장바구니</h1>
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>제품번호</th>
                    <th>이미지</th>
                    <th>제품명</th>
                    <th>수량</th>
                    <th>가격</th>
                    <th>합계</th>
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
                            <%--<td>${cart.quantity}</td>--%>
                        <td>
                            <input type="number" id="quantity" value="${cart.quantity}" style="width: 50px;">
                        </td>
                        <td>₩ ${cart.price}</td>
                        <td class="subTotal">₩ ${cart.quantity * cart.price}</td>
                        <td>
                            <button><a href="/cart/delete/${cart.id}">삭제</a></button>
                        </td>

                        <td class="cartInfo">
                            <input type="hidden" class="subTotal" value="${cart.quantity * cart.price}">
                            <input type="hidden" class="price" value="${cart.price}">
                            <input type="hidden" class="quantity" value="${cart.quantity}">
                        </td>
                    </tr>

                </c:forEach>

                <tr>
                    <td colspan="7" class="text-center">
                        <p id="totalAmount"></p>
                    </td>
                </tr>
                <tr>
                    <td colspan="7" class="text-center">
                        <a class="btn btn-outline-success" href="">구매하기</a>
                    </td>
                </tr>
                <tr>
                    <td colspan="7" class="text-center">
                        <a class="btn btn-outline-secondary" href="/board/showAll">목록으로</a>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script>
    $(document).ready(function() {
        let totalPrice = 0;
        $(".cartInfo").each(function (index, element) {

            totalPrice += parseInt($(element).find(".subTotal").val())
        });
        $("#totalAmount").text("총 결제금액 : " + totalPrice.toLocaleString());
    });

</script>
</body>
</html>
