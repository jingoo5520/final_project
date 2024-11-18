<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Error Page</title>
<style>
body {
	margin: 0;
	padding: 0;
	font-family: Arial, sans-serif;
	color: #fff;
	height: 100vh;
	display: flex;
	justify-content: center;
	align-items: center;
	background: url('/resources/images/error.jpg') no-repeat center center/cover;
	position: relative;
}

.overlay {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.6);
	z-index: 1;
}

.error-container {
	position: relative;
	z-index: 2;
	text-align: center;
	padding: 20px;
}

.error-code {
	font-size: 6rem;
	font-weight: bold;
	margin-bottom: 10px;
}

.error-message {
	font-size: 1.5rem;
	margin-bottom: 20px;
}

.btn {
	background-color: #007bff;
	color: #fff;
	text-decoration: none;
	padding: 10px 20px;
	border-radius: 5px;
	font-size: 1rem;
	font-weight: bold;
	transition: background-color 0.3s ease;
}

.btn:hover {
	background-color: #0056b3;
}
</style>
</head>
<script>
function goBack() {
	window.history.back();
}
</script>
<body>
	<div class="overlay"></div>
	<div class="error-container">
		<div class="error-code">500</div>
		<h2 class="error-message">${errorMessage != null ? errorMessage : ""}</h2>
		<p></p>
		<a href="javascript:void(0);" onclick="goBack();" class="btn">${buttonMesage}</a>
	</div>
</body>
</html>
