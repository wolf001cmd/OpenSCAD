$fn = 85;

spacing = 8;
wall = 1;
outerSpacing = 3;

orangepi_l = 100;
orangepi_w = 23;
orangepi_h = 75;

netgear_l = 105;
netgear_w = 15;
netgear_h = 107;

length = netgear_l + wall * 2;
width = orangepi_w + netgear_w + spacing + wall * 2 + outerSpacing * 2;
height = netgear_h + 1;

netgear_z = height - netgear_h + 7;
orangepi_z = height - orangepi_h;

coreWidth = width - wall * 2;
offset = (orangepi_w - netgear_w) / 2;

interface = 5;

clearance = 0.2;
c = clearance;
c2 = c*2;

chamfer = 1;

color("#449966")
union(){
	//orangepi();
	//netgear();
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
		translate([-orangepi_w-2.5,-(orangepi_l-interface*2)/2,-c])
			cube([orangepi_w + outerSpacing*2 + c +1,orangepi_l-interface*2,height+c2]);
	}
	
module netgear(o=0){
	translate([spacing / 2 + offset, -netgear_l/2,netgear_z])
	union(){
		translate([0,-c,-c])
			cube([netgear_w+c,netgear_l+c2,netgear_h+c2]);
		}
	if(o>0)
		translate([offset-0.5,-(netgear_l-interface*2)/2,-c])
			cube([netgear_w + outerSpacing*2+c2,netgear_l-interface*2,height+c2]);
	}
	
module top (){
	
	radius = width/2 + outerSpacing;
	thickness = 5;
	t = thickness;
	
	union(){
		translate([0,0,height])
		difference(){
			union(){
				hull(){
					translate([0,length/2,0])
						chamferedCylinder(radius,t,1);
					translate([0,-length/2,0])
						chamferedCylinder(radius,t,1);
					}
				}
			union(){
			
				bore4(width-12,length+6,1.4,12);
						
				translate([-17,-95/2,-c])
					cube([15,95,orangepi_h+c-3]);
						
				translate([9,-65/2,-c])
					cube([14,65,netgear_h+c2]);
					
				bore(0,length/2+20,7);
				bore(0,-length/2-20,7);
						
				}
			}
		}
		
	}
	
module core (){
	difference(){
		hull(){
			translate([-width/2,-length/2,0])
				chamferedCube([width,length,height],chamfer);
			translate([-21,-(length+26)/2,0])
				chamferedCube([42,length+26,height],chamfer);
			
			}
		union(){
			orangepi(1);
			netgear(1);
			
			//top/bottom screw holes
			bore4(width-7,length-7,1.4,10);
			translate([0,0,height])
				bore4(width-12,length+6,1.4,10);
			
			//antenna mounts
			translate([0,0,60])
			rotate([90,0,0])
			union(){
				bore(0,0,3.3);
				hull(){
					translate([0,0,-length/2+3])
						bore(0,0,11,12);
					translate([0,0,-length/2+13])
						bore(0,0,17,12);
					}
				hull(){
					translate([0,0,-length/2-10])
						bore(0,0,7,10);
					translate([0,0,-length/2-20])
						bore(0,0,11,10);
					}
				hull(){
					translate([0,0,+length/2-3])
						bore(0,0,11,12);
					translate([0,0,+length/2-13])
						bore(0,0,17,12);
					}
				hull(){
					translate([0,0,+length/2+10])
						bore(0,0,7,10);
					translate([0,0,+length/2+20])
						bore(0,0,11,10);
					}
				}
			
			//side fan mount
			opening = 25;
			translate([0,-length/2,21])
			rotate([90,0,0])
			union(){
				translate([0,0,-4])
				hull(){
					bore(0,0,18.5,opening);
					translate([0,-21,0])
						bore(0,0,18.5,opening);
					}
				bore(0,0,18.5,50);
				translate([0,0,21])
					bore4(32,32,1.4,34);
				}
			translate([-20.5,-length/2-9.5,-1])
				cube([41,11,44]);
				
			rotate([0,0,180])
			translate([0,-length/2,21])
			rotate([90,0,0])
			union(){
				translate([0,0,-4])
				hull(){
					bore(0,0,18.5,opening);
					translate([0,-21,0])
						bore(0,0,18.5,opening);
					}
				}
				
			}
		}
	}
	
/*
module top (){
	t = thickness;
		
	difference(){
		union(){
			translate([x/2-spacing*2,0,h])
			union(){
				translate([-x/2,-y/2,-h])
				hull(){
					translate([0+3,5,0])
						chamferedCube([x-6,y-10,h+5],1);
					translate([0+8,-15,0])
						chamferedCube([x-16,y+30,h+5],1);
					}
				hull(){
					translate([0,y/2,0])
						chamferedCylinder(x/2,10,1);
					translate([0,-y/2,0])
						chamferedCylinder(x/2,10,1);
					}
				}
			}
		union(){
			ndi();
			nano();
			
			//lower opening for port access
			translate([0,0,nano_z-3])
			union(){
				translate([ndi_w+c+spacing+1.5,-nano_l/2+2,0])
					cube([nano_w+c-3.8,nano_l+c-4,nano_h]);
				translate([1.9,0,-10])
					ndi(0,10,0,ndi_l-3);
					
				translate([-3,-(ndi_l-16)/2,-50])
					cube([ndi_w + nano_w + c * 2 + spacing * 2+2, ndi_l-16, z]);
					
				//upper notch for wifi
				translate([33,55,34])
				hull(){
					rotate([90,0,0])
						cylinder(h=110, r=6);
					translate([0,0,40])
					rotate([90,0,0])
						cylinder(h=110, r=6);
					}
				}
				
			//side fan mount
			translate([x/2-spacing*2,-58,21])
			rotate([90,0,0])
			union(){
				translate([0,0,-30])
				hull(){
					bore(0,0,18.5,25);
					translate([0,-21,0])
						bore(0,0,18.5,25);
					}
				bore(0,0,18.5,30);
				bore4(32,32,1.4,34);
				}
			translate([4.25,-47,-1])
				cube([41,11,43]);
						
			//top usb
			translate([13,43,0])
			rotate([0,0,90])
			union(){
				hull(){
					bore(0,-3,1.75);
					bore(0,+3,1.75);
					}
				translate([-5,-4,0])
				hull(){
					bore(0,-2,1);
					bore(0,+2,1);
					}
				translate([-5,4,0])
				hull(){
					bore(0,-2,1);
					bore(0,+2,1);
					}
				}
				
			//screws
			translate([x/2-spacing*2,0,0])
				bore4(x-14,y-14,1.4,10);
							
			//lower space
			hull(){
				translate([18,-33,-1])
					cube([29,67,31]);
				translate([2,-33,-1])
					cube([45,83,26]);
				}
			translate([2,34,-1])
				cube([22,12,80]);
			translate([3,34,-1])
				cube([20,16,80]);
			translate([2,34,73.5])
				cube([22,16,14]);
			}
		}
	}
	
*/
	
module bottom (){
	
	radius = width/2 + outerSpacing;
	thickness = 5;
	t = thickness;
	
	union(){
		translate([0,0,-t])
		difference(){
			union(){
				hull(){
					translate([0,length/2,0])
						chamferedCylinder(radius,t,1);
					translate([0,-length/2,0])
						chamferedCylinder(radius,t,1);
					translate([24,length/7,0])
						chamferedCylinder(radius-8,t,1);
					translate([24,-length/7,0])
						chamferedCylinder(radius-8,t,1);
					}
				}
			union(){
				bore4(width-7,length-7,1.4,12);
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
	