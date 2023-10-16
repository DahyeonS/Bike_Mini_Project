<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberPasingList.jsp</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
	function getMemberListAjax(page) {
		const params = {page};
	    $.ajax({
	        type: 'GET',
	        url: 'getMemberPagingListJson.jsp',
	        data: params,
	        dataType: 'json',
	        success: function(data) {
	        	console.log(data);
	        	const rs = data['rs'];
		        const paging = data['paging']
		        
	        	if(rs === '0') {	        		
	            	$('#resultView').text(' : 0명');
	            	return;
	            } else {
	            	$('#resultView').text(` : ${'${rs.length}'}명`);
	            	makeTr(rs, paging);
	            }
	        },
	        error: function(xhr, status, error) {
	            console.log(xhr, status, error);
	        }
	    });
	};
	
	function makeTr(rs, paging){
		let tr = ``;
		
		// list
		for(item of rs){
    		const idx = item['idx'];
    		const id = item['id'];
    		const pw = item['pw'];
    		const name = item['name'];
    		const role = item['role'];
    		const regdate = item['regdate'];
    		tr += `
    		<tr>
    		<td>${ '${idx}' }</td>
    		<td>${ '${id}' }</td>
    		<td>${ '${pw}' }</td>
    		<td>${ '${name}' }</td>
    		<td>${ '${role}' }</td>
    		<td>${ '${regdate}' }</td>
    		</tr>`;    		
    	}
		
		// paging
		const pageNum = paging['pageNum'];
		const totalPage = paging['totalPage'];
		const startPage = paging['startPage'];
		const endPage = paging['endPage'];
		const isPrev = paging['isPrev'];
		const isNext = paging['isNext'];
		const isBPrev = paging['isBPrev'];
		const isBNext = paging['isBNext'];
		
		tr += `
		<tr>
		<td colspan="6">
		`
		if(isBPrev)
			tr += `<a href="#" onclick="getMemberListAjax(${ '${startPage-1}' })">[<<]</a>`
		if(paging['isPrev'])
			tr += `<a href="#" onclick="getMemberListAjax(${ '${pageNum-1}' })">[<]</a>`
		for(let i=startPage; i<=endPage; i++){
			if(i == pageNum) {				
				tr += `<span style="color:red;">[${ '${i}' }]</span>`
			}else{				
				tr += `<a href="#" onclick="getMemberListAjax(${ '${i}' })">[${ '${i}' }]</a>`
			}
		}
		if(isNext)
			tr += `<a href="#" onclick="getMemberListAjax(${ '${pageNum+1}' })">[>]</a>`
		if(paging['isPrev'])
			tr += `<a href="#" onclick="getMemberListAjax(${ '${endPage+1}' })">[>>]</a>`	
		tr += `
		</td>
		</tr>
		`
		$('tbody').html(tr);
	}
	
	$(function() {	
		getMemberListAjax();
	});
</script>
</head>
<body>
<%@include file="submenu.jsp" %>
<h2>회원목록<span id="resultView" style="color:red;'"></span></h2>
<hr>
<table border="1">
<thead>
<tr>
	<th>Idx</th>
	<th>ID</th>
	<th>PW</th>
	<th>Name</th>
	<th>Role</th>
	<th>Regdate</th>
</tr>
</thead>

<tbody>

</tbody>
</table>
</body>
</html>