$fa = 1;
$fs = 0.2;
width = 20;
/*
This is a model for hanging a bag with horizontal straps to some horizontal tube with zip-ties.
I used it to hang self sewn bags with 20mm straps to a "Tubus Tara Lowrider" bike rack.
In my case the tube diameter was 10mm. Including a piece of rubber i lay between the model and the tube the tube thickness of 12mm fits snug.
*/

height = 40;
tube_thickness = 12;
wall_thickness = 8;
hook_thickness = 4;
slot_thickness = 2;
binder_width = 5;
binder_thickness = 3;
binder_slot_height = wall_thickness;

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
    
    // horizontal binder slot
    translate([wall_thickness / 2.0, -0.001, binder_slot_height])
        cube([binder_width, wall_thickness + tube_thickness + wall_thickness + 0.002, binder_thickness]);
    translate([wall_thickness / 2.0, wall_thickness + tube_thickness + wall_thickness - binder_thickness * 2, binder_slot_height+2*binder_thickness])
        rotate([-90,0,0])
            shave(binder_width+0.001, binder_thickness + 0.001);
    translate([wall_thickness / 2.0, binder_thickness - 0.001, binder_slot_height + 2*binder_thickness])
        rotate([180,0,0])
        shave(binder_width + 0.001, binder_thickness + 0.001);
    
    translate([width - binder_width - wall_thickness / 2.0, -0.001, binder_slot_height])
        cube([binder_width, wall_thickness + tube_thickness + wall_thickness + 0.002, binder_thickness]);
    translate([width - binder_width - wall_thickness / 2.0, wall_thickness + tube_thickness + wall_thickness - binder_thickness * 2, binder_slot_height + 2*binder_thickness])
        rotate([-90,0,0])
            shave(binder_width+0.001, binder_thickness + 0.001);
     translate([width - binder_width - wall_thickness / 2.0, binder_thickness - 0.001, binder_slot_height + 2*binder_thickness])
        rotate([180,0,0])
            shave(binder_width + 0.001, binder_thickness + 0.001);   
    // vertical binder slot
    translate([wall_thickness / 2.0, wall_thickness + tube_thickness + wall_thickness - binder_thickness, wall_thickness - 0.001])
        cube([binder_width, binder_thickness + 0.001, height - wall_thickness + 0.002]);
    translate([wall_thickness / 2.0, wall_thickness + tube_thickness + wall_thickness - 2*binder_thickness, height - binder_thickness + 0.002])
        shave(binder_width, binder_thickness+ 0.001);

        
    translate([width - binder_width - wall_thickness / 2.0, wall_thickness + tube_thickness + wall_thickness - binder_thickness, wall_thickness -0.001])
        cube([binder_width, binder_thickness + 0.001, height - wall_thickness + 0.002]);
    translate([width - binder_width - wall_thickness / 2.0, wall_thickness + tube_thickness + wall_thickness - 2*binder_thickness, height - binder_thickness + 0.002])
        shave(binder_width, binder_thickness+ 0.001);

        
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
