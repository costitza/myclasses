export default class Game {
    constructor(simbol, computerSimbol){
        this.simbol = simbol;
        this.computerSimbol = computerSimbol;
        this.tabla = Array(9).fill("?");
        this.finished = false;
    }

    // methods
    static printtt(){

        let celule = this.tabla.map((val, index) => {
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

    static valid(pozitie) {
        return (
            !isNaN(pozitie) &&
            pozitie >= 1 &&
            pozitie <= 9 &&
            this.tabla[pozitie - 1] === "?"
        );
    }

    static win() {
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

    static draw() {
        return !this.tabla.includes("?") && win(this.tabla) === null;
    }

    static computer_move() {
        let pozitie = Math.floor(Math.random() * 9) + 1;

        if (valid(this.tabla, pozitie)) {
            tabla[pozitie - 1] = this.computerSimbol;
            return;
        } else {
            computer_move(this.tabla, this.simbolComputer);
        }
    }

    static is_finished(){
        return this.win() == true || this.draw() == true;
    }
}