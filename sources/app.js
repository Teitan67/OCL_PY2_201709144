const express=require('express');
const app=express();
//Configuracion de puerto
app.set('port',4000);
//Static files
app.get('/',(req,res)=>{
    res.send('Hola mundo ');
});
//Escuchando el servidor
app.listen(app.get('port'),()=>{
    console.log('Server online on port ',app.get('port'));
});