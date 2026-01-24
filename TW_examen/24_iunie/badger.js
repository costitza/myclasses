
const body = document.querySelector('body');

document.addEventListener('DOMContentLoaded', () => {

    let misca = false;
    let genuflexiuni = parseInt(localStorage.getItem('genu')) || 0;
    const infoPoint = document.getElementById('info');

    function updateGenu(){
        localStorage.setItem('genu', genuflexiuni);
        infoPoint.textContent = `Genuflexiuni facute: ${genuflexiuni}`;
    }
    updateGenu();

    function bursuc(){
        const bursuc = document.createElement('div');
        bursuc.innerHTML = '<img src = "bursuc1.png">';

        bursuc.style.position = "absolute";
        bursuc.style.top = Math.random() * innerHeight + "px";
        bursuc.style.left = Math.random() * innerWidth + "px";


        bursuc.addEventListener('click', (event) => {
            event.stopPropagation();
            if (event.target.animation == undefined){
                let contor_poza = 1;
                event.target.animation = setInterval(() => {
                    if (contor_poza == 4){
                        contor_poza = 1;
                        genuflexiuni++;
                        console.log(genuflexiuni);

                        updateGenu();

                        setTimeout(() => {
                            console.log("s a facut timeout");
                        }, 1000);

                    }
                    else{
                        contor_poza ++;
                    }
                    bursuc.innerHTML = `<img src = "bursuc${contor_poza}.png">`
                }, 200);
            }
            else{
                clearInterval(event.target);
            }

        });

        body.appendChild(bursuc);
    }

    document.addEventListener('keydown', (event) =>{
        if(event.key === "b"){
            bursuc();
        }
    });
});