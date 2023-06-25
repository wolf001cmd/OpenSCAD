$fn = 85;

spacing = 10;

	ndi_l = 62;
	ndi_w = 16;
	ndi_h = 100;
	ndi_z = 40;
	
	nano_l = 72;
	nano_w = 29;
	nano_h = 72;
	nano_z = 45;
	
	bat_l = 82;
	bat_w = 22;
	bat_h = 180;
	bat_z = 5;
	
h = 100;
c = 0.5;
c2 = c/2;

module roundedChannel(l,w,h,o=0){
	hull(){
		translate([0,-(l-w)/2,0])
			cylinder(d=w+o, h);
		translate([0,(l-w)/2,0])
			cylinder(d=w+o, h);
		}
	}

module ndi(){
	translate([0,0,ndi_z])
	roundedChannel(ndi_l+c,ndi_w+c,ndi_h);
	}
	
module nano(){
	translate([-nano_w-ndi_w/2-spacing-c2,-nano_l/2-c2,nano_z])
		cube([nano_w+c,nano_l+c,nano_h]);
	}
	
module bat(o=0,h=bat_h,z=bat_z){
	translate([+bat_w/2+ndi_w/2+spacing,0,z])
	roundedChannel(bat_l+c,bat_w+c,h,o);
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
		
difference(){
	union(){
		translate([-51,-40,0])
		chamferedCube([90,80,h],2);
		hull(){
			bat(4,h,0);
			bat(6,h-4,2);
			}
		}
	union(){
		ndi();
		nano();
		bat();
	
		translate([0,45,70])
		rotate([90,0,0])
		roundedChannel(50,28,90);
		
		translate([-75,0,50])
		rotate([0,90,0])
		rotate([0,0,90])
		roundedChannel(60,26,150);
		
		translate([-nano_w-ndi_w/2-spacing/2,-nano_l/2,-1])
			cube([nano_w-spacing+2,nano_l+c2,nano_h]);
			
		translate([30,60,25])
		rotate([90,0,0])
		roundedChannel(30,10,120);
		
		translate([30,60,70])
		rotate([90,0,0])
		roundedChannel(30,10,120);
		
		translate([-32,60,73])
		rotate([90,0,0])
		roundedChannel(34,24,120);
		
		translate([-32,60,27])
		rotate([90,0,0])
		roundedChannel(35,28,120);
		
		translate([0,0,-1])
		roundedChannel(ndi_l-spacing*1.4,ndi_w,ndi_h);
		
		translate([0,0,65])
		rotate([0,0,90])
		roundedChannel(28,10,ndi_h);
		
		translate([0,0,65])
		rotate([0,0,90])
		roundedChannel(ndi_w,10,ndi_h);
		
		translate([0,45,20])
		rotate([90,0,0])
		roundedChannel(24,26,90);
		
		translate([0,0,5])
		roundedChannel(60,26,16);
		
		translate([+bat_w/2+ndi_w/2+spacing,21,-1])
		roundedChannel(32,ndi_w-2,ndi_h);
		
		translate([+bat_w/2+ndi_w/2+spacing,-21,-1])
		roundedChannel(32,ndi_w-2,ndi_h);
			
		}
	}