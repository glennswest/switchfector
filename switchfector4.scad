use <microswitch.scad>
use <MCAD/nuts_and_bolts.scad>;
use <mount_e3d.scad>;

$fn=125;

body_thickness = 5;
mag_height = 10;  // 2 x 5mm magnets
mag_size = 11.2;
hotend_radius = 16.1;  // Hole for the hotend (J-Head diameter is 16mm).
mount_radius = 18.5;


module ring(ra,ha,ta)
{
    difference(){
        cylinder(r=ra+ta,h=ha);
        translate([0,0,-.1]) cylinder(r=ra,h=ha+.2);
    }
}

module mags()
{
    difference(){
        mags_body();
        mag_body_screws();
        }
    
}

module mags_body()
{
    translate([-25,0,-body_thickness]) cylinder(r=(mag_size/2)+1,h=body_thickness);
    //translate([-25,0,0]) ring(mag_size/2,mag_height,1);
    translate([ 25,0,-body_thickness]) cylinder(r=(mag_size/2)+1,h=body_thickness);
    //translate([ 25,0,0]) ring(mag_size/2,mag_height,1);  
    
}

module mag_body_screws()
{
   translate([-25,0,1]) rotate([0,180,0])  boltHole(3.4,length=12);
   translate([ 25,0,body_thickness]) rotate([0,180,0])  boltHole(3.4,length=12);
   translate([-25,0,3]) rotate([0,180,0])  nutHole(3.5);
   translate([ 25,0,3]) rotate([0,180,0])  nutHole(3.5);
 
    
}

module mag_cuts()
{
    translate([-25,0,-body_thickness]) cylinder(r=mag_size/2,h=body_thickness);
    translate([-25,0,0]) ring(mag_size/2,mag_height,1);
    translate([ 25,0,-body_thickness]) cylinder(r=mag_size/2,h=body_thickness);
    translate([ 25,0,0]) ring(mag_size/2,mag_height,1);  
    
}


module rounded_triangle(tsize,theight)
{
    difference(){
      translate([0,0,0]) cylinder(r=tsize,h=theight,$fn=3);
      translate([0,0,-.1]) ring(tsize+9,theight+.2,20);
      }
}
        
module effector_body()
{ 
    difference(){
      cylinder(r=70,h=body_thickness,$fn=3);
      mag_mounts_cuts();
      }  
    mag_mounts(); 
       
   
}

module mag_mounts()
{
   rotate([0,0,30])     translate ([0,-37.5,body_thickness]) mags();
   rotate([0,0,30+120])  translate ([0,-37.5,body_thickness]) mags();
   rotate([0,0,30+240])  translate ([0,-37.5,body_thickness]) mags();    
    
}

module mag_mounts_cuts()
{
   rotate([0,0,30])      translate ([0,-37.5,body_thickness]) mag_cuts();
   rotate([0,0,30+120])  translate ([0,-37.5,body_thickness]) mag_cuts();
   rotate([0,0,30+240])  translate ([0,-37.5,body_thickness]) mag_cuts();    
    
}
module mag_screws()
{
   
    translate([-10,2.5,body_thickness+.3]) rotate([0,180,0]) boltHole(3.4,length=12);
    translate([ 10,2.5,body_thickness+.3]) rotate([0,180,0]) boltHole(3.4,length=12);
 
    translate([-10,2.5,2]) rotate([0,180,0]) nutHole(3.4,length=12);
    translate([ 10,2.5,2]) rotate([0,180,0]) nutHole(3.4,length=12);
   
}
module effector_cuts()
{
    translate([0,0,-.1]) ring(62,body_thickness+.2,20);
    translate([0,0,-.1]) rounded_triangle(53,body_thickness+.2);
    
    rotate([0,0,30])     translate([0,-33.5,body_thickness-6]) mag_screws();
    rotate([0,0,30+120]) translate([0,-33.5,body_thickness-6]) mag_screws();
    rotate([0,0,30+240]) translate([0,-33.5,body_thickness-6]) mag_screws();
    
    
   
}

module hotend_body()
{
     cylinder(r=55,h=body_thickness,$fn=3);
     //rounded_triangle(55,body_thickness);     
     //rotate([0,0,30]) translate([-28,-30,0]) cube([56,10,1]); //hinge 
       
    
}

module hotend_cuts()
{
     translate([0, 0, 0])
        cylinder(r1=hotend_radius/2, r2=hotend_radius/2+1, h=body_thickness+1, $fn=36);
    //translate([0,0,-.1]) ring(45,body_thickness+.2,5);
    for (a = [0:120:359]) rotate([0, 0, a+30]) {
      translate([0, mount_radius, body_thickness-1])
            rotate([0,180,0])  boltHole(3.4,length=8); 
      }
    rotate([0,0,90]) translate([0,mount_radius+3,0])  boltHole(5.4,length=9);
    rotate([0,0,90+120+60]) translate([0,mount_radius+20,0])  cylinder(r=10,h=9);  // Sensor
    rotate([0,0,90+120+60+120]) translate([+5,mount_radius+23,0])  boltHole(3.4,length=9);
    rotate([0,0,90+120+60+120]) translate([-5,mount_radius+23,0])  boltHole(3.4,length=9);
    rotate([0,0,90+120+60+240]) translate([+5,mount_radius+23,0])  boltHole(3.4,length=9);
    rotate([0,0,90+120+60+240]) translate([-5,mount_radius+23,0])  boltHole(3.4,length=9);    
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
        rotate([0,0,90+120+60]) translate([0,mount_radius+20,0])  cylinder(r=10,h=9);  // Sensor 
        rotate([0,0,90+120+60+120]) translate([+5,mount_radius+32,0])  boltHole(3.4,length=9);
        rotate([0,0,90+120+60+120]) translate([-5,mount_radius+32,0])  boltHole(3.4,length=9);
        rotate([0,0,90+120+60+240]) translate([+5,mount_radius+32,0])  boltHole(3.4,length=9);
        rotate([0,0,90+120+60+240]) translate([-5,mount_radius+32,0])  boltHole(3.4,length=9);   
        //mag_cuts();
        }
    hotend_mount();    
    }
    

  
 effector();
%translate([0,0,-5]) rotate([0,0,150]) mount();