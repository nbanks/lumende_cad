// The base of the lumende lamp.

$fa=3;

include<globals.scad>

base();

module base() {
    height=base_height-wall_thickness-bevel;
    floor_piece(thickness=wall_thickness, height=height, radius=base_radius);
    translate([0,0,height])
        base_cap(thickness=wall_thickness, bevel=bevel, lip=3, radius=base_radius);
}

// Modules related to the floor piece.

module base_cap(thickness, bevel, lip, radius) {
    color(aluminium) {
        // Start with the basic lid.
        difference() {
            minkowski() {
                cylinder(thickness, radius-bevel, radius-bevel);
                sphere(bevel);
            }
            // Take off the bottom half
            translate([0,0,-bevel-1])
                cylinder(bevel+1, radius+1, radius+1);
            // Cut out the inside.
            translate([0,0,-1])
                cylinder(bevel+1-thickness, radius-thickness*2, radius-bevel-thickness);
            cylinder(bevel+thickness+1, pole_radius, pole_radius);
        }
        // Create the lip.
        translate([0,0,-lip+1]) {
            difference() {
                cylinder(lip+1, radius-thickness, radius-thickness);
                translate([0,0,-1])
                    cylinder(lip+3, radius-thickness*2, radius-thickness*2);
            }
        }
    }
}

module floor_piece(thickness, height, radius) {
    color(aluminium) {
        difference() {
            cylinder(height, radius, radius);
            translate([0,0,thickness])
                difference() {
                    cylinder(height, radius-thickness, radius-thickness);
                }
        }
        translate([0,0,thickness/2]) {
            difference() {
                cylinder(height-thickness/2, pole_radius+thickness, pole_radius+thickness);
                translate([0,0,-thickness/4])
                    cylinder(height, pole_radius, pole_radius);
            }
        }
    }
}
