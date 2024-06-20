<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ShiftHandover</title>
</head>
<body>
<div style="height:300px; width:250px; float:left; background-color:skyblue; border-radius:15px; padding:50px; margin-left:370px; margin-top:10px;">
<center>
<form action="MySrevlet">
<h1>shift hand over</h1>
<table >
<tr>
<td>Date:</td>
<td> <input type="date" placeholder="YYYY-MM-DD" name="date"> <td>
</tr>
<tr>
<td>Name:</td>
<td><input type="text" placeholder="Enter Your Name" name="name"></td>
</tr>
<tr>
<td>Department:</td>
<td><input type="text" placeholder="Enter Your Team name" name="dep"></td>
</tr>
<tr>
<td>Comments:</td>
<td><input type="text" placeholder="Enter Your Comments" name="com"></td>
</tr>
</table>
<center><input type="submit" value="submit"></center>
</form>
</center>
</div>
<div style="height:200px; width:200px; float:left; background-color:pink; border-radius:15px; padding:50px; margin-top:10px; margin-left:200px;">
<center>
<form action="MySrevlet">
<h1>search Your Details</h1>
<table>
<tr>
<td>Date:</td>
<td> <input type="date" placeholder="YYYY-MM-DD" name="dates"> <td>
</tr>
<tr>
<td>Name:</td>
<td><input type="text" placeholder="Enter Your Name" name="names"></td>
</tr>
</table>
<center><input type="submit" value="search"></center>
</form>
</center>
</div>
</body>
</html>