<%@ page import="com.nc13.coupang.model.UserDTO" %>
<%@ page import="com.nc13.coupang.service.UserService" %>
<%@ page import="com.nc13.coupang.controller.UserController" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Market Board</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            padding-top: 20px;
        }

        .container {
            margin-top: 20px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            background-color: #007bff;
            color: white;
        }

        .header a {
            color: white;
            text-decoration: none;
        }

        .product-container {
            margin-top: 20px;
        }

        .product {
            background-color: white;
            padding: 20px;
            margin-bottom: 20px;
            border: 1px solid #ced4da;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: box-shadow 0.3s ease;
        }

        .product:hover {
            box-shadow: 0 8px 12px rgba(0, 0, 0, 0.15);
        }

        .pagination-container {
            margin-top: 20px;
            display: flex;
            justify-content: center;
        }

        .pagination {
            margin: 0;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <div>카테고리</div>
        <div>검색</div>
        <div>마이페이지</div>

        <%
            UserDTO result = (UserDTO) session.getAttribute("logIn");
            if(result != null && result.getIsSeller().equalsIgnoreCase("true")) {
        %>
        <div>
            <a class="btn btn-outline-success" href="/board/write">상품 등록</a>
        </div>
        <%
            }
        %>
    </div>

    <div class="product-container">
        <c:forEach items="${list}" var="p">
            <div class="product" onclick="javascript:location.href='/board/showOne/${p.id}'">
                <p>상품 번호:  ${p.id}</p>
                <p>상품 이름: ${p.name}</p>
                <p>가격: ${p.price}</p>
            </div>
        </c:forEach>
    </div>

    <div class="pagination-container">
        <ul class="pagination">
            <li class="page-item">
                <a class="page-link" href="/board/showAll/1"> << </a>
            </li>
            <c:if test="${curPage > 5}">
                <li class="page-item">
                    <a href="/board/showAll/${curPage - 5}" class="page-link"> < </a>
                </li>
            </c:if>
            <c:forEach var="page" begin="${startPage}" end="${endPage}">
                <c:choose>
                    <c:when test="${page eq curPage}">
                        <li class="page-item">
                            <span class="page-link">[${page}]</span>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item">
                            <a href="/board/showAll/${page}" class="page-link">${page}</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <li class="page-item">
                <c:if test="${curPage < maxPage - 5}">
                    <a href="/board/showAll/${curPage + 5}" class="page-link"> > </a>
                </c:if>
            </li>
            <li class="page-item">
                <a href="/board/showAll/${maxPage}" class="page-link"> >> </a>
            </li>
        </ul>
    </div>
</div>
</body>
</html>
