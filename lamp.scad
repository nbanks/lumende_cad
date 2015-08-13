include<globals.scad>
use<base.scad>
use<top.scad>

height=1700; // Actually the height of the pole, not the full thing.

base();
color(aluminium)
    cylinder(height-top_height, pole_radius-0.05, pole_radius-0.05);

translate([0, 0, height-top_height])
    top();
