function variables(tab,id,valor){
    traducir( nTabs(tab)+"var "+id+" = "+valor+"\n");
}


function nTabs(numero){
    var tabulares ="";
    for(var i = 0;i<numero;i++){
        tabulares+="\t";
    }
    return tabulares
}