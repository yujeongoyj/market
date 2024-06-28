<%@ page import="com.nc13.coupang.model.UserDTO" %>
<%@page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>${productDTO.id}번 물품</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<div class="container-fluid">
    <div class="row justify-content-center">
        <div class="col-6">
            <table class="table table-striped">
                <tr>
                    <th>상품 ID</th>
                    <td>${productDTO.id}</td>
                </tr>
                <tr>
                    <th>상품명</th>
                    <td>${productDTO.name}</td>
                </tr>
                <tr>
                    <th colspan="2" class="text-center">상세설명</th>
                </tr>
                <tr>
                    <td colspan="2">${productDTO.description}</td>
                </tr>

                <%
                    UserDTO result = (UserDTO) session.getAttribute("logIn");
                    if(result.getIsSeller().equalsIgnoreCase("true")) {
                %>
                <tr class="text-center">
                    <td class="text-center" colspan="3">
                        <a class="btn btn-outline-success" href="/board/update/${productDTO.id}">수정하기</a>
                        <button class="btn btn-outline-danger" onclick="deleteBoard(${productDTO.id})">삭제하기</button>
                    </td>
                </tr>
                <%
                    }

                    if(result.getIsSeller().equalsIgnoreCase("false")) {
                %>
                <tr class="text-center">
                    <td class="text-center" colspan="3">
                        <button class="btn btn-outline-success" onclick="deleteBoard(${productDTO.id})">장바구니에 넣기</button>
                    </td>
                </tr>
                <%
                    }
                %>
                <tr>
                    <td colspan="2" class="text-center">
                        <a class="btn btn-outline-secondary" href="/board/showAll">목록으로</a>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>
<script>
    function deleteBoard(id) {
        console.log(id);
        Swal.fire({
            title: '정말로 삭제하시겠습니까?',
            showCancelButton: true,
            confirmButtonText: '삭제하기',
            cancelButtonText: '취소',
            icon: 'warning'
        }).then((result) => {
            if(result.isConfirmed){
                Swal.fire({
                    title: '삭제되었습니다.'
                }).then(() => {
                    location.href='/board/delete/'+id;
                })
            }
        });
    }
</script>
</body>
</html>
