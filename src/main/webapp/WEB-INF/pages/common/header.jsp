<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/3/21
  Time: 15:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<body>
<%
    String path = request.getScheme()+"://"+request.getServerName();
    if(request.getServerPort()!=80){
        path += ":"+request.getServerPort();
    }
    path += request.getContextPath();
    pageContext.setAttribute("path",path);
%>
</body>
</html>
