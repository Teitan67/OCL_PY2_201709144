function analizar(texto){
    limpiar();
    Analizador.parse(texto);
    
}
function addVariable(nombre,tipo,linea){
    document.getElementById("tabTitle").insertAdjacentHTML("afterend", 
        "<tr><td>"+nombre+"</td><td>"+tipo+"</td><td>"+linea+"</td></tr>"); 
}
function limpiar(){
    setTraduccion("");
    var elementos = document.getElementById("tabTitle");
    while(elementos.nextElementSibling!=null){
        elementos.nextElementSibling.remove();
    }
    
}