class Game {
    constructor(simbolJucator, simbolComputer) {
        this.simbolJucator = simbolJucator;
        this.simbolComputer = simbolComputer;
        this.tabla = Array(9).fill("?");
        this.finished = false;
    }

    printTabla() {
        let celule = this.tabla.map((val, index) => {
            return val === "?" ? (index + 1).toString() : val;
        });

        return `| ${celule[0]} | ${celule[1]} | ${celule[2]} |
| ${celule[3]} | ${celule[4]} | ${celule[5]} |
| ${celule[6]} | ${celule[7]} | ${celule[8]} |`;
    }

    valid(pozitie) {
        return !isNaN(pozitie) &&
               pozitie >= 1 &&
               pozitie <= 9 &&
               this.tabla[pozitie - 1] === "?";
    }

    win() {
        const combinatiiCastig = [
            [0,1,2],[3,4,5],[6,7,8],
            [0,3,6],[1,4,7],[2,5,8],
            [0,4,8],[2,4,6]
        ];

        for (let [a,b,c] of combinatiiCastig) {
            if (this.tabla[a] !== "?" && this.tabla[a] === this.tabla[b] && this.tabla[a] === this.tabla[c]) {
                return this.tabla[a];
            }
        }
        return null;
    }

    draw() {
        return !this.tabla.includes("?") && this.win() === null;
    }

    moveJucator(pozitie) {
        if (this.valid(pozitie)) {
            this.tabla[pozitie - 1] = this.simbolJucator;
            return true;
        }
        return false;
    }

    moveComputer() {
        let pozitie;
        do {
            pozitie = Math.floor(Math.random() * 9) + 1;
        } while (!this.valid(pozitie));
        this.tabla[pozitie - 1] = this.simbolComputer;
    }

    verificaFinal() {
        if (this.win() === this.simbolJucator) {
            alert("Ai câștigat acest joc!");
            this.finished = true;
        } else if (this.win() === this.simbolComputer) {
            alert("Calculatorul a câștigat acest joc!");
            this.finished = true;
        } else if (this.draw()) {
            alert("Remiză!");
            this.finished = true;
        }
    }
}


let nume = prompt("Cum te cheamă?");
let simbol = prompt("Bună, " + nume + ". Cu ce vrei să joci? X sau 0? X începe primul.").toUpperCase();
let simbolComputer = simbol === "X" ? "0" : "X";

let joc1 = new Game(simbol, simbolComputer);
let joc2 = new Game(simbol, simbolComputer);

while (!joc1.finished || !joc2.finished) {
    let tabla1 = joc1.printTabla();
    let tabla2 = joc2.printTabla();

    alert(`JOC 1:\n${tabla1}\n\nJOC 2:\n${tabla2}`);

    let input = prompt("Introdu două poziții (una pentru fiecare joc), separate prin spațiu:");
    if (!input) break;
    let [poz1, poz2] = input.trim().split(" ").map(Number);

    // joc 1
    if (!joc1.finished && joc1.moveJucator(poz1)) {
        joc1.verificaFinal();
        if (!joc1.finished) {
            joc1.moveComputer();
            joc1.verificaFinal();
        }
    }

    // joc 2 
    if (!joc2.finished && joc2.moveJucator(poz2)) {
        joc2.verificaFinal();
        if (!joc2.finished) {
            joc2.moveComputer();
            joc2.verificaFinal();
        }
    }
}

alert("Ambele jocuri s-au terminat!");
