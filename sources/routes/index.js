const express=require('express');
const router = express.Router();

router.get('/',(req,res)=>{
    res.render('index');

});
router.get('/reporte',(req,res)=>{
    res.render('reporteError');
    
});

module.exports=router;