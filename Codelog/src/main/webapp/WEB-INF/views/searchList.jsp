<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="include/header.jsp"%>


<!DOCTYPE html>
<html>

<head>

   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">

   <style>

       @import url("<c:url value='/css/home.css'/>");
   
     .card-thumb{
          overflow-y : hidden;
          
        }
   </style>
   <title>Document</title>
</head>

<body style="margin-top: 1rem; font-family: ONE-Mobile-Regular;">

   <div class="container">
		
	<!-- Button trigger modal -->
	<div class="container" style="margin-top: 2rem;" id="posterbox">
	
	<c:if test="${not empty searchList}">
	<div class="row py-md-3" id="start">
	<c:forEach var="s" items="${searchList}">
			<div class="col-md-4 px-md-4 py-md-4">
				<div class="card poster" style="width: 100%; height: 27rem;" data-bno="${s.boardId}" data-lno="${s.likes}">
					<!--포스터카드 아무대나 클릭해도 링크 걸리기-->
					<a href="${pageContext.request.contextPath}/boardController/board?boardId=${s.boardId}" class="stretched-link"></a>
					<!--썸네일 이미지-->
					<div class="card-thumb">
					<c:choose>
						<c:when test="${s.thumbnail != null}"><img src="<c:url value='/image/display/${s.thumbnail }'/>" class="card-img-top" alt="..."></c:when>
						<c:when test="${s.thumbnail == null}"><img src="<c:url value='/img/codelog.png'/>" class="card-img-top" alt="..."></c:when>
						<c:otherwise>팔로워</c:otherwise>
					</c:choose>
					
					</div>
					<!--제목 내용-->
					<div class="card-body ">
						<strong>${s.title}</strong>
						<p class="card-text" style="padding-top: 0.3rem;">${s.preview}

						</p>
					</div>
					<div class="card-footer my-md-0 py-md-0"
						style="font-size: 0.8rem; border-top: 0; background-color: white;">

						<p class="card-text"
							style="border-bottom: 1px solid rgba(128, 128, 128, 0.178); margin-bottom: 0.4rem; padding-bottom: 0.3rem;color:gray;">
							<fmt:formatDate value="${s.regDate }" pattern="yy/MM/dd"/></p>

							<!--계정사진 계정명 댓글수 좋아요수-->
						<div>

							<div style="margin-top: 0.3rem;">
								<div style="display: inline-block; float: left;">
									<div style="border-radius: 70%; overflow: hidden; display: inline-block;">
										<img src="<c:url value='/image/${s.userId}'/>" class="img-rounded" width="25rem">
									</div>

								</div>
								<div style="display: inline-block; float: left; margin-top: 0.13rem;">
									<span class="mx-md-1" style="color: gray;">by</span><span style="color:rgb(120, 147, 149); font-weight:bold;">${s.writer}</span>
								</div>
								<div style="display: inline-block; float: right; margin-top: 0.13rem">
									<i class="fa-solid fa-comment" style=""></i>
									<span style="margin-right: 0.5rem;" class="">3</span>
									<i class="fa-solid fa-heart"></i><span class="mx-md-1">${s.likes}</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
	</c:forEach>
		</div>
	</c:if>

</div>
</div>


</body>

</html>