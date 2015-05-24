use <fan_holder_v2.scad>;
use <MCAD/nuts_and_bolts.scad>;
use <pie.scad>;

module pipe(size,thickness,length)
{
        difference(){
            cylinder(r=size/2,h=length);
            cylinder(r=(size-thickness)/2,h=length);
        }
    
}


module tube(x,y,z,thickness)
{
        difference(){
            cube([x,y,z]);
            translate([thickness/2,thickness/2,-.1]) cube([x-thickness,y-thickness,z+.2]);
        }
    
}

module arc(size,slice,height,thickness=1,extraspin=0)
{
    $fn=500;
    thespin = 0 - slice / 2+extraspin;
    difference(){
        pie(size,slice,height,spin=thespin);
        translate([0,0,-.1]) rotate([0,0,-.1]) pie(size-thickness,slice+.2,height+.2,spin=thespin);
    }
    
}

module closed_arc(size,slice,height,thickness=0)
{
    thespin = 0-(slice/2);
    offset = 0 - size / 2 + (2 * thickness);
    difference(){
       translate([0,0,0]) pie(size,slice,height,spin=thespin);
       translate([offset-thickness,thespin,-.1]) cube([slice,slice,height+.2]);
    }
}

module cube_hole(thesize,thehole,thickness)
{
    difference(){
       translate([0-thesize/2,0-thesize/2,0]) cube([thesize,thesize,thickness]);
       translate([0,0,-.1]) cylinder(r=thehole/2,h=thickness+.2);
    }
}

module halfsphere(thesize)
 {
     difference(){
        sphere(thesize);
        sphere(thesize-1);
        translate([0-thesize,0-thesize,0-thesize/8]) cube([thesize*2,thesize*2,thesize*2]);
        } 
 }
 
 module openbox(x,y,z)
 {
     difference(){
         cube([x,y,z]);
         translate([1,1,1]) cube([x-2,y-2,z+2]);
     }
 }
 
module fan_screws()
{
       translate([.1,-20,-5]) rotate([0,90,0])  boltHole(3,length=10); 
       translate([4,-20,-5]) rotate([0,90,0])  nutHole(3);
       translate([5,-20,-5]) rotate([0,90,0])  nutHole(3);
       translate([.1,20,-5]) rotate([0,90,0])  boltHole(3,length=10); 
       translate([4,20,-5]) rotate([0,90,0])  nutHole(3);
       translate([5,20,-5]) rotate([0,90,0])  nutHole(3);
        
       translate([.1,-20,-45]) rotate([0,90,0])  boltHole(3,length=10); 
       translate([4,-20,-45]) rotate([0,90,0])  nutHole(3);
       translate([5,-20,-45]) rotate([0,90,0])  nutHole(3);
       translate([.1,20,-45]) rotate([0,90,0])  boltHole(3,length=10); 
       translate([4,20,-45]) rotate([0,90,0])  nutHole(3);
       translate([5,20,-45]) rotate([0,90,0])  nutHole(3);        
    
}
module fan_holder()
{
    difference(){
        union(){
            translate([0,-25,0]) rotate([0,90,0]) fan_mount(size=50,thick=3);;
            translate([3,-15,-12]) cube([18,30,3]);
            translate([0,-25,0]) rotate([0,90,0]) cube([12,50,3]);
            translate([-40.2,0,-50]) arc(50,60,50);
            translate([-40,0,-2]) closed_arc(50,60,2,5);
           //translate([-40,0,-50]) closed_arc(50,60,2,5);
             translate([3,-20,-45]) rotate([0,90,0]) cylinder(r=3.5,h=3);
             translate([3, 20,-45]) rotate([0,90,0]) cylinder(r=3.5,h=3);
             //translate([0,-25,-55]) cube([20,50,1]);
             translate([0,-25,-50]) rotate([0,90,0]) tube(6,50,20,1); 
             translate([0,-25,-56])  cube([1,50,7]);
             translate([23,-25,-56])  rotate([0,-45,0]) cube([1,50,7]); 
            }
       translate([-41,0,-52]) arc(50,41,7,5);
       translate([8.5+8,2-12,-9])  rotate([0,180,0]) boltHole(3,length=10);
       translate([8.5+8,22-12,-9]) rotate([0,180,0]) boltHole(3,length=10);
       translate([8.5+8,2-12,-11.5])  rotate([0,180,0]) nutHole(3);
       translate([8.5+8,22-12,-11.5]) rotate([0,180,0]) nutHole(3);
       
       //translate([4,-21,-30]) rotate([0,90,0]) cube([9,9,10]); 
       //translate([4, 10,-30]) rotate([0,90,0]) cube([9,9,10]);
       fan_screws();
        
       }
 }
 
 
 
 
 module director(rot)
 {
     translate([4,4,19]) rotate([rot,180-90+50,0]) halfsphere(6);
     tube(10,10,15,1);
//     translate([5,5,15]) arc(5,270,8,1,extraspin=-140);
     translate([5,5,15]) cube_hole(10,9,2);
//     translate([5,5,22]) cylinder(r=5,h=1);
    
} 

 
module partcooler_body()
{
   fan_holder();
   // translate([5,-22,-30]) rotate([0,90,0]) director(-50);
   //translate([5, 10,-30]) rotate([0,90,0]) director(50);
   //translate([5, 10,-30]) rotate([0,90,0]) tube(10,10,15,1);
   //translate([25,-22+5,-35]) rotate([0,270,0]) arc(5,270,8,1,extraspin=-40);
} 

partcooler_body();