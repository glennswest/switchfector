use <MCAD/nuts_and_bolts.scad>;

jhead_height = 6.0; 

centers = 50;

$fn=100;



top_mag_size = 10.3;
hotend_radius = 12;  // Hole for the hotend (J-Head diameter is 16mm).
mount_radius = 18.5;

module rounded_triangle(tsize,theight)
{
    difference(){
      translate([0,0,0]) cylinder(r=tsize,h=theight,$fn=3);
      translate([0,0,-.1]) ring(tsize-6,theight+.2,20);
      }
}

module ring(ra,ha,ta)
{
    difference(){
        cylinder(r=ra+ta,h=ha);
        translate([0,0,-.1]) cylinder(r=ra,h=ha+.2);
    }
}



module holed_triangle(thesize,width,thickness)
{
    difference(){
        rounded_triangle(thesize,thickness);
        translate([0,0,-.1]) rounded_triangle(thesize-width,thickness+.2);
    }
}
    


module e3d_mount()
{
   difference(){
        rotate([0,0,30])  translate([0,0,-6.5]) rounded_triangle(25,jhead_height); 
        translate([0, 0, -6.6])
            cylinder(r=hotend_radius/2 , h=jhead_height+.2, $fn=36);
        rotate([0,0,120+90]) translate([0, -hotend_radius/2, -6.6])
             cube([20,hotend_radius,jhead_height+.2]);
        rotate([0,0,60]) translate([0,15,-6.6]) boltHole(3.1,length=15);
        rotate([0,0,180]) translate([0,15,-6.6]) boltHole(3.1,length=15);
        rotate([0,0,300]) translate([0,15,-6.6]) boltHole(3.1,length=15);
        rotate([0,0,60]) translate([0,15,-6.6]) nutHole(3.1,length=15);
        rotate([0,0,180]) translate([0,15,-6.6]) nutHole(3.1,length=15);
        rotate([0,0,300]) translate([0,15,-6.6]) nutHole(3.1,length=15);
        rotate([0,0,60]) translate([-3,27,-10]) cube([6,3,20]);
        }    
    
}

e3d_mount();

