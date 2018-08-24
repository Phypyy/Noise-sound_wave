import spout.*;
Spout spout;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer song;
FFT fft;


float t =0;
float a;

void setup() {
  size(800,400, P3D);
  spout = new Spout(this);
  spout.createSender("T12");
  minim = new Minim(this);

  song = minim.loadFile("Animals.mp3");
  fft = new FFT(song.bufferSize(), song.sampleRate());

  a=20;
}

void draw() {
  background(0);
  translate(width/2f, height/2f);
  fft.forward(song.mix);

  strokeWeight(2);

  for (int i = 0; i < song.bufferSize() - 1; i++) {

    float x1 = map( i, 0, song.bufferSize(), 0, width );
    float x2 = map( i+1, 0, song.bufferSize(), 0, width );

    stroke(255);
    point(x1, 800*song.left.get(i)* noise(i/2000, t)); 

    stroke(255, 0, 0);
    point(x1, 1000*song.left.get(i)* noise(i/2000, t));

    stroke(255);
    point(x1, 2000*song.right.get(i)* noise(i/2000, t));


    scale(-1, 1);
    stroke(255);
    point(x1, 800*song.left.get(i)* noise(i/2000, t)); 

    stroke(255, 0, 0);
    point(x1, 1000*song.left.get(i)* noise(i/2000, t));

    stroke(255);
    point(x1, 2000*song.right.get(i)* noise(i/2000, t));
  }
  t = t+1;
  spout.sendTexture();
}

void keyPressed() {
  if (song.isPlaying()) {
    song.pause();
  } else if (song.position() == song.length()) {
    song.rewind();
    song.play();
  } else {
    song.play();
  }
}
  
