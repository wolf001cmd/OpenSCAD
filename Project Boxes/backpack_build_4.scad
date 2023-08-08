$fn = 85;

spacing = 4;

	ndi_l = 61.8;
	ndi_w = 16;
	ndi_h = 100;
	ndi_z = 27;
	
	nano_l = 63;
	nano_w = 29;
	nano_h = 63;
	nano_z = 32;
	
	bat_l = 82;
	bat_w = 22;
	bat_h = 180;
	bat_z = 5;
	
h = 80;
c = 0.2;
c2 = c/2;

ix = ndi_w + nano_w + c * 2 + spacing * 5;
iy = nano_h + spacing * 3;
iz = 160;

chamfer = 5;
thickness = 6;
ct = thickness + 6;
cl = 0.2;

x = ix;
y = iy;
z = iz;			

color("#449966")
union(){
	ndi();
	nano();
	}
top();
bottom();

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
				
			//side usb mounts
			/*
			translate([x/2-spacing*2,49,18])
			rotate([90,0,0])
			union(){
				translate([0,2,0])
				rotate([0,0,90])
				union(){
					hull(){
						bore(0,-3,1.75);
						bore(0,+3,1.75);
						}
					}
				translate([0,-11,0])
				rotate([0,0,90])
				union(){
					hull(){
						bore(0,-3,1.75);
						bore(0,+3,1.75);
						}
					}
				translate([0,-4.5,0])
				union(){
					bore(5,0,1.62);
					bore(-5,0,1.62);
					}
				}
			*/
						
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
	
	
/*


			//air channels
			translate([2,-42,-1])
				cube([45,84,15]);
			hull(){
				translate([x/2-spacing*2,20.2,10])
					cylinder(h=2, r=18.5);
				translate([x/2-spacing*2,-20.2,10])
					cylinder(h=2, r=18.5);
				translate([0,0,34])
				union(){
					translate([ndi_w+c+spacing+1,-nano_l/2,0])
						cube([nano_w+c-2,nano_l+c-2,1]);
					}
				}
			hull(){
				translate([x/2-spacing*2,20.2,10])
					cylinder(h=2, r=18.5);
				translate([x/2-spacing*2,-20.2,10])
					cylinder(h=2, r=18.5);
				translate([0,0,34])
				union(){
					translate([0,0,0])
						ndi(0,1,0,ndi_l-6);
					}
				}
			hull(){
				translate([x/2-spacing*2,20.2,10])
					cylinder(h=2, r=18.5);
				translate([x/2-spacing*2,-20.2,10])
					cylinder(h=2, r=18.5);
				translate([0,0,34])
				union(){
					translate([-3,-(ndi_l-16)/2,0])
						cube([ndi_w + nano_w + c * 2 + spacing * 2+2, ndi_l-16, 1]);
					}
				}

*/
	
module bottom (){
	c = chamfer;
	t = thickness;
	
	union(){
		translate([x/2-spacing*2,0,-t])
		difference(){
			union(){
				hull(){
					translate([0,y/2,0])
						chamferedCylinder(x/2,t,1);
					translate([0,-y/2,0])
						chamferedCylinder(x/2,t,1);
					translate([24,y/7,0])
						chamferedCylinder(x/2-5,t,1);
					translate([24,-y/7,0])
						chamferedCylinder(x/2-5,t,1);
					}
				}
			//screws
			translate([0,0,0])
				bore4(x-14,y-14,1.65,20);
			}
		translate([-2,y/2+t*2,-t+1])
		rotate([0,90,0])
			chamferedCylinder(t-1,x-spacing*3,2);
		translate([-2,-y/2-t*2,-t+1])
		rotate([0,90,0])
			chamferedCylinder(t-1,x-spacing*3,2);
		translate([69,-17,-t+1])
		rotate([0,90,90])
			chamferedCylinder(t-1,34,2);
		}
				
	}

module ndi(o=0,h=ndi_h,z=ndi_z,l=ndi_l){
	translate([ndi_w/2+c/2,0,z])
		roundedChannel(l+c,ndi_w+c,h,o);
	}
	
module nano(o=0){
	translate([0,-nano_l/2,nano_z])
	union(){
		translate([ndi_w+c+spacing,0,0])
			cube([nano_w+c,nano_l+c,nano_h]);
		translate([33,nano_l+27,nano_h/2])
			cylinder(d=15, 140);
		translate([33,-27,nano_h/2])
			cylinder(d=15, 140);
		}
	}
	
module bat(o=0,h=bat_h,z=bat_z,l=bat_l){
	translate([+bat_w/2+ndi_w/2+spacing,0,z])
	roundedChannel(l+c,bat_w+c,h,o);
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
	