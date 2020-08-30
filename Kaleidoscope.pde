//import processing.video.*;
//Movie myMovie;
int counter = 1;
PImage img, imgRev, tempImg;
PVector a, b, c;
PShape wedgeImg;
float s;
ArrayList<Slice> slices = new ArrayList();
int xOff = 100;
int yOff = 400;
float zTrans = -1500;
float xScale;
PVector values;

void setup() {
  size(900, 900, P3D);
  surface.setLocation(0, 0);
  //background(0);
  //myMovie = new Movie(this, "sea.mov");
  //myMovie.loop();

  noStroke();

  s = tan(PI/12) * (height/2);
  a = new PVector(- s, - (height/2));
  b = new PVector(s, - (height/2));
  c = new PVector(0, 0);

  for (int i = 0; i < 12; i ++) {
    Slice s = new Slice(0, 0, (PI/6)*i, (i % 2), 0); 
    slices.add(s);
  }
  for (int i = 0; i < 12; i ++) {
    Slice s = new Slice(0, 0, (PI/6)*i, (i % 2), height); 
    slices.add(s);
  }
  values = new PVector(0, 0);
}

void draw() {
  background(0);
  img = loadImage("images/" + counter + ".tif");
  //xScale = map(mouseX, 0, height, .01, 100);
  //yOff = int(map(mouseY, 0, height, 200, 800));

  xScale = 50 * (cos(float(frameCount)/300) + 1);
  yOff = int(300 * (sin(float(frameCount)/1000) + 1)) + 200;

  translate(width/2, height/2, (sin(float(frameCount) /100) + 1) * 100 + zTrans);
  rotate(float(frameCount)/ 1000);
  for (Slice s : slices) {
    s.display();
  }



  if (frameCount % 4 == 0) {
    counter ++;
    if (zTrans < 500) {
      zTrans ++;
    }
  }
  if (counter > 1000) {
    counter = 1;
  }
  //image(img, 0, 0);
  //image(myMovie, 0, 0);
  //saveFrame("images/" + counter +".tif");
  
  //saveFrame("videoImgs/##########.tif");
}

class Slice {
  float x, y, theta;
  boolean rev;
  int cOff;
  Slice(float xPos, float yPos, float t, int r, int c) {
    x = xPos;
    y = yPos;
    theta = t;
    rev = boolean(r);
    cOff = c;
  }
  void display() {
    push();
    beginShape();
    texture(img);
    translate(x, y);
    rotate(theta);
    if (!rev) {
      vertex(a.x, a.y, 0, a.x + xOff, a.y + yOff);
      vertex(b.x, b.y, 0, b.x + (xOff * xScale), b.y + yOff);
    } else {
      vertex(a.x, a.y, 0, b.x + (xOff * xScale), a.y + yOff);
      vertex(b.x, b.y, 0, a.x + xOff, b.y + yOff);
    }
    vertex(c.x, c.y - cOff, 0, c.x + xOff, c.y + yOff);
    endShape(CLOSE);
    pop();
  }
}
