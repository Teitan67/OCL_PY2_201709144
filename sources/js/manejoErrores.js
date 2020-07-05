 var errores = 0 ;
 var contenido="<!DOCTYPE html><html><head><title>Reporte de Tokens</title></head><body><style type='text/css'>body{background-color: rgba(250,250,250,1);}tr{background: #fff;text-align: center;transition: 0.1s;}tr,td{border:1px black solid;padding: 15px;margin: 0px;}tr:hover{transition: 0.1s;padding: 20px;background: yellow;}tr#Cabeza{color: #fff;background: #000;}h2#Titulo{color: #494949;font-size: 40px;position: relative;}</style><center><h1>Universidad San Carlos de Guatemala</h1><h3>Facultad de ingenieria</h3><h3>Organizacion de lenguajes y compiladores 1</h3></center><div><center><h2 id='Titulo'>Tabla de tokens</h2><table><tr id ='Cabeza'><td> No.</td><td> Tipo error </td><td> Descripcion</td><td> Columna</td><td> Fila </td></tr>";
function agregarError(tipo,descripcion,columna,fila){
    errores++;
    contenido+="<tr><td>"+errores+"</td><td>"+tipo+"</td><td>"+descripcion+"</td><td>"+columna+"</td><td>"+fila+"</td></tr>\n"; 
} 
function mostrarError(){
    contenido+="</table></center></div></body></html>";
    guardarErrores(contenido);
   }
function guardarErrores(txt){
    var nombre="reportErrores.html";
    var texto=txt;
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
