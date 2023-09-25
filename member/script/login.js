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
            else alert('아이디나 비밀번호가 다릅니다');
        }, error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

$(function() {
    $('#submit').click(function() {
        loginJson();
    });
});