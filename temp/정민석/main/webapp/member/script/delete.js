function deleteJson() {
    const pw = $('#pw').val();
    const param = {pw};
    $.ajax({
        type: 'POST',
        url: 'delete.json',
        dataType: 'json',
        data: param,
        success: function(data) {
            if(data['rs'] === 1) {
                alert('회원탈퇴가 완료되었습니다. 그동안 감사했습니다.');
                location.href = 'index.do';
            } else alert('죄송합니다. 다시 시도해주세요.');
        }, error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

$(function() {
    $('#submit').click(function() {
        deleteJson();
    });
});