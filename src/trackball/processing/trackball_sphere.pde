/**
 * Noise Sphere 
 * by David Pena.  
 * 
 * Uniform random distribution on the surface of a sphere. 
 */
 
import org.gamecontrolplus.*;
import org.gamecontrolplus.ControlDevice;
import org.gamecontrolplus.ControlIO;
//import org.gamecontrolplus.Configuration;
import net.java.games.input.*;
import java.util.ArrayList;
import java.util.List;

int cuantos = 4000;
Pelo[] lista ;
float[] z = new float[cuantos]; 
float[] phi = new float[cuantos]; 
float[] largos = new float[cuantos]; 
float radio;
float rx = 0;
float ry =0;

// ControlIO has devices. 
ControlIO controlIO;

// A ControlDevice might be a joystick, gamepad, mouse etc.
ControlDevice device;

// A device will have some combination of buttons, hats and sliders
ControlSlider sliderx, slidery;

void setup() {
  size(640, 360, P3D);
  radio = height/3;
  lista = new Pelo[cuantos];
  for (int i=0; i<cuantos; i++) {
    lista[i] = new Pelo();
  }
  noiseDetail(3);
  
  //HID
  //init ControlIO
  controlIO = ControlIO.getInstance(this);

  //get all available devices
  List<ControlDevice> devices = controlIO.getDevices();

  // Print devices list
  println("nr of HID devices: ", controlIO.getNumberOfDevices());  
  int i = 0;
  for (ControlDevice d : devices) {
    if (d != null ){
      println(i, " : ", d);
      i++;
      }
  }
  
  //open the device we want
  device = controlIO.getDevice(4);
  
  //reference its continous controls
  sliderx = device.getSlider("x");
  slidery = device.getSlider("y");
}

void draw() {
  background(0);
  
  //println("x: ", sliderx.getValue());
  //println("y: ", slidery.getValue());
    
  translate(width/2, height/2);

  float rxp = sliderx.getValue() * 0.05;
  float ryp = slidery.getValue() *0.05;
  //rx = (rx*0.9)+(rxp*0.1);
  //ry = (ry*0.9)+(ryp*0.1);
  rx = rx + 0.001*sliderx.getValue();
  ry = ry + 0.001*slidery.getValue()*-1.0;
  println(rx);
  //print(frameCount* PI  * 0.001);
  rotateY(rx);
  rotateX(ry);
  fill(0);
  noStroke();
  sphere(radio);

  for (int i = 0;i < cuantos; i++) {
    lista[i].dibujar();
  }
}


class Pelo {
  
  float z = random(-radio, radio);
  float phi = random(TWO_PI);
  float largo = random(1.15, 1.2);
  float theta = asin(z/radio);

  void dibujar() {
    float off = 0; //(noise(millis() * 0.0005, sin(phi))-0.5) * 0.3;
    float offb = 0; // (noise(millis() * 0.0007, sin(z) * 0.01)-0.5) * 0.3;

    float thetaff = theta+off;
    float phff = phi+offb;
    float x = radio * cos(theta) * cos(phi);
    float y = radio * cos(theta) * sin(phi);
    float z = radio * sin(theta);
    float msx= screenX(x, y, z);
    float msy= screenY(x, y, z);

    float xo = radio * cos(thetaff) * cos(phff);
    float yo = radio * cos(thetaff) * sin(phff);
    float zo = radio * sin(thetaff);

    float xb = xo * largo;
    float yb = yo * largo;
    float zb = zo * largo;

    beginShape(LINES);
    stroke(0);
    vertex(x, y, z);
    stroke(200, 150);
    vertex(xb, yb, zb);
    endShape();
  }
}
