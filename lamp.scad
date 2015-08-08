include<globals.scad>
use<base.scad>
use<top.scad>

height=1700; // Actually the height of the pole, not the full thing.

base();
color(aluminium)
    cylinder(height, pole_radius, pole_radius);
translate([0,0,height-top_height])
    top();
