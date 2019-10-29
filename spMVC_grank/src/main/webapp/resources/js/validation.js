var joinValidate = {
		resultCode : {
			// 공통 유효성 검사
			empty_val : {
				code : 1,
				desc : '필수입력 정보입니다.'
			},
			space_val : {
				code : 2,
				desc : '공백 없이 입력해 주세요.'
			},
			success_id : {
				code : 0,
				desc : '!멋진 아이디네요.'
			},
			// id 체크
			invalid_id : {
				code : 3,
				desc : '올바른 아이디(영문 소문자, 숫자)를 입력해 주세요.'
			},
			length_id : {
				code : 4,
				desc : '아이디(글자수 5~20미만)를 입력해 주세요.'
			},
			// 비밀번호 체크
			success_ps : {
				code : 0,
				desc : '사용가능한 비밀번호입니다.'
			},
			invalid_ps : {
				code : 3,
				desc : '올바른 비밀번호(특수문자 포함 영문 대소문자 8~16자)를 입력해 주세요.'
			},
			equal_ps : {
				code : 5,
				desc : '현재 비밀번호와 다르게 입력해 주세요.'
			},
			// 비밀번호 확인 체크
			success_rps : {
				code : 0,
				desc : '비밀번호가 일치합니다.'
			},
			other_rps : {
				code : 4,
				desc : '비밀번호가 일치하지 않습니다.'
			},
			// 닉네임 체크
			success_name : {
				code : 0,
				desc : '사용 가능한 닉네임입니다.'
			},
			invalid_name : {
				code : 3,
				desc : '올바른 닉네임(영문, 한글, 숫자)을 입력해 주세요.'
			},
			length_name : {
				code : 4,
				desc : '글자수 2~10자로 입력해 주세요.'
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
			},
			// 이메일 체크
			success_em : {
				code : 0,
				desc : '올바른 이메일입니다.'
			},
			invalid_em : {
				code : 3,
				desc : '올바른 이메일을 입력해 주세요.'
			},
			// 상세주소 체크
			success_ad : {
				code : 0,
				desc : '올바른 상세주소입니다.'
			},
			invalid_ad : {
				code : 3,
				desc : '올바른 상세주소를 입력해 주세요.'
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
		checkPs : function(pass) {
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
			}  else {
				return this.resultCode.success_ps;
			}
		},
		// 비밀번호 확인 유효성 체크
		checkRps : function(rpass, pass) {
			// 공백문자
			var regEmpty = /\s/g;
			// 비밀번호 확인 null 체크
			if(rpass == "" || rpass.length == 0) {
				return this.resultCode.empty_val;
			// 비밀번호 확인 공백 체크
			} else if (rpass.match(regEmpty)) {
				return this.resultCode.space_val;
			// 비밀번호 null 체크
			} else if (pass != "" || pass.length != 0) {
				// 비밀번호 확인과 비밀번호가 일치하는지 체크
				if(rpass == pass) {
					return this.resultCode.success_rps;
				} else {
					return this.resultCode.other_rps;
				}
			} else {
				return this.resultCode.success_rps;
			}
		},
		// 닉네임 유효성 체크
		checkName : function(name) {
			// 공백문자
			var regEmpty = /\s/g;
			//영문, 한글만
			var regLang =/[^가-힣a-zA-Z]/;
			// 닉네임 null 체크
			if(name == "" || name.length == 0) {
				return this.resultCode.empty_val;
			// 닉네임 공백 체크
			} else if (name.match(regEmpty)) {
				return this.resultCode.space_val;
			// 닉네임 길이(2~10) 체크
			} else if ((name.length < 2) || (name.length > 10)) {
				return this.resultCode.length_name;
			// 닉네임 유효성 체크
			} else if (regLang.test(name)) {
				return this.resultCode.invalid_name;
			} else {
				return this.resultCode.success_name;
			}
		},
		// 전화번호 유효성 체크
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
			// 전화번호 숫자 체크
			} else if ($.isNumeric(phone) ==false) {
				return this.resultCode.number_ph;
			// 전화번호 유효성 체크
			} else if (!regPhone.test(phone)) {
				return this.resultCode.invalid_ph;
			} else {
				return this.resultCode.success_ph;
			}
		},
		// 이메일 유효성 체크
		checkEmail : function(email) {
			// 공백문자
			var regEmpty = /\s/g;
			// 이메일 유효성 체크
			regEmail =/^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,4}$/i;
			// 이메일 null 체크
			if(email == "" || email.length == 0) {
				return this.resultCode.empty_val;
			// 이메일 공백 체크
			} else if (email.match(regEmpty)) {
				return this.resultCode.space_val;
			// 이메일 유효성 체크
			} else if (!regEmail.test(email)) {
				return this.resultCode.invalid_em;
			} else {
				return this.resultCode.success_em;
			}
		},
		// 상세주소 유효성 체크
		checkAddr : function(addr) {
			// 상세주소 유효성 체크(숫자, 한글, 공백, (,))만
			regAddr =/[^0-9가-힣, ]/;
			// 상세주소 null 체크
			if(addr == "" || addr.length == 0) {
				return this.resultCode.empty_val;
			// 상세주소 유효성 체크
			} else if (regAddr.test(addr)) {
				return this.resultCode.invalid_ad;
			} else {
				return this.resultCode.success_ad;
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
				return_val = true;
			} else {
				return_val = false;
			}
		},
		error:function(){
			alert("err~~~~~~~~~");
		} 
	})
	return return_val;
}

// 아이디 찾기의 이메일 값으로 아이디 값 가져오기
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

// 비밀번호 찾기의 아이디 값과 이메일 값으로 비밀번호 검색 후 맞으면 임시비밀번호 생성 후 가져오기
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