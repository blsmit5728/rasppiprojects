top_thickness = 2;
cly_height = 12;
cly_sides = 50;
cly_radius1 = 3.5;
cly_radius2 = 3.5;

cly_off_up = cly_height - ((cly_height/2)+1);
//cly_off_up = 0;


union()
{
    
    difference()
    {
        union()
        {
            cube([65,23,top_thickness],center=true);
            cube([58,30,top_thickness],center=true);
            translate([29,11.5,cly_off_up])cylinder(cly_height,cly_radius1,cly_radius2,center=true,$fn=cly_sides);
            translate([-29,-11.5,cly_off_up])cylinder(cly_height,cly_radius1,cly_radius2,center=true,$fn=cly_sides);
            translate([29,-11.5,cly_off_up])cylinder(cly_height,cly_radius1,cly_radius2,center=true,$fn=cly_sides);
            translate([-29,11.5,cly_off_up])cylinder(cly_height,cly_radius1,cly_radius2,center=true,$fn=cly_sides);
        }
        translate([29,11.5,cly_off_up])cylinder(cly_height,1.5,1.5,center=true,$fn=cly_sides); 
        translate([-29,-11.5,cly_off_up])cylinder(cly_height,1.5,1.5,center=true,$fn=cly_sides); 
        translate([29,-11.5,cly_off_up])cylinder(cly_height,1.5,1.5,center=true,$fn=cly_sides); 
        translate([-29,11.5,cly_off_up])cylinder(cly_height,1.5,1.5,center=true,$fn=cly_sides); 
    }   
}

// BELOW IS AN EXAMPLE OF THE PI ITSELF DO NOT PRINT
/*
union()
{
    translate([0,0,17.5])
    difference()
    {
        union()
        {
            cube([65,23,5],center=true);
            cube([58,30,5],center=true);
            translate([29,11.5,0])cylinder(5,cly_radius1,cly_radius2,center=true,$fn=cly_sides);
            translate([-29,-11.5,0])cylinder(5,cly_radius1,cly_radius2,center=true,$fn=cly_sides);
            translate([29,-11.5,0])cylinder(5,cly_radius1,cly_radius2,center=true,$fn=cly_sides);
            translate([-29,11.5,0])cylinder(5,cly_radius1,cly_radius2,center=true,$fn=cly_sides);
        }
        translate([29,11.5,0])cylinder(5,1.5,1.5,center=true,$fn=cly_sides); 
        translate([-29,-11.5,0])cylinder(5,1.5,1.5,center=true,$fn=cly_sides); 
        translate([29,-11.5,0])cylinder(5,1.5,1.5,center=true,$fn=cly_sides); 
        translate([-29,11.5,0])cylinder(5,1.5,1.5,center=true,$fn=cly_sides); 
    }   
}
*/