top_thickness = 2;
corner_round_height = 2;
cly_height = 8.5;
cly_sides = 40;
cly_radius1 = 3;
cly_radius2 = 3;

cly_off_up = cly_height - ((cly_height/2)+1);

CASEcolor="Green";

screw_hole_top_r1 = 1.75;
screw_hole_top_r2 = 1.75;

screw_hole_bot_r1 = 1.5;
screw_hole_bot_r2 = 1.5;

hole_loc_x = 11.5;
hole_loc_y = 29;
module drill_holes_top()
{
    union()
    {
        translate([hole_loc_y,-hole_loc_x,0])
        cylinder(15,screw_hole_top_r1,screw_hole_top_r2,center=true,$fn=cly_sides); 
        translate([-hole_loc_y,-hole_loc_x,0])
        cylinder(15,screw_hole_top_r1,screw_hole_top_r2,center=true,$fn=cly_sides); 
        translate([hole_loc_y,hole_loc_x,0])
        cylinder(15,screw_hole_top_r1,screw_hole_top_r2,center=true,$fn=cly_sides); 
        translate([-hole_loc_y,hole_loc_x,0])
        cylinder(15,screw_hole_top_r1,screw_hole_top_r2,center=true,$fn=cly_sides);
    }    
}
module drill_holes_bot()
{
    union()
    {
        translate([hole_loc_y,-hole_loc_x,0])
        cylinder(15,screw_hole_bot_r1,screw_hole_bot_r2,center=true,$fn=cly_sides); 
        translate([-hole_loc_y,-hole_loc_x,0])
        cylinder(15,screw_hole_bot_r1,screw_hole_bot_r2,center=true,$fn=cly_sides); 
        translate([hole_loc_y,hole_loc_x,0])
        cylinder(15,screw_hole_bot_r1,screw_hole_bot_r2,center=true,$fn=cly_sides); 
        translate([-hole_loc_y,hole_loc_x,0])
        cylinder(15,screw_hole_bot_r1,screw_hole_bot_r2,center=true,$fn=cly_sides);
    }    
}
module stand_offs(height)
{
    union()
    {
        translate([hole_loc_y,-hole_loc_x,cly_off_up])
        cylinder(height,cly_radius1,cly_radius1,center=true,$fn=cly_sides); 
        translate([-hole_loc_y,-hole_loc_x,cly_off_up])
        cylinder(height,cly_radius1,cly_radius1,center=true,$fn=cly_sides); 
        translate([hole_loc_y,hole_loc_x,cly_off_up])
        cylinder(height,cly_radius1,cly_radius1,center=true,$fn=cly_sides); 
        translate([-hole_loc_y,hole_loc_x,cly_off_up])
        cylinder(height,cly_radius1,cly_radius1,center=true,$fn=cly_sides); 
    }
}

module rounded_rect(x,y,h,rad,r_ness)
{
    r_height=h;
    cube2_l = y - ((rad * 2) - 1);
    cube1_w = x - ((rad * 2) - 1);
    r_center_x = cube1_w/2 - 0.5;
    r_center_y = cube2_l/2 - 0.5;
    union()
    {
        cube([x,cube2_l,h],center=true);
        cube([cube1_w,y,h],center=true);
        translate([r_center_x,r_center_y,0])cylinder(h,rad,rad,center=true,$fn=r_ness);
        translate([-r_center_x,-r_center_y,0])cylinder(h,rad,rad,center=true,$fn=r_ness);
        translate([r_center_x,-r_center_y,0])cylinder(h,rad,rad,center=true,$fn=r_ness);
        translate([-r_center_x,r_center_y,0])cylinder(h,rad,rad,center=true,$fn=r_ness);
    }
}

module piZeroTop()
{
    color(CASEcolor)
    {
        difference()
        {
            union()
            {            
                difference()
                {
                    rounded_rect(65,30,3,3,40);
                    drill_holes_top();
                }   
            }
            translate([0,11,0])cube([52,8,top_thickness+1],center=true);
        }      
        difference()
        {       
            stand_offs(cly_height);
            drill_holes_top();
        }
    }
}

module piZeroBottom()
{
    color(CASEcolor)
    {
        union()
        {
            
            difference()
            {
                rounded_rect(65,30,3,3,40);
                drill_holes_bot(); 
            }   
            difference()
            {       
                translate([0,0,-0.5])stand_offs(3);
                drill_holes_bot();
            }
        }
    }
}

//translate([0,0,7])rounded_rect(65,30,2,3,40);
//rotate(a=[0,180,0])translate([0,0,-14])piZeroBottom();
translate([0,40,0])piZeroBottom();
//difference()
//{
piZeroTop();
//    translate([-15,-5,-1])text("MYPi");
//}

