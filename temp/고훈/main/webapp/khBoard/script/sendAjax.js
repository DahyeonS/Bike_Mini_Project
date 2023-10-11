async function sendAjax (ajaxUrl, params) {
	let result;
	try {
		result = await $.ajax({
	    	contentType: "application/json; charset:UTF-8",
	        url: ajaxUrl,
	        type: 'GET',
	        dataType: 'json',
	        data: params,
	    });
		return result;
	} catch (error) {
		console.error(error);
	}
	
	
       // success: function(data) {
       // 	str = '<h3>총 게시물 수 : ' + data['totalCount'] + '</h3>'
       //     $('#totalCount').html(str);
       // },
       // error: function(xhr, status, error) {
       //     console.log(xhr, status, error);
       // }
	
}