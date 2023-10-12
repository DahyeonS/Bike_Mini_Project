<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	function pwShow() {
		const id = "<%=(String)session.getAttribute("id")%>";
		const param = {id};
	    $.ajax({
	        type: 'POST',
	        url: 'pwShow.json',
	        data: param,
	        dataType: 'json',
	        success: function(data) {
	        	$('#pw').attr('value', data['pw']);
	        },
	        error: function(xhr, status, error) {
	            console.log(xhr, status, error);
	        }
	    });
	};

	function updateJson() {
		const id = $('#id').val();
		const pw = $('#pw').val();
		const nickname = $('#nickname').val();
		const params = {id, pw, nickname};
		$.ajax({
	        type: 'POST',
	        url: 'update.json',
	        dataType: 'json',
	        data: params,
	        success: function(data) {
	        	if(data['rs'] === 1) {
	        		alert('회원정보가 수정되었습니다.');
	        		location.href = "update.do";
	        	} else alert('죄송합니다. 다시 시도해주세요.');
	        }, error: function(xhr, status, error) {
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
	            	console.log(param['nickname'])
	            	if(param['nickname'] === '<%=(String)session.getAttribute("nickname")%>') {
	                	$('#nicksuccess').hide();
	                	$('#nickfail').hide();
	                	$('#nickequal').show();
	            	} else {
		                $('#nicksuccess').hide();
		                $('#nickequal').hide();
		                $('#nickfail').show();
		                $('#submit').attr('disabled', 'disabled');
	            	}
	            } else {
	                $('#nickfail').hide();
	                $('#nickequal').hide();
	                $('#nicksuccess').show();
	                $('#submit').removeAttr("disabled");
	            }
	        },
	        error: function(xhr, status, error) {
	            console.log(xhr, status, error);
	        }
	    });
	};
	
	$(function() {
 		$('#nicksuccess').hide();
	    $('#nickfail').hide();
	    $('#nickequal').hide();
		pwShow();
		$('#submit').click(function() {
			const input = confirm("회원정보를 수정하겠습니까?");
		    if (input) {
				updateJson();
		   	}
		    else return;
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
	});
</script>