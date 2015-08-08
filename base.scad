// The base of the lumende lamp.

$fa=3;

// Various parameters
base_diameter=280;
pole_diameter=40;
thickness=2; // Thickness of all aluminum parts.

floor_piece(thickness=thickness, height=80, diameter=base_diameter);
translate([0,0,80])
    base_cap(thickness=thickness, height=50, diameter=base_diameter);

// Modules related to the floor piece.

module base_cap(thickness, height, diameter) {
    // 1/8 of the thickness comes from lowering the cone
    thickness=thickness*7/8;
    difference() {
        union() {
            translate([0, 0, thickness])
                cylinder(height, diameter, 0);
            cylinder(thickness, diameter, diameter);
        }
        // lower the cone.
        translate([0,0,-thickness/8])
            cylinder(height, diameter, 0);
        // room for the pole
        cylinder(height+thickness*2, pole_diameter, pole_diameter);
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