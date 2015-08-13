// This file contains various variables and colours which are needed
// for more than one lamp part.

// The number and location of the large LED's
num_leds=5; // the number of large lamps
led_offset=88; // how far they are from the center (for over 1)


// Several sizes that define the look
base_radius=200;
base_height=45;
top_radius=200;
top_height=45;
pole_radius=20;
bevel=15;         // The size of the bevel in mm.

// Stuff that defines functionality
wall_thickness=2; // Thickness of all aluminum parts.
// Apparently cast aluminium shouldn't go under 1.5mm of thickness.
fin_thickness=1.5;  // For the heatsink.
num_fins = 20; // Number of heatsink fins.

// The colour of various materials (useful for debugging)

aluminium = "LightSteelBlue";
circuit_board = "green";
steel = "LightSlateGray";
