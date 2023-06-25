
$fn = 100;

module hexagon(size, height) {
  boxWidth = size/1.75;
  hull(){
    for (r = [-60, 0, 60])
      rotate([0,0,r])
        cube([boxWidth, size, height], true);
    }
  }
  
module box(x,y,x2,y2,z){
  translate([x2,y2,z/2])
    cube([x,y,z], center=true);
  }
  
module bore(x,y,r){
  translate([x,y,0])
    cylinder(h=500, r=r,center=true);
  }
  
module bore(x,y,r){
  translate([x,y,0])
    cylinder(h=500, r=r,center=true);
  }


/**/

/**

color("silver")
  
/**/

module arm(){
  difference(){
    union(){
      translate([-105/2,105/2,2.5])
        cylinder(h=5, r=9/2,center=true);
      translate([12.6,105/2,0])
        box(131,9,0,0,5);
      translate([75,0,0])
      hull(){
        box(7,9,0,105/2,1);
        translate([0,0,12])
          hull(){
            box(7,9,3.3,105/2,0.01);
            translate([0,0,2])
              box(5,7,4.86,105/2,.01);
            }
        }
      difference(){
        translate([0,0,5/2])
          cylinder(h=5, r=130/2,center=true);
        translate([0,-19,-1])
          box(200,135,0,0,10);
        }
      }
    union(){
      cylinder(h=20, r=117/2,center=true);
      bore(-105/2,105/2,2.5);
      bore(105/2,105/2,2.5);
      translate([87.5,105/2,4.8])
      rotate([0,105,0])  
        cylinder(h=500, r=2.25,center=true);
      }
    }
  }
arm();
              
/*Half Nut Assembly
module halfNutAssembly(){
  translate([0,-(hexNutLength+hexNutSupport)/2-sides -clearance,0])
  rotate([270,270+halfNutAngle,0])
  difference(){
    union(){
      union(){
        difference(){
          rotate([0,0,-halfNutAngle])
          hull(){
            difference(){
              resize([latchHeight*2+latchTopRadius, halfNutRadius*2])
                cylinder(h=halfNutHeight, r=halfNutRadius);
              translate([-center*2,-center,-center/2])
                cube([center*2,center*3,center*3]);
              }
            difference(){
              cylinder(h=halfNutHeight, r=halfNutRadius);
              translate([0,-center,-center/2])
                cube([center*2,center*3,center*3]);
              }
            }
          union(){
            translate([0,0,center/2+sides+hexNutSupport/2])
              hexagon(hexNutWidth,hexNutLength+clearance);
            translate([0,center/2,0])
              cube([center*3,center,center*4],center=true);
            rotate([90,0,-60])
              bore(0,hexNutLength/4+sides+hexNutSupport,halfNutSetScrew);
            rotate([90,0,-60])
              bore(0,hexNutLength/4*3+sides+hexNutSupport,halfNutSetScrew);
            rotate([90,0,-60])
            translate([0,hexNutLength/4+sides+hexNutSupport,22])
              cylinder(h=15,r=halfNutSetScrew*2);
            rotate([90,0,-60])
            translate([0,hexNutLength/4*3+sides+hexNutSupport,22])
              cylinder(h=15,r=halfNutSetScrew*2);
            }
          }
        hull(){
          translate([latchHeight+latchTopRadius*2.5,0,sides+clearance])
            cylinder(h=hexNutLength+hexNutSupport, r=latchTopRadius);
          translate([latchHeight,0,sides+clearance])
            cylinder(h=hexNutLength+hexNutSupport, r=latchTopRadius);
          }
        }
      translate([latchHeight,0,sides+clearance])
        cylinder(h=hexNutLength+hexNutSupport, r=latchTopRadius);
      }
    translate([0,0,-0.01])
    hull(){
      cylinder(h=sides+clearance, r=latchRadius+clearance/2);
      translate([latchHeight,0,0])
        cylinder(h=sides+clearance, r=latchTopRadius+clearance/2);
      }
    translate([0,0,sides+center+0.01-clearance])
    hull(){
      cylinder(h=sides+clearance, r=latchRadius+clearance/2);
      translate([latchHeight,0,0])
        cylinder(h=sides+clearance, r=latchTopRadius+clearance/2);
      }
    bore(0,0,latchBore);
    //latching bore
    bore(latchHeight,0,latchTopBore);
    }
  }
halfNutAssembly();*/