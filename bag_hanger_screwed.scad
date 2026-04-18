$fa = 1;
$fs = 0.2;

/*
This is a model for hanging a bag with horizontal straps to some horizontal tube with zip-ties.
I used it to hang self sewn bags with 20mm straps to a "Tubus Tara Lowrider" bike rack.
In my case the tube diameter was 10mm. Including a piece of rubber i lay between the model and the tube the tube thickness of 12mm fits snug.
The horizontal channels for zip-ties are placed low to tighten the component further.
*/

width = 20;
height = 40;
tube_thickness = 12;
wall_thickness = 8;
hook_thickness = 4;
slot_thickness = 2;
binder_width = 5;
binder_thickness = 3;
binder_slot_height = wall_thickness;
nut_width = 5.5;
nut_width_max = 5.5;
nut_thickness = 1.8;
screw_head_radius = 5.5 / 2;
screw_head_height = 3;
module shave(length, width) {
    difference() {
        cube([
            length,
            width,
            width]);
        translate([
            -0.002, 
            0, 
            0])
            rotate([0,90,0])
            cylinder(h=length + 0.004, r=width, center=false);
    }
}

difference() {
    // main cube
    cube([width,wall_thickness + tube_thickness + wall_thickness + slot_thickness + hook_thickness, height]);
    
    // tube slot
    translate([-0.001,wall_thickness,-0.001])
    {
       cube([width + 0.002, tube_thickness, height - wall_thickness - tube_thickness / 2.0]);
       translate([0,tube_thickness/2.0,height-wall_thickness - tube_thickness / 2.0])
        rotate([0,90,0])
            cylinder(h=width + 0.002, r=tube_thickness / 2.0, center = false);
    };

    
    // webbing slot
    translate([-0.001, wall_thickness + tube_thickness + wall_thickness, wall_thickness])
        cube([width + 0.002, slot_thickness, height - wall_thickness + 0.001]);
        
    // back shave
    translate([-0.001, wall_thickness - 0.001, height - wall_thickness + 0.001])
    rotate([90,0,0])
    shave(width+0.002,wall_thickness);
    
    // lower back shave
    translate([-0.001, wall_thickness -0.001, wall_thickness])
    rotate([180,0,0])
    shave(width+0.002, wall_thickness +0.001);
    
    
    // front shave
        translate([-0.001, wall_thickness + tube_thickness + slot_thickness + hook_thickness, height - wall_thickness])
        rotate([0,0,0])
        shave(width + 0.002, wall_thickness + 0.001);   
    
    translate([-0.001, wall_thickness + tube_thickness + slot_thickness + hook_thickness, wall_thickness])
        rotate([-90,0,0])
        shave(width + 0.002, wall_thickness + 0.001);
        
   // screw_hole
   translate([width / 2.0, - 0.001, wall_thickness + nut_width / 2.0])
   rotate([-90,0,0])
   cylinder(h = wall_thickness * 2 + tube_thickness + 0.002, r=1.5, center=false);
   
   // screw head slot
   translate([width / 2.0, - 0.001, wall_thickness + nut_width / 2.0])
      rotate([-90,0,0])
         cylinder(h=screw_head_height + 0.001, r=screw_head_radius, center=false);
   
   // nut_slot
   translate([-0.001, wall_thickness * 2.0 + tube_thickness - nut_thickness, wall_thickness])
   cube([width / 2.0 + nut_width_max / 2.0 + 0.001, nut_thickness + 0.001, nut_width]);
}

// webbing stop
difference() {
translate([0, wall_thickness *2 + tube_thickness + slot_thickness + 1, height - 2.6])
rotate([0, 90, 0])
cylinder(h=width, r=2.5, center=false);
        translate([-0.001, wall_thickness + tube_thickness + slot_thickness + hook_thickness, height - wall_thickness])
        rotate([0,0,0])
        shave(width + 0.002, wall_thickness + 0.001);  
}
