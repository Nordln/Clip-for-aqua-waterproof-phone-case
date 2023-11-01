/* [Global settings] */

// Global rescaler (X*1mm)
rescaler = 1; 

// Min. facet render level (mm)
$fs = 0.1;  // Don't generate smaller facets than 0.1 mm

// Min angles render level (deg)
$fa = 5;    // Don't generate larger angles than 5 degrees

// Enable helper geometry
debug = false; // [True, False]

// Horiz. spacing between debug parts (mm)
debug_spacing_y = 10;

// Vert. spacing between debug parts (mm)
debug_spacing_z = 20; 


/* [catch dimensions] */

// Thickness of catch (mm)
catch_y = 3;

// Width of catch (mm)
catch_x = 4;

// Height of catch (mm)
catch_z = 11.2;


/* [handle dimensions] */

// Thickness of handle (mm)
handle_y = 3;

// Width of handle (mm)
handle_x = 14.8;

// Height of handle (mm)
handle_z = 10; 

//Diameter of catch (lrg half-sphere) (mm)
catch_dia = 14.8; 

/* [tube dimensions] */

// length of tube (mm)
tube_y = 13.5; //surface to surface 

// Diameter of tube (mm)
tube_d = 6.5;


/* [retainer dimensions] */

// Thickness of retainer (mm)
retainer_y = 2;

// Width of retainer (mm)
retainer_x = 2;

// visible length of retainer from tube (mm)
retainer_offset_z = 1.5;

// Location of retainer along tube, from catch (mm)
retainer_position_z = 3.5;

// Helpers
if (debug) helpers();



// Main geometry
// *************
color("Yellow") clip();


// Intermediate components
// ***********************

module clip() {
    translate([0,0-tube_y/2-handle_y/2,0]) handle();
    tube();
    translate([0,0+tube_y/2-handle_y/2-retainer_position_z,0]) retainer();
    translate([0,0+tube_y/2-handle_y/2,0]) catch();
}

// Core geometric primitives
// *************************

module handle() {

    color("Pink") translate([0,2.5,0]) difference() {
        hull(){
            translate([0,0,0]) sphere(catch_dia/2, $fa=5, $fs=0.1);
            translate([catch_dia*0.9,0,0]) sphere(catch_dia/4, $fa=5, $fs=0.1);
        }
        translate([0,catch_dia/2-1,0]) cube([catch_dia*3,catch_dia,15], center=true);
    }
}

module tube() {
   color("Red") rotate([90,0,0]) cylinder(h=tube_y, r1=(tube_d/2), r2=(tube_d/2), center=true);
}

module catch() {
    color("Green") intersection() {
        cube([catch_x,catch_y,catch_z], center=true);
        rotate([90,0,0]) cylinder(h=catch_y, r1=(catch_z/2), r2=(catch_z/2), center=true);
    }
}

module retainer() {
    //rotate([0,90,0]) cube([retainer_x,retainer_y,retainer_offset_z + tube_d], center=true);
    hull() {
        rotate([0,90,0]) 
            cube([retainer_x,0.1,retainer_offset_z + tube_d], center=true);
        translate([0,retainer_y/2,0]) 
                rotate([0,90,0]) 
                    cube([retainer_x,0.1,tube_d*0.9], center=true);
    }
}

// debug display 
module helpers() {
    
    translate([0, 0, debug_spacing_z * -1]) clip();
    
    translate([0, 0 - debug_spacing_y*2 - handle_y/2, debug_spacing_z * -2]) handle();
    translate([0, 0, debug_spacing_z * -2]) tube();
    translate([0, 0 + debug_spacing_y*2 - catch_y/2, debug_spacing_z * -2]) retainer();
    translate([0, 0 + debug_spacing_y*3 - catch_y/2, debug_spacing_z * -2]) catch();
}

echo(version=version());
// Written by Ed Watson <mail@edwardwatson.co.uk>
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

              