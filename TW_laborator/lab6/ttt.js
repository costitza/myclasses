

let nume = prompt("Cum te cheama?");

let simbol = prompt("Bună, " + nume + ". Cu ce vrei să joci? X sau 0? X începe primul."); 

simbol = simbol.toUpperCase();
let simbolComputer = simbol === "X" ? "0" : "X";

let tabla = [];

for(let i = 0; i < 9; i++){
    tabla[i] = "?";
}


function printtt(tabla){

    let celule = tabla.map((val, index) => {
        if(val == "?")
            return (index + 1).toString();
        else
            return val;
    });

    let result = "";
    result += `| ${celule[0]} | ${celule[1]} | ${celule[2]} |\n`;
    result += `| ${celule[3]} | ${celule[4]} | ${celule[5]} |\n`;
    result += `| ${celule[6]} | ${celule[7]} | ${celule[8]} |`;

    return result;
}

function valid(tabla, pozitie) {
    return (
        !isNaN(pozitie) &&
        pozitie >= 1 &&
        pozitie <= 9 &&
        tabla[pozitie - 1] === "?"
    );
}

function win(tabla) {
    const combinatiiCastig = [
        [0, 1, 2], // rândul 1
        [3, 4, 5], // rândul 2
        [6, 7, 8], // rândul 3
        [0, 3, 6], // coloana 1
        [1, 4, 7], // coloana 2
        [2, 5, 8], // coloana 3
        [0, 4, 8], // diagonala principală
        [2, 4, 6]  // diagonala secundară
    ];

    for (let combo of combinatiiCastig) {
        const [a, b, c] = combo;

        if (tabla[a] !== "?" && tabla[a] === tabla[b] && tabla[a] === tabla[c]) {
            return tabla[a];
        }
    }
    return null;
}

function draw(tabla) {
    return !tabla.includes("?") && win(tabla) === null;
}

function computer_move(tabla, simbolComputer) {
    let pozitie = Math.floor(Math.random() * 9) + 1;

    if (valid(tabla, pozitie)) {
        tabla[pozitie - 1] = simbolComputer;
        return;
    } else {
        computer_move(tabla, simbolComputer);
    }
}


let finished = false;
while(!finished){
    alert(printtt(tabla));
    let input = prompt("unde vrei sa pui urmatorul semn? (1-9)");
    input = input.trim();
    let position = parseInt(input, 10);

    if(valid(tabla, position)){
        tabla[position - 1] = simbol;
    }
    else{
        alert("Pozitie invalida! incearca din nou");
        continue;
    }

    console.log(printtt(tabla));

    if(win(tabla) === simbol){
        alert("Bravo, " + nume + " ai castigat");
        finished = true;
        break;
    }

    if(draw(tabla)){
        alert("Remiza");
        finished = true;
        break;
    }

    computer_move(tabla, simbolComputer);
    if(win(tabla) == simbolComputer){
        alert("Ai pierdut :(");
        finished = true;
        break;
    }

    if(draw(tabla)){
        alert("Remiza");
        finished = true;
        break;
    }
}


alert("Jocul s-a terminat");