let vizor = null;
let img = null;
let gallery = null;

let baseImgWidth = 0;
let baseImgHeight = 0;

let offsetX = 0;
let offsetY = 0;
const STEP = 30;
let zoom = 1;
const ZOOM_STEP = 0.1;
const MIN_ZOOM = 0.5;
const MAX_ZOOM = 3;

let timerDiv = null;
let timerId = null;
let countdown = 0;

function updateZoom() {
  if (!img) return;
  if (zoom < MIN_ZOOM) zoom = MIN_ZOOM;
  if (zoom > MAX_ZOOM) zoom = MAX_ZOOM;
  img.style.transformOrigin = "0 0";
  img.style.transform = `scale(${zoom})`;
  updatePosition();
}

function updatePosition() {
  if (!vizor || !img) return;

  const vizorWidth = vizor.clientWidth;
  const vizorHeight = vizor.clientHeight;

  const imgWidth = baseImgWidth * zoom;
  const imgHeight = baseImgHeight * zoom;

  const maxOffsetX = Math.max(0, imgWidth - vizorWidth);
  const maxOffsetY = Math.max(0, imgHeight - vizorHeight);

  if (offsetX > 0) offsetX = 0;
  if (offsetX < -maxOffsetX) offsetX = -maxOffsetX;

  if (offsetY > 0) offsetY = 0;
  if (offsetY < -maxOffsetY) offsetY = -maxOffsetY;

  img.style.marginLeft = offsetX + "px";
  img.style.marginTop = offsetY + "px";
}

function playCaptureEffect() {
  if (vizor) {
    vizor.classList.add("flash");
    setTimeout(() => {
      vizor.classList.remove("flash");
    }, 200);
  }
}

function takeSnapshot() {
  const container = document.getElementById("container");
  const clone = container.cloneNode(true);
  clone.id = "";
  const clonedVizor = clone.querySelector("#vizor");
  if (clonedVizor) clonedVizor.removeAttribute("id");
  return clone;
}

function addSnapshotToGallery(snapshotContainer) {
  if (!gallery || !snapshotContainer) return;
  gallery.append(snapshotContainer);
}

function updateTimerDisplay() {
  if (!timerDiv) return;
  if (countdown > 0) timerDiv.textContent = countdown + " s";
  else timerDiv.textContent = "";
}

function startTimedCapture(seconds) {
  if (timerId !== null) return;

  countdown = seconds;
  updateTimerDisplay();

  function tick() {
    countdown--;
    updateTimerDisplay();

    if (countdown > 0) {
      timerId = setTimeout(tick, 1000);
    } else {
      timerId = null;
      playCaptureEffect();
      const capture = takeSnapshot();
      addSnapshotToGallery(capture);
    }
  }

  timerId = setTimeout(tick, 1000);
}

function handleKeyDown(event) {
  if (!img) return;

  let moved = false;
  let zoomed = false;
  let captured = false;

  switch (event.key) {
    case "ArrowLeft":
      offsetX += STEP;
      moved = true;
      break;
    case "ArrowRight":
      offsetX -= STEP;
      moved = true;
      break;
    case "ArrowUp":
      offsetY += STEP;
      moved = true;
      break;
    case "ArrowDown":
      offsetY -= STEP;
      moved = true;
      break;
    case "+":
      zoom += ZOOM_STEP;
      zoomed = true;
      break;
    case "-":
      zoom -= ZOOM_STEP;
      zoomed = true;
      break;
    case "s":
      captured = true;
      break;
    case "t":
      startTimedCapture(5);
      break;
    default:
      return;
  }

  event.preventDefault();

  if (moved) updatePosition();
  if (zoomed) updateZoom();
  if (captured) {
    playCaptureEffect();
    const capture = takeSnapshot();
    addSnapshotToGallery(capture);
  }
}

window.onload = function () {
  vizor = document.getElementById("vizor");
  img = vizor.querySelector("img");
  gallery = document.getElementById("gallery");
  timerDiv = document.getElementById("timer");

  document.addEventListener("keydown", handleKeyDown);

  baseImgWidth = img.clientWidth;
  baseImgHeight = img.clientHeight;

  if (img.complete) {
    updateZoom();
  } else {
    img.addEventListener("load", updateZoom);
  }
}
