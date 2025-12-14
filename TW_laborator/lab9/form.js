window.onload = function() {
    // 1. DEFINIM VARIABILELE PRINCIPALE (Aici era greșeala, lipseau aceste linii)
    const form = document.querySelector('form');
    const container = document.getElementById('container');
    const colorPicker = document.getElementById('culoare');

    // 2. LOGICA PENTRU CULOARE
    function applyColor(color) {
        document.body.style.backgroundColor = color;
        colorPicker.value = color; 
    }

    // Verificăm LocalStorage la încărcare
    const savedColor = localStorage.getItem('alien_skin_color');
    if (savedColor) {
        applyColor(savedColor);
    }

    // Ascultăm schimbarea culorii
    colorPicker.addEventListener('input', function(event) {
        const selectedColor = event.target.value;
        document.body.style.backgroundColor = selectedColor;
        localStorage.setItem('alien_skin_color', selectedColor);
    });


    // 3. LOGICA PENTRU SUBMIT (Unificat într-un singur loc)
    form.addEventListener('submit', function(event) {
        // Oprim trimiterea standard a formularului
        event.preventDefault(); 

        // --- VERIFICARE 1: Credit Social ---
        const credit = document.getElementById('credit_social').value;
        // Notă: în HTML ai pus min="0", deci logic ar trebui verificat o valoare
        // Dar am păstrat logica ta cu < 50
        if (parseInt(credit) < 50) {
            alert("Eroare: Creditul social este prea mic (minim 50)!");
            return; // Oprim execuția aici
        }

        // --- VERIFICARE 2: Checkbox-uri ---
        const checkboxes = document.querySelectorAll('input[name="scop"]:checked');
        const errorMsg = document.getElementById('scop_error');

        if (checkboxes.length === 0) {
            errorMsg.style.display = 'block';
            alert("Vă rugăm selectați cel puțin un scop al vizitei!");
            // Focus pe zona cu probleme
            document.getElementById('scop_container').scrollIntoView({behavior: "smooth"});
            return; // Oprim execuția aici
        } else {
            errorMsg.style.display = 'none';
        }

        // --- EXTRAGERE NUME (Lipsește definirea variabilei în codul tău vechi) ---
        const numeAlien = document.getElementById('nume').value;

        // --- GO WILD: Modificarea paginii ---
        console.log("Formular validat. Se trimite către Terra...");
        
        container.innerHTML = `
            <div style="text-align:center; padding: 50px; color: white; font-family: sans-serif;">
                <h1 style="font-size: 3em; color: #76ff03; margin-bottom: 20px;">
                    CERERE RECEPȚIONATĂ!
                </h1>
                
                <p style="font-size: 1.5em; margin-bottom: 30px;">
                    Mulțumim, <strong>${numeAlien}</strong>. Datele au fost teleportate în baza noastră de date.
                    <br>Vă rugăm așteptați aprobarea Consiliului Galactic.
                </p>

                <div style="margin: 0 auto; width: 100%; max-width: 480px;">
                    <img src="https://media.giphy.com/media/26BRpMry6seVLNjbq/giphy.gif" 
                         alt="Alien success" 
                         style="width: 100%; border-radius: 15px; box-shadow: 0 0 50px rgba(118, 255, 3, 0.5); border: 2px solid #76ff03;">
                </div>

                <p style="margin-top: 30px; opacity: 0.8;">
                    <i>Redirectare către portul spațial în 3... 2... 1...</i>
                </p>
            </div>
        `;
    });
}