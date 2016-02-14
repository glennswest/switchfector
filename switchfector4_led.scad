use <MCAD/nuts_and_bolts.scad>;

theheight = 30;
ledring = 83;
ledthick = 9;
ledheight = 9;
$fn = 256;

module ring(ra,ha,ta)
{
    difference(){
        cylinder(r=ra+ta,h=ha);
        translate([0,0,-.1]) cylinder(r=ra,h=ha+.2);
    }
}



module led_body()
{
translate([-18,0,0]) cube([18,11+17,5]);
translate([-18,0,5]) cube([18,15,theheight-5+ledheight]);

}


module led_cuts()
{
    translate([-4,23,0]) boltHole(3.4,length=8);
    translate([-14,23,0]) boltHole(3.4,length=8);
    translate([-4,23,4]) nutHole(3.4,length=8);
    translate([-14,23,4]) nutHole(3.4,length=8);
    translate([-18+10,53,theheight-4]) ring(ledring/2,ledheight+5,ledthick);
    translate([-9,0.5,35]) rotate([270,0,0]) boltHole(3.5,length=20);
    translate([-9,14,35]) rotate([270,0,0]) nutHole(3);
    
}

difference(){
    led_body();
    led_cuts();
}