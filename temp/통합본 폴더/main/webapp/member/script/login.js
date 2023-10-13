function loginJson() {
    const id = $('#id').val();
    const pw = $('#pw').val();
    const param = {id, pw};
    $.ajax({
        type: 'POST',
        url: 'login.json',
        dataType: 'json',
        data: param,
        success: function(data) {
            if (data['rs'] === 1) {
                alert('환영합니다!');
                location.href = 'index.do';
            }
            else {
	            alert('아이디나 비밀번호가 다릅니다');
	            return;
            }
        }, error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

$(function() {
	$('#id').focus();
    $('#submit').click(function() {
        const id = $('#id').val();
    	const pw = $('#pw').val();
    	if (id === '') alert('아이디를 입력해주세요.');
    	else if (pw === '') alert('비밀번호를 입력해주세요.');
	    else loginJson();
    });
    $('#pw').keydown(function(event) {
    	if (event.keyCode === 13) {
    		const id = $('#id').val();
    		const pw = $('#pw').val();
    		if (id === '') alert('아이디를 입력해주세요.');
    		else if (pw === '') alert('비밀번호를 입력해주세요.');
	        else loginJson();
    	}
    });
    $('#id').keydown(function(event) {
    	if (event.keyCode === 13) {
    		const id = $('#id').val();
    		const pw = $('#pw').val();
    		if (id === '') alert('아이디를 입력해주세요.');
    		else if (pw === '') alert('비밀번호를 입력해주세요.');
    	}
    });
});