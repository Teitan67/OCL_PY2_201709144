function analizar(texto){
    
    limpiar();
    Analizador.parse(texto);
    py();
    if(errores>0){
        alert("Se detectaron "+errores+" errores");
    }

}
function addVariable(nombre,tipo,linea){
    var tabla=document.getElementById("tabTitle");
    for(var i=0;i<nombre.length ;i++){
        tabla.insertAdjacentHTML("afterend", "<tr><td id='nombre[i]'>"+nombre[i]+"</td><td>"+tipo+"</td><td>"+linea+"</td></tr>"); 
    }
}
function addVariable(nombre,tipo,linea){
    var tabla=document.getElementById("tabTitle");
    for(var i=0;i<nombre.length ;i++){
        tabla.insertAdjacentHTML("afterend", "<tr><td>"+nombre[i]+"</td><td>"+tipo+"</td><td>"+linea+"</td></tr>"); 
    }
}
function limpiar(){
    setTraduccion("");
    var elementos = document.getElementById("tabTitle");
    
    var txtTraducion=document.getElementById("txtHtml");
    txtTraducion.value="";
    setJSON("");
    while(elementos.nextElementSibling!=null){
        elementos.nextElementSibling.remove();
    }
    errores = 0 ;
    contenido="<!DOCTYPE html><html><head><title>Reporte de Tokens</title></head><body><style type='text/css'>body{background-color: rgba(250,250,250,1);}tr{background: #fff;text-align: center;transition: 0.1s;}tr,td{border:1px black solid;padding: 15px;margin: 0px;}tr:hover{transition: 0.1s;padding: 20px;background: yellow;}tr#Cabeza{color: #fff;background: #000;}h2#Titulo{color: #494949;font-size: 40px;position: relative;}</style><center><h1>Universidad San Carlos de Guatemala</h1><h3>Facultad de ingenieria</h3><h3>Organizacion de lenguajes y compiladores 1</h3></center><div><center><h2 id='Titulo'>Tabla de tokens</h2><table><tr id ='Cabeza'><td> No.</td><td> Tipo error </td><td> Descripcion</td><td> Columna</td><td> Fila </td></tr>"; 
}