<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Iniciar sesión</title>

    <link href="${pageContext.request.contextPath}/styles/login.css" rel="stylesheet" type="text/css"/>

    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
            integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV"
            crossorigin="anonymous"></script>

    <style>
        body {
            background-image: url("${pageContext.request.contextPath}/resources/images/body.jpg");
            background-size: cover;
        }
    </style>
</head>
<body>
<!-- Section: Design Block -->
<div class="container">
    <div class="row d-flex align-items-center">
        <div class="col-lg-2"></div>
        <div class="col-lg-8">
            <section class=" text-center text-lg-start mx-auto" style="margin-top: 20%!important;">
                <div class="card mb-3">
                    <div class="row g-0 d-flex align-items-center">
                        <div class="col-lg-4 d-none d-lg-flex">
                            <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="Music Store"
                                 class="w-100 rounded-t-5 rounded-tr-lg-0 rounded-bl-lg-5"/>
                        </div>
                        <div class="col-lg-8">
                            <div class="card-body py-5 px-md-5">
                                <s:form action="login" method="post" cssClass="form-horizontal"
                                        cssStyle="text-align: -webkit-center">
                                    <s:textfield name="username" placeholder="Usuario/Correo" cssClass="form-control"
                                                 required="true"/>
                                    <s:password name="password" placeholder="Contraseña" cssClass="form-control"
                                                required="true" cssStyle="margin-top: 1rem"/>
                                    <s:submit value="Iniciar sesión" cssClass="btn btn-primary btn-block mb-4"
                                              cssStyle="margin-top: 1rem"/>
                                </s:form>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <div class="col-lg-2"></div>
    </div>
</div>

<!-- Section: Design Block -->
</body>
</html>
