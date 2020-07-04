

function showTab(evt, cityName) {
    var i, tabcontent, tablinks;
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
      tabcontent[i].style.display = "none";
      tabcontent[i].className="tabcontent";
    }
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
      tablinks[i].className = tablinks[i].className.replace(" active", "");
    }
    document.getElementById(cityName).style.display = "block";
    document.getElementById(cityName).className+=" ACTIVO"
    evt.currentTarget.className += " active";
  }
  
function addTab(name,contendido) { 
    var childs=document.getElementById("MenuTabs").children.length;
    childs++;
    if (name==''){
        name='newFile'+childs+".cs";
    }
    document.getElementById("MenuTabs").insertAdjacentHTML("beforeend", 
        "<button class=\"tablinks\" onclick=\"showTab(event, '"+name+"')\" value =\""+name+"\">"+name+"</button>"); 
    document.getElementById("MenuTabs").insertAdjacentHTML("afterend", 
        "<div id=\""+name+"\" class=\"tabcontent\">\n\t<textarea class=\"txtArea\" id=\"txtEditor\" rows=\"15\" cols=\"80\">"+contendido+"</textarea><span onclick=\"this.parentElement.style.display='none'\" class=\"topright\">&times</span>\n</div>");
        
}
function obtenerTexto(){
    var txt=obtenerTxtSelect().value;
     return txt;
} 
function obtenerTxtSelect(){
  var texto =document.getElementsByClassName("ACTIVO");
  if(texto.length>0){
    return texto[0].childNodes[1];
  }else{
    alert("No hay texto seleccionado");
    return 'nulo';
  }
}
$('#button').on('click', function() {
  $('#file-input').trigger('click');
});
const input=document.querySelector('input[type="file"]')
input.addEventListener('change',function(e){
    console.log(input.files);
    const lector = new FileReader()
    lector.onload = function(e) {
      var contenido = e.target.result;
      //console.log(contenido);
    };
    lector.readAsText(input.files[0])
    
    
},false)

function leerArchivo(e) {
  var archivo = e.target.files[0];
  if (!archivo) {
    return;
  }
  var lector = new FileReader();
  lector.onload = function(e) {
    var contenido = e.target.result;
     
      var filePath=$('#file-input').val().split('\\').pop(); 
      addTab(filePath,contenido)
  };
  lector.readAsText(archivo);
}

document.getElementById('file-input')
  .addEventListener('change', leerArchivo, false);

  function guardar(tipo){
    var nombre=obtenerNombre();
    
    if(tipo==1){
      nombre="Nuevo archivo.cs";
      
    }
    var texto=obtenerTexto();
    var bom = document.createElement('a');
    bom.setAttribute('href','data:text/plain;charset=utf-8,'+encodeURIComponent(texto));
    bom.setAttribute('download',nombre);
    if(document.createEvent){
        var event = document.createEvent('MouseEvents');
        event.initEvent('click',true,true);
        bom.dispatchEvent(event);
    }else{
      bom.click();
    }
  }
  function obtenerNombre(){
    var tab=document.getElementsByClassName('active');
    return tab[0].value;
  }

function setTraduccion(texto){
  var txtTraducion=document.getElementById("txtPy");
  txtTraducion.value=texto;
}
function traducir(sentencia){
  var txtTraducion=document.getElementById("txtPy");
  var contenido=txtTraducion.value;
  contenido+=sentencia;
  txtTraducion.value=contenido;
}


