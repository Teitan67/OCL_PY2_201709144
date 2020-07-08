const express=require('express');
const analizador=require('./js/Analizador');
const app=express();
const path=require('path');

//Configuracion de puerto
app.set('port',4000);
app.set('views',path.join(__dirname,'views'));
app.set('view engine','ejs');
//Static files
app.use(express.static('sources'));
//routes
app.use(require('./routes/index'));
//Escuchando el servidor
app.listen(app.get('port'),()=>{
    console.log('Server online on port ',app.get('port'));
});


console.log("Server online!!!");
 