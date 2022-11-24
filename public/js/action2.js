


const b21=document.getElementById('b21')
const f21=document.getElementById('pid_form')
var patientmail=document.getElementById('plmail').value


b21.addEventListener('click',(e)=>{
    e.preventDefault()
    var patientmail=document.getElementById('plmail').value
    console.log("hello")
    b21.disabled=false;
    console.log(patientmail)
    axios.get("http://localhost:3000/patientID/"+patientmail, {
        headers: {
            'Access-Control-Allow-Origin': '*',
        }
    }).then( res => {
        console.log(res.data)
        let list = document.createElement('ul');
        
        res.data.forEach(function (row) {
            var li = document.createElement('li');
            li.textContent = row.p_id;
            list.appendChild(li);
        });
        document.getElementById('#t21').appendChild(list);
    }).catch(err => console.log(err));
})



const button22=document.getElementById('b22')
console.log("ok")

button22.addEventListener('click',(e)=>{
    e.preventDefault()
    var doctorspec=document.getElementById('dspec').value
    var bookdt=document.getElementById('bdt').value
    var booktm=document.getElementById('btm').value
    console.log("chalra hai")
    button22.disabled=true;
    axios.get("http://localhost:3000/showAvailableDoctors/"+bookdt+"/"+booktm+"/"+doctorspec, {
        headers: {
            'Access-Control-Allow-Origin': '*',
        }
    }).then( res => {
        console.log(res.data)
        let list = document.createElement('ul');
        var l1 = document.createElement('li');
            l1.textContent ="( ID , NAME , SPECIALIZATION  )";
            list.appendChild(l1);
        res.data.forEach(function (row) {
            var li = document.createElement('li');
            li.textContent = " ( "+ row.d_id + " , "+row.d_name + " , "  + row.spec +" ) ";
            list.appendChild(li);
        });
        document.getElementById('#t22').appendChild(list);
    }).catch(err => console.log(err));
})


const button23=document.getElementById('b23')
console.log("ok")

button23.addEventListener('click',(e)=>{
    e.preventDefault()
    var doctorspec=document.getElementById('dspec').value
    var bookdt=document.getElementById('bdt').value
    var booktm=document.getElementById('btm').value
    console.log("chalra hai")
    button22.disabled=true;
    axios.get("http://localhost:3000/showAvailableRooms/"+bookdt+"/"+booktm, {
        headers: {
            'Access-Control-Allow-Origin': '*',
        }
    }).then( res => {
        console.log(res.data)
        let list = document.createElement('ul');
        var l1 = document.createElement('li');
            l1.textContent ="( Room No.  )";
            list.appendChild(l1);
        res.data.forEach(function (row) {
            var li = document.createElement('li');
            li.textContent = " ( "+ row.room_no +" ) ";
            list.appendChild(li);
        });
        document.getElementById('#t23').appendChild(list);
    }).catch(err => console.log(err));
})



const b24=document.getElementById('b24')
const bdt=document.getElementById('bdt')
const btm=document.getElementById('btm')
const bpid=document.getElementById('bpid')
const bdid=document.getElementById('bdid')
const brno=document.getElementById('brno')

b24.addEventListener("click",(e)=> {
    e.preventDefault()
    console.log("ok")
   
    fetchURL='/addAppointment?bdt='+bdt.value+'&btm='+btm.value+'&bpid='+bpid.value+'&bdid='+bdid.value+'&brno='+brno.value
    
    fetch(fetchURL).then((response)=>{
        console.log(response);
       
    })
    console.log("ye bhi chalra hai")
    
    alert("Appointment booked")
    window.open('index.html')
    
})