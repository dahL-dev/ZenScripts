const windowWidth = 1280;
const windowHeight = 720;

function pentatonic(n) {
  const f0 = 110;
  return f0 * Math.pow(2, n / 12);
}

class ShapeType {
  constructor(type) {
    this.type = type;
  }
}

class Shape {
  constructor(x, y) {
    this.x = x;
    this.y = y;
  }

  draw(shapeType, radius = 10) {
    switch (shapeType.type) {
      case "point":
        fill("#ffffffae");
        stroke("#ffffffae");
        ellipse(this.x, this.y, radius, radius);
        break;
    }
  }
}

class Point extends Shape {
  constructor(x, y) {
    super(x, y);
    this.x = x;
    this.y = y;
  }
}

class Oscillator extends Point {
  constructor(x, y, radius, oscillatingFreq, noteFreq) {
    super(x, y, radius);
    this.x = x;
    this.y = y;
    this.r = radius;
    this.frequency = oscillatingFreq;
    this.noteFrequency = noteFreq;
    this.sound = new Audio();
    this.sound.src = "rich-saw-synth-pluck_C_major.wav";
  }

  angle = -1;
  direction = 1;
  frequency = 0.1;

  playSound() {
    this.sound.play();
  }

  play() {
    this.playSound();
    setTimeout(() => this.sound.pause(), 3);
  }
}

const origin = new Point(windowWidth / 2, windowHeight);
let oscillators = [];
let start = false;

function setup() {
  createCanvas(windowWidth, windowHeight);
  const oscillatorCount = 25;
  const pathSpacing = 10;

  for (let i = 0; i < oscillatorCount; i++) {
    const radius = 100 + pathSpacing * i;
    oscillators.push(
      new Oscillator(
        origin.x - radius * Math.cos(0),
        origin.y - radius * Math.sin(0),
        radius,
        (oscillatorCount - i / 2) / pathSpacing,
        pentatonic(oscillatorCount - i)
      )
    );
  }

  button = createButton("Start Your Drawing");
  button.mousePressed(() => (start = true));
}

function draw() {
  background(40);
  fill(255);

  if (!start) {
    return;
  }

  drawPaths();
  drawOscillators();
  drawFps();
}

function drawFps() {
  let fps = frameRate();
  fill(255);
  stroke(0);
  text("FPS: " + fps.toFixed(2), windowWidth - 100, 20);
}

function drawPaths() {
  colorMode(HSB);

  for (let i = 0; i < oscillators.length; i++) {
    const osc = oscillators[i];
    const hue = map(i, 0, oscillators.length, 300, 0);
    noFill();
    stroke(hue, 100, 100);
    strokeWeight(1);
    ellipse(origin.x, origin.y, 2 * osc.r, 2 * osc.r);
  }

  colorMode(RGB);
}

function drawOscillators() {
  oscillators.forEach((oscillator) => {
    oscillator.x =
      origin.x - oscillator.r * Math.cos((oscillator.angle * PI) / 180);
    oscillator.y =
      origin.y - oscillator.r * Math.sin((oscillator.angle * PI) / 180);

    if (oscillator.angle > 180) {
      let h1 = oscillator.angle - 180;
      oscillator.angle = 180 - h1;
      oscillator.direction = -1;
      oscillator.play();
    }

    if (oscillator.angle < 0) {
      let h2 = oscillator.angle * -1;
      oscillator.angle = 0 + h2;
      oscillator.direction = 1;
      oscillator.play();
    }

    oscillator.angle += 0.75 * oscillator.direction * oscillator.frequency;
  });

  oscillators.forEach((oscillator) => {
    oscillator.draw(new ShapeType("point"));
  });
}

function pentatonic(n) {
  const f0 = 110;
  return f0 * Math.pow(2, n / 12);
}

function mouseClicked() {
  oscillators.forEach((oscillator) => {
    oscillator.playSound();
  });
}
