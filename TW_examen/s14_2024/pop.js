const body = document.body;

function getRandom(minim, maxim){
    return Math.random() * (maxim - minim) + minim;
}


function poc(x, y){
    const poc = document.createElement('div');

    poc.innerHTML = '<img src="pow.png">';
    poc.style.position = "absolute";

    poc.style.top = y + "px";
    poc.style.left = x + "px";

    body.appendChild(poc);

    setTimeout(() => {
        poc.remove();
    }, 300);
}


document.addEventListener('DOMContentLoaded', () => {

    const displayscore = document.getElementById('score');
    let score = parseInt(localStorage.getItem('score')) || 0;

    const updatescore = () => {
        displayscore.textContent = `Baloane sparte: ${score}`;

    }

    updatescore();

    const playsound = () => {
        const sunete = [
            'pop-1.mp3',
            'pop-2.mp3',
            'pop-3.mp3'
        ];

        const audio = new Audio(sunete[Math.floor(Math.random() * 3)]);

        audio.play();
    }

    function createBalloon(){


        const balloon = document.createElement('div');
        balloon.innerHTML = '<img src="balloon.png">';

        balloon.classList.add("balloon");
        balloon.style.position = "absolute";
        balloon.style.top = getRandom(0, innerHeight) + "px";
        balloon.style.left = getRandom(0, innerWidth) + "px";

        // pentru spart

        balloon.addEventListener("click", (event) => {
            
            balloon.remove();

            poc(event.clientX, event.clientY);
            playsound()

            score ++;
            updatescore()
            localStorage.setItem('score', score);

        });

        body.appendChild(balloon);
    };


    function fly(){

    }


    document.addEventListener('keydown', (event) => {
        if (event.key === 'b'){
            console.log("s-a apasat");
            createBalloon();
        }
    });
});