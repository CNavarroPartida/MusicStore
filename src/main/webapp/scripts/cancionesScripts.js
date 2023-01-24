$(document).ready(function () {

    $('input[name="song.price"]').keyup(function () {
        this.value = this.value.replace(/[^0-9\.]/g, '');
    });

    $('input[name="song.availableQuantity"]').keyup(function () {
        this.value = this.value.replace(/[^0-9]/g, '');
    });

    $('input[name="id"]').keyup(function () {
        this.value = this.value.replace(/[^0-9]/g, '');
    });

    $('#alert-div').hide();

    $('#song-form').submit(function (event) {
        let isValid = true;
        let inputs = $('input[name^="song."]');
        let message = '';

        inputs.each(function () {
            let input = $(this);
            // let inputName = input.attr("name").split(".")[1];
            let inputName = input.attr("placeholder");
            let inputValue = input.val();
            if (inputValue.trim() === "") {
                message = "!Upps - El campo " + inputName + " es obligatorio"
                isValid = false;
                return false
            }
            if (inputName === "price" || inputName === "availableQuantity") {
                if (isNaN(inputValue)) {
                    message = "!Upps - El campo " + inputName + " debe ser un numero"
                    isValid = false;
                    return false
                }
            }
        });

        if (!isValid) {
            $('#alert-div').show();
            $('#alert-message').text(message);
            event.preventDefault();
        }
    });

    $("#song-delete-form").submit(function(event){
        let id = $("input[name='id']").val();
        if(id.trim() === "" || isNaN(id)){
            alert("Por favor ingrese un número válido en el campo ID");
            event.preventDefault();
        }
    });
});

