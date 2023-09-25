function getJson() {
    $.ajax({
        type: 'POST',
        url: 'memberList.json',
        dataType: 'json',
        success: function(data) {
            let tr = '';
            for (item of data) {
                const {idx, id, pw, nickname, grade, regdate} = item;
                tr += '<tr style="text-align: center;"><td>' + idx + '</td><td>' + id + '</td><td>' + pw
                + '</td><td>' + nickname + '</td><td>' + grade + '</td><td>' + regdate + '</td></tr>';
            }
            $('#tbody').html(tr);
        },
        error: function(xhr, status, error) {
            console.log(xhr, status, error);
        }
    });
};

$(function() {
    getJson();
});