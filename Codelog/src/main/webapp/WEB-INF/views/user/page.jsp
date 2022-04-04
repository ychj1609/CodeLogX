<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@include file="../include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>mypage</title>

<!-- reset.css 마이페이지에만 적용되는 css 지우지 마세요. -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css">

<style>
@import url("<c:url value='/css/mypage.css' />");
</style>
</head>

<div class="container">
	<!--프로필 -->
	<div class="row p-4 p-md-5 mb-2 main">
		<div class="col-md-4">
			<c:choose>
				<c:when
					test="${userInfo.userImg eq null || userInfo.userImg eq 'null'}">
					<img src="<c:url value='/img/user_icon.png' />" alt="user_icon"
						width="130" height="130" style="border-radius: 70px;">
				</c:when>
				<c:otherwise>
					<img src="<c:url value='/image/${userInfo.userId}' />"
						alt="user_icon" width="130" height="130"
						style="border-radius: 70px;">
				</c:otherwise>
			</c:choose>
		</div>
		<div class="col-md-8 profile">
			<h3 class="id">${userInfo.nickname }&nbsp;&nbsp;
				<c:if test="${not empty loginSession and userInfo.userId ne loginSession.userId}">
				<c:choose>
					<c:when test="${followCheck == 1 }">
						<button class="follow-button" style="background-color: #C0D8C0">
							<p class="follow-txt">
								&nbsp;<i class="fa-solid fa-check">팔로잉</i>
							</p>
						</button>
					</c:when>
					<c:otherwise>
						<button class="follow-button">
							<p class="follow-txt">팔로우</p>
						</button>
					</c:otherwise>
				</c:choose>
				</c:if>
				
			</h3>
			<p class="posts">
				게시물 ${fn:length(userInfo.boardList)} &nbsp;&nbsp;&nbsp; <a class="followers" data-bs-toggle="modal"
					data-bs-target="#followers_modal" style="cursor: pointer;">팔로워
					${fn:length(followerList)}</a> &nbsp;&nbsp;&nbsp; <a class="folloing"
					data-bs-toggle="modal" data-bs-target="#following_modal"
					style="cursor: pointer;">팔로우 ${fn:length(followingList)}</a>
			</p>
			<p class="intro">${userInfo.userInfo}</p>
		</div>
	</div>
	<!-- end main-->

	<!-- 클릭시 팔로워 모달 -->
	<div class="modal fade" id="followers_modal" data-bs-backdrop="static"
		data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-scrollable modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="staticBackdropLabel">팔로워</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<ul class="list-unstyled">
						<c:choose>
							<c:when test="${fn:length(followerList) <= 0}">
								<p>팔로우 하는 사람이 없습니다.
							</c:when>
							<c:otherwise>
								<c:forEach var="list" items="${followerList}">
									<li class="follow-li">
									<div class="profile-section">
											<c:choose>
												<c:when test="${list.userImg != 'null' && list.userImg != null}">
													<img class="profile-photo" alt="img" src="<c:url value='/image/${list.activeUserId}'/>" width="20" height="20" style="border-radius: 70px; display:inline;">
												</c:when>
												<c:otherwise>
													<img alt="img" src="<c:url value='/img/user_icon.png'/>"width="20" height="20" style="padding-top:2px">
												</c:otherwise>
											</c:choose>
										<p class="profile-id" style="display:inline;">
											<a href="<c:url value='/user/userpage/${list.activeUserId}'/>">${list.activeUserId} </a>
										</p>
									</div>
									</li>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<!-- 팔로잉 모달-->
	<div class="modal fade" id="following_modal" data-bs-backdrop="static"
		data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-scrollable modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="staticBackdropLabel">팔로우</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<ul class="list-unstyled">
						<c:if test="${followingList.size() <= 0}">
							<p>팔로잉 하는 회원이 없습니다.
						</c:if>
						<c:if test="${followingList.size() > 0 }">
							<c:forEach var="list" items="${followingList }">

								<li class="follow-li">
								<div class="profile-section">
											<c:choose>
												<c:when test="${list.userImg ne 'null' and list.userImg ne null}">
													<img class="profile-photo" alt="img" src="<c:url value='/image/${list.passiveUserId}'/>" width="22" height="22" style="border-radius: 70px; display:inline;">
												</c:when>
												<c:otherwise>
													<img alt="img" src="<c:url value='/img/user_icon.png'/>"width="22" height="22" style="padding-top:2px">
												</c:otherwise>
											</c:choose>
									<p class="profile-id"  style="display:inline;">
										<a href="<c:url value='/user/userpage/${list.passiveUserId}'/>">${list.passiveUserId} </a>
									</p>
								</div>
								</li>


							</c:forEach>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<!-- 태그 및 페이지-->
	<div class="row">
		<!--태그-->
		<div class="col-md-2 tags">
			태그목록
			<hr>
			        <c:if test="${not empty tagKey }">            
            <c:forEach var ="key" items="${tagKey}" varStatus="status" >              
             		<a href="${pageContext.request.contextPath}/searchByTag?keyword=${key}"> ${key} &nbsp;(${tagValue[status.index]})<br></a>            		
             </c:forEach>  
         </c:if>
		</div>
		<!--게시글들 -->
		<div class="col-md-10">
			<!--검색 -->
			<form action="d-flex">
				<section>
					<input class="form-control search shadow-none" type="search"value="${word}" placeholder="Search" aria-label="Search"onfocus="this.value='';">
					<button class="btn btn-outline-primary shadow-none" type="submit">검색</button>
				</section>
			</form>
			<!-- 사진 썸네일, 글제목, 보이는 곳  -->
			<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-5">
			<c:forEach var="Poster" items="${userInfo.boardList }">
					<div class="col-md-4 px-md-4 py-md-4">
						<div class="card poster" style="width: 100%; height: 24rem;"
							data-bno="${Poster.boardId }" data-lno="${Poster.likes }">
							<!--포스터카드 아무대나 클릭해도 링크 걸리기-->
							<a
								href="${pageContext.request.contextPath}/boardController/board?boardId=${Poster.boardId}"
								class="stretched-link"></a>
							<!--썸네일 이미지-->
							<img src="<c:url value='/image/display/${Poster.thumbnail }'/>" class="card-img-top"
								alt="...">
							<!--제목 내용-->
							<div class="card-body ">
								<strong>${Poster.title }</strong>
								<p class="card-text" style="padding-top: 0.3rem;">${Poster.preview }

								</p>
							</div>
							<div class="card-footer my-md-0 py-md-0"
								style="font-size: 0.8rem; border-top: 0; background-color: white;">

								<p class="card-text"
									style="border-bottom: 1px solid rgba(128, 128, 128, 0.178); margin-bottom: 0.4rem; padding-bottom: 0.3rem;">
									
								</p>

								<!--계정사진 계정명 댓글수 좋아요수-->
								<div>

									<div style="margin-top: 0.3rem;">
										<div style="display: inline-block; float: left;">
											
											<fmt:formatDate value="${Poster.regDate }" pattern="yy/MM/dd" />
										</div>
										<div
											style="display: inline-block; float: left; margin-top: 0.13rem;">
										</div>
										<div
											style="display: inline-block; float: right; margin-top: 0.13rem">
											<i class="fa-solid fa-comment" style=""></i> <span
												style="margin-right: 0.5rem;" class="">${Poster.recnt }</span> <i
												class="fa-solid fa-heart"></i><span class="mx-md-1">${Poster.likes}</span>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>

		</div>
	</div>
</div>
<!-- end container-->
<%@include file="../include/footer.jsp"%>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"
	integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB"
	crossorigin="anonymous">
    </script>

<script>
      // 팔로우버튼 누를시 팔로잉, 다시클릭시 팔로우
      $(function () {
        $('.follow-button').click(function () {
        	console.log('${userInfo.userId}');
        	console.log('넘어오니?');
        	
        	//소켓 메세지 보낼 내용
        	let msg = 'follow' + ',' + '${loginSession.userId}' + ',' + '${userInfo.userId}';
        	
          if ($('.follow-txt').html() == '팔로우') {
            $(this).css("background-color", "#C0D8C0")
            $.ajax({
            	type: "post",
            	dataType: 'text',
            	url: "<c:url value='/follow/${userInfo.userId}' />",
            	contentType: "application/json",
            	success: function(data){
            		console.log('연결 성공:'+ data);
            		if(data === 'followOk'){
			            $('.follow-txt').html('<i class="fa-solid fa-check">&nbsp;팔로잉</i>');
			            //$('.followers').html('팔로워 ' + ${fn:length(followerList)} + 1);
			            socket.send(msg); //소켓 메세지 전송
			            location.reload();
            		}
            	}, 
            	error: function(){
            		alert('팔로우 실패');
            	}
            }); //end ajax
          } else {
            $.ajax({
            	type: "post",
            	dataType: 'text',
            	url: "<c:url value='/unfollow/${userInfo.userId}' />",
            	contentType: "application/json",
            	success: function(data){
            		console.log('연결 성공:'+ data);
            		if(data === 'unfollowOk'){
			            $('.follow-txt').html('팔로우');
			            $('.follow-button').css("background-color", "gray");
			            //$('.followers').html('팔로워 ' + ${fn:length(followerList)} - 1);
			            location.reload();
            		}
            	}, 
            	error: function(){
            		alert('팔로잉 취소 실패');
            	}
            });
          }
        });
      });
      

     </script>
<script>
      $(document).ready(function () {
        $("#so").click(function () {
          $(location).attr("href", "https://www.naver.com/")
        });
        $("#btnD").click(function () {
          $(location).attr("href", "https://www.daum.net/")
        });
        $("#btnG").click(function () {
          $(location).attr("href", "https://www.google.com/")
        })
      });
    </script>
</body>

</html>