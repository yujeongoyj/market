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


    </style>
</head>
<body>
<%--<div class="container">
    <div class="header">
        <div>카테고리</div>
        <div>검색</div>
        <div>나의 정보</div>
        <div>장바구니</div>

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
    </div>--%>

<div class="container">
    <nav class="navbar navbar-expand-lg navbar-light bg-light" style="background-color: #e3f2fd">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">짭팡</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown"
                    aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavDropdown">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="/board/showAll">Home</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button"
                           data-bs-toggle="dropdown" aria-expanded="false">
                            카테고리
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                            <li><a class="dropdown-item" href="#">Action</a></li>
                            <li><a class="dropdown-item" href="#">Another action</a></li>
                            <li><a class="dropdown-item" href="#">Something else here</a></li>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">나의 정보</a>
                    </li>
                    <%
                        UserDTO result = (UserDTO) session.getAttribute("logIn");
                        if(result != null && result.getIsSeller().equalsIgnoreCase("false")) {
                    %>
                    <li class="nav-item">
                        <a class="nav-link" href="#">장바구니</a>
                    </li>
                    <%
                        }
                        if(result != null && result.getIsSeller().equalsIgnoreCase("true")) {
                    %>
                    <li class="nav-item">
                        <a class="nav-link" href="/board/write">상품등록</a>
                    </li>
                    <%
                        }
                    %>
                </ul>
                <form class="d-flex">
                    <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                    <button class="btn btn-outline-success" type="submit">Search</button>
                </form>
            </div>
        </div>
    </nav>


    <div class="product-container row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
        <c:forEach items="${list}" var="p">
            <div class="col">
                <div class="product" onclick="javascript:location.href='/board/showOne/${p.id}'">
                    <img src="${p.imagePath}" alt="${p.name}">
                    <div class="details">
                        <p>상품 번호: ${p.id}</p>
                        <p>상품 이름: ${p.name}</p>
                        <p>가격: ${p.price}</p>
                    </div>
                </div>
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
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
        integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
        integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy"
        crossorigin="anonymous"></script>

</body>
</html>
