var joinValidate = {
		resultCode : {
			// 공통 유효성 검사
			empty_val : {
				code : 1,
				desc : '필수입력 정보입니다.'
			},
			space_val : {
				code : 2,
				desc : '공백 없이 입력해주세요.'
			},
			success_id : {
				code : 0,
				desc : '!멋진 아이디네요.'
			},
			// id 체크
			invalid_id : {
				code : 3,
				desc : '올바른 아이디를 입력해주세요.'
			},
			length_id : {
				code : 4,
				desc : '5~20자의 영문 소문자, 숫자만 사용 가능 합니다.'
			}
		},
		// id 유효성 체크
		checkId : function(memid) {
			// 공백문자
			var regEmpty = /\s/g;
			// ID 유효성체크
			var regId = /[^a-z0-9-_.]+/g;
			
			// id null 체크
			if(memid == "" || memid.length == 0) {
				return this.resultCode.empty_val;
			// id 공백 체크
			} else if (memid.match(regEmpty)) {
				return this.resultCode.space_val;
			// id 정규식 체크
			} else if (regId.test(memid)) {
				return this.resultCode.invalid_id;
			// id 길이 체크
			} else if ((memid.length < 5) || (memid.length > 20)) {
				return this.resultCode.length_id;
			} else {
				return this.resultCode.success_id;
			}
		}
}



// 아이디 체크
function ajaxIdCheck(memid) {
	var return_val = false;
	$.ajax({
		url : 'idCheck?userid='+memid,
		type : 'POST',
		async : false,
		contentType: "application/json",
		success : function(data) {
			if(data == 1) {
				$("#join-id").next().text("중복 된 아이디 입니다.").css("display","block")
				return_val = false;
			} else {
				$("#join-id").next().text("!멋진 아이디네요.").css("display","block").css("color","blue")
				return_val = true;
			}
		},
		error:function(){
			alert("err~~~~~~~")
		}
	})
	return return_val;
}

// 비밀번호 체크
function ajaxPassCheck(user, pass) {
	var return_val = false;
	$.ajax({
		url : 'passCheck?userid='+user+ '&passwd=' + pass,
		type : 'POST',
		async: false,
		contentType: "application/json",
		success : function(data) {
			if(data == 1) {
//				$('.member-delete-err').text('비밀번호가 일치합니다.').css('visibility','visible').css('color','blue');
				return_val = true;
			} else {
//				$('.member-delete-err').text('비밀번호가 일치하지 않습니다.').css('visibility','visible');
				return_val = false;
			}
		},
		error:function(){
			alert("err~~~~~~~~~");
		} 
	})
	return return_val;
}

// 이메일 체크
function ajaxEmailCheck(email) {
	var email_check = null;
	$.ajax({
		url : 'emailcheck?email='+email,
		type : 'POST',
		async : false,
		contentType : "application/json",
		success : function(data) {
			if (data != null) {
				email_check = data;
			} else {
				email_check = data;
			}
		},
		error:function(){
			alert("err~~~~~~~~~");
		}
	})
	return email_check;
}

// password 체크
function ajaxPswordCheck(userid, email) {
	var psword = null;
	$.ajax({
		url : 'pswordcheck?userid='+userid+"&email="+email,
		type : 'POST',
		async : false,
		contentType : "application/json",
		success : function(data) {
			if(data != null) {
				psword = data;
			} else {
				psword = data;
			}
		},
		error:function(){
			alert("err~~~~~~~~~");
		}
	})
	return psword;
}