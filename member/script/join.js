function idCheck(param) {
    $.ajax({
        type: 'POST',
        url: 'idCheck.json',
        data: param,
        dataType: 'json',
        success: function(data) {
            if(data['rs'] === 1) {
                $('#success').hide();
                $('#fail').show();
                $('#submit').attr('disabled', 'disabled');
            } else {
                $('#fail').hide();
                $('#success').show();
                $('#submit').removeAttr("disabled");
            }
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

function nicknameCheck(param) {
    $.ajax({
        type: 'POST',
        url: 'nicknameCheck.json',
        data: param,
        dataType: 'json',
        success: function(data) {
            if(data['rs'] === 1) {
                $('#nicksuccess').hide();
                $('#nickfail').show();
                $('#submit').attr('disabled', 'disabled');
            } else {
                $('#nickfail').hide();
                $('#nicksuccess').show();
                $('#submit').removeAttr("disabled");
            }
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

function join(params) {
    $.ajax({
        type: 'POST',
        url: 'join.json',
        dataType: 'json',
        data: params,
        success: function(data) {
            if(data['rs'] === 1) {
                alert('회원가입을 축하드립니다!');
                location.href = 'login.do';
            } else alert('다시 시도해주세요.');
        }, error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

$(document).ready(function() {
    $('#success').hide();
    $('#nicksuccess').hide();
    $('#fail').hide();
    $('#nickfail').hide();

    $('#check').click(function() {
        const id = $('#id').val();
        const param = {id};
        if(id === '') {
            alert('아이디를 입력해주세요.');
            $('#id').focus();
            return;
        } else if (/^[ㄱ-ㅎ|가-힣]+$/.test(id)) {
        	alert('아이디는 한글을 사용할 수 없습니다.');
            $('#id').focus();
        	return;
        }
        idCheck(param);
    });
    $('#nickcheck').click(function() {
        const nickname = $('#nickname').val();
        const param = {nickname};
        if(nickname === '') {
            alert('닉네임을 입력해주세요.');
            $('#nickname').focus();
            return;
        }
        nicknameCheck(param);
    });
    
    $('#submit').click(function() {
        const id = $('#id').val();
        if(id === '') {
            alert('아이디를 입력해주세요.');
            $('#id').focus();
            return;
        } else if (/^[ㄱ-ㅎ|가-힣]+$/.test(id)) {
            alert('아이디는 한글을 사용할 수 없습니다.');
            $('#id').focus();
            return;
        }
        const pw = $('#pw').val();
        if(pw === '') {
            alert('비밀번호를 입력해주세요.');
            $('#pw').focus();
            return;
        }
        const pw2 = $('#pw2').val();
        if(pw2 === '') {
            alert('비밀번호 확인을 해주세요..');
            $('#pw2').focus();
            return;
        } else if (pw !== pw2) {
            alert('비밀번호가 일치하지 않습니다.');
            $('#pw2').focus();
            return;
        }
        const nickname = $('#nickname').val();
        if(nickname === '') {
            alert('닉네임을 입력해주세요.');
            $('#nickname').focus();
            return;
        }
        const params = {id, pw, nickname};
        join(params);
    });
});