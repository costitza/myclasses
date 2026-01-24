
const canvas = document.getElementById('teren');
const ctx = canvas.getContext('2d');

document.addEventListener('DOMContentLoaded', () => {

    const info = document.getElementById('info');

    drawTeren();

    document.addEventListener("click", (event) => {
        ctx.beginPath();

        ctx.rect(30, 30, 600, 400);

        const rect = canvas.getBoundingClientRect();
        const posx = event.clientX - rect.left;
        const posy = event.clientY - rect.top;

        if (ctx.isPointInPath(posx, posy)){

            afiseazaEchipe();
        }

    });


    function afiseazaEchipe(){

        fetch('champ.json')
            .then(response =>{
                if (!response.ok){
                    throw new Error("Nu am gasit fisierul")
                }
                return response.json();
            })
            .then(matches => {

                const randomIndex = Math.floor(Math.random() * matches.length);
                const match = matches[randomIndex];

                showMatch(match);

            })
            .catch(error => {
                console.error("Eroare: ", error);
                info.innerHTML = "<h2>EROARE VERE</h2>"
            });
    }


    function showMatch(match){
        info.innerHTML = '';

        const htmlContent = `
        <div class = "flags-container">
            <img src="${match.homeflag}">
            <img src="${match.guestflag}">
        </div>
        <h2>${match.date} at ${match.time}</h2>
        `

        info.innerHTML = htmlContent;
    }
    

    function drawTeren(){

        ctx.fillStyle = "green";

        ctx.fillRect(30, 30, 600, 400);
        ctx.fill();

        ctx.strokeStyle = "white";
        ctx.lineWidth = 5;

        ctx.strokeRect(50, 50, 560, 360); // rect mare
        ctx.stroke();

        ctx.strokeRect(50, 170, 40, 120);
        ctx.stroke();

        ctx.strokeRect(570, 170, 40, 120);
        ctx.stroke();

        ctx.beginPath();
        ctx.moveTo(50 + 280, 50);
        ctx.lineTo(50 + 280, 50 + 360);
        ctx.closePath();
        ctx.stroke();

        ctx.beginPath();
        ctx.arc(50 + 280, 50 + 180, 30, 0, 2 * Math.PI);
        ctx.stroke();
    }

});