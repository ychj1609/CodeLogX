<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- 글 작성 페이지에만 적용되는 CDN들. 지우지 마세요 -->
<link rel="stylesheet" type="text/css"
	href="path/to/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
	integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN"
	crossorigin="anonymous">
<link rel="preconnect" href="https://fonts.googleapis.com">
 <link
      rel="stylesheet"
      href="https://uicdn.toast.com/editor/latest/toastui-editor-viewer.min.css"
    />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Jua&family=Nanum+Brush+Script&family=Nanum+Pen+Script&display=swap"
	rel="stylesheet">

<link
	href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Brush+Script&family=Nanum+Pen+Script&display=swap"
	rel="stylesheet">
<script src="https://kit.fontawesome.com/fec7fe9db7.js"
	crossorigin="anonymous"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<!-- 글 작성 페이지에만 적용되는 CDN들. 지우지 마세요 -->

<style>
/* 글 작성 페이지 css */
@import url("<c:url value='/css/toastTest.css'/>");

@import url("<c:url value='/css/test.css'/>");
</style>

<title>Document</title>
</head>



<body>
	<form action="<c:url value='/boardController/write' />"
		class="write-bbs" enctype=multipart/form-data method="post">
		<!-- 글등록 페이지에 따로 작성자를 기입하지는 않으므로 현재 로그인 세션에서 작성자 명을 뽑아옵니다. -->
		<input type="hidden" id="test2" name="content"> <input
			type="hidden" name="writer" value="${loginSession.nickname}">
		<!-- 로그인 세션에 있는 사용자의 닉네임 -->
		<input type="hidden" name="userId" value="${loginSession.userId}">
		<input type="hidden" name="userNo" value="${loginSession.userNo}">

		<!-- 로그인 세션에 있는 사용자의 id -->
		<div id="articles">
			<textarea placeholder="제목을 입력하세요" id="title" name="title""></textarea>

			<br>
			<!--태그-->
			<input class="tag" name="tags" placeholder="태그를 입력하세요">
			<!-- 글 작성 화면(화면 왼 쪽 절반 div)  -->

			<div id="editor" style=""></div>



			<script>
 const Editor = toastui.Editor;
 
 const editor = new Editor({
 	  el: document.querySelector('#editor'),
 	  width: '100%',
 	  height: '41.327rem',
 	  initialEditType: 'markdown',
 	  previewStyle: 'vertical'
 	});

 </script>
			<script>
  function submit(){
	  let content = editor.getHTML();
	  $('#test2').val(content);
	  console.log(content);
	 
	  $('#test3').val(content);
  }
 </script>

			<button class="ok" id="show" type="button">
				<i class="fa-solid fa-check"></i>
			</button>
			<button type="button" class="exit" onclick="history.back()">
				<i class="fa-solid fa-right-from-bracket"></i>
			</button>

		</div>



		</div>

		<!-- 미리보기 버튼 작동 후 페이지-->
		<!--contanier 1개에 row 1개 col 2개로 영역 구분
        썸네일 직접 업로드 가능(기본값은 글 작성에 이미지를 넣었으면 그 중 최상단 이미지 없으면 null)
    -->


		<div id="check">


			<div class="container-down">

				<div class="row py-md-3" style="margin: 5% 15% 0% 15%">

					<div class="col-md-6 px-md-4" style="margin: 0 auto;">
						<div class="card"
							style="width: 100%; height: 40rem; border: 0; background-color: transparent;">

							<!--썸네일 부분-->

							<p class="my-md-1"
								style="font-weight: bold; font-size: 1.7rem; text-align: center">포스터
								미리보기</p>
							<div class="thumbnailBox" id="thumbnailBox"
								style="height: 40rem; position: relative; background-color: rgba(128, 128, 128, 0.185); text-align: center;">
								<img src="C:\test\upload\37655c69f5434d18906695b4a594bbc5.jpg" class="btn"
									id="img-preview"
									onclick="document.all.thumbnailUpload.click();"
									style="width: 100%; height: 100%; position: relative"> <span
									style="color: rgb(77, 238, 98);">이미지를 클릭하여 썸네일을 변경하세요</span> <input
									type="file" id="thumbnailUpload" name="thumbnail2"
									accept="image/*"> <input type="hidden" id="thumbnail"
									name="thumbnail">
								<script>
    // start jQuery
    $(document).ready(function () {
       
      //썸네일 이미지 업로드 버튼 클릭 이벤트
      $('#thumbnailUpload').change(function() {
    	 
    	  upload();
         
     });
       
      //이미지 업로드를 담당하는 함수
      function upload() {
         //자바스크립트의 파일 확장자 체크 검색
         let file = $('#thumbnailUpload').val();
         
         console.log(file);
         
         file = file.slice(file.indexOf('.') + 1).toLowerCase();
         console.log(file);
         if(file !== 'jpg' && file !== 'png' && file !== 'jpeg' && file !== 'bmp') {
            alert('이미지 파일(jpg, png, jpeg, bmp)만 등록이 가능합니다.');
            $('#thumbnailUpload').val('');
           return;            
         }
         
         //ajax 폼 전송의 핵심 FormData 객체
         const formData = new FormData();
         const data = $('#thumbnailUpload');
         
         console.log('폼 데이터: ' + formData);
         console.log('data: ' + data);
         
         //FormData 객체에 사용자가 업로드한 파일의 정보들이 들어있는 객체에 전달
        formData.append('file', data[0].files[0]);
         
         //비동기 방식으로 썸네일 등록을 진행
         //ajax 시작
        $.ajax({
            url : '<c:url value="/boardController/thumbnail" />',
            type : 'POST',
            data : formData,
            contentType : false,
            processData : false,
            
            success : function(result) { //컨트롤러와 통신 성공 시 파일명을 반환
               
                  $('#thumbnail').val(result); //파일명을 BoardVO에 보낼 파라미터 값에 저장
                  console.log(result);
                  
           
            
           },
           error : function(request, status, error) {
              console.log('code: ' + request + '\n' + 'message: ' + request.responseText + '\n' + 'error: ' + error);
            
           }
         }); //ajax 끝
         
     } //프로필 이미지 업로드 버튼 클릭 이벤트 끝
     //프로필 이미지 업로드 시 미리보기
         $('#thumbnailUpload').change(function() {
    	 
    	  readURL(this);
    	  
     });

     function readURL(input) {
         if (input.files && input.files[0]) {
             var reader = new FileReader();
             reader.onload = function (e) {
                 $('#img-preview').attr('src', e.target.result);
             }
             reader.readAsDataURL(input.files[0]);
             
          }
     } ////프로필 이미지 업로드 시 미리보기 끝
    });
     </script>
							</div>

									<div id="viewer"><input type="hidden" id="view"></div>
							<!--제목은 글작성 페이지에서 가져오기-->

							<div class="card-body my-md-2 p-0 "
								style="margin-top: 2.7rem; margin-bottom: 1rem">

								<!--키다운 이벤트로 글자 수 실시간 기록 50(임시) 이상시 못씀-->
								
	
									<span style="float: right">/100</span><span id="textL"
										style="float: right">0</span>
							
							<div class="row" style="margin-top: 1rem">
								<div class="form-check form-switch"
									style="margin: 1.5% 0% 0% 61.5%; margin-top: 0.5rem">
									<input class="form-check-input" type="checkbox"
										id="flexSwitchCheckDefault" checked> <label
										class="form-check-label" for="flexSwitchCheckDefault">전체
										공개</label> <input type="hidden" id="viewAll" name="viewAll" value="1">
								</div>
								<div class="btn-group my-md-0" role="group"
									aria-label="Basic radio toggle button group"
									style="height: 2.7rem;">

									<input type="radio" class="btn-check" name="btnradio2"
										id="btnradio3" autocomplete="off">
									<button type="button" class="btn btn-outline-primary hide"
										for="btnradio3"
										style="font-size: 1.3rem; width: 2rem; border: 0">취소</button>
									&nbsp;&nbsp;&nbsp; <input type="radio" class="btn-check"
										name="btnradio2" id="btnradio4" autocomplete="off">
									<button class="btn btn-outline-primary show px-md-0"
										for="btnradio4"
										style="font-size: 1.3rem; width: 2rem; background-color: #0d6efd; color: white;">작성</button>


								</div>
							</div>
						</div>
					</div>
			

				</div>


			</div>

		</div>
		</div>

		</div>
	</form>
	<script>
	
	</script>
	<script>
      /*작성과 작성검토 부분을 버튼으로 연결함(버튼은 임시)
    up은 작성검토 페이지 화면으로 올리기 down은 내리기
    toggleclass사용
*/


      $(document).ready(function () {
         $(".hide").click(function () {
            $("#articles").show();
            $("#check").hide();
            $("#articles").toggleClass('fadeIn');
            $("#check").toggleClass();



         });
         $("#show").click(function () {
        	 
        	 let content = editor.getHTML();
        	$("#view").val(content);
        	console.log(content);
        	var view = $('#view').val()
      	  
      	  const viewer = toastui.Editor.factory({
      		    el: document.querySelector('#viewer'),
      		    viewer: true,
      		    height: '500 px',
      		    width: '500 px',
      		    initialValue: view
      		    
      	  });
      	  console.log(view)
      	  function ToView()
      	  {
      		  viewer.getMarkdown(viewer.setHTML());
      	  };
       	    $('#test2').val(content);
       	    $('#floatingTextarea').val(content);
            $("#check").show();
            $("#articles").hide();
            $("#check").toggleClass('fadeIn');
            $("#articles").toggleClass();



         });

         var checked = $('.form-check-input').is(':checked');
         console.log('check여부' + checked);

         $(".form-switch").click(function () {



            var checked = $('.form-check-input').is(':checked');
            var checkVal;
            console.log('check여부' + checked);
            if (!checked) {
               $(".form-check-label").html('&nbsp;비공개');
               checkVal = 0;
               $("#viewAll").val(checkVal);	
               // $('.form-switch').attr('checked',true);
            } else {
               $(".form-check-label").text('전체 공개');
               checkVal = 1;
               $("#viewAll").val('1');	

            }
         });
         
         

         $('#floatingTextarea').keyup(function () {
            var contentL = $(this).val().length;
            console.log(contentL);
            $('#textL').text(contentL);
            if (contentL > 100) {
               $(this).val($(this).val().substring(0, 100));
               alert("최대 100글자까지 가능합니다.");

            }
            $('#textSlash').click(function () {
               var content = $('.content').val();
               $('.content').val(content + "~텍스트~");
            })
         });
         
     
      })
   </script>

	<!-- 글 작성 페이지에만 적용되는 bootstrap js. 여기는 헤더가 없어요. 지우지 마세요. -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous">
   </script>

</body>


</html>