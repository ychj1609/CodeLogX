<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class="collapse" id="reply_card${tmp.no }">
    <section class="modal-section">
        <div class="card card-body">
            <!-- 댓글 목록 -->
            <div class="reply-list reply-list${tmp.no }">
                <!-- 댓글이 목록이 들어가는 곳 -->
            </div>
            <!-- 댓글 작성 => 로그인한 상태여야만 댓글작성 칸이 나온다. -->
            <c:if test="${loginSession.nickname == dto.writer}">
                <div class="row reply_write">
                    <div class="col-1">
                        <a href="other_profile.do?other_nick=${tmp.writer }">
                            <img id="write_reply_profileImage"
                                src="./upload/profile/${sessionScope.profile }" />
                        </a>
                    </div>
                    <div class="col-8" class="input_reply_div">
                        <input class="w-100 form-control" id="input_reply${tmp.no}"
                            type="text" placeholder="댓글입력...">
                    </div>
                    <div class="col-3 ">
                        <button type="button" idx="${tmp.no }"
                            class="btn btn-success mb-1 write_reply">댓글&nbsp;달기</button>
                    </div>
                </div>
            </c:if>
        </div>
    </section>
</div>
<script>

const ReplyList = function(no) {
    $.ajax({
        url : 'picture_replyList.do',
        type : 'get',
        data : {
            no : no
        },
        success : function(data) {

            console.log("댓글 리스트 가져오기 성공");

            // 댓글 목록을 html로 담기
            let listHtml = "";
            for(const i in data){
                let no = data[i].no;
                let bno = data[i].bno;
                let grp = data[i].grp;
                let grps = data[i].grps;
                let grpl = data[i].grpl;
                let writer = data[i].writer;
                let content = data[i].content;
                let wdate = data[i].wdate;
                let wgap = data[i].wgap;
                let profile = data[i].profile;

                console.log(grpl);	// 모댓글일땐 0, 답글일땐 1

                listHtml += "<div class='row replyrow reply" + no + "'>";

                if(content == ""){		// 삭제된 댓글일때
                    listHtml += "	<div>";
                    listHtml += "		(삭제된 댓글입니다)";
                    listHtml += "	</div>";
                }else{
                    if(grpl == 0){	// 모댓글일때
                        listHtml += "	<div class='col-1'>";
                        listHtml += "		<a href='other_profile.do?other_nick="+writer+"'> ";
                        listHtml += "			<img class='reply_list_profileImage' src='./upload/profile/"+ profile +"'/>";
                        listHtml += "		</a> ";
                        listHtml += "	</div>";
                        listHtml += "	<div class='rereply-content col-8'>";
                        listHtml += "		<div>";
                        listHtml += "			<span>";
                        listHtml += "				<b>"+ writer +"</b>";
                        listHtml += "			</span>";
                        listHtml += "			<span>";
                        listHtml += 				content;
                        listHtml += "			</span>";
                        listHtml += "		</div>";
                        // 현재 로그인 상태일때 답글작성 버튼이 나온다.
                        if("${nick}" != ""){
                            listHtml += "		<div>";
                            // 함수에 게시글번호(bno), 모댓글번호(no), 모댓글 작성자(writer)를 인자로 담아서 넘긴다.
                            // 이때 모댓글 작성자 writer는 string인데 string을 인자에 넣기 위해선''나""로 감싸줘야한다.
                            // 여기선 ''와 ""가 이미 둘다 쓰이고 있는데  href를 감싸고 있는 ''와 겹치지 않는 ""를 \" 처리해서 넣어줬다.
                            listHtml += "			<a href='#' class='write_reply_start' data-bs-toggle='collapse' data-bs-target='#re_reply"+ no +"' aria-expanded='false' aria-controls='collapseExample'>답글&nbsp;달기</a>";
                            listHtml += "		</div>";
                        }
                        listHtml += "	</div>";

                    }else{	// 답글일때
                        listHtml += "	<div class='col-1'>"
                        listHtml += "	</div>"
                        listHtml += "	<div class='col-1'>";
                        listHtml += "		<img class='reply_list_profileImage' src='./upload/profile/"+ profile +"'/>";
                        listHtml += "	</div>";
                        listHtml += "	<div class='rereply-content"+ no +" col-7'>";
                        listHtml += "		<div>";
                        listHtml += "			<span>";
                        listHtml += "				<b>"+ writer +"</b>";
                        listHtml += "			</span>";
                        listHtml += "			<span>";
                        listHtml += 				content;
                        listHtml += "			</span>";
                        listHtml += "		</div>";

                        listHtml += "	</div>";
                    }

                    listHtml += "	<div class='col-3 reply-right'>";
                    listHtml += "		<div>";
                    listHtml += 			wdate;
                    listHtml += "		</div>";
                    // 책갈피
                    // 현재 로그인 상태이고..
                    if("${nick}" != ""){

                        //현재 사용자가 이 댓글의 작성자일때 삭제 버튼이 나온다.
                        if("${nick}" == writer){
                            listHtml += "		<div>";
                            // 수정할 댓글의 no를 grpl과 함께 넘긴다. 
                            // 모댓글 수정칸과 답글 수정칸을 화면에 다르게 나타내야하기 때문에 모댓글과 답글을 구분하는 grpl을 함께 넘겨주어야한다.
                            //listHtml += "			<a href='javascript:' no='"+ no +"' grpl='"+ grpl +"' class='reply_modify'>수정</a>";
                            //listHtml += "			&nbsp;|&nbsp;";
                            // 삭제는 no만 넘겨주면 된다.
                            listHtml += "			<a href='javascript:' no='"+ no +"' grpl='"+ grpl + "' bno='"+ bno +"' grp='"+ grp +"' class='reply_delete'>삭제</a>";
                            listHtml += "		</div>";
                        }
                    }

                    listHtml += "	</div>";
                    // 댓글에 답글달기를 누르면 답글입력란이 나온다.
                    // ---- 답글입력란
                    listHtml += "	<div class='collapse row rereply_write' id='re_reply"+ no +"'>";
                    listHtml += "		<div class='col-1'>"
                    listHtml += "		</div>"
                    listHtml += "		<div class='col-1'>"
                    listHtml += "			<a href='other_profile.do?other_nick="+writer+"'> ";
                    listHtml += "				<img id='write_reply_profileImage' src='./upload/profile/${profile}'/>"
                    listHtml += "			</a> ";
                    listHtml += "		</div>"
                    listHtml += "		<div class='col-7'>"
                    listHtml +=  "  		<input class='w-100 input_rereply_div form-control' id='input_rereply"+ no +"' type='text' placeholder='댓글입력...'>"
                    listHtml += "		</div>"
                    listHtml += "		<div class='col-3'>"
                    // 답글달기 버튼이 눌리면 모댓글 번호(no)와 게시물번호(bno)를 함수에 전달한다.

                    // 동적으로 넣은 html태그에서 발생하는 이벤트는 동적으로 처리해줘야한다 !!!!!
                    // 예를들어, 동적으로 넣은 html태그에서 발생하는 click 이벤트는 html태그 안에서 onclick으로 처리하면 안되고, jquery에서 클래스명이나 id값으로 받아서 처리하도록 해야한다.
                    // 아래코드를 보자~~~~
                    // listHtml += "			<button onclick='javascript:WriteReReply("+ no +","+ bno +")' type='button' class='btn btn-success mb-1 write_rereply' >답글&nbsp;달기</button>"
                    // 위 코드는 클릭되어도 값이 넘겨지지 않는다. 값이 undefined가 된다.
                    // 아래코드처럼 짜야한다. click이벤트를 처리하지 않고 데이터(no, bno)만 속성으로 넘겨주도록 작성한다.
                    listHtml += "			<button type='button' class='btn btn-success mb-1 write_rereply' no='" + no + "' bno='" + bno + "'>답글&nbsp;달기</button>"
                    listHtml += "		</div>";
                    listHtml += "	</div>";
                    // ---- 답글입력란 끝
                }

                listHtml += "</div>";


            };

            ///////////// 동적으로 넣어준 html에 대한 이벤트 처리는 같은 함수내에서 다 해줘야한다.
            ///////////// $(document).ready(function(){}); 안에 써주면 안된다.

            // 댓글 리스트 부분에 받아온 댓글 리스트를 넣기
            $(".reply-list"+no).html(listHtml);

            // 답글에서 답글달기를 누르면 input란에 "@답글작성자"가 들어간다.
            //$('.write_re_reply_start').on('click', function(){
            //	$('#input_rereply'+ $(this).attr('no')).val("@"+$(this).attr('writer')+" ");
            //});

            //답글을 작성한 후 답글달기 버튼을 눌렀을 때 그 click event를 아래처럼 jquery로 처리한다.
            $('button.btn.btn-success.mb-1.write_rereply').on( 'click', function() {
                console.log( 'no', $(this).attr('no') );
                console.log( 'bno', $(this).attr('bno') );

                // 답글을 DB에 저장하는 함수를 호출한다. bno와 no를 같이 넘겨주어야한다.
                WriteReReply($(this).attr('bno'), $(this).attr('no') );
            });

            // 삭제버튼을 클릭했을 때
            $('.reply_delete').on('click', function(){
                // 모댓글 삭제일때
                if($(this).attr('grpl') == 0){	
                    DeleteReply($(this).attr('no'), $(this).attr('bno'));

                // 답글 삭제일때
                }else{
                    DeleteReReply($(this).attr('no'), $(this).attr('bno'), $(this).attr('grp'));
                }

            })


        },
        error : function() {
            alert('서버 에러');
        }
    });
};

const WriteReReply = function(bno,no) {

    console.log(bno);
    console.log(no);

    console.log($("#input_rereply" + no).val());

    // 댓글 입력란의 내용을 가져온다. 
    // ||"" 를 붙인 이유  => 앞뒤 공백을 제거한다.(띄어쓰기만 입력했을때 댓글작성안되게 처리하기위함)
    let content = $("#input_rereply" + no).val();
    content = content.trim();


    if(content == ""){	// 입력된게 없을때
        alert("글을 입력하세요!");
    }else{	
        // 입력란 비우기
        $("#input_rereply" + no).val("");

        // reply+1 하고 그 값을 가져옴
        $.ajax({
            url : 'picture_write_rereply.do',
            type : 'get',
            data : {
                no : no,
                bno : bno,
                content: content
            },
            success : function(pto) {

                let reply = pto.reply;
                // 페이지, 모달창에 댓글수 갱신
                $('#m_reply'+bno).text(reply);//
                $('#reply'+bno).text(reply);

                console.log("답글 작성 성공");

                // 게시물 번호(bno)에 해당하는 댓글리스트를 새로 받아오기
                ReplyList(bno);
            },
            error : function() {
                alert('서버 에러');
            }
        });

    };
};

// 모댓글 삭제일때
const DeleteReply = function(no, bno){
    // grp이 no인 댓글이 있는 경우 content에 null을 넣고 없으면 삭제한다.
    $.ajax({
        url : 'picture_delete_reply.do',
        type : 'get',
        data : {
            no : no,
            bno : bno
        },
        success : function(pto) {

            let reply = pto.reply;

            // 페이지, 모달창에 댓글수 갱신
            $('#m_reply'+bno).text(reply);
            $('#reply'+bno).text(reply);

            console.log("모댓글 삭제 성공");

            // 게시물 번호(bno)에 해당하는 댓글리스트를 새로 받아오기
            ReplyList(bno);
        },
        error : function() {
            alert('서버 에러');
        }
    });
};

// 답글 삭제일때
const DeleteReReply = function(no, bno, grp){

    //console.log("grp : " + grp);

    // 답글을 삭제한다.
    $.ajax({
        url : 'picture_delete_rereply.do',
        type : 'get',
        data : {
            no : no,
            bno : bno,
            grp : grp
        },
        success : function(pto) {

            let reply = pto.reply;

            // 페이지, 모달창에 댓글수 갱신
            $('#m_reply'+bno).text(reply);
            $('#reply'+bno).text(reply);

            console.log("답글 삭제 성공");

            // 게시물 번호(bno)에 해당하는 댓글리스트를 새로 받아오기
            ReplyList(bno);
        },
        error : function() {
            alert('서버 에러');
        }
    });

};
</script>
</body>
</html>