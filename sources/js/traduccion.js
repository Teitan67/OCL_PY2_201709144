function variables(tabs,contenido){
    traducir( nTabs(tabs)+"var "+contenido+"\n");
}
function asignacion(tab,contenido){
    traducir( nTabs(tab)+contenido+"\n");
}
function print_if(tabs,contenido){
    traducir( nTabs(tabs)+contenido+"\n");
    tabs++;
}
function tablear(input ){
    const var1 = /\n/gi;
    const var2 = /\t/gi;

    input=input.replace(var2, '\t');
    input=input.replace(var1, '\n\t');

    return input; 
}
function py(){

    var txtTraducion=document.getElementById("txtHtml");
    var contenido=txtTraducion.value;
    traductorHTML.parse(contenido);
}