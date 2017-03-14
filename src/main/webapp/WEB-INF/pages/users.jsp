<%--
  Created by IntelliJ IDEA.
  User: Aleks
  Date: 11.03.2017
  Time: 04:22
  To change this template use File | Settings | File Templates.
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="false" %>

<html>
<head>
    <title>UserData</title>

    <style type="text/css">
        .tg {
            border-collapse: collapse;
            border-spacing: 0;
            border-color: #ccc;
        }

        .tg td {
            font-family: Arial, sans-serif;
            font-size: 14px;
            padding: 10px 5px;
            border-style: solid;
            border-width: 1px;
            overflow: hidden;
            word-break: normal;
            border-color: #ccc;
            color: #333;
            background-color: #fff;
        }

        .tg th {
            font-family: Arial, sans-serif;
            font-size: 14px;
            font-weight: normal;
            padding: 10px 5px;
            border-style: solid;
            border-width: 1px;
            overflow: hidden;
            word-break: normal;
            border-color: #ccc;
            color: #333;
            background-color: #f0f0f0;
        }

        .tg .tg-4eph {
            background-color: #f9f9f9
        }
    </style>
</head>
<body>
<a href="../../index.jsp">Back to main menu</a>

<br/>
<br/>

<div id="content">

    <c:if test="${!empty usersPages}">
    <h1>All users list</h1>
    <table class="tg">
        <tr>
            <th width="50">ID</th>
            <th width="100">Name</th>
            <th width="50">Age</th>
            <th width="100">Root</th>
            <th width="100">Created Date</th>
            <th width="100">Edit</th>
            <th width="100">Delete</th>
        </tr>
        <c:forEach items="${usersPages.pageList}" var="user">
            <tr>
                <td>${user.id}</td>
                <td>${user.name}</td>
                <td>${user.age}</td>
                <td>
                    <c:if test="${!user.isAdmin}"> User</c:if>
                    <c:if test="${user.isAdmin}"> Admin</c:if>
                </td>
                <td>${user.createdDate}</td>
                <td><a href="<c:url value='/edit/${user.id}'/>">Edit</a></td>
                <td><a href="<c:url value='/remove/${user.id}'/>">Delete</a></td>
            </tr>
        </c:forEach>

        <tr>
            <td style="border-style:hidden"><a
                    <c:if test="${usersPages.firstPage}">hidden</c:if> href="/users${prevPageRequest}">Prev</a></td>
            <td style="border-style:hidden"></td>
            <td style="border-style:hidden"></td>
            <td style="border-style:hidden"></td>
            <td style="border-style:hidden"></td>
            <td style="border-style:hidden"></td>
            <td style="border-style:hidden"><a
                    <c:if test="${usersPages.lastPage}">hidden</c:if> href="/users${nextPageRequest}">Next</a></td>
        </tr>
        </c:if>


    </table>


</div>

<h1>Add/Edit user</h1>

<c:url var="addAction" value="/users/add"/>

<form:form action="${addAction}" commandName="user">
    <table>
        <c:if test="${!empty user.name}">
            <tr>
                <td>
                    <form:label path="id">
                        <spring:message text="ID"/>
                    </form:label>
                </td>
                <td>
                    <form:input path="id" readonly="true" size="8" disabled="true"/>
                    <form:hidden path="id"/>
                </td>
            </tr>
        </c:if>
        <tr>
            <td>
                <form:label path="name">
                    <spring:message text="Name"/>
                </form:label>
            </td>
            <td>
                <form:input path="name"/>
            </td>
        </tr>
        <tr>
            <td>
                <form:label path="age">
                    <spring:message text="Age"/>
                </form:label>
            </td>
            <td>
                <form:input path="age"/>
            </td>
        </tr>
        <tr>
            <td>Root</td>
            <td>
                <input id="radioAdmin" name="admin" type="radio" value="true"
                        <c:if test="${user.isAdmin}"> checked="checked"</c:if> /> Admin
                <input id="radioUser" name="admin" type="radio" value="false"
                        <c:if test="${!user.isAdmin}"> checked="checked"</c:if> /> User
            </td>
        </tr>
        <tr>
            <td>
                <form:label path="createdDate">
                    <spring:message text="Date"/>
                </form:label>
            </td>
            <td>
                <form:input path="createdDate" readonly="true" disabled="true"/>
                <form:hidden path="createdDate"/>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <c:if test="${!empty user.name}">
                    <input type="submit"
                           value="<spring:message text="Edit user"/>"/>
                </c:if>
                <c:if test="${empty user.name}">
                    <input type="submit"
                           value="<spring:message text="Add user"/>"/>
                </c:if>
            </td>
        </tr>
    </table>
</form:form>

<h1>Search users</h1>
<c:url var="saveUrl" value="/users/filter"/>
<form:form modelAttribute="user" method="POST" action="${saveUrl}">
    <table>
        <tr>
            <td><form:label path="name">Name:</form:label></td>
            <td><form:input path="name"/></td>
        </tr>
    </table>
    <br/>
    <input type="submit" value="Find user"/>
    <br/>
</form:form>

</body>
</html>