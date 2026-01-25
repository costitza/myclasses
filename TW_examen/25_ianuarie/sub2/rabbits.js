const body = document.querySelector('body');

document.addEventListener('DOMContentLoaded', () => {

    let nrIepuri = (localStorage.getItem('iepuri')) || 0;
    const info = document.getElementById('info');
    info.style.color = 'white';
    body.style.display = "flex";
    body.style.justifyContent = "end";
    updateStorage();

    function updateStorage(){
        localStorage.setItem('iepuri', nrIepuri);
        info.innerHTML = `aici exista ${localStorage.getItem('iepuri')} iepuri`;

    }

    function miscaIepurila(){

        const iepuri = document.querySelectorAll('.iepure');
        console.log(iepuri)

        iepuri.forEach(element => {
            if (element.moving == undefined){
                element.moving = setInterval(() => {

                    let st = Math.floor(Math.random() * 21) - 10;
                    let sus = Math.floor(Math.random() * 21) - 10;
                    element.style.left = (st + element.offsetLeft) + "px";
                    element.style.top = (sus + element.offsetTop) + "px";
                    

                }, 100)
            }
        });
    }


    function opresteIepurila(){
        
        const iepuri = document.querySelectorAll('.iepure');

        iepuri.forEach(element => {
            if (element.moving != undefined){
                clearInterval(element.moving);
                element.moving = undefined;
            }
        })
    }


    function cantaIepurila(){
        const sunet = new Audio("rabbits-ambience.mp3");

        sunet.play();
    }


    function apareIepurila(){
        const iepure = document.createElement('img');
        nrIepuri ++;
        updateStorage();
        
        iepure.classList.add('iepure');
        iepure.src = 'rabbit-01.png';
        iepure.style.position = "absolute";
        iepure.style.left = Math.random() * (innerWidth - 50) + "px";
        iepure.style.top = Math.random() * (innerHeight - 400) + "px";
        let index = 1;


        iepure.addEventListener('click', () =>{
            
            if (index == 3){
                body.removeChild(iepure);
            }
            else{
                index ++;
                iepure.src = `rabbit-0${index}.png`;
            }

        });


        body.appendChild(iepure);
    }


    document.addEventListener('keydown', (event) => {
        if (event.key === "r"){
            apareIepurila();
        }
        else if (event.key === "p"){
            miscaIepurila();
        }
        else if (event.key === "s"){
            opresteIepurila();
        }
        else if (event.key === "a"){
            cantaIepurila();
        }
    });




});