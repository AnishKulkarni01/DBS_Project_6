//const { response } = require("express")

// const { response } = require("express")

console.log("working")
const myform=document.getElementById('login_form')
const id=document.getElementById('id')
const password=document.getElementById('password')

const plform=document.getElementById('plogin_form')
const pmail=document.getElementById('lmail')
const ppass=document.getElementById('lpass')
const b2=document.getElementById('testbtn')

b2.addEventListener("click",(e)=> {
    e.preventDefault()
    console.log(id.value)
    console.log(password.value)
    fetchURL='/addUser?id='+id.value+'&password='+password.value
    fetch(fetchURL).then((response)=>{
        console.log(response);
       
    })
})

function submitlogin(){
  window.open('index2.html')
    const pmail=document.getElementById('lmail')
    const ppass=document.getElementById('lpass')
    console.log(pmail.value)
    console.log(ppass.value)
    fetchURL='/checkPatient?id='+pmail.value+'&password='+ppass.value
    fetch(fetchURL).then((response)=>{
        console.log(response);
       
       
    })

}

const button=document.getElementById('b1')


button.addEventListener('click',(e)=>{
    e.preventDefault()
    button.disabled=true;
    axios.get("http://localhost:3000/route", {
        headers: {
            'Access-Control-Allow-Origin': '*',
        }
    }).then( res => {
        console.log(res.data)
        let list = document.createElement('ul');
        
        res.data.forEach(function (row) {
            var li = document.createElement('li');
            li.textContent = row.idlogin+ "," + row.password;
            list.appendChild(li);
        });
        document.getElementById('#t1').appendChild(list);
    }).catch(err => console.log(err));
})

const regpatient=document.getElementById('regp')
const b11=document.getElementById('b11')
const passp=document.getElementById('passp')
const namep=document.getElementById('namep')
const genderp=document.getElementById('genderp')
const agep=document.getElementById('agep')
const addressp=document.getElementById('addressp')
const mailp=document.getElementById('mailp')
b11.addEventListener("click",(e)=> {
    e.preventDefault()
    console.log("ok")
   
    fetchURL='/addPatient?namep='+namep.value+'&genderp='+genderp.value+'&agep='+agep.value+'&addressp='+addressp.value+'&passp='+passp.value+'&mailp='+mailp.value
    
    fetch(fetchURL).then((response)=>{
        console.log(response);
       
    })
    window.location='index2.html'
})








var attempt = 3; // Variable to count number of attempts.
// Below function Executes on click of login button.
function validate(){
var username = document.getElementById("aduser").value;
var password = document.getElementById("adpass").value;
if ( username == "admin" && password == "123"){
alert ("Login successfully");
window.location = "index3.html"; // Redirecting to other page.
return false;
}
else if(attempt>0){
attempt --;// Decrementing by one.
alert("You have left "+attempt+" attempt;");
// Disabling fields after 3 attempts.
if( attempt == 0){
document.getElementById("aduser").disabled = true;
document.getElementById("adpass").disabled = true;
alert("Try again later");
document.getElementById("adbtn").disabled = true;
return false;
}
}
}















// Script Goes Here...
const leftSlide = document.querySelector(".left-slides");
const rightSlide = document.querySelector(".right-slides");
const leftBtn = document.querySelector(".left-btn");
const rightBtn = document.querySelector(".right-btn");
const slidesLength = leftSlide.querySelectorAll("div").length;

let currentSlide = 0;

rightSlide.style.transform = `translateY(-${(slidesLength - 1) * 100}%)`;

leftBtn.addEventListener("click", () => changeSlide("left"));
rightBtn.addEventListener("click", () => changeSlide("right"));

function changeSlide(btn) {
  if (btn == "right") {
    currentSlide++;

    if (currentSlide > slidesLength - 1) {
      currentSlide = 0;
    }
  } else if (btn == "left") {
    currentSlide--;

    if (currentSlide < 0) {
      currentSlide = slidesLength - 1;
    }
  }

  rightSlide.style.transform = `translateY(-${
    (slidesLength - 1 - currentSlide) * 100
  }%)`;
  leftSlide.style.transform = `translateY(-${currentSlide * 100}%)`;
}

setInterval(autoChangeSlide, 3000);

function autoChangeSlide() {

  currentSlide++;

  if (currentSlide > slidesLength - 1) {
    currentSlide = 0;
  }

  rightSlide.style.transform = `translateY(-${
    (slidesLength - 1 - currentSlide) * 100
  }%)`;
  leftSlide.style.transform = `translateY(-${currentSlide * 100}%)`;
}


