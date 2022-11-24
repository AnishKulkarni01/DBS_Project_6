const button31=document.getElementById('b31')
console.log("ok")

button31.addEventListener('click',(e)=>{
    e.preventDefault()
    console.log("chalra hai")
    button31.disabled=true;
    axios.get("http://localhost:3000/showPatients", {
        headers: {
            'Access-Control-Allow-Origin': '*',
        }
    }).then( res => {
        console.log(res.data)
        let list = document.createElement('ul');
        var l1 = document.createElement('li');
            l1.textContent ="(NAME , GENDER , AGE , ID , PASSWORD )";
            list.appendChild(l1);
        res.data.forEach(function (row) {
            var li = document.createElement('li');
            li.textContent = " ( "+row.p_name + " , " + row.p_gend+ " , " + row.age+ " , " + row.p_id+ " , " + row.p_pwd+ " , "+" ) ";
            list.appendChild(li);
        });
        document.getElementById('#t31').appendChild(list);
    }).catch(err => console.log(err));
})

const button32=document.getElementById('b32')
console.log("ok")

button32.addEventListener('click',(e)=>{
    e.preventDefault()
    console.log("chalra hai")
    button32.disabled=true;
    
    axios.get("http://localhost:3000/showDoctors", {
        headers: {
            'Access-Control-Allow-Origin': '*',
        }
    }).then( res => {
        console.log(res.data)
        let list = document.createElement('ul');
        var l1 = document.createElement('li');
            l1.textContent ="(NAME , GENDER , SPECIALIZATION , ID , PASSWORD )";
            list.appendChild(l1);
        res.data.forEach(function (row) {
            var li = document.createElement('li');
            li.textContent = " ( "+row.d_name + " , " + row.d_gend+ " , " + row.spec+ " , " + row.d_id+ " , " + row.d_pwd+ " , "+" ) ";
            list.appendChild(li);
        });
        document.getElementById('#t32').appendChild(list);
    }).catch(err => console.log(err));
})

const button33=document.getElementById('b33')
console.log("ok")

button33.addEventListener('click',(e)=>{
    e.preventDefault()
    console.log("chalra hai")
    button33.disabled=true;
   
    axios.get("http://localhost:3000/showAppointments", {
        headers: {
            'Access-Control-Allow-Origin': '*',
        }
    }).then( res => {
        console.log(res.data)
        let list = document.createElement('ul');
        var l1 = document.createElement('li');
            l1.textContent ="(AppointmentID , Date , Time , PatientID , DoctorID , RoomNo)";
            list.appendChild(l1);
        res.data.forEach(function (row) {
            var li = document.createElement('li');
            var date=String(row.a_dt);
            
            
            li.textContent = " ( "+row.a_id + " , " + date.substring(0,10) + " , " + row.a_tm+ " , " + row.p_id+ " , " + row.d_id+ " , "+ row.room_no+" ) ";
            list.appendChild(li);
        });
        document.getElementById('#t33').appendChild(list);
    }).catch(err => console.log(err));
})