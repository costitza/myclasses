
jsonButton = document.getElementById("download-json");
jsonButton.addEventListener("click", () => {
    fetch("cinemateca.xml")
        .then(response => {
            if (!response.ok) {
                throw new Error("Nu s-a putut încărca fișierul XML");
            }
            return response.text();
        })
        .then(str => {
            const parser = new DOMParser();
            const xmlDoc = parser.parseFromString(str, "text/xml");
            const jsonData = fromXMLtoJSON(xmlDoc);
            descarcaJSON(jsonData, "cinemateca.json");
        })
        .catch(error => {
            console.error("Eroare:", error);
            alert("Eroare: Trebuie să rulați acest fișier pe un server local (localhost) pentru a citi XML extern.");
        });
});

document.addEventListener("DOMContentLoaded", () => {
    fetch("cinemateca.xml")
        .then(response => {
            if (!response.ok) {
                throw new Error("Nu s-a putut încărca fișierul XML");
            }
            return response.text();
        })
        .then(str => {
            const parser = new DOMParser();
            const xmlDoc = parser.parseFromString(str, "text/xml");
            if (xmlDoc.getElementsByTagName("parsererror").length > 0) {
                console.error("Eroare la parsarea XML-ului!");
                return;
            }
            proceseazaSiAfiseaza(xmlDoc);
        })
        .catch(error => {
            console.error("Eroare:", error);
            document.getElementById("lista-filme").innerHTML = "<p style='color:red'>Eroare: Trebuie să rulați acest fișier pe un server local (localhost) pentru a citi XML extern.</p>";
        });
});

function proceseazaSiAfiseaza(xmlDoc) {
    const filmeArray = [];
    const filmeNodes = xmlDoc.getElementsByTagName("film");
    for (let i = 0; i < filmeNodes.length; i++) {
        const filmNode = filmeNodes[i];
        const actoriNodes = filmNode.getElementsByTagName("actor");
        const actoriList = [];
        for(let j = 0; j < actoriNodes.length; j++) {
            actoriList.push({
                nume: actoriNodes[j].textContent,
                rol: actoriNodes[j].getAttribute("tip")
            });
        }
        const filmObj = {
            titlu: filmNode.getElementsByTagName("titlu")[0].textContent,
            limba: filmNode.getElementsByTagName("titlu")[0].getAttribute("limba"),
            gen: filmNode.getElementsByTagName("gen")[0].textContent,
            regizor: filmNode.getElementsByTagName("regizor")[0].textContent,
            an: filmNode.getElementsByTagName("an")[0].textContent,
            scenarist: filmNode.getElementsByTagName("scenarist")[0].textContent,
            producator: filmNode.getElementsByTagName("producator")[0].textContent,
            actori: actoriList,
            scor: filmNode.getElementsByTagName("scor")[0].textContent
        };
        filmeArray.push(filmObj);
    }
    afiseazaFilme(filmeArray);
}

function afiseazaFilme(filme) {
    const container = document.getElementById("lista-filme");
    container.innerHTML = "";
    filme.forEach(film => {
        const filmDiv = document.createElement("div");
        filmDiv.className = "film-container";
        const titluH3 = document.createElement("h3");
        titluH3.className = "film-titlu";
        titluH3.textContent = `${film.titlu} (${film.an})`;
        filmDiv.appendChild(titluH3);
        const listaDetalii = document.createElement("ul");
        listaDetalii.innerHTML = `
            <li><strong>Titlu original:</strong> ${film.titlu} (Limba: ${film.limba})</li>
            <li><strong>Gen:</strong> ${film.gen}</li>
            <li><strong>Regizor:</strong> ${film.regizor}</li>
            <li><strong>Scenarist:</strong> ${film.scenarist}</li>
            <li><strong>Producător:</strong> ${film.producator}</li>
            <li><strong>Scor:</strong> ${film.scor}/10</li>
            <li><strong>Actori:</strong>
                <ul>
                    ${film.actori.map(a => `<li>${a.nume} (Rol: ${a.rol})</li>`).join('')}
                </ul>
            </li>
        `;
        filmDiv.appendChild(listaDetalii);
        container.appendChild(filmDiv);
    });
}

function fromXMLtoJSON(xmlDoc){
    filmeArray = [];
    const filmeNodes = xmlDoc.getElementsByTagName("film");
    for (let i = 0; i < filmeNodes.length; i++) {
        const filmNode = filmeNodes[i];
        const actoriNodes = filmNode.getElementsByTagName("actor");
        const actoriList = [];
        for(let j = 0; j < actoriNodes.length; j++) {
            actoriList.push({
                nume: actoriNodes[j].textContent,
                rol: actoriNodes[j].getAttribute("tip")
            });
        }
        const filmObj = {
            titlu: filmNode.getElementsByTagName("titlu")[0].textContent,
            limba: filmNode.getElementsByTagName("titlu")[0].getAttribute("limba"),
            gen: filmNode.getElementsByTagName("gen")[0].textContent,
            regizor: filmNode.getElementsByTagName("regizor")[0].textContent,
            an: filmNode.getElementsByTagName("an")[0].textContent,
            scenarist: filmNode.getElementsByTagName("scenarist")[0].textContent,
            producator: filmNode.getElementsByTagName("producator")[0].textContent,
            actori: actoriList,
            scor: filmNode.getElementsByTagName("scor")[0].textContent
        };
        filmeArray.push(filmObj);
    }
    return filmeArray;
}

function descarcaJSON(data, numeFisier) {
    const jsonString = JSON.stringify(data, null, 2);
    const blob = new Blob([jsonString], { type: "application/json" });
    const url = URL.createObjectURL(blob);
    const link = document.createElement("a");
    link.href = url;
    link.download = numeFisier;
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
    URL.revokeObjectURL(url);
}
