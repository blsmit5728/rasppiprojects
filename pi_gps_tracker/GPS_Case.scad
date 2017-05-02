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
module box()
{
    translate([17,34,-8.5])piZeroBottom();
    difference()
    {
        rounded_rect(100,100,20,3,40);
        translate([0,0,4])rounded_rect(98,98,20,3,40);
    }
    
}
module holes()
{
    translate([17,50,-1.5])cube([55,5,5],center=true);
    translate([50,34,-1.5])cube([5,15,5],center=true);
}

module powerboost()
{
    difference()
    {
        union()
        {
            translate([(36.2/2)-2.542,(17.65/2),0])cylinder(3,(1.25+1),(1.25+1),$fn=50);
            translate([(36.2/2)-2.542,-(17.65/2),0])cylinder(3,(1.25+1),(1.25+1),$fn=50);
        }
        union()
        {
            translate([(36.2/2)-2.542,(17.65/2),0])cylinder(7,(.25+1),(.25+1),$fn=50);
            translate([(36.2/2)-2.542,-(17.65/2),0])cylinder(7,(.25+1),(.25+1),$fn=50);
        }
    }    
    //translate([(36.2/2)-2.542,0,0])cube([1,17.65,5],center=true);
    //cube([36.2,22.86,1],center=true);
}
module bottom()
{
    rounded_rect(100,100,2,3,40);
}
module battery()
{
    cube([65,51,8]);
}
module display()
{
    difference()
    {
        cube([27.3,27.3,2],center=true);
        cube([19,26,5],center=true);
    }
    //color("White"){cube([23.2,20.7,4],center=true);}
    difference()
    {
        union()
        {
            translate([(23.2/2),(20.7/2),0])cylinder(2,(2),(2),$fn=50);
            translate([(23.2/2),-(20.7/2),0])cylinder(2,(2),(2),$fn=50);
            translate([-(23.2/2),(20.7/2),0])cylinder(2,(2),(2),$fn=50);
            translate([-(23.2/2),-(20.7/2),0])cylinder(2,(2),(2),$fn=50);
        }
        union()
        {
            translate([(23.2/2),(20.7/2),0])cylinder(7,(1),(1),$fn=50);
            translate([(23.2/2),-(20.7/2),0])cylinder(7,(1),(1),$fn=50);
            translate([-(23.2/2),(20.7/2),0])cylinder(7,(1),(1),$fn=50);
            translate([-(23.2/2),-(20.7/2),0])cylinder(7,(1),(1),$fn=50);
        }
    }
}
display();
//bottom();
//color("Green"){translate([-16,-3,0])battery();}
//color("Blue"){rotate([0,0,90])translate([-62,-32,0])powerboost();}

//difference()
//{
//    box();
//    holes();
//}

