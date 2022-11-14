
$fn = 100;

//Designed for 3/4 inch hole

diameter = 19;
clearance = 0.1;
slot = 3;
slot_height = 15;
rounding = 0.7;

//Spaghetti

radius = diameter / 2;
r = radius;
c = clearance;

//Body
module bench_body(height, pin){
	union(){
		cylinder(h=height, r=radius);
		minkowski(){
			cylinder(h=pin, r=radius);
			sphere(c*4);
			}
    cylinder(rounding);
		}
	}

//Bench A
module bench_A (height, notch_height, notch_size, pin){
    difference(){
      minkowski(){
        difference(){
				
					//Body
					bench_body(height, pin);
						
          //Notch
          translate([notch_size,-diameter,height-notch_height])
            cube([diameter*2,diameter*2,notch_height*2]);
						
          }
        }
      union(){
			
        //Pin
        translate([0,0,slot_height+slot])
          cylinder(h=height+radius, r=pin+c/2);
					
        //Slot
        translate([0,0,-1+slot_height/2])
          cube([radius*3, slot, slot_height+2], center=true);
					
        }
      }
  }

//Bench B
module bench_B (z, xy, top_z, offset, pin, notch){
  xy = xy;
  o = offset;
  n = notch;
  difference(){
    union(){
		
			//Body
			bench_body(z, pin);
				
      //Head
      translate([-xy/2-(xy/2-radius),-xy/2,z])
        minkowski(){
          hull(){
            translate([offset,offset/2,top_z-0.01])
              cube([xy-offset,xy-offset,.01]);
            cube([xy,xy,.01]);
            }
          cylinder(rounding);
          }
					
      }
    union(){
		
      //Puller
      translate([0,0,slot_height+slot])
        cylinder(h=z+radius, r=pin+c/2);
				
			//Slot
      translate([0,0,-1+slot_height/2])
        cube([radius*3, slot, slot_height+2], center=true);
				
      }
    }
  }

/* A */
translate([0,diameter*2,0])
bench_A(45, 15, 5, 3);
/**/
  
/* B - Small 1/4 inch */
translate([0,-diameter*2,0])
bench_B(30, 23, 6, 4, 2, 2);
/**/

/* B - Medium 1/2 inch */
translate([-diameter*2,0,0])
bench_B(30, 26, 10, 5.5, 2, 2);
/**/

/* B - Large 3/4 inch */
translate([diameter*2,0,0])
bench_B(35, 30, 15, 7, 3, 2);
/**/
