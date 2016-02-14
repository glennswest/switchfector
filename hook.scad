

difference(){
    cube([20,5,8]);
    translate([15,6,4]) rotate([90,0,0]) cylinder(r=1.5,h=8,$fn=100);  
    }
difference(){
  translate([3,-5.5,0]) cylinder(r=8,h=8,$fn=100);
  translate([3,-5.5,-.1]) cylinder(r=6,h=8.2,$fn=100);
  translate([4,-5,-.1]) cube([15,5,8.2]);
  
}