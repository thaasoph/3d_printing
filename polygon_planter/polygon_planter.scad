$fn=100;

// Height
height = 150;

// Sides
sides = 4;

// Side length
top_side_length = 100;
bottom_side_length = 80;

// Radius
top_radius = (top_side_length / 2) / sin( 360 / sides / 2 );
bottom_radius = (bottom_side_length / 2) / sin( 360 / sides / 2 );

//Wall thickness
wall_thickness = 1.6;

// Apothem
bottom_inner_apothem = bottom_side_length / ( 2 * tan(180 / sides) ) - wall_thickness;

difference(){
    cylinder($fn = sides, r1 = bottom_radius, r2 = top_radius, h = height);
    translate([0,0,wall_thickness]){
        cylinder($fn = sides, r1 = bottom_radius - wall_thickness , r2 = top_radius - wall_thickness,h = height);
    }
}


