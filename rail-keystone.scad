use <keystone.scad>;
use <MCAD/nuts_and_bolts.scad>;
$fn=256;

difference(){
  union(){
    translate([0,0,9.9]) rotate([0,180,0]) rj45Receiver();
    translate([-38,-2.5,0]) cube([20,30,3]);
     }
translate([-28.2,4,1]) boltHole(5.1,length=10);
translate([-28.2,22,1]) boltHole(5.1,length=10);
 }