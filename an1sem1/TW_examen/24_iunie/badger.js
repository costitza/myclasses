
const body = document.querySelector('body');


function playSound(){

    const sunet = new Audio("badger.mp3");

    sunet.play();
}


document.addEventListener('DOMContentLoaded', () => {

    let genuflexiuni = parseInt(localStorage.getItem('genu')) || 0;
    const infoPoint = document.getElementById('info');

    function updateGenu(){
        localStorage.setItem('genu', genuflexiuni);
        infoPoint.textContent = `Genuflexiuni facute: ${genuflexiuni}`;

    }
    updateGenu();

    function ciupearca(){
        const mush = document.createElement('img');
        mush.src = "mush.png";

        mush.style.position = "absolute";
        mush.style.left = Math.random() * innerWidth + "px";
        mush.style.top = Math.random() * innerHeight + "px";

        body.appendChild(mush);
    }

    function bursuc(){
        const bursuc = document.createElement('div');
        bursuc.innerHTML = '<img src = "bursuc1.png">';

        bursuc.style.position = "absolute";
        bursuc.style.top = Math.random() * innerHeight + "px";
        bursuc.style.left = Math.random() * innerWidth + "px";


        bursuc.addEventListener('click', (event) => {
            event.stopPropagation();
            if (bursuc.dataset.running === "true"){
                clearInterval(bursuc.intervalRef);
                clearTimeout(bursuc.timeoutRef);
                body.removeChild(bursuc);
            }
            else{

                bursuc.dataset.running = "true";
                let contor_poza = 1;
                let isWaiting = false;


                bursuc.intervalRef = setInterval(() => {
                    if (isWaiting) return;

                    if (contor_poza == 4){
                        genuflexiuni++;
                        
                        if(genuflexiuni % 5 == 0){
                            ciupearca();
                        }

                        updateGenu();

                        isWaiting = true; // pauza
                        bursuc.timeoutRef = setTimeout(() => {
                            console.log("s a facut timeout");
                            contor_poza = 1;
                            isWaiting = false; // sa inceapa din nou
                            bursuc.innerHTML = `<img src = "bursuc${contor_poza}.png">`
                        }, 1000);

                    }
                    else{
                        contor_poza ++;
                        bursuc.innerHTML = `<img src = "bursuc${contor_poza}.png">`
                    }
                }, 200);
            }

        });

        body.appendChild(bursuc);
    }

    document.addEventListener('keydown', (event) =>{
        if(event.key === "b"){
            bursuc();
        }
        else if (event.key === "p"){
            playSound();
        }
    });
});