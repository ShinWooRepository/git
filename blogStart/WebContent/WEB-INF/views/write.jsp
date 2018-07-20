<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>CKEditor</title>
	<script src="https://cdn.ckeditor.com/4.10.0/standard/ckeditor.js"></script>
</head>
<body>
	<form action="/blogStart/writePro.do" method="post" enctype="multipart/form-data"><br/>
		<input type="text" name="subject" placeholder="제목"/><br/>
		<input type="text" name="name" placeholder="성명"/><br/>
		<textarea name="content" placeholder="본문" rows="15"></textarea><br/>
		<input type="file" name="save"/><br/>
		<input type="submit" class="btn"/>
	</form>
</body>
	<!-- <body>
	<form action="/blogStart/writePro.do" method="post" enctype="multipart/form-data">
		<input type="text" name="subject" placeholder="제목"/><br/>
		<input type="text" name="name" placeholder="성명"/><br/>
		<textarea name="content"></textarea>
		<script>
		CKEDITOR.replace( 'content', {//해당 이름으로 된 textarea에 에디터를 적용
            width:'100%',
            height:'400px',
            filebrowserImageUploadUrl: '/imageUpload.do' //여기 경로로 파일을 전달하여 업로드 시킨다.
        });
         
         
        CKEDITOR.on('dialogDefinition', function( ev ){
            var dialogName = ev.data.name;
            var dialogDefinition = ev.data.definition;
          
            switch (dialogName) {
                case 'image': //Image Properties dialog
                    //dialogDefinition.removeContents('info');
                    dialogDefinition.removeContents('Link');
                    dialogDefinition.removeContents('advanced');
                    break;
            }
        });
		</script>
		<input type="submit" class="btn"/>
	</form>
	</body> -->
</html>