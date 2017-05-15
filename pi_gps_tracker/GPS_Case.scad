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
    screw_hole_bot_r1 = 1.25;
    screw_hole_bot_r2 = 1.25;
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

module box_stand_offs(l,w,h)
{
    y =46;
    x = 46;
    union()
    {
        //translate([y,-x,cly_off_up])
        translate([(x+(-.5*l)),(y+(-.5*w)),0])cube([l,w,h]);
        //cylinder(height,cly_radius1,cly_radius1,center=true,$fn=cly_sides); 
        translate([-(x-(-.5*l)),-(y-(-.5*w)),0])cube([l,w,h]);
        //cylinder(height,cly_radius1,cly_radius1,center=true,$fn=cly_sides); 
        translate([-(x-(-.5*l)),y+(-.5*w),0])cube([l,w,h]);
        //cylinder(height,cly_radius1,cly_radius1,center=true,$fn=cly_sides); 
        translate([(x+(-.5*l)),-(y-(-.5*w)),0])cube([l,w,h]);
        //cylinder(height,cly_radius1,cly_radius1,center=true,$fn=cly_sides); 
    }
}

module box_drill_holes_bot(r1,r2,h)
{
    x = 46;
    y = 46;
    union()
    {
        translate([y,-x,0])
        cylinder(h,r1,r2,center=true,$fn=cly_sides); 
        translate([-y,-x,0])
        cylinder(h,r1,r2,center=true,$fn=cly_sides); 
        translate([y,x,0])
        cylinder(h,r1,r2,center=true,$fn=cly_sides); 
        translate([-y,x,0])
        cylinder(h,r1,r2,center=true,$fn=cly_sides);
    }    
}
module top_counter_sinks(r1,r2,h,t)
{
    x = 46;
    y = 46;
    union()
    {
        translate([y,-x,t])
        cylinder(h,r1,r2,center=true,$fn=cly_sides); 
        translate([-y,-x,t])
        cylinder(h,r1,r2,center=true,$fn=cly_sides); 
        translate([y,x,t])
        cylinder(h,r1,r2,center=true,$fn=cly_sides); 
        translate([-y,x,t])
        cylinder(h,r1,r2,center=true,$fn=cly_sides);
    }
}

module rounded_rect(x,y,h,rad,r_ness)
{
    r_height=h;
    cube2_l = y - ((rad * 2) - 1);
    cube1_w = x - ((rad * 2) - 1);
    r_center_x = cube1_w/2 + rad;
    r_center_y = cube2_l/2 + rad;
    union()
    {
        translate([-(.5*x),-(.5*y),0])cube([x,y,h]);
        translate([-(.5*(6+x)),-(.5*(y-6)),0])cube([x+6,y-6,h]);
        translate([r_center_x,r_center_y,0])cylinder(h,rad,rad,$fn=r_ness);
        translate([-r_center_x,-r_center_y,0])cylinder(h,rad,rad,$fn=r_ness);
        translate([r_center_x,-r_center_y,0])cylinder(h,rad,rad,$fn=r_ness);
        translate([-r_center_x,r_center_y,0])cylinder(h,rad,rad,$fn=r_ness);
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
module piZero_mount()
{
    color(CASEcolor)
    {
        union()
        {            
            difference()
            {
                //rounded_rect(65,30,3,3,40);
                //drill_holes_bot(); 
            }   
            difference()
            {       
                translate([0,0,-0.5])stand_offs(3);
                drill_holes_bot();
            }
        }
    }
}

module box(x,y,h)
{
    translate([9,34,2.7])piZero_mount();
    difference()
    {
        union()
        {
            translate([-(.5*x),-(.5*y),0])cube([x,y,h]);       
        }
        
        union()
        {
            rotate([0,0,90])translate([-52,-52,2])cube([104,2.125,2]);
            rotate([0,0,0])translate([-52,-52,2])cube([104,2.125,2]);
            rotate([0,0,180])translate([-52,-52,2])cube([104,2.125,2]);
            rotate([0,0,270])translate([-52,-52,2])cube([104,2.125,2]);
        }
        
    }
    
    difference()
    {
        translate([0,0,h])box_stand_offs(7.625,7.625,35/2);
        translate([0,0,0])box_drill_holes_bot(1.5,1.5,100);
    }
}

module wall_blank(length,wall_height)
{
    cube([length,2,wall_height]);
}
module wall_1(length, height)
{
    wall_blank(length,height);
}
module wall_2(length, height)
{
    wall_blank(length,height);
}
module wall_3_pi(length, height)
{
    difference()
    {
        wall_blank(length,height);
        translate([14,-2,5])cube([53,16,5]);
    }
}
module wall_4_disp(length, height)
{
    difference()
    {
        wall_blank(length,height);
        union()
        {
            translate([44,-2,5])cube([16,16,5]);
            translate([78,-2,5])cube([16,16,8]);            
            rotate([0,90,90])translate([-26.5,-37,-3])cube([19,26,15]);
        }
    }
    rotate([270,90,0])translate([-17,-24,1])display();
}
//wall_4_disp(104,35);
module walls(wall_height)
{
    union()
    {
        rotate([0,0,90])translate([-52,-52,-13])wall_4_disp(104,wall_height);
        rotate([0,0,0])translate([-50,-52,-13])wall_2(100,wall_height);
        rotate([0,0,180])translate([-50,-52,-13])wall_3_pi(100,wall_height);
        rotate([0,0,270])translate([-52,-52,-13])wall_1(104,wall_height);        
    }
}
//translate([0,0,15])walls(35);


module top()
{
    height = 4;
    difference()
    {
        difference()
        {
            union()
            {
                translate([-(106/2),-(106/2),0])cube([106,106,height]);
                translate([0,0,height])box_stand_offs(7.625,7.625,35/2);
            }
            union()
            {          
                rotate([0,0,90])translate([-52,-52,2])cube([104,2,2]);
                rotate([0,0,0])translate([-52,-52,2])cube([104,2,2]);
                rotate([0,0,180])translate([-52,-52,2])cube([104,2,2]);
                rotate([0,0,270])translate([-52,-52,2])cube([104,2,2]);            
                translate([0,0,-2])box_drill_holes_bot(1.75,1.75,60);
            }
        }
        top_counter_sinks(6,1.75,4,0);
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
            //cube([36.2,22.86,1],center=true);
        }
        union()
        {
            translate([(36.2/2)-2.542,(17.65/2),0])cylinder(10,1,1,$fn=50);
            translate([(36.2/2)-2.542,-(17.65/2),0])cylinder(10,1,1,$fn=50);
        }
    }    
    translate([-12,0,1.5])cube([1,17.65,3],center=true);
    //translate([0,0,2])cube([2,2,2.5],center=true);
    
}
module bottom()
{
    rotate([0,0,90])translate([-16,16,8])battery();
    box(106,106,4);
    //translate([0,0,15])walls(35);
    rotate([0,0,0])translate([31,0,3.5])powerboost();
}
module battery()
{
    difference()
    {
        union()
        {
            difference()
            {
                translate([0,0,-1])cube([68,54,8],center=true);
                cube([65,51,10],center=true);
            }            
        }
        translate([33,0,1])cube([4,45,9],center=true);
    }
}
module display()
{
    difference()
    {
        union()
        {
            cube([28,40,2],center=true);
            cube([28,28,2],center=true);
            translate([(23.2/2),(20.7/2),0])cylinder(4,(2),(2),$fn=50);
            translate([(23.2/2),-(20.7/2),0])cylinder(4,(2),(2),$fn=50);
            translate([-(23.2/2),(20.7/2),0])cylinder(4,(2),(2),$fn=50);
            translate([-(23.2/2),-(20.7/2),0])cylinder(4,(2),(2),$fn=50);
        }
        union()
        {
            cube([19,26,5],center=true);
            translate([(23.2/2),(20.7/2),0])cylinder(10,(1),(1),$fn=50);
            translate([(23.2/2),-(20.7/2),0])cylinder(10,(1),(1),$fn=50);
            translate([-(23.2/2),(20.7/2),0])cylinder(10,(1),(1),$fn=50);
            translate([-(23.2/2),-(20.7/2),0])cylinder(10,(1),(1),$fn=50);
        }
    }
    //translate([13,46,4])cube([2,8,8],center=true);
    //translate([13,-46,4])cube([2,8,8],center=true);
}
module walls(h)
{
    rotate([90,0,90])translate([0,0,-80])wall_4_disp(104,h);
    rotate([90,0,90])translate([0,0,40])wall_2(100,h);
    rotate([90,0,90])translate([0,0,-40])wall_3_pi(100,h);
    rotate([90,0,90])translate([0,0,0])wall_1(104,h);
}


module build()
{
    /* Good Working Area */
    bottom();
    translate([110,0,0])top();    
    translate([0,57,0])walls(35);
}


build();
