use <microswitch.scad>
use <MCAD/nuts_and_bolts.scad>;
use <mount_e3d.scad>;
use <keystone.scad>;

centers = 50;

$fn=100;

body_thickness = 11.5;
mag_height = 10;  // 2 x 5mm magnets
mag_size = 10; //10.2;
top_mag_size = 10.2;
hotend_radius = 16;  // Hole for the hotend (J-Head diameter is 16mm).
mount_radius = 18.5;

module rounded_triangle(tsize,theight)
{
    difference(){
      translate([0,0,0]) cylinder(r=tsize,h=theight,$fn=3);
      translate([0,0,-.1]) ring(tsize+9,theight+.2,20);
      }
}

module ring(ra,ha,ta)
{
    difference(){
        cylinder(r=ra+ta,h=ha);
        translate([0,0,-.1]) cylinder(r=ra,h=ha+.2);
    }
}


module mag_body(x)
{
    translate([x,0,-body_thickness]) cylinder(r=(mag_size/2)+3,h=body_thickness);
    translate([x,0,0]) ring(mag_size/2,mag_height,3);
    translate([x,0,mag_height]) ring(top_mag_size/2,2.75+3.35,2);    
    
}

module mags_body()
{
    %translate([-25,0,0]) cube([1,1,10]);
    %translate([25,0,0]) cube([1,1,10]);
    rotate([0,-90,0]) translate([0,0,10]) mag_body(0);
    rotate([0,90,0])  translate([0,0,10]) mag_body(0);    
}

module holed_triangle(thesize,width,thickness)
{
    difference(){
        rounded_triangle(thesize,thickness);
        translate([0,0,-.1]) rounded_triangle(thesize-width,thickness+.2);
    }
}
    
module fan_mount()
{
    difference(){
     translate([-10,0,-1]) cube([20,6,10]);
     translate([-5,4,4]) rotate([270,0,180]) boltHole(3.1,length=12);
     translate([5,4,4])  rotate([270,0,180]) boltHole(3.1,length=12);
    }   
    translate([-10,2,-3]) cube([20,4,4]);
}

module inner_body()
{
   difference(){
        rotate([0,0,30])  translate([0,0,-6.5]) rounded_triangle(30,body_thickness+3); 
        translate([0, 0, -6.6])
            cylinder(r1=hotend_radius/2, r2=hotend_radius/2+1, h=body_thickness+1+3, $fn=36);
        rotate([0,0,60]) translate([0,15,-5]) boltHole(3.1,length=15);
        rotate([0,0,180]) translate([0,15,-5]) boltHole(3.1,length=15);
        rotate([0,0,300]) translate([0,15,-5]) boltHole(3.1,length=15);
        rotate([0,0,60]) translate([-3,27,-10]) cube([6,3,20]);
        }    
    
}

module main_body()
{
    difference(){
        rotate([0,0,30])  translate([0,0,-6.5]) holed_triangle(46,12,body_thickness+3);
        rotate([0,0,60]) translate([-7.5,40,-10])  cube([15,10,20]);
        rotate([0,0,180]) translate([-7.5,40,-10]) cube([15,10,20]);
        rotate([0,0,300]) translate([-7.5,40,-10]) cube([15,10,20]);
        rotate([0,0,60]) translate([0,38,0]) rotate([90,0,0]) boltHole(3.1, length=12);
        rotate([0,0,180]) translate([0,38,0]) rotate([90,0,0]) boltHole(3.1, length=12);
        rotate([0,0,300]) translate([0,38,0]) rotate([90,0,0]) boltHole(3.1, length=12);
        }   
}

module switch()
{
    rotate([0,0,240]) %translate([-3,-26,-15]) rotate([0,0,0]) microswitch(); 
    difference(){
        rotate([0,0,240]) translate([-11,-34,-19]) cube([19,5,13]); // Switch Block 
        rotate([0,0,240]) translate([-5-3,2.5-26,-14.5]) rotate([0,90,-90]) boltHole(3.1,length=12);
        rotate([0,0,240]) translate([ 5-3,2.5-26,-14.5]) rotate([0,90,-90]) boltHole(3.1,length=12);
        rotate([0,0,240]) translate([-5-3,2.5-35,-14.5]) rotate([0,90,-90]) nutHole(3.1,length=12);
        rotate([0,0,240]) translate([ 5-3,2.5-35,-14.5]) rotate([0,90,-90]) nutHole(3.1,length=12); 
    }           
}

module effector_complete()
{
    rotate([0,0,0])   translate([0,30,0]) mags_body();
    rotate([0,0,120]) translate([0,30,0]) mags_body();
    rotate([0,0,240]) translate([0,30,0]) mags_body();
 
    main_body();
    inner_body();
    switch();
    
    rotate([0,0,60]) translate([-24,-20,5]) cube([48,7,3]); //hinge   

    rotate([0,0,60]) translate([8,-62,6.5]) rotate([0,180,0]) rj45Receiver();
    rotate([0,0,120]) translate([0,37,4]) rotate([-60,0,0]) fan_mount();
    rotate([0,0,0]) translate([0,37,4]) rotate([-60,0,0]) fan_mount();
}

module effector()
{
      difference(){
          effector_complete();
          translate([-100,-100,7]) cube([200,200,3]);
          }
}

translate([0,0,7]) rotate([0,180,0]) effector();