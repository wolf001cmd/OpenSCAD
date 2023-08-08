$fn = 85;

spacing = 7;
wall = 0.5;
outerSpacing = 2;

orangepi_l = 100;
orangepi_w = 20;
orangepi_h = 75;

netgear_l = 104.5;
netgear_w = 14.6;
netgear_h = 103.5;

length = netgear_l + 7;
width = orangepi_w + netgear_w + spacing + wall * 2 + outerSpacing * 2;
height = netgear_h + 14;

netgear_z = height - netgear_h + 7;
orangepi_z = height - orangepi_h;

coreWidth = width - wall * 2;
offset = (orangepi_w - netgear_w) / 2;


innerBoltRadius = 1.4;
outerBoltRadius = 1.47;

topBoltPatternX = width-12;
topBoltPatternY = length+6;

bottomBoltPatternX = width-8;
bottomBoltPatternY = length-10;


interface = 5;

clearance = 0.2;
c = clearance;
c2 = c*2;

chamfer = 1;

color("#449966")
union(){
	//orangepi(1);
	//netgear(1);
	}
//top();
//core();
bottom();

module orangepi(o=0){
	translate([-spacing / 2 - orangepi_w + offset,-orangepi_l/2,orangepi_z])
	union(){
		translate([0,-c,3])
			cube([orangepi_w+c,orangepi_l+c2,orangepi_h+c-3]);
		
		translate([orangepi_w-4,-c,0])
			cube([2,orangepi_l+c2,orangepi_h+c]);
		}
	if(o>0)
		translate([-spacing / 2 - orangepi_w + offset,-(orangepi_l-interface*2)/2,-c])
			cube([orangepi_w+c+spacing/2,orangepi_l-interface*2,height+c2]);
	}
	
module netgear(o=0){
	translate([spacing / 2 + offset, -netgear_l/2,netgear_z])
	union(){
		translate([0,-c,-c])
			cube([netgear_w+c,netgear_l+c2,netgear_h+c2]);
		}
	if(o>0)
		translate([+offset-c2,-(netgear_l-interface*2)/2,-c])
			cube([netgear_w+c2+spacing/2,netgear_l-interface*2,height+c2]);
	}
	
module top (){
	
	radius = width/2 + outerSpacing;
	thickness = 5;
	t = thickness;
	distance = length/2 + 8;
	
	union(){
		translate([0,0,height])
		difference(){
			union(){
				hull(){
					translate([0,distance,0])
						chamferedCylinder(radius,t,1.2);
					translate([0,-distance,0])
						chamferedCylinder(radius,t,1.2);
					}
				}
			union(){
			
				bore4(topBoltPatternX,topBoltPatternY,outerBoltRadius,12);
						
				translate([-21+c,-97/2,-c])
					cube([17,97,orangepi_h+c-3]);
						
				translate([5,-80/2,-c])
					cube([8,80,netgear_h+c2]);
				translate([5,-50/2,-c])
					cube([15,50,netgear_h+c2]);
					
				bore(0,length/2+23,8);
				bore(0,-length/2-23,8);
						
				}
			}
		}
		
	}
	
module core (){
	difference(){
		hull(){
			translate([-width/2,-length/2,0])
				chamferedCube([width,length,height],chamfer);
			translate([-21.5,-(length+26)/2,0])
				chamferedCube([43,length+26,height],chamfer);
			
			}
		union(){
			orangepi(1);
			netgear(1);
			
			//top/bottom screw holes
			bore4(bottomBoltPatternX,bottomBoltPatternY,innerBoltRadius,10);
			translate([0,0,height])
				bore4(topBoltPatternX,topBoltPatternY,innerBoltRadius,10);
			
			//antenna mounts
			offset = length/2 - 9;
			translate([1.5,0,55])
			rotate([90,0,0])
			union(){
				bore(0,0,3.3);
				hull(){
					translate([0,0,-offset])
						bore(0,0,6,12);
					translate([0,0,-offset+13])
						bore(0,0,12,12);
					}
				hull(){
					translate([0,0,-offset-18])
						bore(0,0,7,20);
					translate([0,0,-offset-30])
						bore(0,0,7,20);
					}
				hull(){
					translate([0,0,+offset])
						bore(0,0,6,12);
					translate([0,0,+offset-13])
						bore(0,0,12,12);
					}
				hull(){
					translate([0,0,+offset+18])
						bore(0,0,7,20);
					translate([0,0,+offset+30])
						bore(0,0,7,20);
					}
				}
			
			//side fan mount
			opening = 25;
			translate([0,-length/2,21])
			rotate([90,0,0])
			union(){
				translate([0,0,-4])
				hull(){
					bore(0,0,19,opening);
					translate([0,-21,0])
						bore(0,0,16,opening);
					}
				bore(0,0,19,50);
				translate([0,0,21])
					bore4(32,32,1.45,34);
				}
			translate([-20.25,-length/2-9.5,-1])
				cube([40.5,11,42]);
				
			rotate([0,0,180])
			translate([0,-length/2,21])
			rotate([90,0,0])
			union(){
				translate([0,0,-4])
				hull(){
					bore(0,0,19,opening);
					translate([0,-21,0])
						bore(0,0,16,opening);
					}
				}
				
			//side cutouts
			cutout();
			rotate([0,0,180])
			cutout();
				
			}
		}
	}
module cutout(){
	opening = 20;
	translate([0,-length/2-13,95])
	rotate([90,0,0])
	union(){
		translate([0,0,-4])
		hull(){
			bore(0,0,19,opening);
			translate([0,-33,0])
				bore(0,0,19,opening);
			}
		}
	}
	
module bottom (){
	
	radius = width/2 + outerSpacing;
	thickness = 5;
	t = thickness;
	distance = length/2 + 8;
	
	union(){
		translate([0,0,-t])
		difference(){
			union(){
				hull(){
					translate([0,distance,0])
						chamferedCylinder(radius,t,1.2);
					translate([0,-distance,0])
						chamferedCylinder(radius,t,1.2);
					translate([24,length/7,0])
						chamferedCylinder(radius-8,t,1.2);
					translate([24,-length/7,0])
						chamferedCylinder(radius-8,t,1.2);
					}
				}
			union(){
				bore4(bottomBoltPatternX,bottomBoltPatternY,outerBoltRadius,12);
				}
			}
		}
				
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
	
module roundedChannel(l,w,h,o=0){
	hull(){
		translate([0,-(l-w)/2,0])
			cylinder(d=w+o, h);
		translate([0,(l-w)/2,0])
			cylinder(d=w+o, h);
		}
	}
		
module chamferedCube(xyz, chamfer){
  c2 = chamfer * 2;
  a = [xyz[0] - c2, xyz[1] - c2, xyz[2]];
  b = [xyz[0] - c2, xyz[1], xyz[2] - c2];
  c = [xyz[0], xyz[1] - c2, xyz[2] - c2];
  hull(){
    translate([chamfer,chamfer,0])
      cube(a);
    translate([chamfer,0,chamfer])
      cube(b);
    translate([0,chamfer,chamfer])
      cube(c);
    }
  }
	
module chamferedCylinder(radius, height, chamfer){
	c2 = chamfer * 2;
  r2 = radius - chamfer;
	h2 = height - c2;
  hull(){
		cylinder(r=r2, height);
    translate([0,0,chamfer])
			cylinder(r=radius, h2);
    }
  }
	