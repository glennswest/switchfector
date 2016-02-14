use <keystone.scad>;
use <MCAD/nuts_and_bolts.scad>;

module rj_body()
{
translate([-18,0,0]) cube([18,11+17,5]);
translate([0,9.8,29]) rotate([-270,180,0])  rj45Receiver();
}


module rj_cuts()
{
    translate([-4,23,0]) boltHole(3.4,length=8);
    translate([-14,23,0]) boltHole(3.4,length=8);
    translate([-4,23,4]) nutHole(3.4,length=8);
    translate([-14,23,4]) nutHole(3.4,length=8);
    
}

difference(){
    rj_body();
    rj_cuts();
}