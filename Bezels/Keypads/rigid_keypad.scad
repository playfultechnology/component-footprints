
//translate([-32,-32,0])
/*
translate([7,13.2,0])
color("red")
import("keypad 4x4.stl");
*/

$fn=100;


// For 3x4
// Perimeter of the mount
outside_width = 65;
outside_height = 90;
base_width = 51;
base_height = 64;
base_depth = 3 + 1; // base is only 3mm deep, but little black pins stick out 1mm further)
base_round = 2;
// Window cutaway
window_width = 46;
window_height = 57;
window_depth = 3.6;
window_round = 4;
// PCB connector at base of keypad 
pcb_width = 37;
pcb_height = 5;


/*
// This is the spacing of the screw holes
translate([4.5+3.3/2+.25,4.5+3.3/2+.25,8])
color("red")
// 52.2, 77.2
cube([65-12.8, 90-12.8,1]);
*/

// For 4x4
/*
// Perimeter of the mount
outside_width = 79;
outside_height = 90;
base_width = 65;
base_height = 64;
base_depth = 3 + 1; // base is only 3mm deep, but little black pins stick out 1mm further)
base_round = 2;
// Window cutaway
window_width = 60;
window_height = 57;
window_depth = 3.6;
window_round = 4;
// PCB connector at base of keypad 
pcb_width = 50.8;
pcb_height = 5;
*/

// For TM1637 LED
/*
// Perimeter of the mount
outside_width = 59.5;
outside_height = 40;
base_width = 50;
base_height = 23;
base_depth = 4.2; // base is only 3mm deep, but little black pins stick out 1mm further)
base_round = 0;
// Window cutaway
window_width = 30.5;
window_height = 14.5;
window_depth = 7.4;
window_round = 0;
// PCB connector at base of keypad 
pcb_width = 0;
pcb_height = 0;
*/


bevel = 5;
base();

module base() {
  difference() {
    
    // Shell
    linear_extrude(base_depth + window_depth){
      polygon([[bevel,0],[outside_width-bevel,0],[outside_width,bevel],[outside_width,outside_height-bevel],[outside_width-bevel,outside_height], [bevel, outside_height], [0, outside_height-bevel], [0, bevel]]);
    }
    
    // Base
    translate([(outside_width-base_width)/2, (outside_height-base_height)/2, 0])
    linear_extrude(base_depth){
      polyround(base_round) { square([base_width, base_height]); }
    }
    // PCB cutaway
    translate([(outside_width-pcb_width)/2, (outside_height-base_height)/2-pcb_height, 0])
    linear_extrude(base_depth){
      square([pcb_width, pcb_height]);
    }
    
    // Window
    translate([(outside_width-window_width)/2, (outside_height-window_height)/2, base_depth])
    linear_extrude(window_depth){
      polyround(window_round) { square([window_width, window_height]); }
    }

    // M3 screws and heads
    for ( x = [4.5+3.3/2+.25, outside_width-4.5-3.3/2-.25], y = [4.5+3.3/2+.5, outside_height-4.5-3.3/2-.5] ){
      translate([x, y, 0]){
        // screw hole
        cylinder(r=3.3/2, h=base_depth+window_depth);
        // countersunk screw head
        translate([0,0,base_depth+window_depth-1.25]) 
          cylinder(r=6.1/2, h=1.25);
      }
    }
  }
}
module polyround(radius){
  //Inside corners
  offset(r=-radius)
  offset(delta=radius)
  //Outside corners
  offset(r=radius)
  offset(delta=-radius)
  children();
} 

