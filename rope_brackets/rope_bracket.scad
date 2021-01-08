$fn=100;

// Total width of the bracket. Wider brackets can accomodated wider ropes or flat belts and distribute the force more evently on a greater area.
width = 10;

// Angle of the bracket. 60° Triangle, 90° Square, 108° Pentagon, 120° Hexagon or custom angle of your liking.
bracket_angle=120;


// Height of the side walls. They help to keep your rope or belt centered and prevent it from slipping off.
wall_height = 4;

// Thickness of the side walls. There is no particular load on these walls. But the thickness of the sidewalls determines how wide your rope or belt can be. => rope_width = width - (wall_thickness * 2)
wall_thickness = 3;

// Thickness of the wall that touches your part. A thicker bottom also increases the distance between your rope and your part if that is something you need.
bottom_thickness = 4;

// Diameter of the rounded edge in the groove. 
groove_edge_dia = 3;

// Length of the two straight arms of the bracket. Increase for larger parts but keep the size of your printing bed in mind.
arm_length=40;

// Diameter of the the hole in the corner of the bracket. Decrease if you need a sharp corner, increase if you want more wiggle room.
corner_hole_dia = 2;

// Width of the loop at the end of the two arms. Should be adjusted if you significantly increase or decrease the overall size of the bracket. Setting it to 0 effectively removes the loops.
loop_width=4;

// Offset to compensate large loops when the bottom_thickness is high. Use negative values to recess the loops into the part.
loop_offset=0;

module Loop(){
    translate([(bottom_thickness+wall_height)/2+loop_offset,0,width/2]){
rotate([90,0,0]){
linear_extrude(height = loop_width) {
   difference() {
     offset(delta  = wall_thickness) {
      Groove();
     }     
     Groove();
     square([bottom_thickness+wall_height,width+1], center=true);
   }}
}}

}

module Groove(){
    translate([bottom_thickness,0,0]) {
            minkowski() {
                square([                bottom_thickness+wall_height- groove_edge_dia,width - 2 * wall_thickness - groove_edge_dia], true);
                circle(d=groove_edge_dia);
            }
        }
}

module CrossSection(){    
    translate([(bottom_thickness+wall_height)/2,width/2,0]){
        
    difference(){
        square([bottom_thickness+wall_height,width], true);
        Groove();
        }
    }
}
difference(){

    union(){
        rotate_extrude(angle=180-bracket_angle, convexity = 10, $fn = 100){    
            CrossSection();
        }
        
        union(){
            
            translate([0,-(arm_length-loop_width),0]){
                Loop();
            }
            rotate([90,0,0]){
                linear_extrude(height=arm_length){ 
                    CrossSection();
                }
            }
        }
            
          
        rotate([0,0,180-bracket_angle]){
            union(){
                translate([0,0,width]){
                    rotate([-90,0,0]){
                        linear_extrude(height=arm_length){ 
                            CrossSection();
                        }
                    }
                }
                translate([0,arm_length,0]){
                    Loop();
                }
            }
        }
            
        } 
    
    
    translate([0,0,-1])
    cylinder(d=corner_hole_dia, h=width+2);

}




