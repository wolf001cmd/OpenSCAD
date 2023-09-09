$fn = 85;

spacing = 7;
wall = 01;
outerSpacing = 2;

orangepi_l = 100;
orangepi_w = 20;
orangepi_h = 75;

netgear_l = 105;
netgear_w = 15;
netgear_h = 103.7;

length = netgear_l + 6;
width = orangepi_w + netgear_w + spacing + wall * 2 + outerSpacing * 2;
height = netgear_h + 6;

netgear_z = height - netgear_h + 7;
orangepi_z = height - orangepi_h;

coreWidth = width - wall * 2;
offset = (orangepi_w - netgear_w) / 2;


innerBoltRadius = 1.43;
outerBoltRadius = 1.5;

topBoltPatternX = width-12;
topBoltPatternY = length+4;

bottomBoltPatternX = topBoltPatternX;
bottomBoltPatternY = topBoltPatternY;


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
top();
core();
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
		translate([-spacing / 2 - orangepi_w + offset - c,-(orangepi_l-interface*2)/2,-c])
			cube([orangepi_w+c+spacing/2+2.5,orangepi_l-interface*2,height+c2]);
	}
	
module netgear(o=0){
	translate([spacing / 2 + offset, -netgear_l/2,netgear_z])
	union(){
		translate([0,-c,-c])
			cube([netgear_w+c,netgear_l+c2,netgear_h+c2]);
		}
	if(o>0)
		translate([+offset+2.5-c2,-(netgear_l-interface*2)/2,-c])
			cube([netgear_w+c+spacing/2-2.5,netgear_l-interface*2,height+c2]);
	}
	
module top (){
	
	radius = width/2 + outerSpacing;
	thickness = 6;
	t = thickness;
	overage = 0;
	distance = length/2 + overage;
	
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
				translate([0,0,thickness])
				bore4(topBoltPatternX,topBoltPatternY,3.1,thickness);
						
				translate([-21+c,-97/2,-c])
					cube([16.2,97,orangepi_h+c-3]);
						
				translate([4,-38,-c])
					cube([7,80,netgear_h+c2]);
				translate([5,-26,-c])
					cube([15,45,netgear_h+c2]);
					
				/*
				translate([-8.5,-length/2,0])
					bore(0,-radius+11,7.5);
				translate([-8.5,length/2,0])
					bore(0,radius-11,7.5);
				translate([8.5,-length/2,0])
					bore(0,-radius+11,7.5);
				translate([8.5,length/2,0])
					bore(0,radius-11,7.5);
				*/
				
				translate([0,-length/2-15,0])
					bore(0,0,7.5);
				translate([0,length/2+15,0])
					bore(0,0,7.5);
					
			
				union(){
					translate([0,0,-t+1])
					scale([1.006,1.006,1.006])
						hull(){
							translate([-width/2,-length/2,0])
								chamferedCube([width,length,t],chamfer);
							translate([(-width+5)/2,-6-length/2,0])
								chamferedCube([width-5,length+12,t],chamfer);
							}
					}
						
				}
			}
		}
		
	}
	
module core (){
	union(){
		difference(){
			union(){
				hull(){
					translate([-width/2,-length/2,0])
						chamferedCube([width,length,height],chamfer);
					translate([(-width+5)/2,-6-length/2,0])
						chamferedCube([width-5,length+12,height],chamfer);
					}
				/*
				hull(){
					rotate([90,0,0])
						bore(width/2,50,outerSpacing,48);
					rotate([90,0,0])
						bore(width/2,50,outerSpacing-1,50);
					}
					*/
				}
			union(){
				orangepi(1);
				translate([0,2,0])
				netgear(1);
				
				//top/bottom screw holes
				bore4(bottomBoltPatternX,bottomBoltPatternY,innerBoltRadius,10);
				translate([0,0,height])
					bore4(topBoltPatternX,topBoltPatternY,innerBoltRadius,10);
				
				//antenna mounts
				//translate([-11.5,0,29.5])
				//antenna();
					
				//second antenna
				translate([-3,0,10.9])
				antenna();
				
				//front fan mount
				frontFan();
				
				//side fan mount
				sideFan();
				//rotate([0,0,180])
				//sideFan();
					
				//side cutouts
				cutout();
				translate([0,1,0])
				rotate([0,0,180])
				cutout();
				
				//usb hub cutout
				translate([6,-54,-1])
					cube([15,108,11]);
				}
			}
		}
	}
	
module antenna(){
	offset = length/2 - 15.5;
	rotate([90,0,0])
	union(){
		bore(0,0,3.3);
		hull(){
			translate([0,0,-offset])
				bore(0,0,6,12);
			translate([0,0,-offset+13])
				bore(0,0,6,12);
			}
		hull(){
			translate([0,0,-offset-18])
				bore(0,0,7.5,20);
			translate([0,0,-offset-30])
				bore(0,0,7.5,20);
			}
		hull(){
			translate([0,0,+offset])
				bore(0,0,6,12);
			translate([0,0,+offset-13])
				bore(0,0,6,12);
			}
		hull(){
			translate([0,0,+offset+18])
				bore(0,0,7.5,20);
			translate([0,0,+offset+30])
				bore(0,0,7.5,20);
			}
		}
	}
	
module frontFan(){
	translate([15,0,22])
	rotate([90,0,90])
	union(){
		//bore(0,0,19,25);
		//translate([0,0,21])
		//	bore4(32,32,1.45,34);
		translate([0,-14,21])
			bore4(84,4,1.45,500);
		translate([0,-12,21])
			bore4(76,4,1.45,500);
		translate([0,-10,21])
			bore4(68,4,1.45,500);
			
		translate([0,80,21])
			bore4(84,4,1.45,500);
		translate([0,78,21])
			bore4(76,4,1.45,500);
		translate([0,76,21])
			bore4(68,4,1.45,500);
		}
	}

module sideFan(){
	
	translate([-2.5,-length/2+11,65])
	rotate([90,0,0])
	union(){
		hull(){
			bore(0,0,14.5,14.9);
			bore(0,0,18.8,1);
			}
		bore(0,0,14.5,45);
		bore4(24.5,24.2,1.44,50);
		bore(-5,14,3,50);
		}
		
	}
	
module cutout(){
	opening = 20;
	radius = 19;
	spacing = 3;
	translate([0,-length/2-13.5,height-spacing-radius])
	rotate([90,0,0])
	union(){
		translate([0,0,-4])
		hull(){
			bore(0,0,19,opening);
			translate([0,-height+spacing*2+radius*2,0])
				bore(0,0,19,opening);
			}
		}
	}
	
module bottom (){
	
	radius = width/2 + outerSpacing;
	thickness = 6;
	t = thickness;
	overage = -6;
	distance = length/2 + overage;
	
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
				bore4(bottomBoltPatternX,bottomBoltPatternY,3.1,thickness);
				
				union(){
					translate([0,0,t-1])
					scale([1.006,1.006,1.006])
						hull(){
							translate([-width/2,-length/2,0])
								chamferedCube([width,length,height],chamfer);
							translate([(-width+5)/2,-6-length/2,0])
								chamferedCube([width-5,length+12,height],chamfer);
							}
					}
				
				}
			}
		translate([width/2-wall*2-outerSpacing-c,0,-1])
			cube([outerSpacing,95,2], center=true);
		translate([-width/2+wall*2+outerSpacing+c,0,-1])
			cube([outerSpacing,70,2], center=true);
		//cube([width-wall*2-outerSpacing*2-c2,20,2], center=true);
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
	