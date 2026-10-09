function drawTable(nrows, ncols) {

   containerelm = document.getElementById("container");

   let table = document.createElement("table");
   table.setAttribute("id", "drawtable");
   
   for (let r = 0; r < nrows; r++) {
       let row = document.createElement("tr");
       for (let c = 0; c < ncols; c++) {
         let cell = document.createElement("td");
         cell.classList.add(`r${r}`);
         cell.classList.add(`c${c}`);
         row.appendChild(cell);
       }
       table.appendChild(row);
   }
   containerelm.appendChild(table);
}

function colorCol(column, color) {

   var table = document.getElementById("drawtable");
   for (let r = 0; r < table.rows.length; r++) {
      let cell = table.rows[r].cells[column];
      cell.style.backgroundColor = color;
   }

}

function colorRow(row, color) {

   var table = document.getElementById("drawtable");
   for(let c = 0; c < table.rows[row].cells.length; c++) {
      let cell = table.rows[row].cells[c];
      cell.style.backgroundColor = color;
   }
}

function rainbow(target) {
   let colors = ["rgb(255, 0, 0)", "rgb(255, 154, 0)", "rgb(240, 240, 0)", "rgb(79, 220, 74)", "rgb(63, 218, 216)", "rgb(47, 201, 226)", "rgb(28, 127, 238)", "rgb(95, 21, 242)", "rgb(186, 12, 248)", "rgb(251, 7, 217)"];
   let numberOfColors = colors.length;

   if (target === "orizontal") {
      var table = document.getElementById("drawtable");
      let numberOfRows = table.rows.length;
      for (let r = 0; r < table.rows.length; r++) {
         let color = colors[Math.round(numberOfColors / numberOfRows * (r - 1)) % numberOfColors];
         for (let c = 0; c < table.rows[r].cells.length; c++) {
            let cell = table.rows[r].cells[c];
            cell.style.backgroundColor = color;
         }
      }
   } else if (target === "vertical") {
      var table = document.getElementById("drawtable");
      let numberOfCols = table.rows[0].cells.length;
      for (let c = 0; c < table.rows[0].cells.length; c++) {
         let color = colors[Math.round((numberOfColors / numberOfCols) * (c - 1)) % numberOfColors];
         for (let r = 0; r < table.rows.length; r++) {
            let cell = table.rows[r].cells[c];
            cell.style.backgroundColor = color;
         }
      }
   }
}

function getNthChild(element, n) {
/*
   4. Întoarceți al n-lea element copil al unui element dat ca argument.
*/
   return element.children[n];
}

function drawPixel(row, col, color) {	
/*
   5. Colorați celula de la linia 'row' și coloana 'col' cu culoarea `color'.
*/
   element = document.getElementById("drawtable").rows[row].cells[col];
   element.style.backgroundColor = color;

}

function drawLine(r1, c1, r2, c2, color) {
/*
   6. Desenați o linie (orizontală sau verticală) de la celula aflată 
   pe linia 'r1', coloana 'c1' la celula de pe linia 'r2', coloana 'c2'
   folosind culoarea 'color'. 
   Hint: verificați mai întâi că punctele (r1, c1) și (r2, c2) definesc
   într-adevăr o linie paralelă cu una dintre axe.
*/
   if (r1 === r2) {
      for (let c = Math.min(c1, c2); c <= Math.max(c1, c2); c++) {
         drawPixel(r1, c, color);
      }
   }
   else if (c1 === c2) {
      for (let r = Math.min(r1, r2); r <= Math.max(r1, r2); r++) {
         drawPixel(r, c1, color);
      }
   }
}

function drawRect(r1, c1, r2, c2, color) {
/*
   7. Desenați, folosind culoarea 'color', un dreptunghi cu colțul din 
   stânga sus în celula de pe linia 'r1', coloana 'c1', și cu 
   colțul din dreapta jos în celula de pe linia 'r2', coloana 'c2'.
*/
   for (let r = r1; r <= r2; r++) {
      drawLine(r, c1, r, c2, color);
   }
}

function drawPixelExt(row, col, color) {
/*
   8. Colorați celula de la linia 'row' și coloana 'col' cu culoarea 'color'.
   Dacă celula nu există, extindeți tabla de desenat în mod corespunzător.
*/
   var table = document.getElementById("drawtable");

   if (row >= table.rows.length) {
      let currentRows = table.rows.length;
      for (let r = currentRows; r <= row; r++) {
         let newRow = document.createElement("tr");

         for (let c = 0; c < table.rows[0].cells.length; c++) {
            let newCell = document.createElement("td");
            newCell.classList.add(`r${r}`);
            newCell.classList.add(`c${c}`);
            newRow.appendChild(newCell);
         }
         table.appendChild(newRow);
      }
   }
   if (col >= table.rows[0].cells.length) {
      let currentCols = table.rows[0].cells.length;
      for (let r = 0; r < table.rows.length; r++) {
         for (let c = currentCols; c <= col; c++) {
            let newCell = document.createElement("td");
            newCell.classList.add(`r${r}`);
            newCell.classList.add(`c${c}`);
            table.rows[r].appendChild(newCell);
         }
      }
   }
   
   drawPixel(row, col, color);
}

function colorMixer(colorA, colorB, amount){
   let cA = colorA * (1 - amount);
   let cB = colorB * (amount);
   return parseInt(cA + cB);
}

function drawPixelAmount(row, col, color, amount) {
   /* 
   9. Colorați celula la linia 'row' și coloana 'col' cu culoarea 'color'
   în funcție de ponderea 'amount' primită ca argument (valoare între 0 și 1). 
   Dacă 'amount' are valoarea:
   1, atunci celula va fi colorată cu 'color'
   0, atunci celula își va păstra culoarea inițială
   pentru orice altă valoare, culoarea inițială și cea dată de argumentul 
   'color' vor fi amestecate. De exemplu, dacă ponderea este 0.5, atunci 
   culoarea inițială și cea nouă vor fi amestecate în proporții egale (50%). 
   */

   /*   
   Hint 1: folosiți funcția colorMixer de mai sus.

   Hint 2: pentru un argument 'color' de forma 'rgb(x,y,z)' puteți folosi
   let newColorArray = color.match(/\d+/g); 
   pentru a obține un Array cu trei elemente, corespunzătoare valorilor
   asociate celor trei culori - newColorArray = [x, y, z]
   
   Hint 3: pentru a afla culoarea de fundal a unui element puteți folosi
   metoda getComputedStyle(element). Accesând proprietatea backgroundColor 
   a obiectului întors, veți obține un string de forma 'rgb(x,y,z)'.
   */
   const table = document.getElementById("drawtable");
   const cell = table.rows[row].cells[col];

   if (amount === 1) {
      cell.style.backgroundColor = color;
      return;
   }

   if (amount === 0) {
      return;
   }
   
   const oldColor = getComputedStyle(cell).backgroundColor;
   
   let oldRGB = oldColor.match(/\d+/g).map(Number);
   let newRGB = color.match(/\d+/g).map(Number);
   let r = colorMixer(oldRGB[0], newRGB[0], amount);
   let g = colorMixer(oldRGB[1], newRGB[1], amount);
   let b = colorMixer(oldRGB[2], newRGB[2], amount);

   cell.style.backgroundColor = `rgb(${r},${g},${b})`;
}

function delRow(row) {
/*
   10. Ștergeți linia cu numărul 'row' din tabla de desenat.
*/
   table = document.getElementById("drawtable");
   table.deleteRow(row);
}

function delCol(col) {
/*
   10. Ștergeți coloana cu numărul 'col' din tabla de desenat.
*/
   table = document.getElementById("drawtable");
   for (let r = 0; r < table.rows.length; r++) {
      table.rows[r].deleteCell(col);
   }
}

function shiftRow(row, pos) {
/*
   11. Aplicați o permutare circulară la dreapta cu 'pos' poziții a
   elementelor de pe linia cu numărul 'row' din tabla de desenat. 
*/
   const table = document.getElementById("drawtable");
   const cells = [...table.rows[row].cells];
   const n = cells.length;
   pos = pos % n;
   const newOrder = cells.slice(n - pos).concat(cells.slice(0, n - pos));
   newOrder.forEach(cell => table.rows[row].appendChild(cell));
}

function jumble() {
/*
   12. Folosiți funcția 'shiftRow' pentru a aplica o permutare circulară
   cu un număr aleator de poziții fiecărei linii din tabla de desenat.
*/
   const table = document.getElementById("drawtable");
   const nrows = table.rows.length;
   for (let r = 0; r < nrows; r++) {
      const ncols = table.rows[r].cells.length;
      const pos = Math.floor(Math.random() * ncols);
      shiftRow(r, pos);
   }
}

function transpose() {
/*
   13. Transformați tabla de desenat în transpusa ei.
*/
}

function flip(element) {
/*
   14. Inversați ordinea copiilor obiectului DOM 'element' primit ca argument.
*/
}

function mirror() {
/*
   15. Oglindiți pe orizontală tabla de desenat: luați jumătatea stângă a tablei, 
   aplicați-i o transformare flip și copiați-o în partea dreaptă a tablei.
*/
}

function smear(row, col, amount) {
/*
   16. Întindeți culoarea unei celule de pe linia 'row' și coloana 'col' în celulele
   învecinate la dreapta, conform ponderii date de 'amount' (valoare între 0 și 1).
   Cu colorarea fiecărei celule la dreapta, valoarea ponderii se înjumătățește. 
   Hint: folosiți funcția 'drawPixelAmount'.
*/
}


window.onload = function(){
    const rows = 40;
    const cols = 40;	

    drawTable(rows, cols);
    rainbow("vertical");
   drawLine(5, 5, 5, 30, "black");
   drawRect(10, 10, 20, 20, "blue");
   //jumble();
   drawPixelAmount(1, 1, "rgb(0,0,255)", 0.8);
   jumble();
}


