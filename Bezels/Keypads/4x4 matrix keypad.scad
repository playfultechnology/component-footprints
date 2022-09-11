include <Round-Anything/polyround.scad>
$fn=100;

//import("4x4 matrix keypad simple.stl");
import("4x4 matrix keypad detailed.stl");


linear_extrude(height=3.2) aperture();
surround();

module aperture() {
  width=60; height=57; depth = 3.2; r=3;
  points=[
  [0, 0, r],
  [width, 0, r],
  [width, height, r],
  [0, height, r]
  ];
  polygon(polyRound(points,5));
}

module surround() {
  width=64; height=65.5; depth = 3; r=3;
  points=[
  [0, 0, r],
  [width, 0, r],
  [width, height, r],
  [0, height, r]
  ];
  polygon(polyRound(points,5));
}