window.onload = function() {
    obtineAlbume();
};

function obtineAlbume() {
    fetch('albums.json')
        .then(function(raspuns) {
            return raspuns.json();
        })
        .then(function(listaAlbume) {
            populeazaGaleria(listaAlbume);
        })
        .catch(function(eroare) {
            console.log("Eroare la citire albums.json: " + eroare);
        });
}

function populeazaGaleria(lista) {
    var galerie = document.getElementById('gallery');
    for (var i = 0; i < lista.length; i++) {
        var album = lista[i];
        var index = i; 

        var card = document.createElement('div');
        card.className = 'album-card';

        var img = document.createElement('img');
        imagePath = 'images/' + album.image;
        img.src = imagePath; 

        var nume = document.createElement('h3');
        nume.innerText = album.name;

        var artist = document.createElement('p');
        artist.innerText = album.artist;
        card.dataset.indexAlbum = index;
        card.onclick = function() {
            var indexSelectat = this.dataset.indexAlbum;
            afiseazaDetalii(indexSelectat);
        };
        card.appendChild(img);
        card.appendChild(nume);
        card.appendChild(artist);
        galerie.appendChild(card);
    }
}

function afiseazaDetalii(index) {
    var numeFisier = "albums/" + index + ".json";
    fetch(numeFisier)
        .then(function(raspuns) {
            return raspuns.json();
        })
        .then(function(detalii) {
            var infoDiv = document.getElementById('info');
            infoDiv.innerHTML = "<h2>" + detalii.name + "</h2>" +
                                "<p><strong>Artist:</strong> " + detalii.artist + "</p>" +
                                "<p><strong>An:</strong> " + detalii.year + "</p>" +
                                "<hr>" +
                                "<img src='images/" + detalii.image + "' alt='" + detalii.name + "'>" +
                                "<p><strong>Gen:</strong>" + detalii.genres + "</p>";
        });
}

