<%@page language="java" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>upload</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script src="https://cdn.ckeditor.com/ckeditor5/41.4.2/classic/ckeditor.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script src="https://ckeditor.com/apps/ckfinder/3.5.0/ckfinder.js"></script>
</head>
<body>
<div class="container-fluid">
    <form method="post" action="/board/write" enctype="multipart/form-data">
        <div class="table">
            <div class="row justify-content-center mb-3">
                <div class="col-6">
                    <div class="form-floating">
                        <input type="text" class="form-control" id="input_name" name="name" placeholder="name">
                        <label for="input_name">상품명</label>
                    </div>
                </div>
            </div>
            <div class="row justify-content-center mb-3">
                <div class="col-6">
                    <textarea name="description" id="input_description"></textarea>
                </div>
            </div>
            <div class="row justify-content-center mb-3">
                <div class="col-6">
                    <div class="form-floating">
                        <input type="number" class="form-control" id="input_price" name="price" placeholder="price">
                        <label for="input_price">가격</label>
                    </div>
                </div>
            </div>

            <div class="row justify-content-center">
                <div class="col-6">
                    <label for="input_file">썸네일에 등록할 사진</label>
                    <input type="file" class="form-control" id="input_file" name="file" multiple>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-6">
                    <input type="submit" class="btn btn-outline-primary w-100" value="작성하기">
                </div>
            </div>
        </div>
    </form>
</div>
<script>
    ClassicEditor
        .create(document.querySelector('#input_description'), {
            ckfinder: {
                uploadUrl: '/board/uploads'
            }
        })
        .catch(error => {
            console.log(error)
        })


</script>
</body>
</html>