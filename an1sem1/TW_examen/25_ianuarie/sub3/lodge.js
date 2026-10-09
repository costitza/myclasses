const canvas = document.getElementById("teren");
const ctx = canvas.getContext('2d');


document.addEventListener('DOMContentLoaded', () => {

    desenCiudat();
    kissTheRose();
    const divinfo = document.createElement('div');
    document.body.appendChild(divinfo);

    function kissTheRose(){
        const rose = document.createElement('img');
        rose.src = "rose.webp";
        rose.style.position = "absolute";
        rose.style.left = 170+"px";
        rose.style.top = 20+"px";
        rose.style.transform = "scale(0.5)";

        rose.addEventListener("click", () => {
            loadQuotes();
        }); 
    
        document.body.appendChild(rose);
    }


    function showQuote(quote){

        divinfo.innerHTML = `<b>${quote.character}:</b> ${quote.quote}
        <div id = "detali" style = "display: none">Season: ${quote.season}, episode ${quote.episode}</div>`;

        const divdet = document.getElementById('detali');
        divinfo.onmouseenter = () => {
            divdet.style.display = 'block';
        };
        
        divinfo.onmouseleave = () => {
            divdet.style.display = 'none';
        };
    }   


    async function loadQuotes(){
        await fetch('quotes.json')
            .then(response =>{
                if (!response.ok){
                    throw new Error("Nu am gasit fisierul")
                }
                return response.json();
            })
            .then(quotes => {

                const randomIndex = Math.floor(Math.random() * quotes.length);
                const quote = quotes[randomIndex];

                showQuote(quote);

            })
            .catch(error => {
                console.error("Eroare: ", error);
                info.innerHTML = "<h2>EROARE VERE</h2>"
            });
    }


    function desenCiudat(){

        ctx.beginPath();
        let difst = 40;
        ctx.fillStyle = "red";

        ctx.moveTo(1200, 30);
        ctx.lineTo(40, 30);
        ctx.lineTo(40, 300);
        for(let j = 0; j < 15;j ++){
            ctx.lineTo(40 + difst, 300 - 30);
            difst += 40;
            ctx.lineTo(40 + difst, 300);
            difst += 40;
        }
        ctx.fill();


        for(let i = 0; i < 5; i++){
            ctx.beginPath();
            let difst = 40;
            ctx.lineWidth = 15;

            ctx.strokeStyle = "black";
            ctx.moveTo(40, 300 + 40 * i);
            for(let j = 0; j < 15;j ++){
                ctx.lineTo(40 + difst, 300 + 40 * i - 30);
                difst += 40;
                ctx.lineTo(40 + difst, 300 + 40 * i);
                difst += 40;
            }
            ctx.stroke();
        }

        ctx.beginPath();
        ctx.lineWidth = 20;
        ctx.strokeStyle = "white";
        ctx.strokeRect(40, 40, 1000, 500);
        ctx.stroke();

    }

});
