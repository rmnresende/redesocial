var cabecalho = document.getElementById("cabecalho");

if (cabecalho.attachEvent) {
  cabecalho.attachEvent("onclick", function (event) {
    alert("Voc� clicou no cabe�alho, usu�rio do IE!");
  });
} else if (cabecalho.addEventListener) {
  cabecalho.addEventListener("click", function (event) {
    alert("Voc� clicou no cabe�alho!")
  }, false);
}