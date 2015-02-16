
$fn=250;

body_thickness = 5;
mag_height = 10;  // 2 x 5mm magnets

module ring(ra,ha,ta)
{
    difference(){
        cylinder(r=ra,h=ha);
        translate([0,0,-.1]) cylinder(r=ra-ta,h=ha+.2);
    }
}

module mags()
{
    translate([-50,0,0]) ring(12,mag_height,3);
    translate([ 50,0,0]) ring(12,mag_height,3);  
    
}

module rounded_triangle(tsize,theight)
{
    difference(){
      translate([0,0,0]) cylinder(r=tsize+50,h=theight,$fn=3);
      translate([0,0,-.1]) ring(tsize+50,theight+.2,10);
      }
}
        
module effector_body()
{
    cylinder(r=150,h=body_thickness,$fn=3);
    
    rotate([0,0,30]) translate ([-5,-62,body_thickness]) mags();
    rotate([0,0,30+120]) translate ([-5,-62,body_thickness]) mags();
    rotate([0,0,30+240]) translate ([-5,-62,body_thickness]) mags();
}


module effector_cuts()
{
    translate([0,0,-.1]) ring(150,body_thickness+.2,50);
    translate([0,0,-.1]) rounded_triangle(30,body_thickness+.2);
}

module hotend_mount()
{
    rounded_triangle(26,body_thickness);     
    rotate([0,0,30]) translate([-50,-50,body_thickness-1]) cube([100,20,1]); //hinge
}

module effector()
{
    difference(){
        effector_body();
        effector_cuts();
        }
    hotend_mount();  
    }
    
   
 effector();