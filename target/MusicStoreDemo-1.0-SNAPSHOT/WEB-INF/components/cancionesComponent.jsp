<script type="text/javascript" src="${pageContext.request.contextPath}/scripts/cancionesScripts.js"></script>
<link href="${pageContext.request.contextPath}/styles/canciones.css" rel="stylesheet" type="text/css"/>

<script>
    var result = '<s:property value="result"/>';
    if(result === 'SUCCESS'){
        $("#success-alert").show();
    }else if(result === 'DUPLICATE_TITLE'){
        $("#duplicate-alert").show();
    }else if(result === 'ERROR'){
        $("#error-alert").show();
    }
</script>



<div class="container">


    <div class="accordion" id="accordionExample">
        <div class="card">
            <div class="card-header" id="headingOne">
                <h2 class="mb-0">
                    <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#collapseOne"
                            aria-expanded="true" aria-controls="collapseOne">
                        Agregar Cancion
                    </button>
                </h2>
            </div>
            <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
                <div class="card-body">
                    <div id="alert-div" class="alert alert-warning" role="alert"
                         style="background-color: red !important;">
                        <span id="alert-message"></span>
                    </div>

                    <div class="alert alert-danger" role="alert" style="display:none" id="error-alert">
                        Ocurrio un error al guardar la canción
                    </div>

                    <div class="alert alert-warning" role="alert" style="display:none" id="duplicate-alert">
                        Canción duplicada.
                    </div>

                    <div class="alert alert-success" role="alert" style="display:none" id="success-alert">
                        Canción agregada correctamente.
                    </div>

                    <div class="card-text">
                        <form id="song-form" action="saveSong" method="post">
                            <div class="form-row">
                                <div class="col">
                                    <input type="text" class="form-control" placeholder="Titulo" name="song.title">
                                </div>
                                <div class="col">
                                    <input type="text" class="form-control" placeholder="Artista" name="song.artist">
                                </div>
                            </div>
                            <div class="form-row" style="padding-top:1rem">
                                <div class="col">
                                    <input type="text" class="form-control" placeholder="Album" name="song.album">
                                </div>
                                <div class="col">
                                    <input type="text" class="form-control" placeholder="Genero" name="song.genre">
                                </div>
                            </div>
                            <div class="form-row" style="padding-top:1rem">
                                <div class="col">
                                    <input type="text" class="form-control" placeholder="Precio" name="song.price">
                                </div>
                                <div class="col">
                                    <input type="text" class="form-control" placeholder="Cantidad"
                                           name="song.availableQuantity">
                                </div>
                            </div>
                            <div class="form-row" style="padding-top:1rem">
                                <div class="col">
                                    <button type="submit" class="btn btn-primary">Agregar</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="card">
            <div class="card-header" id="headingThree">
                <h2 class="mb-0">
                    <button class="btn btn-link collapsed" type="button" data-toggle="collapse"
                            data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                        Eliminar Cancion
                    </button>
                </h2>
            </div>
            <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordionExample">
                <div class="card-body">
                    <div class="card-text">
                        <form id="song-delete-form" action="deleteSong" method="post">
                            <div class="form-row">
                                <div class="col">
                                    <input type="number" class="form-control" placeholder="ID - Cancion" name="id">
                                </div>
                                <div class="col">
                                    <button type="submit" class="btn btn-danger">Eliminar</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="card">
            <div class="card-header" id="headingTwo">
                <h2 class="mb-0">
                    <button class="btn btn-link collapsed" type="button" data-toggle="collapse"
                            data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                        Listado de canciones
                    </button>
                </h2>
            </div>
            <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionExample">
                <div class="card-body">
                    <s:url var="songs_data_provider_url" action="songs-data-provider" namespace="/data"/>
                    <sjg:grid
                            id="songsGrid"
                            autowidth="true"
                            caption="Canciones"
                            dataType="json"
                            href="%{songs_data_provider_url}"
                            pager="true"
                            gridModel="gridModel"
                            rowList="10,15,20"
                            rowNum="15"
                            rownumbers="true">
                        <sjg:gridColumn name="id" index="id" title="ID" width="30" formatter="integer"
                                        sortable="false"/>
                        <sjg:gridColumn name="title" index="title" title="Titulo" width="250" sortable="false"/>
                        <sjg:gridColumn name="artist" index="artist" title="Artista" width="250" sortable="false"/>
                        <sjg:gridColumn name="album" index="album" title="Album" width="250" sortable="false"/>
                        <sjg:gridColumn name="genre" index="genre" title="Genero" width="250" sortable="false"/>
                        <sjg:gridColumn name="price" index="price" title="Precio" align="right" formatter="currency"
                                        sortable="false"/>
                        <sjg:gridColumn name="availableQuantity" index="availableQuantity" title="Cantidad"
                                        sortable="false"/>

                    </sjg:grid>
                </div>
            </div>
        </div>
    </div>
</div>