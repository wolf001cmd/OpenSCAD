
$fn = 90;

module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60])
    rotate([0,0,r])
      cube([boxWidth, size, height], true);
  }

module bore(x,y,r,z=500){
  translate([x,y,-z/2])
    cylinder(h=z, r=r);
  }

module bore4(x, y, r, z=500){
  translate([-x/2, -y/2, 0])
  union(){
    bore(0, 0, r, z);
    bore(x, 0, r, z);
    bore(0, y, r, z);
    bore(x, y, r, z);
    }
  }

module nema17(r){
  bore4(31, 31, r);
  }

module box(x,y,x2,y2,z){
  translate([x2,y2,z/2])
    cube([x,y,z], center=true);
  }
module chamferedBox(x,y,z,c){
  hull(){
    box(x,y-c,0,0,z);
    box(x-c,y,0,0,z);
    }
  }
module cone(r, r2, h){
  hull(){      
    translate([0,0,0])
      cylinder(h=0.01,r=r);   
    translate([0,0,h])
      cylinder(h=0.01,r=r2);   
    }
  }

/* */

module cylinder4(x,y,h,r){
  x=x/2;
  y=y/2;
  union(){
      translate([x,y,0])
        cylinder(r=r,h=h);
      translate([x,-y,0])
        cylinder(r=r,h=h);
      translate([-x,y,0])
        cylinder(r=r,h=h);
      translate([-x,-y,0])
        cylinder(r=r,h=h);
    }
  }
  
module hexagon4(x,y,h,r){
  x=x/2;
  y=y/2;
  union(){
      translate([x,y,0])
        hexagon(r,h);
      translate([x,-y,0])
        hexagon(r,h);
      translate([-x,y,0])
        hexagon(r,h);
      translate([-x,-y,0])
        hexagon(r,h);
    }
  }

/* */

X=130;
Y=120;
Z=4;
chamfer=4;
boreInset=15; 
  
screenX=79;
screenY=52;
screenXOffset=-9.5;
screenYOffset=4.5;

boltX=88;
boltY=65;

controllerX=96;
controllerY=61.2;

sideTrim=6;
sideX=54;

/* Joystick */

difference(){
  union(){
    hull(){
      chamferedBox(84,84,40-chamfer,chamfer);
      chamferedBox(84-chamfer,84-chamfer,40,chamfer);
      }
    }
  union(){
    bore(0,0,38.5/2);
    translate([0,0,-chamfer])
      chamferedBox(84-chamfer*4,84-chamfer*2,40+1,chamfer);
    bore4(32.5,32.5,1.75);
    bore(29,29,3.25);
    translate([0,0,-chamfer])
      cylinder4(76,65,15,1.5);
    translate([0,60,10])
    rotate([90,0,0])
      cylinder(r=5,h=80);
    }
  }

/* Front *
        
difference(){
  union(){
    hull(){
      chamferedBox(X,Y,Z/2,chamfer);
      chamferedBox(X-chamfer,Y-chamfer,Z,chamfer);
      }
    translate([screenXOffset,screenYOffset,-5])
      cylinder4(boltX,boltY,6,3);
    }
  union(){
    bore(X/2-boreInset-3,0,7.93);
    bore4(X-boreInset,Y-boreInset,2.1);
    translate([0,0,2.5])
      cylinder4(X-boreInset,Y-boreInset,6,4);
    translate([0,0,-18.5])
      difference(){
        box(X-12,Y-12,0,0,20);
        translate([0,0,-5])
          box(X-17,Y-17,0,0,30);
        }
    translate([screenXOffset,screenYOffset,0])
    union(){
      translate([0,0,-10])
        box(screenX,screenY,0,0,20);
      translate([0,0,3])
        hull(){
          box(screenX,screenY,0,0,4);
          translate([0,0,4])
            box(screenX+chamfer,screenY+chamfer,0,0,1);
          }
      translate([0,0,-6])
        cylinder4(boltX,boltY,6,1.5);
      bore(36,-44,4);
      bore(3,-43,5);
      translate([0,0,-1])
        box(screenX+10,screenY,0,0,3);
      } 
    }
  }

/* Back *
  
translate([0,0,-sideX-chamfer])
difference(){
  union(){
    hull(){
      translate([0,0,Z/2])
        chamferedBox(X,Y,Z/2,chamfer);
      chamferedBox(X-chamfer,Y-chamfer,Z,chamfer);
      }
    translate([0,-5,1])
      cylinder4(controllerX,controllerY,7,3);
    }
  union(){
    bore4(X-boreInset,Y-boreInset,2.1);
    translate([0,0,0])
      hexagon4(X-boreInset,Y-boreInset,3.5,7.5);
    translate([0,0,2.5])
      difference(){
        box(X-12,Y-12,0,0,20);
        translate([0,0,-5])
          box(X-17,Y-17,0,0,30);
        }
      translate([0,-5,1])
        cylinder4(controllerX,controllerY,22,1.5);
    }
  }

/* Top *

translate([0,70,-sideX/2])
rotate([-90,0,0])
difference(){
  union(){
    box(X-boreInset-sideTrim,sideX+3,0,0,2);
    box(X-boreInset-sideTrim,sideX,0,0,3);
    }
  translate([0,0,0])
  union(){
    bore(0,0,19);
    bore4(32,32,1.4);
    }
  }
  
/* Bottom *

translate([0,-70,-sideX/2])
rotate([90,0,0])
difference(){
  union(){
    box(X-boreInset-sideTrim,sideX+3,0,0,2);
    box(X-boreInset-sideTrim,sideX,0,0,3);
    }
  union(){
    translate([0,3,-2])
      box(X-boreInset*2,3,0,0,10);
    translate([0,9,-2])
      box(X-boreInset*2.5,3,0,0,10);
    translate([0,15,-2])
      box(X-boreInset*3,3,0,0,10);
    translate([0,21,-2])
      box(X-boreInset*3,3,0,0,10);
    translate([0,-3,-2])
      box(X-boreInset*2,3,0,0,10);
    translate([0,-9,-2])
      box(X-boreInset*2.5,3,0,0,10);
    translate([0,-15,-2])
      box(X-boreInset*3,3,0,0,10);
    translate([0,-21,-2])
      box(X-boreInset*3,3,0,0,10);
    }
  }

/* Side *

translate([-80,0,-sideX/2])
rotate([0,-90,0])
difference(){
  union(){
    box(sideX+3,Y-boreInset-sideTrim,0,0,2);
    box(sideX,Y-boreInset-sideTrim,0,0,3);
    }
  union(){
    translate([(sideX/2)-13,15-23,-4])
      cube([4,28,10]);
    bore(-16,-2,8);
    }
  }

/* Side *

translate([80,0,-sideX/2])
rotate([0,90,0])
difference(){
  union(){
    box(sideX+3,Y-boreInset-sideTrim,0,0,2);
    box(sideX,Y-boreInset-sideTrim,0,0,3);
    }
  union(){
    bore(13,12,7);
    bore(13,-12,7);
    }
  }

/* */