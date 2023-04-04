

//Import the libs Game Control Plus (GCP) and G4P. 

import org.gamecontrolplus.*;
import org.gamecontrolplus.ControlDevice;
import org.gamecontrolplus.ControlIO;
//import org.gamecontrolplus.Configuration;
import net.java.games.input.*;
import java.util.ArrayList;
import java.util.List;

// ControlIO has devices. 
ControlIO controlIO;

// A ControlDevice might be a joystick, gamepad, mouse etc.
ControlDevice device;

// A device will have some combination of buttons, hats and sliders
ControlSlider sliderx, slidery;

void setup(){
  
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
  
    println("x: ", sliderx.getValue());
    println("y: ", slidery.getValue());
}
