function getJson() {
    $.ajax({
        type: 'POST',
        url: 'memberList.json',
        dataType: 'json',
        success: function(data) {
            let tr = '';
            for (item of data) {
                const {idx, id, pw, nickname, grade, regdate} = item;
                tr += '<tr class="info"><td class="num">' + idx + '</td><td>' + id + '</td><td>'
                + nickname + '</td><td class="grade">' + grade + '</td><td>' + regdate + '</td></tr>';
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