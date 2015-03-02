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
    translate([-25,0,-body_thickness]) cylinder(r=12,h=body_thickness);
    translate([-25,0,0]) ring(12,mag_height,3);
    translate([ 25,0,-body_thickness]) cylinder(r=12,h=body_thickness);
    translate([ 25,0,0]) ring(12,mag_height,3);  
    
}

module rounded_triangle(tsize,theight)
{
    difference(){
      translate([0,0,0]) cylinder(r=tsize,h=theight,$fn=3);
      translate([0,0,-.1]) ring(tsize,theight+.2,10);
      }
}
        
module effector_body()
{
    cylinder(r=70,h=body_thickness,$fn=3);
    
    rotate([0,0,30])     translate ([0,-41.5,body_thickness]) mags();
   rotate([0,0,30+120])  translate ([0,-41.5,body_thickness]) mags();
   rotate([0,0,30+240])  translate ([0,-41.5,body_thickness]) mags();
}


module mag_screws()
{
    translate([-25,0,body_thickness]) rotate([0,180,0])  boltHole(3.1,length=12);
    translate([ 25,0,body_thickness]) rotate([0,180,0])  boltHole(3.1,length=12);
    translate([-25,0,3]) rotate([0,180,0])  nutHole(3.5);
    translate([ 25,0,3]) rotate([0,180,0])  nutHole(3.5);
   // translate([-30,6,body_thickness+.3]) rotate([0,180,0]) boltHole(3.1,length=12);
    translate([-10,6+4.5,body_thickness+.3]) rotate([0,180,0]) boltHole(3.1,length=12);
    translate([ 10,6+4.5,body_thickness+.3]) rotate([0,180,0]) boltHole(3.1,length=12);
  //  translate([ 30,6,body_thickness+.3]) rotate([0,180,0]) boltHole(3.1,length=12); 
   // translate([-30,6,2]) rotate([0,180,0]) nutHole(3.1,length=12);
    translate([-10,6+4.5,2]) rotate([0,180,0]) nutHole(3.1,length=12);
    translate([ 10,6+4.5,2]) rotate([0,180,0]) nutHole(3.1,length=12);
   // translate([ 30,6,2]) rotate([0,180,0]) nutHole(3.1,length=12); 
}
module effector_cuts()
{
    translate([0,0,-.1]) ring(80,body_thickness+.2,20);
    translate([0,0,-.1]) rounded_triangle(53,body_thickness+.2);
    
    rotate([0,0,30])     translate([0,-41,body_thickness-6]) mag_screws();
    rotate([0,0,30+120]) translate([0,-41,body_thickness-6]) mag_screws();
    rotate([0,0,30+240]) translate([0,-41,body_thickness-6]) mag_screws();
    
    
   
}

module hotend_body()
{
     rounded_triangle(50,body_thickness);     
     rotate([0,0,30]) translate([-28,-30,0]) cube([56,10,1]); //hinge    
    
}

module hotend_cuts()
{
     translate([0, 0, 0])
        cylinder(r1=hotend_radius/2, r2=hotend_radius/2+1, h=body_thickness+1, $fn=36);
    for (a = [0:120:359]) rotate([0, 0, a+30]) {
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
    rotate([0,0,120]) %translate([41-4,-3+2,13]) rotate([180,0,90]) microswitch();
    difference(){
       rotate([0,0,120]) translate([44-4,-14+2,5]) cube([5,24,14]); // Switch Block
       
       rotate([0,0,120]) translate([38,-7.6+2,12.8]) rotate([0,90,0])  boltHole(3.1,length=15);
       rotate([0,0,120]) translate([38,1.3+2,12.8]) rotate([0,90,0])  boltHole(3.1,length=15); 
       rotate([0,0,120]) translate([47,-7.6,12.8]) rotate([0,90,0])  nutHole(3.1);
       rotate([0,0,120]) translate([47,1.3,12.8]) rotate([0,90,0])   nutHole(3.1);  
    }
    }
    

  
 effector();
%translate([0,0,-5]) rotate([0,0,150]) mount();