

window.onload = function() {
   const canvas = document.getElementById("canvdoor");
   const ctx = canvas.getContext("2d");
   draw();

   canvas.addEventListener("click", function(event){


      const rect = canvas.getBoundingClientRect();
      const mouseX = event.clientX - rect.left;
      const mouseY = event.clientY - rect.top;

      Door(ctx);

      if(ctx.isPointInPath(mouseX, mouseY)){
         colorBlack();
      }
   });
   
   function Door(ctx){

      ctx.beginPath();


      ctx.moveTo(50, 50);
      ctx.lineTo(200, 15);
      ctx.lineTo(200, 360);
      ctx.lineTo(50, 330);

      ctx.closePath();
   }

   function knob(ctx){

      ctx.beginPath();

      ctx.arc(180, 200, 10, 0, 2 * Math.PI);
   }

   function draw() {
       // desenăm ușa roșie

      ctx.fillStyle = "#FF0000";
      ctx.fillRect(30, 30, 200, 300);

      ctx.fillStyle = "#FFFFFF";
      ctx.fillRect(40, 40, 180, 300);

      ctx.fillStyle = "#FF0000";

      Door(ctx);
      ctx.fill();

      ctx.strokeStyle = "white";
      ctx.lineWidth = 5;
      ctx.stroke();

      ctx.fillStyle = "white";
      knob(ctx);
      ctx.fill();
   }          
             
   function colorBlack() {
      // colorăm ușa în negru    

      ctx.fillStyle = "black";

      Door(ctx);

      ctx.fill();

      ctx.fillStyle = "white"
      knob(ctx);
      ctx.fill();

   }
}   
        
       
      
