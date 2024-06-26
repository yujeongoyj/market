<%@ page import="com.nc13.coupang.model.UserDTO" %>
<%@ page import="com.nc13.coupang.service.UserService" %>
<%@ page import="com.nc13.coupang.controller.UserController" %>
<%@page language="java" contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %> <!--태그라이브라는 애를 불러올 껀데 걔 이름이 c야-->
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>board</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
</head>
<body>
<div>
    <div>카테고리</div>
    <div>검색</div>
    <div>마이페이지</div>
</div>
<div class="row justify-content-end">

</div>
<div>
    <table class="table table-striped">
        <thead>
        <tr>
            <th>상품 번호</th>
            <th>상품 이름</th>
            <th>가격</th>
        </tr>
        </thead>

        <c:forEach items="${list}" var="p">
            <tr onclick="javascript:location.href='/board/showOne/${p.id}'">
                <td>${p.id}</td>
                <td>${p.name}</td>
                <td>${p.price}</td>
            </tr>
        </c:forEach>


    </table>
    <div class="text-center">
        <ul class="pagination justify-content-center">
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
        <%

            UserDTO result = (UserDTO) session.getAttribute("logIn");
            if(result.isAdmin()) {

        %>
        <div class="row justify-content-end">
            <div class="col-3">
                <a class="btn btn-outline-success" href="/board/write">상품 등록</a>
            </div>
        </div>
        <%
            }
        %>
    </div>
</div>
</body>
</html>
