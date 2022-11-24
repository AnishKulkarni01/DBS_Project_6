const path=require('path')
const express = require('express');
const mysql =require('mysql');

const publicDirectoryPath=path.join(__dirname,'./public')



var app=express();
const bodyparser =require('body-parser');
app.use(bodyparser.json());
const cors = require('cors');
app.use(cors())

app.use(express.static(publicDirectoryPath))

var db=mysql.createConnection({
    host:'localhost',
    user: 'root',
    password :'1234',
    database:'project'

});
db.connect((err)=>{
if(!err)
console.log('DB connection succeeded');
else
console.log('DB connection failed \n Error : '+JSON.stringify(err,undefined,2));
});
app.listen(3000,()=>console.log('express server is running at port no 3000'));

app.get('', (req,res)=>{
    res.send('index.html')
})

app.get('/addUser', (req,res)=>{
    console.log(req.query)


    db.query('insert into login (idlogin,password) VALUES (?,?)',
    [req.query.id,req.query.password],(err,rows,fields)=>{
        if(!err)
        res.send(rows);
        else
        console.log(err);
    })
})

app.get('/checkPatient', (req,res)=>{
    console.log(req.query)


    db.query('select * from login where idlogin=? and password=?',
    [req.query.id,req.query.password],(err,rows,fields)=>{
        console.log(rows)

       
        if(!err)
        res.send(rows);
        else
        console.log(err);
    })
})

app.get('/route',(req,res)=>{
    db.query('select * from login',(err,rows,fields)=>{
        if(!err)
        res.send(rows);
        else
        console.log(err);
    })
})

app.get('/route/:id',(req,res)=>{
    db.query('select * from login WHERE idlogin= ?',[req.params.id],(err,rows,fields)=>{
        if(!err)
        res.send(rows);
        else
        console.log(err);
    })
})

app.get('/showPatients',(req,res)=>{
    db.query('select * from patient',(err,rows,fields)=>{
        if(!err)
        res.send(rows);
        else
        console.log(err);
    })
})

app.get('/showDoctors',(req,res)=>{
    db.query('select * from doctor',(err,rows,fields)=>{
        if(!err)
        res.send(rows);
        else
        console.log(err);
    })
})

app.get('/showAppointments',(req,res)=>{
    db.query('select * from appointment',(err,rows,fields)=>{
        if(!err)
        res.send(rows);
        else
        console.log(err);
    })
})


app.get('/patientID/:plmail',(req,res)=>{
    db.query('select p_id from patient WHERE p_mail= ?',[req.params.plmail],(err,rows,fields)=>{
        if(!err)
        res.send(rows);
        else
        console.log(err);
    })
})




app.get('/addPatient', (req,res)=>{
    console.log(req.query)


    db.query('insert into patient (p_name,p_gend,age,address,p_pwd,p_mail) VALUES (?,?,?,?,?,?)',
    [req.query.namep,req.query.genderp,req.query.agep,req.query.addressp,req.query.passp,req.query.mailp],(err,rows,fields)=>{
        if(!err)
        res.send(rows);
        else
        console.log(err);
    })
})




app.get('/showAvailableDoctors/:dt/:tm/:spec',(req,res)=>{
    db.query('SELECT distinct(d.d_id),d.d_name,d.spec FROM doctor d left join appointment a ON d.d_id=a.d_id WHERE d.d_id NOT IN( SELECT d_id FROM appointment WHERE a_dt=? AND a_tm=?) AND d.spec=?;' ,[req.params.dt,req.params.tm,req.params.spec],(err,rows,fields)=>{
        if(!err)
        res.send(rows);
        else
        console.log(err);
    })
})
app.get('/showAvailableRooms/:dt/:tm',(req,res)=>{
    db.query('SELECT distinct(room_no) FROM appointment WHERE room_no NOT IN( SELECT room_no FROM appointment WHERE a_dt=? AND a_tm=?);' ,[req.params.dt,req.params.tm],(err,rows,fields)=>{
        if(!err)
        res.send(rows);
        else
        console.log(err);
    })
})



app.get('/addAppointment', (req,res)=>{
    console.log(req.query)


    db.query('insert into appointment (a_dt,a_tm,p_id,d_id,room_no) VALUES (?,?,?,?,?)',
    [req.query.bdt,req.query.btm,req.query.bpid,req.query.bdid,req.query.brno],(err,rows,fields)=>{
        if(!err)
        res.send(rows);
        else
        res.send(err);
    })
})

// SELECT distinct(d.d_name), d.d_gend, d.spec, a.r_stat
// FROM doctor d join d_availability a
// ON d.d_id=a.d_id
// WHERE d.spec=spec
// AND a.r_stat='yes';