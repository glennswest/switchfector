use <microswitch.scad>
use <MCAD/nuts_and_bolts.scad>;
use <mount_e3d.scad>;

$fn=250;

body_thickness = 5;
mag_height = 10;  // 2 x 5mm magnets
hotend_radius = 14;  // Hole for the hotend (J-Head diameter is 16mm).
mount_radius = 18.5;

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


module mag_screws()
{
    translate([-50,0,6]) rotate([0,180,0])  boltHole(3.1,length=8);
    translate([ 50,0,6]) rotate([0,180,0])  boltHole(3.1,length=8);
    translate([-50,0,3]) rotate([0,180,0])  nutHole(3.5);
    translate([ 50,0,3]) rotate([0,180,0])  nutHole(3.5);
    
}
module effector_cuts()
{
    translate([0,0,-.1]) ring(150,body_thickness+.2,50);
    translate([0,0,-.1]) rounded_triangle(30,body_thickness+.2);
    
    rotate([0,0,30])     translate([-5,-62,body_thickness-6]) mag_screws();
    rotate([0,0,30+120]) translate([-5,-62,body_thickness-6]) mag_screws();
    rotate([0,0,30+240]) translate([-5,-62,body_thickness-6]) mag_screws();
    
    
   
}

module hotend_body()
{
     rounded_triangle(26,body_thickness);     
     rotate([0,0,30]) translate([-50,-50,body_thickness-1]) cube([100,20,1]); //hinge    
    
}

module hotend_cuts()
{
     translate([0, 0, 0])
        cylinder(r1=hotend_radius/2, r2=hotend_radius/2+1, h=body_thickness+1, $fn=36);
    for (a = [0:120:359]) rotate([0, 0, a]) {
      translate([0, mount_radius, body_thickness-1])
            rotate([0,180,0])  boltHole(3.1,length=8); 
      }
}

module hotend_mount()
{
    difference(){
        hotend_body();
        hotend_cuts();
        }
}

module effector()
{
    difference(){
        effector_body();
        effector_cuts();
        }
    hotend_mount();  
    rotate([0,0,120]) %translate([61,-3,13]) rotate([180,0,90]) microswitch();
    difference(){
       rotate([0,0,120]) translate([64,-14,5]) cube([5,30,10]);
       rotate([0,0,120]) translate([63.9,-7.9,5]) cube([5.2,16.2,4]);
       rotate([0,0,120]) translate([60,-7.6,12.8]) rotate([0,90,0])  boltHole(3.1,length=14);
       rotate([0,0,120]) translate([60,1.3,12.8]) rotate([0,90,0])  boltHole(3.1,length=14); 
    }
    }
    
   
 effector();
 %translate([0,0,-5]) mount();