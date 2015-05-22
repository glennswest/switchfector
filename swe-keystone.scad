use <keystone.scad>;
use <MCAD/nuts_and_bolts.scad>;

difference(){
  union(){
    translate([0,0,9.9]) rotate([0,180,0]) rj45Receiver();
    translate([-27,-2.5,0]) cube([10,30,3]);
     }
translate([-22,2,1]) boltHole(3,length=10);
translate([-22,22,1]) boltHole(3,length=10);
 }