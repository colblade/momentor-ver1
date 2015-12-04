<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>tiles layout</title>
</head>
<body>
<table width="100%" border="1" cellpadding="5">
<tr height="100">
 <td colspan="2"><tiles:insertAttribute name="header" /></td> 
</tr>
<tr height="400">
 <td width="200" valign="top"><tiles:insertAttribute name="left" /></td>
 <td valign="top"><tiles:insertAttribute name="main" /></td>
</tr>
<tr height="70">
 <td colspan="2"><tiles:insertAttribute name="footer" /></td>
</tr>
</table>
</body>
</html>