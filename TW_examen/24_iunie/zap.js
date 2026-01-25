

document.addEventListener("DOMContentLoaded", () => {
    const canvas = document.getElementById('teve');
    const ctx = canvas.getContext('2d');

    draw_teve();

    function drawLines(x, y, culoare){
        ctx.beginPath();
        ctx.fillStyle = culoare;

        ctx.fillRect(x, y, 57, 300);
        ctx.fill();
    }

    function draw_teve(){

        ctx.fillStyle = "#7b8ca8";

        ctx.fillRect(20, 20, 600, 400);
        ctx.fill();

        ctx.strokeStyle = "white";
        ctx.lineWidth = 10;

        ctx.strokeRect(60, 60, 400, 300);
        ctx.stroke();

        ctx.beginPath();
        ctx.fillStyle = "white";
        ctx.arc(540, 150, 20, 0, Math.PI * 2);
        ctx.fill();

        ctx.beginPath();
        ctx.fillStyle = "white";
        ctx.arc(540, 230, 17, 0, Math.PI * 2);
        ctx.fill();

        ctx.beginPath();
        ctx.fillStyle = "white";
        ctx.arc(540, 310, 15, 0, Math.PI * 2);
        ctx.fill();
        

        drawLines(60, 60, "white");
        drawLines(60 + 57, 60, "yellow");
        drawLines(60 + 57 * 2, 60, "green");
        drawLines(60 + 57 * 3, 60, "cyan");
        drawLines(60 + 57 * 4, 60, "purple");
        drawLines(60 + 57 * 5, 60, "red");
        drawLines(60 + 57 * 6, 60, "blue");
    }


    function showMovie(movie){
        const infoZone = document.getElementById('info');

        infoZone.innerHTML = `
        <h2>${movie.date}</h2>
        <p>${movie.time} - ${movie.title}</p>
        <img src="${movie.poster}">

        <div id = "detali" style = "display: none">Cu: ${movie.starring}. Rating: ${movie.rate}</div>
        `;

        const divdet = document.getElementById('detali');
        infoZone.onmouseenter = () => {
            divdet.style.display = 'block';
        };
        
        infoZone.onmouseleave = () => {
            divdet.style.display = 'none';
        };
    }


    function loadMovie(){
        fetch('zap.json')
            .then(response =>{
                if (!response.ok){
                    throw new Error("Nu am gasit fisierul")
                }
                return response.json();
            })
            .then(movies => {

                const randomIndex = Math.floor(Math.random() * movies.length);
                const movie = movies[randomIndex];

                showMovie(movie);

            })
            .catch(error => {
                console.error("Eroare: ", error);
                info.innerHTML = "<h2>EROARE VERE</h2>"
            });
    }


    canvas.addEventListener('click', (event) => {

        ctx.beginPath();
        ctx.rect(20, 20, 600, 400);

        const rect = canvas.getBoundingClientRect();
        const posx = event.clientX - rect.left;
        const posy = event.clientY - rect.top;

        if(ctx.isPointInPath(posx, posy)){
            loadMovie();
        }
    });

});