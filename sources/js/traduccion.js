function variables(tabs,contenido){
    traducir( nTabs(tabs)+"var "+contenido+"\n");
}
function asignacion(tab,contenido){
    traducir( nTabs(tab)+contenido+"\n");
}
function nTabs(numero){
    var tabulares ="";
    for(var i = 0;i<numero;i++){
        tabulares+="\t";
    }
    return tabulares
}