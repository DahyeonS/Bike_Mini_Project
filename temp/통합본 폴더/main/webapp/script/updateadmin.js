function memberShow() {
    const context = $('#context').val();
    const param = {context};
    $.ajax({
        type: 'POST',
        url: 'memberShow.json',
        data: param,
        dataType: 'json',
        success: function(data) {
            if (data['pw'] === null) alert('회원이 존재하지 않습니다.');
            else if (data['id'] === 'admin') alert('관리자는 수정할 수 없습니다.');
            else {
                $('#id').attr('value', data['id']);
                $('#nickname').attr('value', data['nickname']);
                $('#member').show();
            }
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

function updateAdminJson() {
    const id = $('#id').val();
    const nickname = $('#nickname').val();
    const grade = $('#grade').val();
    const params = {id, nickname, grade};
    $.ajax({
        type: 'POST',
        url: 'updateAdmin.json',
        dataType: 'json',
        data: params,
        success: function(data) {
            if(data['rs'] === 1) {
                alert('회원정보가 수정되었습니다.');
                location.href = "updateAdmin.do";
            } else alert('죄송합니다. 다시 시도해주세요.');
        }, error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

function deleteAdminJson() {
    const id = $('#id').val();
    const param = {id};
    $.ajax({
        type: 'POST',
        url: 'deleteAdmin.json',
        dataType: 'json',
        data: param,
        success: function(data) {
            if(data['rs'] === 1) {
                location.href = 'updateAdmin.do';
            } else alert('죄송합니다. 다시 시도해주세요.');
        }, error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

function memberDeleteConfirm() {
    const input = confirm("해당회원을 탈퇴시킬까요?");
    if (input) {
        alert("회원을 탈퇴시켰습니다.");
        deleteAdminJson();
    }
    else return;
 };

$(function() {
    $('#member').hide();
    $('#search').click(function() {
        memberShow();
    });
    $('#submit').click(function() {
        updateAdminJson();
    });
});