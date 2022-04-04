<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 로그인 모달 시작 -->
<div class="modal fade" tabindex="-1" role="dialog" id="loginModal">
  <div class="modal-dialog" role="document">
    <div class="modal-content rounded-5 shadow">
      <div class="modal-header p-5 pb-4 border-bottom-0">
        <!-- <h5 class="modal-title">Modal title</h5> -->
        <h2 class="fw-bold mb-0">로그인</h2>
        <button type="button" class="btn-close shadow-none" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <div class="modal-body p-5 pt-0">
        <form>
          <label for="basic-url" class="form-label">아이디</label>
          <div class="form-floating mb-3">
            <input type="text" class="form-control rounded-4 shadow-none" id="login-id">
            <label for="floatingInput" id="login-id-msg"></label>
          </div>
          <label for="basic-url" class="form-label">비밀번호</label>
          <div class="form-floating mb-3">
            <input type="password" class="form-control rounded-4 shadow-none" id="login-pw">
            <label for="floatingPassword" id="login-pw-msg"></label>
          </div>
          <button class="w-100 mb-2 btn btn-lg rounded-4 btn-primary shadow-none" type="button" id="login-btn">로그인</button>
          <hr class="my-4">
          <small class="text-muted">아직 회원이 아니신가요?</small>
          <h2 class="fs-5 fw-bold mb-3"></h2>
          <!-- 회원가입 버튼 클릭 시 회원가입 모달 열림-->
          <button class="w-100 py-2 mb-2 btn btn-outline-primary rounded-4 shadow-none" type="button" data-bs-toggle="modal"
            data-bs-target="#joinModal">
            회원가입
          </button>
        </form>
      </div>
    </div>
  </div>
</div>
<!-- 로그인 모달 끝 -->

<!-- 회원가입 모달 시작 -->
<div class="modal fade" tabindex="-1" role="dialog" id="joinModal">
  <div class="modal-dialog" role="document">
    <div class="modal-content rounded-5 shadow">
      <div class="modal-header p-5 pb-4 border-bottom-0">
        <!-- <h5 class="modal-title">Modal title</h5> -->
        <h2 class="fw-bold mb-0">회원가입</h2>
        <button type="button" class="btn-close shadow-none" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <div class="modal-body p-5 pt-0">
        <form>
          <label for="basic-url" class="form-label">아이디</label>
          <div class="form-floating mb-3">
            <input class="form-control rounded-4 shadow-none" id="user-id">
            <label for="floatingInput" id="id-msg"></label>
          </div>
          <label for="basic-url" class="form-label">비밀번호</label>
          <div class="form-floating mb-3">
            <input type="password" class="form-control rounded-4 shadow-none" id="user-pw">
            <label for="floatingPassword" id="pw-msg"></label>
          </div>
          <label for="basic-url" class="form-label">비밀번호 확인</label>
          <div class="form-floating mb-3">
            <input type="password" class="form-control rounded-4 shadow-none" id="user-pw-check">
            <label for="floatingPassword" id="pw-check-msg"></label>
          </div>
          <label for="basic-url" class="form-label">닉네임</label>
          <div class="form-floating mb-3">
            <input class="form-control rounded-4 shadow-none" id="user-nick">
            <label for="floatingInput" id="nick-msg"></label>
          </div>
          <label for="basic-url" class="form-label">이메일</label> <br>
          <span id="email-msg"></span>
          <div class="form-floating input-group mb-3">
            <input type="text" class="form-control rounded-4 shadow-none" id="email1">
            <span class="input-group-text">@</span>
            <input type="text" class="form-control rounded-4 shadow-none" id="email2-input" placeholder="Server"
              aria-label="Server" style="display: none;">
            <select name="" id="email2" class="form-select email2-select shadow-none">
              <option selected value="default">선택</option>
              <option value="naver">naver.com</option>
              <option value="google">gmail.com</option>
              <option value="daum">hanmail.net</option>
              <option value="self">직접 입력</option>
            </select>
          </div>
          <button class="w-100 mb-2 btn btn-lg rounded-4 btn-primary shadow-none" type="button" id="join-btn">회원가입</button>
          <hr class="my-4">
          <small class="text-muted">계정이 이미 있으신가요?</small>
          <h2 class="fs-5 fw-bold mb-3"></h2>
          <button class="w-100 py-2 mb-2 btn btn-outline-primary rounded-4 shadow-none" type="button" data-bs-toggle="modal"
            data-bs-target="#loginModal">
            <svg class="bi me-1" width="16" height="16">
              <use xlink:href="#facebook" /></svg>
            로그인
          </button>
        </form>
      </div>
    </div>
  </div>
</div>
<!-- 회원가입 모달 끝 -->

<script>
	
	//start jQuery
	$(document).ready(function() {
		//회원가입
		//각 입력값들의 유효성 검증을 위한 정규표현식을 변수로 선언
		const get_id_check = RegExp(/^[a-zA-Z0-9]{4,14}$/);
		const get_pw_check = RegExp(/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\'",.<>\/?]).{8,16}$/);
		const get_nick_check = RegExp(/^[가-힣a-zA-Z0-9]{2,20}$/);
		const get_email1_check = RegExp(/^[a-zA-Z0-9]{4,20}$/i);
		const get_email2_check = RegExp(/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i);
		
		//입력값 중 하나라도 만족하지 못한다면 회원가입 처리를 막기 위한 논리형 변수 선언
		let chk1 = false, chk2 = false, chk3 = false, chk4 = false, chk5 = false, chk6 = false;
		
		//1. ID 입력값 검증
		$('#user-id').keyup(function() {
			if($(this).val() === '') {
				$(this).css('border-color', '#E83A14');
				$('#id-msg').html('<b style="font-size: 14px; color: #E83A14">[아이디를 입력하세요.]</b>');
				chk1 = false;
			}
			//아이디 입력값 유효성 검사 (영문, 숫자 4~14자 허용)
			else if(!get_id_check.test($(this).val())) {
				$(this).css('border-color', '#E83A14');
				$('#id-msg').html('<b style="font-size: 14px; color: #E83A14">[아이디는 영문, 숫자로 4~14자로 입력하세요.]</b>');
				chk1 = false;
			}
			//ID 중복 확인 (비동기)
			else {
				const id = $(this).val();
				//console.log(id);
				
				//ajax 호출
				$.ajax({
					type : 'POST',
					url : '<c:url value="/user/checkId" />',
					headers : {
						'Content-Type' : 'application/json'
					},
					dataType : 'text',
					data : id,
					success : function(result) {
						//console.log('통신 성공!: ' + result);
						if(result === 'available') {
							$('#user-id').css('border-color', '#94B49F');
							$('#id-msg').html('<b style="font-size: 14px; color: #94B49F">[사용 가능한 아이디입니다.]</b>');
							chk1 = true;
						} else {
							$('#user-id').css('border-color', '#E83A14');
							$('#id-msg').html('<b style="font-size: 14px; color: #E83A14">[아이디가 중복되었습니다.]</b>');
							chk1 = false;
						}
					},
					error : function(status, error) {
						//console.log('통신 실패!');
						//console.log(status.error);
					}
				}); //ajax(아이디 중복 확인) 끝
			}
		}); //ID 입력값 검증 끝
		
		//2. 비밀번호 입력값 검증
		$('#user-pw').keyup(function() {
			//비밀번호란 공백
			if($(this).val() === '') {
				$(this).css('border-color', '#E83A14');
				$('#pw-msg').html('<b style="font-size: 14px; color: #E83A14">[비밀번호를 입력하세요.]</b>');
				chk2 = false;
			}
			//비밀번호 유효성 검사
			else if(!get_pw_check.test($(this).val()) || $(this).val().length < 8) {
				$(this).css('border-color', '#E83A14');
				$('#pw-msg').html('<b style="font-size: 14px; color: #E83A14">[영대문자,소문자,숫자,특수문자를 각각 하나 이상 포함하여 8~16자]</b>');

				chk2 = false;
			}
			//통과
			else {
				$(this).css('border-color', '#94B49F');
				$('#pw-msg').html('<b style="font-size: 14px; color: #94B49F">[사용 가능한 비밀번호입니다.]</b>');
				chk2 = true;
			}
		}); //비밀번호 입력값 검증 끝
		
		//3. 비밀번호 확인란 입력 검증
		$('#user-pw-check').keyup(function() {
			//비밀번호 확인란 공백 검증
			if($(this).val() === '') {
				$(this).css('border-color', '#E83A14');
				$('#pw-check-msg').html('<b style="font-size: 14px; color: #E83A14">[비밀번호를 다시 한 번 입력하세요.]</b>');
				chk3 = false;
			}
			//비밀번호 확인란 유효성 검사
			else if($(this).val() !== $('#user-pw').val()) {
				$(this).css('border-color', '#E83A14');
				$('#pw-check-msg').html('<b style="font-size: 14px; color: #E83A14">[비밀번호와 일치하지 않습니다.]</b>');
				chk3 = false;
			} else {
				$(this).css('border-color', '#94B49F');
				$('#pw-check-msg').html('<b style="font-size: 14px; color: #94B49F">[비밀번호와 일치합니다.]</b>');
				chk3 = true;
			}
		}); //비밀번호 확인란 검증 끝
		
		//4. 닉네임 입력값 검증
		$('#user-nick').keyup(function() {
			if($(this).val() === '') {
				$(this).css('border-color', '#E83A14');
				$('#nick-msg').html('<b style="font-size: 14px; color: #E83A14">[닉네임을 입력하세요.]</b>');
				chk4 = false;
			}
			//닉네임값 유효성 검사
			else if(!get_nick_check.test($(this).val())) {
				$(this).css('border-color', '#E83A14');
				$('#nick-msg').html('<b style="font-size: 14px; color: #E83A14">[닉네임은 한글, 영어, 숫자 2~20자로 입력하세요.]</b>');
				chk4 = false;
			} else {
				$(this).css('border-color', '#94B49F');
				$('#nick-msg').html('<b style="font-size: 14px; color: #94B49F">[사용 가능한 닉네임 입니다.]</b>');
				chk4 = true;
			}
		}); //닉네임 입력 검증 끝
		
		//5. 이메일1 입력값 검증
	    $('#email1').keyup(function() {
			if($(this).val() === '') {
				$(this).css('border-color', '#E83A14');
				$('#email-msg').html('<b style="font-size: 14px; color: #E83A14">[이메일 주소를 입력하세요.]</b>');
				chk5 = false;
			} else if(!get_email1_check.test($(this).val())) {
				$(this).css('border-color', '#E83A14');
				$('#email-msg').html('<b style="font-size: 14px; color: #E83A14">[이메일 주소를 다시 입력하세요.]</b>');
				chk5 = false;
			} else {
				$(this).css('border-color', '#94B49F');
				$('#email-msg').html('');
				chk5 = true;
			}
		}); //이메일1 검증 끝

		//이메일2 관련 내용 시작
		
		//회원가입 창 이메일 셀렉트 직접 입력 옵션
		//평상시에는 직접 입력 인풋박스 안보이는 상태
		$('#email2-input').hide();

		//메일 선택 셀렉트 변화가 생기면
		$('.email2-select').change(function() {
			//직접 입력을 선택했을 경우
			if($('.email2-select').val() === 'self') {
				//직접 입력 인풋창 보여준다.
				$('#email2-input').show();
				//이메일2 입력값 검증 시작
				$('#email2-input').keyup(function() {
		    		if($(this).val() === '') {
						$(this).css('border-color', '#E83A14');
						$('#email-msg').html('<b style="font-size: 14px; color: #E83A14">[이메일 주소를 입력하세요.]</b>');
						chk6 = false;
					} else if(!get_email2_check.test($(this).val())) {
						$(this).css('border-color', '#E83A14');
						$('#email-msg').html('<b style="font-size: 14px; color: #E83A14">[이메일 주소를 다시 입력하세요.]</b>');
						chk6 = false;
					} else {
						$(this).css('border-color', '#94B49F');
						$('#email-msg').html('');
						chk6 = true;
					}
				}); 
			} else {
				$('#email2-input').hide();
				$('.email2-select').css('border-color', '#94B49F');
				chk6 = true;
			} //이메일2 입력값 검증 끝
		}); //회원가입 창 이메일 셀렉트 직접 입력 옵션 끝
		
		
		//회원가입 버튼 클릭 이벤트
		$('#join-btn').click(function() {
			
			if(chk1 && chk2 && chk3 && chk4 && chk5 && chk6) {
				
				//아이디
				const id = $('#user-id').val();
				//비밀번호
				const pw = $('#user-pw').val();
				//닉네임
				const nick = $('#user-nick').val();
				//이메일1
				const email1 = $('#email1').val();
				//이메일2
				let email2;
				if($('#email2').val() !== 'self') {
					email2 = $("#email2 option:selected").text();
				} else {
					email2 = $('#email2-input').val();
				}
				
				const user = {
						"userId" : id,
						"userPw" : pw,
						"nickname" : nick,
						"email1" : email1,
						"email2" : email2,
				};
				
				//비동기 통신 시작!
				$.ajax({
					type : 'POST',
					url : '<c:url value="/user/" />',
					contentType : 'application/json',
					dataType : 'text',
					data : JSON.stringify(user),
					success : function(result) {
						//console.log('통신 성공!: ' + result);
						alert('회원 가입을 환영합니다!');
						location.reload();
					},
					error : function() {
						alert('회원 가입 실패!');
					}
				}); //end ajax(회원가입 처리)
			} else {
				alert('입력 정보를 다시 확인해주세요.');
			}
			
		}); //회원가입 처리 끝
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		//로그인 검증
		
		//로그인 ID 입력값 검증(공백, 정규표현식)
		$('#login-id').keyup(function() {
			if($(this).val() === '') {
				$(this).css('border-color', '#E83A14');
				$('#login-id-msg').html('<b style="font-size: 14px; color: #E83A14">[아이디를 입력하세요.]</b>');
				chk1 = false;
			} else if(!get_id_check.test($(this).val())) {
				$(this).css('border-color', '#E83A14');
				$('#login-id-msg').html('<b style="font-size: 14px; color: #E83A14">[아이디를 다시 확인해주세요.]</b>');
				chk1 = false;
			} else {
				$(this).css('border-color', '#94B49F');
				$('#login-id-msg').html('');
				chk1 = true;
			}
		}); //로그인 ID 입력값 검증 끝
		
		//로그인 PW 입력값 검증(공백, 정규표현식)
		$('#login-pw').keyup(function() {
			if($(this).val() === '') {
				$(this).css('border-color', '#E83A14');
				$('#login-pw-msg').html('<b style="font-size: 14px; color: #E83A14">[비밀번호를 입력하세요.]</b>');
				chk2 = false;
			} else if(!get_pw_check.test($(this).val())) {
				$(this).css('border-color', '#E83A14');
				$('#login-pw-msg').html('<b style="font-size: 14px; color: #E83A14">[비밀번호를 다시 확인해주세요.]</b>');
				chk2 = false;
			} else {
				$(this).css('border-color', '#94B49F');
				$('#login-pw-msg').html('');
				chk2 = true;
			}
		}); //로그인 PW 입력값 검증 끝
		
		//로그인 버튼 클릭 이벤트
		$('#login-btn').click(function() {
			
			if(chk1 && chk2) {
				const id = $('#login-id').val();
				const pw = $('#login-pw').val();
				
				//console.log('id: ' + id);
				//console.log('pw: ' + pw);
				
				const loginInfo = {
					"userId" : id,
					"userPw" : pw
				};
				
				//비동기 통신 시작!
				$.ajax({
					type : 'POST',
					url : '<c:url value="/user/login" />',
					contentType : 'application/json',
					dataType : 'text',
					data : JSON.stringify(loginInfo),
					success : function(data) {
						if(data === 'wrongId') {
							//console.log('없는 아이디임');
							alert('존재하지 않는 아이디 입니다.');
							$('#login-id').val('');
							$('#login-pw').val('');
							$('#login-id').focus();
						} else if(data === 'wrongPw') {
							//console.log('비번 틀림');
							alert('비밀번호를 다시 확인해주세요.');
							$('#login-pw').val('');
							$('#login-pw').focus();
						} else {
							//console.log('로그인 성공!');
							document.location.reload();
						}
					},
					error : function() {
						//console.log('통신 실패!');
					}
				}); //end ajax 로그인 비동기 처리
				
			} else {
				alert('아이디와 비밀번호를 입력해주세요.');
			}
			
		}); //로그인 버튼 클릭 이벤트 처리 끝!
		
	}); //end jQuery
	
</script>