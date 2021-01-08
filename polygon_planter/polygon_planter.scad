$fn=100;

// Height
height = 115;

// Sides
sides = 4;

// Side length
top_side_length    = 138;
bottom_side_length = 95;

// Radius
top_radius    = (top_side_length    / 2) / sin( 360 / sides / 2 );
bottom_radius = (bottom_side_length / 2) / sin( 360 / sides / 2 );

// Drain hole diameter
drain_hole_dia = 10;

// Drain hole population density
drain_hole_pop_density = 0.3;

//Wall thickness
wall_thickness = 1.6;

// Apothem
bottom_inner_apothem = bottom_side_length / ( 2 * tan(180 / sides) ) - wall_thickness;

difference(){
    cylinder($fn = sides, r1 = bottom_radius, r2 = top_radius, h = height);
    translate([0,0,wall_thickness]){
        cylinder($fn = sides, r1 = bottom_radius - wall_thickness , r2 = top_radius - wall_thickness,h = height);
    }
   
    drain_hole_path_r = bottom_inner_apothem * 0.75;
    number_drain_holes = round( ( 2 * PI * drain_hole_path_r ) / drain_hole_dia * drain_hole_pop_density );
    
    for (i=[1:number_drain_holes])  {
        translate([drain_hole_path_r*cos(i*(360/number_drain_holes)), drain_hole_path_r*sin(i*(360/number_drain_holes)),-0.1]) cylinder(d=drain_hole_dia, h=wall_thickness+0.2);
    }
}