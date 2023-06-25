$fn = 75;

module cutout(){
	hull(){
		r = 3.8;
		translate([0,-5.8,0])
			cylinder(50,r=r);
		cylinder(50,r=r);
		}
	}
	
	
difference(){
	union(){
		
		hull(){
			translate([0,-2.5,11])
				cube([55,7,10], center=true);
			translate([0,0,10])
				cube([50,8,8], center=true);
			translate([0,-3,1])
				cube([55,6,2], center=true);
			}
		translate([0,-3,5])
			cube([55,6,10], center=true);
		hull(){
			translate([0,-4,1])
				cube([55,6,2], center=true);
			translate([0,-13,1])
				cube([35,20,2], center=true);
			}
			
		}
	union(){
	
		translate([14,-15,-5])
		hull(){
			translate([0,-3,0])
				cylinder(10, r=2.5);
			cylinder(10, r=2.5);
			}
			
		translate([-14,-15,-5])
		hull(){
			translate([0,-3,0])
				cylinder(10, r=2.5);
			cylinder(10, r=2.5);
			}
	
		translate([0,-1,-5])
		union(){
			translate([20,0,0])
				cutout();
			translate([0,0,0])
				cutout();
			translate([-20,0,0])
				cutout();
			}
		
		
		}
	}
	
	
	