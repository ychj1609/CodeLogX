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

.toastui-editor-md-html, .toastui-editor-md-link.toastui-editor-md-link-url.toastui-editor-md-marked-text,
   .toastui-editor-md-meta {
   position: absolute;
   font-size: 1px !important;
   overflow: hidden;
   margin: -1px;
   clip-path: polygon(0 0, 0 0, 0 0);

}

</style>

<title>Document</title>
</head>
<c:if test="${loginSession == null }">
   <script>
   alert("로그인 후 이용이 가능합니다.");
    history.back();
   </script>

</c:if>

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
      <div id="title-line">
         <textarea placeholder="제목을 입력하세요" id="title" name="title" style="float:left;" onkeyup="priviewTitle()"></textarea>
 
            </div>
         <br>
         <!--태그-->
         <div class="hashtag">
            <div class="form-group">
               <input type="hidden" value="" name="tag" id="rdTag" />
            </div>
            <ul id="tag-list"></ul>
            <div class="form-group">
               <input type="text" id="tag" size="7" class="tag" name="tags" placeholder="태그는 쉼표(,)로 구분합니다." style="width: 500px;">
            </div>
         </div>
         <!-- 글 작성 화면(화면 왼 쪽 절반 div)  -->
         <div id="editor">
            </div>


         <script>
         
          const Editor = toastui.Editor;
          const content = ('#editor').val
          
          const editor = new Editor({
               el: document.querySelector('#editor'),
               width: '100%',
               height: '41.327rem',
               initialEditType: 'markdown',
               previewStyle: 'vertical',
             });
         
          </script>
                  <script>
           function submit(){
              let content = editor.getMarkdown();
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

   





      <!-- 미리보기 버튼 작동 후 페이지-->
      <!--contanier 1개에 row 1개 col 2개로 영역 구분
        썸네일 직접 업로드 가능(기본값은 글 작성에 이미지를 넣었으면 그 중 최상단 이미지 없으면 null)
    -->


      <div id="check">


         <div class="container-down">

            <div class="row py-md-3" style="margin: 5% 15% 0% 15%">

               <div class="col-md-6 px-md-4" style="margin: 0 auto; width:70%;">
               <p class="my-md-1" style="font-weight: bold; font-size: 1.7rem; text-align: center; position: relative; top: 65px; left: -20px; ">썸네일 미리보기</p>
                  <div class="card" style="width: 90%; border:0; background-color: transparent;">

                     <!--썸네일 부분-->
              
                     <div class="thumbnailBox" id="thumbnailBox" style="height: 300px; width:300px; position: relative;  text-align: center; top: 127px; left: -156px;">
                        <img src="<c:url value='/img/change.jpg'/>" class="btn thumbnailBox" type="button" id="img-preview" onclick="document.all.thumbnailUpload.click();"
                           style="width: 100%; height: 100%; position: relative"> 
                           <input type="file" id="thumbnailUpload" name="thumbnailUpload" accept="image/*" onchange="readURL(this)"> 
                           <input type="hidden" id="thumbnail" name="thumbnail">
                     </div>
                  </div>
            
            
<script>

    // start jQuery
    $(document).ready(function () {
       
       
      //썸네일 이미지 업로드 버튼 클릭 이벤트
      $('#thumbnailUpload').change(function() {
        
         upload();
         
     });
       
      //이미지 업로드를 담당하는 함수
      function upload() {
         console.log("d");
         //자바스크립트의 파일 확장자 체크 검색
         let file = $('#thumbnailUpload').val();
         
         console.log(file);
         
         file = file.slice(file.indexOf('.') + 1).toLowerCase();
         console.log(file);
         if(file !== 'jpg' && file !== 'png' && file !== 'jpeg' && file !== 'bmp'  && file !== 'gif') {
            alert('이미지 파일(jpg, png, jpeg, bmp, gif)만 등록이 가능합니다.');
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

                     <!--제목은 글작성 페이지에서 가져오기-->
					
                     <div class="card-body my-md-2 p-0 "
                        style=" margin-bottom: 1rem; position: relative; bottom: 183px; left: 156px;">
		
						
                        <!--키다운 이벤트로 글자 수 실시간 기록 50(임시) 이상시 못씀-->
                        <div class="form-floating" style="margin-top: 1rem; text-align:center;padding-top: 13px;" >
                           <textarea class="thumbtext" placeholder="Leave a comment here" id="floatingTextarea" name="preview" style="width: 290px; height: 146px; resize: none;"></textarea>
                           <span id="textL" style="">0</span>
                           <span style="">/100</span>
                           
                        </div>

                     <div class="row" style="margin-top: 1rem">
                        <div class="form-check form-switch open" style="margin: 0% 0% 0% 75%; margin-top: 0.5rem; margin-bottom:1rem;" >
                           <input class="form-check-input" type="checkbox" id="flexSwitchCheckDefault" checked> 
                           <label class="form-check-label" for="flexSwitchCheckDefault">전체 공개</label> 
                           <input type="hidden" id="viewAll" name="viewAll" value="1">
                           <br>
                        </div>
                        <div class="btn-group my-md-0" role="group" aria-label="Basic radio toggle button group" style="height: 2.7rem;">
                           <input type="radio" class="btn-check" name="btnradio2" id="btnradio3" autocomplete="off">
                           <button type="button" class="btn btn-outline-primary hide" for="btnradio3" style="font-size: 1.3rem; width: 2rem; border: 0; color:rgb(148 180 159); border-color:rgb(148 180 159);">
                              취소
                           </button>
                           &nbsp;&nbsp;&nbsp; 
                           <input type="radio" class="btn-check" name="btnradio2" id="btnradio4" autocomplete="off">
                           <button class="btn btn-outline-primary show px-md-0" for="btnradio4" style="font-size: 1.3rem; width: 2rem; background-color: rgb(148 180 159); border-color:rgb(148 180 159); color: white;">
                              작성
                           </button>
                        </div>
                     </div>
                     </div>
                     
                  </div>
               </div>
         

            </div>


         </div>


   </form>
   <script>
      /*작성과 작성검토 부분을 버튼으로 연결함(버튼은 임시)
    up은 작성검토 페이지 화면으로 올리기 down은 내리기
    toggleclass사용
*/   

//enter 입력으로 인한 submit 방지(null값 전송 방지)
  $('input[type="text"]').keydown(function() {
	  if (event.keyCode === 13) {
		    event.preventDefault();
		  };
		});
      
      

      $(document).ready(function () {
    	  
    	  
         //태그 기능 이벤트
         var tag ={};
         var counter = 0;
         
         
         //글자수 많을시 처리 
         $('#tag').keyup(function () {
              var contentL = $(this).val().length;
              console.log(contentL);
              $('#textL').text(contentL);
              if (contentL > 30) {
                 $(this).val($(this).val().substring(0, 30));
                 alert("태그가 너무 많아요!");
				
              }
           });
         $('#tag').keypress(function(e){
           
            //엔터나 스페이스 누를때 실행
            if(e.key === "Enter" || e.keyCode ==32){
               
               var tagValue = $(this).val();
               
               if(tagValue !== ""){
                  
               }
            }
         });
         
         
         $(".hide").click(function () {
            $("#articles").show();
            $("#check").hide();
            $("#articles").toggleClass('fadeIn');
            $("#check").toggleClass();



         });
         $("#show").click(function () {
            var checkTitle = $('#title').val();
            var checkTag = $('#tag').val();
            
             if(checkTitle == '') {alert("제목을 입력해주세요!"); return false;}
             if(checkTag == '') {alert("태그를 입력해주세요!"); return false; }
             
            let content = editor.getHTML();
              $('#test2').val(content);
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