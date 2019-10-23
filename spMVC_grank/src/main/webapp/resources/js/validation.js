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
			},
			// 비밀번호 체크
			success_ps : {
				code : 0,
				desc : '사용가능한 비밀번호입니다.'
			},
			invalid_ps : {
				code : 3,
				desc : '올바른 비밀번호(특수문자 포함 8~16자)를 입력해 주세요.'
			},
			other_ps : {
				code : 4,
				desc : '비밀번호가 일치하지 않습니다.'
			},
			equal_ps : {
				code : 5,
				desc : '현재 비밀번호와 다르게 입력해주세요.'
			},
			// 비밀번호 확인 체크
			success_rps : {
				code : 0,
				desc : '비밀번호가 일치합니다.'
			},
			// 닉네임 체크
			success_name : {
				code : 0,
				desc : '사용 가능한 닉네임 입니다.'
			},
			invalid_name : {
				code : 3,
				desc : '올바른 닉네임(영문, 한글 2~10자)를 입력해 주세요.'
			},
			// 전화번호 체크
			success_ph : {
				code : 0,
				desc : '사용 가능한 번호입니다.'
			},
			invalid_ph : {
				code : 3,
				desc : '올바른 번호(-)없이 10자, 11자로 입력해 주세요.'
			},
			number_ph : {
				code : 4,
				desc : '숫자만 입력해 주세요'
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
		},
		// 비밀번호 유효성 체크
		checkPs : function(pass, rpass) {
			// 공백문자
			var regEmpty = /\s/g;
			// 비밀번호 유효성 체크
			var regPs =/^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,16}$/;
			
			// 비밀번호 null 체크
			if(pass == "" || pass.length == 0) {
				return this.resultCode.empty_val;
			// 비밀번호 공백 체크
			} else if (pass.match(regEmpty)) {
				return this.resultCode.space_val;
			// 비밀번호 정규식 체크
			} else if (!regPs.test(pass)) {
				return this.resultCode.invalid_ps;
			// 비밀번호 확인 null 체크
			} else if (rpass != "" || rpass.length != 0) {
				// 비밀번호와 비밀번호 확인 일치하는지 체크
				if(pass == rpass) {
					return this.resultCode.success_ps;
				} else {
					return this.resultCode.other_ps;
				}
			} else {
				return this.resultCode.success_ps;
			}
		},
		// 비밀번호 확인 유효성 체크
		checkRps : function(rpass, pass) {
			// 비밀번호 확인 null 체크
			if(rpass == "" || rpass.length == 0) {
				return this.resultCode.empty_val;
			// 비밀번호 null 체크
			} else if (pass != "" || pass.length != 0) {
				if(rpass == pass) {
					return this.resultCode.success_rps;
				} else {
					return this.resultCode.other_ps;
				}
			} else {
				return this.resultCode.success_ps;
			}
		},
		// 닉네임 유효성 체크
		checkName : function(name) {
			// 공백문자
			var regEmpty = /\s/g;
			//영문, 한글만(2~10자)
			var regLang =/[^a-zA-Z가-힣]{2,10}/;
			// 닉네임 null 체크
			if(name == "" || name.length == 0) {
				return this.resultCode.empty_val;
			// 닉네임 공백 체크
			} else if (name.match(regEmpty)) {
				return this.resultCode.space_val;
			// 닉네임 유효성 체크
			} else if (regLang.test(name)) {
				return this.resultCode.invalid_name;
			} else {
				return this.resultCode.success_name;
			}
		},
		checkPhone : function(phone) {
			// 공백문자
			var regEmpty = /\s/g;
			// 전화번호 유효성 체크
			var regPhone =/(01[016789])([1-9]{1}[0-9]{2,3})([0-9]{4})$/;
			// 전화번호 null 체크
			if(phone == "" || phone.length == 0) {
				return this.resultCode.empty_val;
			// 전화번호 공백 체크
			} else if (phone.match(regEmpty)) {
				return this.resultCode.space_val;
			} else if ($.isNumeric(phone) ==false) {
				return this.resultCode.number_ph;
			} else if (!regPhone.test(phone)) {
				return this.resultCode.invalid_ph;
			} else {
				return this.resultCode.success_ph;
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

// 닉네임 중복 체크
function ajaxNameCheck(name) {
	check = null;
	$.ajax({
		url : 'namecheck?name='+name,
		type : 'POST',
		async : false,
		contentType : "application/json",
		success : function(data) {
			if(data == 1) {
				$("#join-name").next().text("중복 된 닉네임 입니다.").css("display","block")
				check = false;
			} else {
				$("#join-name").next().text("사용 가능한 닉네임 입니다.").css("display","block").css("color","blue")
				check = true;
			}
		},
		error:function(){
			alert("err~~~~~~~~~");
		}
	})
	return check;
}