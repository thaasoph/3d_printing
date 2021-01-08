$fn=100;

// Total length of the case
length = 150;

// Sides
sides = 6;


// Inner radius of the hexagon
inner_rad = 35;
outer_rad = inner_rad / cos(360 / (sides * 2));

// Minimum wall thickness
min_wall_thickness = 0.8;


rotate([-90, 0, 0]){
    cylinder($fn = sides, r = outer_rad, h = length+20);
    cylinder($fn = sides, r = outer_rad + min_wall_thickness, h = length);

    cylinder( r = inner_rad, h = length+10);
    
}