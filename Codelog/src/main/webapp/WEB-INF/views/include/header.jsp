<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <!-- jQuery -->
   <script src="http://code.jquery.com/jquery-latest.min.js"></script>
   
<!-- bootstrap css -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
   <!-- bootstrap icon -->
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
   <!-- fontawesome -->
   <script src="https://kit.fontawesome.com/7b2a04da3a.js" crossorigin="anonymous"></script>
   <style type="text/css">
      @import url("<c:url value='/css/header.css'/>");
      
   </style>

   <title>Document</title>
</head>

<body style="margin-top: 0.3rem; font-family: ONE-Mobile-Regular;">
   <div class="container">
      <div class="row px-md-4">
         <!--로고 부분-->
         <div class="col-md-3 px-md-0 my-md-0 pb-md-4">
            <button id="logo-btn" style="margin-top:0.5rem;">
            <span class="logo">CodeLog
            </span>
            </button>
            <c:choose>
	            <c:when test="${not empty userInfo.nickname}">
	            	<span class="logo" style="font-size: 25px;">/</span> 
	            	<button id="nick-logo-btn">
	            		<span class="logo nick-logo">
	            		 ${userInfo.nickname}
	            		</span>
	            	</button>
	            </c:when>
	            <c:when test="${not empty dto.writer}">
	            	<span class="logo" style="font-size: 25px;">/</span> 
	            	<button id="nick-logo-btn">
	            		<span class="logo dto-logo">
	            		 ${dto.writer}
	            		</span>
	            	</button>
	            </c:when>
            </c:choose>
            <!--<span style="font-size: 2rem; color: rgba(241, 31, 129, 0.897);">log</span>
            <i class="fa-solid fa-heart" style="color: red;"></i>
            <span style="font-size: 1.7rem; color: rgb(241, 31, 129);">g</span>-->
         </div>

		<!-- 검색 창 -->
        <div class="col-md-3 offset-1" style="margin-top: 1.2rem;" >
            <form style="width: 80%; margin-left:3rem;" action="<c:url value='/search' />" class="form-inline my-2 my-lg-0 input-group shadow-none" onsubmit="return search_check()">
               <input style="border-color:gary; border-right:none;" class="form-control mr-sm-2 shadow-none" id = "searchInput" name="keyword" type="search" value="${keyword}" placeholder="Search" aria-label="Search" onfocus="this.value='';">
               <button class="btn btn-outline-secondary my-2 my-sm-0 shadow-none" type="submit" style="background-color: rgb(148, 180, 159); border-color:rgb(148, 180, 159); border-left:none;"><i class="bi bi-search" style="color:white"></i></button>
             </form>
         <div class="" id="toast-area" style="background-color:transparent; margin-top:0.3rem; width:255px; z-index: 1000; position: absolute; " ></div>
         </div>
         

            <!--해,알림,검색,글작성,메뉴토글 바-->
         <div class="col-md-3 offset-2 p-0" style="padding-left:2rem;">
             <c:if test="${loginSession != null}">    
         
            <!--해(다크모드)-->
            <div style="display: inline-block; margin-left: 5rem;">
            <button style="margin-left:5rem;" type="button" id="theme-btn" class="btn c rounded-circle mx-md-1 px-md-2 hc" >
            	<i class="fa-regular fa-sun ic" id="theme-icon"></i>
            </button>
            </div>
            <!--알림,알림 목록 토글-->  
            <button type="button" id="notification-btn" class="btn rounded-circle position-relative c mx-md-1  px-md-3 hc" role="button" aria-expanded="false">
            <!--알림 아이콘, 알림개수-->
               <i class="fa-regular fa-bell ic"></i>
               <span class="position-absolute top-0 translate-middle badge rounded-pill bg-danger" id="alarm-badge" style="left: 2.8rem;">
                  ${countAlarm}
                  <span class="visually-hidden">unread messages</span>
               </span>
            <!--알림,알림 목록 토글-(위에 거랑 세트)-->
            <!-- 로그인해서 보여줄 알림 있을 때에만 보여줄 것 -->
               <div id="notification"
                  style="position: absolute; width: 30rem; top:2.7rem; right: 0rem; z-index: 1000; display: none;">
                  <div class="card" style="width: 100%;">

                     <!--알림 목록 내용-->
                     <c:forEach var="a" items="${alarm}">
                      <div class="card-body" style=" height: 6rem;" id="${a.notiNo}">
                        <div class="row alarm-list">
                           <div class="col-md-3">
                           
                           <!-- 알림 사진 클릭하면 이동할 링크 구분하기 -->
                           <c:choose>
                           	  <c:when test="${a.bno == 0}">
                              	<a href="${pageContext.request.contextPath}/user/userpage/${a.sender}" class="stretched-link" style="position: relative; text-decoration: none;">
                              </c:when>
                              <c:otherwise>
                              	<a href="${pageContext.request.contextPath}/boardController/board?boardId=${a.bno}" class="stretched-link" style="position: relative; text-decoration: none;">
                           	  </c:otherwise>
                           </c:choose>   
                              <img src="<c:url value='/image/${a.sender}'/>" class="card-img-right rounded-circle" width="50px" height="50px" style="border-radius: 70px;">
                            </a>
                           </div>
                           <div class="col-md-8" style="text-align: left;">
                              <span class="card-text"><strong>${a.msg}</strong></span>
                              
                              <p class="pt-1" style="font-size: 0.8rem;">
                              	<fmt:formatDate value="${a.regDate}" pattern="yy/MM/dd" />
                              </p>

                           </div>
                           <div class="col-md-1">
                              <a class="btn-close close-notification-list" data-bs-dismiss="card-body" aria-label="Close"></a>
                           </div>
                        </div>
                     </div>
                     </c:forEach>
                     
                     
                  </div>
               </div>

            <!-- 로그인해서 보여줄 알림 있을 때에만 보여줄 것 -->
            </button>
             <!--글 작성-->
              <button type="button" class="btn c rounded-circle mx-md-1 px-md-2 hc" onclick="location='/codelog/boardController/getWrite'"><i class="fa-solid fa-pen-to-square" style="font-size: 19px;"></i></button>
            </c:if>

            

            <!-- 로그인 안했을 때 보여주기 -->
            <c:if test="${loginSession == null}">
            <!-- 로그인 버튼 누르면 모달창 열림-->
            <div style="display: inline-block; margin-left: 9.2rem; margin-top:1.3rem;">
            <button  type="button" id="theme-btn" class="btn c rounded-circle mx-md-1 px-md-2 hc" >
            	<i class="fa-regular fa-sun ic" id="theme-icon"></i>
            </button>
            </div>
                <button style="background-color: rgb(148, 180, 159); border-color: rgb(148, 180, 159);"type="button" class="btn btn-primary mx-md-4 px-md-2 hclogin shadow-none" data-bs-toggle="modal" data-bs-target="#loginModal">로그인</button>
            </c:if>
            <!-- 로그인 안했을 때 보여주기 끝 -->
            <!-- 로그인하면 보여주기 -->
            <c:if test="${loginSession != null}">            
            <!--메뉴, 메뉴 토글-->      
            <div style="display: inline;">
               <button width="10px"type="button" class="btn c rounded-circle px-md-0 x pb-md-4 pt-md-0 position-relative"
                   data-bs-toggle="collapse" style="background-color:transparent; border-color: transparent;"
                  href="#collapseExample2" role="button" aria-expanded="false" aria-controls="collapseExample2">
                  <!--메뉴 이미지+화살표 아래 아이콘-->
                  <!-- 프로필 이미지 -->
                  <c:choose>
                     <c:when test="${loginSession.userImg eq null || loginSession.userImg eq 'null'}">
                        <img style="margin-top:1rem;"  id="small-profile-img" src="<c:url value='/img/user_icon.png'/>" class="card-img-right rounded-circle mx-md-1"
                           alt=".">
                     </c:when>
                     <c:otherwise>
                           <img style="margin-top:1rem;" id="small-profile-img" src="<c:url value='/user/display'/>" class="card-img-right rounded-circle mx-md-1"
                           alt=".">
                     </c:otherwise>
                  </c:choose>
            <!--메뉴, 메뉴 토글(위에꺼랑 세트)-->   
                  <div class="collapse" id="collapseExample2"
                     style="position: absolute; top:3.8rem; left: -3.6rem; z-index: 1000;">
               <!--메뉴 토글 내용-->      
                     <div class="card" style="width: 8rem;">

                        <div class="card-body " id="mycodelog">
                           <div style="text-align: right;">
                              <span class="card-text pop"><strong>내 코드로그</strong></span>
                           </div>
                        </div>

                        <div class="card-body " id="edit-profile">
                           <div style="text-align: right;">
                              <span class="card-text pop"><strong>프로필 수정</strong></span>
                           </div>
                        </div>

                        <div class="card-body " id="logout">
                           <div style="text-align: right;">
                              <span class="card-text pop"><strong>로그아웃</strong></span>
                           </div>
                        </div>   
                     </div>   
                  </div>   
               </button>
            </div>
            </c:if>
           
           
           

            
          
            <!-- 로그인하면 보여주기 끝 -->
         </div>
      </div>
      <div class="row" id=searchIds></div>
   </div>   
   <!-- Button trigger modal -->

   <%@ include file="../user/login-modal.jsp" %>

   <!-- bootstrap js -->
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous">
   </script>
   <!-- sockJS -->
   <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
   
   <script>
	// 전역변수 설정
	var socket = null;
	$(document).ready(function(){
	    	// 웹소켓 연결
		    sock = new SockJS('<c:url value="/websocket"/>');
		   	socket = sock;
			//console.log('소켓연결!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
			
		    // 데이터를 전달 받았을때 
		    socket.onmessage = onMessage; // toast 생성
	    
	});
	
	//검색값 유효성 검사(입력값 널 방지)
	function search_check() {
		let search_value = document.getElementById('searchInput').value;
		if(search_value !== '') {
			return true;
		} else {
			alert('검색어를 입력해주세요.');
			return false;
		}
	}
	
	
$('#searchInput').keydown(function(){
		
    $("#toast-area").children().remove();
	
	});

	
	$('#searchInput').keyup(function(){
		$("#toast-area").children().remove();

		let x = $('#searchInput').val();
		console.log("x는 "+x);
		if(x.indexOf("@")==0 && x.length>=2){
			console.log("계정탐색");
			x = x.replace("@","");
			
			

	        
			 $.ajax({
			        url : '/codelog/search/searchId',
			        type : 'post',
			        contentType : 'application/json',
					dataType : 'json',
		            data : JSON.stringify({
			        	"userId" : x
			        }),
			        success : function(pto) {
			        	$("#toast-area").children().remove();

			        	console.log(pto);
			        	console.log("성공");
			        	if(pto!=null){
			        	 // 댓글 목록을 html로 담기
			             for(const i in pto){
			                 let userId = pto[i].userId;

            let listHtml = "";
            listHtml += "	<div class='' id=searchResult style='z-index: 10000; border-collapse: collapse; border:1px solid white; background-color:white; width:78%; margin-left:3rem'  >";
            listHtml += "		<a style='text-decoration:none;' href='${pageContext.request.contextPath}/user/userpage/"+userId+"' >";
            listHtml += "			<img class='reply_list_profileImage' style='margin-top:0.20rem; border-radius: 70%; overflow: hidden;' width='40rem' src='<c:url value='/image/"+userId+"'/>'/><span style='font-color: rgb(148, 180, 159);'>&nbsp;&nbsp;&nbsp;"+userId+"</span>";
            listHtml += "		</a> ";
            listHtml += "	</div>";
            $("#toast-area").append(listHtml);
			             }
			        	} else {
			        		$("#toast-area").children().remove();

			        	}
			        },
			        error : function() {
			            alert('서버 에러');
			        }
			 });
		}
	});

	// toast생성 및 추가
	function onMessage(evt){
	    var data = evt.data;
	   	console.log(data);
	 	// toast
	    let toast = "<div class='toast' role='alert' aria-live='assertive' aria-atomic='true'>";
	    toast += "<div class='toast-header'><i class='fas fa-bell me-2'></i><strong class='me-auto'>알림</strong>";
	    toast += "<small class='text-muted'>just now</small><button type='button' class='btn-close shadow-none' data-bs-dismiss='toast' aria-label='Close'>";
	    toast += "</button>";
	    toast += "</div> <div class='toast-body'>" + data + "</div></div>";
	    //let toast = data;
	    $("#toast-area").append(toast);   // msgStack toast 추가
	    $('.toast').toast('show');
	};	
   
      //자바스크립트 시작
      //다크모드 토글 이벤트 처리
      const theme_btn = document.querySelector('#theme-btn');
      
      const current_theme = localStorage.getItem('theme');
      if(current_theme === 'dark') {
         document.body.classList.add("dark-theme");
      }
      
      theme_btn.addEventListener("click", function() {
         document.body.classList.toggle('dark-theme');
         
         let theme = 'light';
         if(document.body.classList.contains('dark-theme')) {
            theme = 'dark';
         }
         localStorage.setItem('theme', theme);
      }); //다크모드 토글 이벤트 처리 끝
      //자바스크립트 끝
      
      //start jQuery
      $(document).ready(function() {
        	
    	    //다크모드 토글 이벤트 처리
        	$('#theme-icon').click(function() {
				if($('#theme-icon').attr('class') == 'fa-regular fa-sun ic') {
					$('#theme-icon').attr('class', 'bi bi-moon-fill');
				} else {
					$('#theme-icon').attr('class', 'fa-regular fa-sun ic');
				}
			});
            
            //로고버튼 클릭 시 메인페이지 이동 이벤트 처리
            $('#logo-btn').click(function() {
               location.href = "<c:url value='/' />";
            }); //로고버튼 클릭 이벤트 끝

            /*화면 클릭시 알람,프로필 토글 숨김*/
            var LayerPopup = $("#collapseExample");
            var LayerPopup2 = $("#collapseExample2");

            $(document).click(function(e) {
               if (LayerPopup.hasClass("show")) {
                  LayerPopup.removeClass("show");
               }

               if (LayerPopup2.has(e.target).length === 0) {
                  LayerPopup2.removeClass("show");
               }
            });
            
            //내 코드로그(마이페이지) 클릭 이벤트 처리
            $('#mycodelog').click(function() {
               location.href = "<c:url value='/user/mypage' />";
            }); //내 코드로그 이벤트 끝
            
            //프로필 수정 클릭 이벤트 처리
            $('#edit-profile').click(function() {
               location.href = "<c:url value='/user/editUser' />";
            }); //프로필 수정 클릭 이벤트 끝
            
            //로그아웃 클릭 이벤트 처리
            $('#logout').click(function() {
               const result = confirm('정말 로그아웃 하시겠어요?');
               
               if(result) {
                  location.href = "<c:url value='/user/logout' />";
               } else {
                  
               }
            }); //로그아웃 이벤트 끝
			
            //헤더 닉네임 누를 시 페이지 이동 이벤트 처리 
            $('.nick-logo').click(function() {
            	
            	location.href= "<c:url value='/user/userpage/${userInfo.userId}'/>";
            });
            
			$('.dto-logo').click(function() {
            	
            	location.href= "<c:url value='/user/userpage/${dto.userId}'/>";
            });
			
			//종 버튼 클릭 시 알림 리스트 보여주기
			$('#notification-btn').click(function() {
				if($('#notification').css("display") == 'block') {
					$('#notification').hide();
				} else {
					$('#notification').show();
				}
			});
			
			//이벤트 전파 방지 (알림 리스트 클릭시 바로 닫혀버려서 추가함)
			$('#notification').click(function(e) {
				e.stopPropagation();
			});
			
			//개별 알림 x버튼 클릭 시 삭제 이벤트
			$('.close-notification-list').click(function(e) {
				let target_noti = $(event.target).parent().prev().prev().parent().parent();
				let notiNo = target_noti.attr('id');
				
				if($('#alarm-badge').text() != 1) {
		        	$('#alarm-badge').text(${countAlarm} - 1);
	        	} else {
	        		$('#alarm-badge').text(0);
	        	}
				//console.log(target_num);
				//console.log(notiNo);
				
				$.ajax({ //ajax 시작
			        url : '<c:url value="/user/deleteAlarm" />',
			        type : 'POST',
			        contentType : 'application/json',
					dataType : 'text',
		            data : notiNo,
			        success : function() {
			        	console.log("통신 성공!");
			        	target_noti.remove();
			        	location.reload();
			        },
			        error : function(status, error) {
			            alert('통신 실패!');
			        }
				}); //ajax 끝
				
			});
            
     }); //end jQuery     
         
   </script>

</body>

</html>