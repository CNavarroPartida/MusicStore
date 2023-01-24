<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sb" uri="/struts-bootstrap-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Style-Type" content="text/css"/>
    <meta http-equiv="pragma" content="no-cache"/>
    <meta http-equiv="cache-control" content="no-cache"/>
    <meta http-equiv="expires" content="0"/>
    <title>Agregar canción</title>


    <%@ include file="boostrap-imports.jsp" %>

    <sj:head loadAtOnce="true" jquerytheme="cupertino"/>


    <style>
        .nav-pills .nav-link.active{
            color: #fff;
            background-color: #237527;
        }

        a {
            color: #237527;
        }
    </style>
</head>

<body>
<%@ include file="../components/headerComponent.jsp" %>

<div class="row" style="padding: 1rem 0 0 0.5rem">
    <div class="col-2">
        <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
            <a class="nav-link" id="v-pills-ventas-tab" data-toggle="pill" href="#v-pills-ventas" role="tab"
               aria-controls="v-pills-home" aria-selected="true">Ventas</a>
            <a class="nav-link active" id="v-pills-canciones-tab" data-toggle="pill" href="#v-pills-canciones" role="tab"
               aria-controls="v-pills-profile" aria-selected="false">Canciones</a>
            <a class="nav-link" id="v-pills-usuarios-tab" data-toggle="pill" href="#v-pills-usuarios" role="tab"
               aria-controls="v-pills-messages" aria-selected="false">Usuarios</a>
        </div>
    </div>
    <div class="col-10">
        <div class="tab-content" id="v-pills-tabContent">
            <div class="tab-pane fade show active" id="v-pills-canciones" role="tabpanel" aria-labelledby="v-pills-canciones-tab">
                <%@ include file="../components/cancionesComponent.jsp" %>
            </div>
        </div>
    </div>
</div>

<%@ include file="../components/footerComponent.jsp" %>

</body>


</html>
