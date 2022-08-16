
// Microswitch housing e.g. SS-5GL

// Housing
difference(){
  // Exterior walls
  cube([10.5,24,10]);
  // Interior cutout
  translate([2, 2, 0])
    cube([6.5,20,10]);
}

// Base Plate
translate([-8,-8,0])
difference(){
  cube([26.5, 40, 2]);
  translate([6,0,0]) {
    // Cutouts for switch contacts
    translate([4, 10, 0])
        cube([6.5, 4, 2]);  
    translate([4, 18.5, 0])
        cube([6.5, 4, 2]);
    translate([4, 26, 0])
        cube([6.5, 4, 2]);
    // Screw holes
    translate([16.25, 4, 0])
        cylinder(h=2, r=1.5, $fn=100);
    translate([-1.75, 4, 0])
        cylinder(h=2, r=1.5, $fn=100);  
    translate([16.25, 36, 0])
        cylinder(h=2, r=1.5, $fn=100);
    translate([-1.75, 36, 0])
        cylinder(h=2, r=1.5, $fn=100);  
  }
}