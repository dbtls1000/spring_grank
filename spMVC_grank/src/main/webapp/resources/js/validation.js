function ajaxPassCheck(user, pass) {
	var return_val = false;
	$.ajax({
		url : 'passCheck?userid='+user+ '&passwd=' + pass,
		type : 'POST',
		async: false,
		contentType: "application/json",
		success : function(data) {
			if(data == 1) {
				$('.member-delete-err').text('비밀번호가 일치합니다.').css('visibility','visible').css('color','blue');
				return_val = true;
			} else {
				$('.member-delete-err').text('비밀번호가 일치하지 않습니다.').css('visibility','visible');
				return_val = false;
			}
		},
		error:function(){
			alert("err~~~~~~~~~");
		} 
	})
	return return_val;
}