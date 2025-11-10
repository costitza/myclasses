export default class Game {
    constructor(simbol, computerSimbol){
        this.simbol = simbol;
        this.computerSimbol = computerSimbol;
        this.tabla = Array(9).fill("?");
        this.finished = false;
    }

    // methods
    printtt(){

        let celule = this.tabla.map((val, index) => {
            if(val == "?")
                return (index + 1).toString();
            else
                return val;
        });

        let result = "";
        result += `| ${celule[0]} | ${celule[1]} | ${celule[2]} |\n| ${celule[3]} | ${celule[4]} | ${celule[5]} |\n| ${celule[6]} | ${celule[7]} | ${celule[8]} |`;

        return result;
    }

    valid(pozitie) {
        return (
            !isNaN(pozitie) &&
            pozitie >= 1 &&
            pozitie <= 9 &&
            this.tabla[pozitie - 1] === "?"
        );
    }

    win() {
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

            if (this.tabla[a] !== "?" && this.tabla[a] === this.tabla[b] && this.tabla[a] === this.tabla[c]) {
                return this.tabla[a];
            }
        }
        return null;
    }

    draw() {
        return !this.tabla.includes("?") && win(this.tabla) === null;
    }

    computer_move() {
        let pozitie = Math.floor(Math.random() * 9) + 1;

        if (valid(this.tabla, pozitie)) {
            tabla[pozitie - 1] = this.computerSimbol;
            return;
        } else {
            computer_move(this.tabla, this.simbolComputer);
        }
    }

    is_finished(){
        return this.win() == true || this.draw() == true;
    }
}

let nume = prompt("Cum te cheama?");

let simbol = prompt("Bună, " + nume + ". Cu ce vrei să joci? X sau 0? X începe primul. VEI JUCA 2 JOCURI IN PARALEL"); 

simbol = simbol.toUpperCase();
let simbolComputer = simbol === "X" ? "0" : "X";

let game1 = new Game(simbol, simbolComputer);
let game2 = new Game(simbol, simbolComputer);

while(!game1.finished || !game2.finished){
    let tabla1 = game1.printtt();
    let tabla2 = game2.printtt();

    alert(`JOC 1:\n${tabla1}\n\nJOC 2:\n${tabla2}`);

}