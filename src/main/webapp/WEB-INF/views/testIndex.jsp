<%@ page session="false"%>
<html>
<head>
<title>testIndex</title>
<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	$(function(){
		$.ajax({
			url : "/test/startTest",
			type : "GET",
			dataType: "JSON",
			async : false,
			success : function(data) {
				console.log(data);
			},
			error : function(e) {
				console.log(e);
			},
			complete : function() {
			}
		});
	})
</script>
</head>
<body>
	<h1>testIndex.jsp</h1>

	<P>The time on the server is ${serverTime}.</P>



</body>
</html>
