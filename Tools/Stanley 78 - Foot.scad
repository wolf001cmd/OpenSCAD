$fn=100;

difference(){
  union(){
    translate([-14,0,1])
      hull(){
        cube([28,8,1]);
        translate([4,0,29])
          cube([20,8,1]);
        translate([5,0,30])
          cube([18,8,1]);
        }
      hull(){
        translate([-8.7,0,14])
          rotate([0,0,45])
            cube([2.3,2.3,24], center=true);
        translate([-8.7,1.7,14])
          rotate([0,0,45])
            cube([2.3,2.3,27.5], center=true);
        }
    translate([5,6.5,1])
      minkowski(){
        hull(){
          translate([0,0,2])
            cube([60,11,.01], center=true);
          cube([55,11,1], center=true);
          }
        rotate([90,0,0])
          cylinder(r=0.5,h=1);
        }
    }
  union(){
    hull(){
      translate([0,0,25])
        rotate([90,0,0])
          cylinder(r=2.5, h=12, center=true);
      translate([0,0,8])
        rotate([90,0,0])
          cylinder(r=2.5, h=12, center=true);
      }
    translate([0,11,0])
      hull(){
        translate([0,0,25])
          rotate([90,0,0])
            cylinder(r=4.1, h=12, center=true);
        translate([0,0,8])
          rotate([90,0,0])
            cylinder(r=4.1, h=12, center=true);
        }
    }
  }