// The top & heatsink of the lumende lamp.

$fa=3;
$fs=1;

include<globals.scad>

height=top_height;
main_led_radius=20;
miniled_radius=2.5;

top();

module top() {
    full_heatsink(height-10);
    top_shell();
}

module top_shell() {
    color(aluminium)
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

module full_heatsink(height) {
    color(aluminium) {
        intersection() {
            // Cut out any beveled edges./
            top_shape(top_radius - wall_thickness/2);
            if (num_leds==1) {
                mini_heatsink(height);
            } else {
                for(i=[0:num_leds]) {
                    rotate(360*i/num_leds)
                        intersection() {
                            // This creates a prism wedge of the appropriate angle.
                            x=sin(180/num_leds)*top_radius*3;
                            y=cos(180/num_leds)*top_radius*3;
                            translate([0,0,-5]) {
                                linear_extrude(height+10) {
                                    // The pollygon's off because the polygon mesh
                                    // export likes a little overlap on the faces.
                                    polygon([[0,0],[-x-0.01,y],[0,top_radius*3],[x+0.01,y]]);
                                }
                            }
                            // Offset by a certain amount
                            translate([0, led_offset, 0])
                                mini_heatsink(height);
                        }
                }
            }
        }
    }
}

module mini_heatsink(height) {
    // The space between the center and mini LED's
    miniled_offset=45;

    union() {
        // Draw a bunch of fins & miniLED's
        for(r=[0:num_fins]) {
            rotate(360*r/num_fins) {
                // The fin
                translate([-fin_thickness/2, miniled_offset, 0]) {
                    cube([fin_thickness, top_radius, height]);
                }
                // A mini LED.
                translate([0, miniled_offset, 0]) {
                    cylinder(height, miniled_radius, miniled_radius);
                }
                translate([-fin_thickness, 0, 0]) {
                    cube([fin_thickness*2, miniled_offset, height]);
                }
            }
        }
        cylinder(height, main_led_radius, main_led_radius);
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
