// The base of the lumende lamp.

$fa=3;

// Various parameters
base_diameter=280;
pole_diameter=40;
thickness=2; // Thickness of all aluminum parts.
bevel=10; // The size of the bevel in mm.

floor_piece(thickness=thickness, height=80, diameter=base_diameter);
translate([0,0,80])
    base_cap(thickness=thickness, bevel=bevel, lip=10, diameter=base_diameter);

// Modules related to the floor piece.

module base_cap(thickness, bevel, lip, diameter) {
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
    translate([0,0,-lip+1])
        difference() {
            cylinder(lip+1, diameter-thickness, diameter-thickness);
            translate([0,0,-1])
                cylinder(lip+3, diameter-thickness*2, diameter-thickness*2);
        }
}

module floor_piece(thickness, height, diameter) {
    difference() {
        cylinder(height, diameter, diameter);
        translate([0,0,thickness])
            difference() {
                cylinder(height, diameter-thickness, diameter-thickness);
            }
    }
    translate([0,0,thickness/2])
        difference() {
            cylinder(height-thickness/2, pole_diameter+thickness, pole_diameter+thickness);
            translate([0,0,-thickness/4])
                cylinder(height, pole_diameter, pole_diameter);
        }
}