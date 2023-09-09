$fn = 85;

spacing = 4.5;
wall = .2;
outerSpacing = 2;

orangepi_l = 100;
orangepi_w = 20;
orangepi_h = 75;

netgear_l = 105;
netgear_w = 14.8;
netgear_h = 103.7;

length = netgear_l + 5;
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
//top();
//core();
bottom();

module orangepi(o=0){
	translate([-spacing / 2 - orangepi_w + offset,-orangepi_l/2+3.5,orangepi_z])
	union(){
		translate([0,-c,3])
			cube([orangepi_w+c,orangepi_l+c2,orangepi_h+c-3]);
		
		translate([orangepi_w-4,-c,0])
			cube([2,orangepi_l+c2,orangepi_h+c]);
		}
	if(o>0)
		translate([-spacing / 2 - orangepi_w + offset,-(orangepi_l-interface*2)/2+3.5,-c])
			cube([orangepi_w+c+spacing/2+2.5-2,orangepi_l-interface*2,height+c2]);
	}
	
module netgear(o=0){
	translate([spacing / 2 + offset, -netgear_l/2-3.2,netgear_z])
	union(){
		translate([0,-c,-c])
			cube([netgear_w+c,netgear_l+c2,netgear_h+c2]);
		}
	if(o>0)
		translate([+offset+2-c2-1,-(netgear_l-interface*2)/2-3.5,-c])
			cube([netgear_w+c+spacing/2-1+c2,netgear_l-interface*2,height+c2]);
	}
	
module top (){
	
	radius = width/2 + outerSpacing;
	thickness = 5;
	t = thickness;
	overage = -6;
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
				translate([0,0,thickness+.5])
				bore4(topBoltPatternX,topBoltPatternY,3.1,thickness);
						
				translate([-20+c,-97/2+3.5,-c])
					cube([16.2,97,orangepi_h+c-3]);
						
				translate([3,-38-3.2,-c])
					cube([7,80,netgear_h+c2]);
				translate([4,-26-3.2,-c])
					cube([15,50,netgear_h+c2]);
					
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
				
				//translate([0,-length/2-15,0])
				//	bore(0,0,7.5);
				//translate([0,length/2+15,0])
				//	bore(0,0,7.5);
			
				union(){
					translate([0,0,-t+1.5])
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
				//translate([-3,0,10.9])
				//antenna();
				
				//front fan mount
				frontFan();
				
				//side fan mount
				translate([-1.5,0,0])
				sideFan();
				translate([-1.5,0,0])
				rotate([0,0,180])
				sideFan(180);
					
				//side cutouts
				cutout();
				rotate([0,0,180])
				cutout();
				
				//various cutouts
				translate([4.7,-52,-1])
					hull(){
						cube([14,104,10]);
						translate([0,16,0])
							cube([14,72,14]);
						}
				translate([-spacing / 2 - orangepi_w + offset,-52,2])
					hull(){
						cube([22,104,24]);
						translate([0,20,0])
							cube([22,64,40]);
						}
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
	r=1.4;
	s=8;
	h=2;
	translate([15,0,22])
	rotate([90,0,90])
	union(){
		translate([0,0,21])
			for(i = [0 : 4]){
				translate([0,-12 + h * i,0])
					bore4(84 - s * i,h*2,r,500);
				translate([0,80 - h * i,0])
					bore4(84 - s * i,h*2,r,500);
				}
		}
	}

module sideFan(a=0){
	
	translate([0,-length/2+11,60])
	rotate([90,270+a,0])
	union(){
		hull(){
			bore(0,0,14.5,19.9);
			bore(0,0,17.1,1);
			}
		bore(0,0,14.5,45);
		bore4(24.5,24.2,1.44,50);
		bore(-5,14,2.5,50);
		}
		
	}
	
module cutout(){
	opening = 18.5;
	radius = 18;
	spacing = 3;
	translate([0,-length/2-14,height-spacing-radius])
	rotate([90,0,0])
	union(){
		translate([0,0,-4])
		hull(){
			bore(0,0,radius,opening);
			translate([0,-height+spacing*2+radius*2,0])
				bore(0,0,radius,opening);
			}
		}
	}
	
module bottom (){
	
	radius = width/2 + outerSpacing;
	thickness = 5;
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
					//translate([24,length/7,0])
					//	chamferedCylinder(radius-8,t,1.2);
					//translate([24,-length/7,0])
					//	chamferedCylinder(radius-8,t,1.2);
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
			cube([outerSpacing,85,2], center=true);
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
	