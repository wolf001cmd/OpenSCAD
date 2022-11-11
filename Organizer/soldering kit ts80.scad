
$fn = 90;

/* Parameters */

width = 65;
height = 43;
wallthickness = 2.5;
chamfer = 2/sqrt(2);

solderZoneLength = 22;
powerZoneLength = 31;
storageZoneLength = 34;
cableZoneLength = 17.5;

tipOffset = 10.5;
tipSpacing = (storageZoneLength+wallthickness)/4+wallthickness;
ironSpacing = (storageZoneLength+wallthickness)/3+wallthickness;

length = wallthickness*5+solderZoneLength+powerZoneLength+storageZoneLength+cableZoneLength;
    
/* Cube */

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
	
/* Iron Tips */

module ironTips(){
	translate([0,tipSpacing,wallthickness])
	union(){
	translate([0,0,0])
		cylinder(d=9, height);
	translate([0,tipSpacing,0])
		cylinder(d=9, height);
	translate([0,tipSpacing*2,0])
		cylinder(d=9, height);
		}
	}

difference(){

	//Main Body
  union(){
		translate([0,0,0])
      chamferedCube([width,length,height], chamfer);
    }
		
  union(){
	
		translate([wallthickness,0,wallthickness])
		union(){
			
			//Power Zone
			translate([0,length-wallthickness*2-solderZoneLength-powerZoneLength,0])
				chamferedCube([width-wallthickness*2,powerZoneLength,height],chamfer);
				
			//Solder Zone
			translate([0,length-wallthickness-solderZoneLength,0])
				chamferedCube([width-wallthickness*2,solderZoneLength,height],chamfer);
			
			//Storage Zone
			translate([0,wallthickness*2+cableZoneLength,7])
				chamferedCube([16-wallthickness*2,storageZoneLength,height],chamfer);
			
			//Cable Zone
			translate([0,wallthickness,0])
				chamferedCube([width-wallthickness*2,cableZoneLength,height],chamfer);
				
			}
			
		translate([6,cableZoneLength-wallthickness/2,0])
		union(){
		
			//Tips Storage
			translate([width-(wallthickness*2+tipOffset),0,0])
			ironTips();
			translate([wallthickness*2+tipOffset,0,0])
			ironTips();
        
			//Soldering Irons
      translate([width/2,ironSpacing,wallthickness])
        cylinder(d=14.5, height);
      translate([width/2,ironSpacing*2+wallthickness,wallthickness])
        cylinder(d=14.5, height);
				
			}
    }
  }
  
/**/