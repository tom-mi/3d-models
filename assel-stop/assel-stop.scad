outer_width = 24;
outer_height = 8;

thickness = 1;
inner_width = 10;
inner_thickness = 5;
inner_height = 6.5;
wall_thickness = 1.5;


dw = inner_height / 2 - wall_thickness / 2;

cube([outer_width, outer_height, thickness], center=true);
translate([0, dw, inner_thickness / 2 - thickness / 2]) {
    cube([inner_width, wall_thickness, inner_thickness], center=true);
}
translate([0, -dw, inner_thickness / 2 - thickness / 2]) {
    cube([inner_width, wall_thickness, inner_thickness], center=true);
}
