//-------------------------------------------------------------------
// title: DIN clip
// author: OK1HRA 
// license: Creative Commons BY-SA
// URL: http://remoteqth.com/3d-din-rail-mount-clip.php
// Original revision: 0.1
// revision: 0.2b Contributed by John Cabrer
// format: OpenSCAD
//-------------------------------------------------------------------
// HowTo:
// Determine the center to center hole spacing of the device to mount (mount_hole_spacing)
// Pick a metric screw size, and length
// Pick a nut width and height
// See http://mcmaster-carr.com/ for drawings of all screws and nuts.
// The mount post length is calculated based on the screw length
// After after making your changes, press F5 to re-render them to the screen
// .STL export press F6 and menu /Design/Export as STL...

// ----- Inside Hole Calibration Values --------
// To use, print out a part with default values (i.e. mount_nut_width = 8,
// actual_measurement = 8)
// Measure the resulting hole width of the nut, and type that value as the actual measurement. Render and export. Print again.
// The gain_adjust value will insure that holes measure as they should.

expected_measurement = 8;
actual_measurement = 8;
gain_adjust = expected_measurement / actual_measurement; // Default = 8/8 = 1

//----------------- Mounting Screw Input Parameters ---------------------------------
plate_thickness = 1.65;    // This is the thickness of the thing being mounted
mount_hole_spacing = 50;    // mount_hole_spacing between mounting holes. 31mm for LCD1602. 50mm for relay module
mount_screw_length = 10; // Min = 6
mount_screw_thread_diameter = 3.5;    // Min = 1, Max = 6
mount_nut_width = 6;   // Max = 10
mount_nut_height = 2.5;   // Max = 5

//----------------- Mounting Srew Input Parameters, Default is M3x8 ---------------------------------
lock_screw_length = 8; 
lock_screw_thread_diameter = 3 * gain_adjust;
lock_nut_width = 5.5 * gain_adjust;
lock_nut_height = 2.4 * gain_adjust;

//----------------- Calculated Parameters
standoff_length = mount_screw_length - (mount_nut_height * gain_adjust) - plate_thickness - 2;
$fn=50;
width = 8; 
r_mount_screw = (mount_screw_thread_diameter * gain_adjust) / 2;      // Radius of the mounting screw threads
r_lock_screw = (lock_screw_thread_diameter * gain_adjust) / 2;
expand = 1;      // 0-x
long = 45;

din();
translate([0,0,50]) din();
cube([2,50,50]);

module din(){
	difference() {
		union() {
			hull() {
				translate([15+expand,long-2,0]) {
                    cylinder(h=width, r=2, center=false);}

                translate([12+expand,37.5,0]) {
                    cube([5,1,width], center=false);}

                translate([12+expand,long-1,0]) {
                    cube([1,1,width], center=false);}
            }

			hull() {
				translate([16+expand,35.7,0]) {
                    cylinder(h=width, r=1, center=false);}

                translate([14.2+expand,37.5,0]) {
                    cube([2.8,1,width], center=false);}
            }

			hull() {
				translate([18.5+expand,0.5,0]) {
                    cylinder(h=width, r=0.5, center=false);}
				translate([14.5+expand,3.8,0]) {
                    cylinder(h=width, r=0.3, center=false);}
				translate([14.2+expand,0,0]) {
                    cube([1,1,width], center=false);}
			}

			cube([3.5,4,width], center=false);
            cube([15+expand,2,width], center=false);

			hull() {
				translate([12+expand,4,0]) {
                    cylinder(h=width, r=1, center=false);}

                translate([0,3,0]) {
                    cube([1,1,width], center=false);}

                translate([0,long-1,0]) {
                    cube([13+expand,1,width], center=false);}
            }

			hull() {
            translate([0,40,0]) {
                cube([14,1,width], center=false);}

            translate([2,mount_hole_spacing+14,0]) {
                cylinder(h=width, r=2, center=false);}

            translate([6,mount_hole_spacing+14,0]) {
                cylinder(h=width, r=2, center=false);}
            }

            translate([-standoff_length,10.5-3.5,0]) {
                cube([standoff_length+1,7,width], center=false);}

            translate([-standoff_length,10.5-3.5+mount_hole_spacing,0]) {
                cube([standoff_length+1,7,width], center=false);}
        }
        // Clip fillet
        translate([3.5,2.5,-1]) {
            cylinder(h=width+2, r=0.5, center=false);}
        
        // Lock Screw and Nut
        translate([9+expand,-1,width/2]) rotate([-90,0,0]){
            cylinder(h=lock_screw_length+3, r=r_lock_screw, center=false);}

		translate([6.15+expand,5,-1]) {
            cube([5.7,lock_nut_height,width+2], center=false);}

        // 1. mount
        translate([-1-standoff_length,10.5,width/2]) rotate([0,90,0]){
            cylinder(h=standoff_length+8, r=r_mount_screw, center=false);}

		translate([2,7.65 - (((mount_nut_width * gain_adjust) - 5.7) / 2),-1]) {
            cube([mount_nut_height * gain_adjust,mount_nut_width * gain_adjust,width+2], center=false);}

        // 2. mount
        translate([-1-standoff_length,10.5+mount_hole_spacing,width/2]) rotate([0,90,0]){
            cylinder(h=standoff_length+8, r=r_mount_screw, center=false);}

		translate([2,7.65 - (((mount_nut_width * gain_adjust) - 5.7) / 2)+mount_hole_spacing,-1]) {
            cube([mount_nut_height * gain_adjust,mount_nut_width * gain_adjust,width+2], center=false);}
    }
}