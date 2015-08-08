// The base of the lumende lamp.

$fa=3;
$fs=1;

include<globals.scad>

height=60;
main_led_radius=20;
miniled_radius=2.5;

top();

module top() {
    heatsink(height-10);
    top_shell();
}

module top_shell() {
    difference() {
        top_shape(top_radius);
        translate([0,0,wall_thickness])
            top_shape(top_radius-wall_thickness);
        translate([0,0,height+bevel])
            cube([top_radius*3,top_radius*3,bevel*2],center=true);
    }
}

module top_shape(radius) {
    translate([0,0,bevel])
        minkowski() {
            cylinder(height-bevel, radius-bevel*2, radius-bevel*2);
            sphere(bevel);
        }
}

module heatsink(height) {
    intersection() {
        // Cut out any beveled edges.
        top_shape(top_radius);
        union() {
            // Draw a bunch of fins & miniLED's
            for(r=[0:num_fins]) {
                rotate(360*r/num_fins) {
                    // The fin
                    cube([fin_thickness, top_radius, height]);
                    // A mini LED.
                    translate([fin_thickness/2, main_led_radius*2, 0]) {
                        cylinder(height, miniled_radius, miniled_radius);
                    }
                }
            }
            cylinder(height, main_led_radius, main_led_radius);
        }
    }
}


// Modules related to the floor piece.

module base_cap(thickness, bevel, lip, diameter) {
    color(aluminium) {
        // Start with the basic lid.
        difference() {
            minkowski() {
                cylinder(thickness, diameter-bevel, diameter-bevel);
                sphere(bevel);
            }
            // Take off the bottom half
            translate([0,0,-bevel-1])
                cylinder(bevel+1, diameter+1, diameter+1);
            // Cut out the inside.
            translate([0,0,-1])
                cylinder(bevel+1-thickness, diameter-thickness*2, diameter-bevel-thickness);
            cylinder(bevel+thickness+1, pole_diameter, pole_diameter);
        }
        // Create the lip.
        translate([0,0,-lip+1]) {
            difference() {
                cylinder(lip+1, diameter-thickness, diameter-thickness);
                translate([0,0,-1])
                    cylinder(lip+3, diameter-thickness*2, diameter-thickness*2);
            }
        }
    }
}
