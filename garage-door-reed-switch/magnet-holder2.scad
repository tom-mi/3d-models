length = 10;
width = 20;
base_thickness = 1;

magnet_height_over_base = 31;
magnet_offset_from_center = 25;


magnet_length = 4;
magnet_width = 11;
magnet_hole_depth = 0.5;
magnet_hole_distance_to_wall = 1;

spacer_height = magnet_height_over_base - base_thickness - magnet_height_over_base / 2 - magnet_hole_distance_to_wall;

horizontal_spacer_width = magnet_offset_from_center - width / 2 ;

magnet_holder_width = magnet_width + 2 * magnet_hole_distance_to_wall;
magnet_holder_length = magnet_length + 2 * magnet_hole_distance_to_wall;




// base plate
cube([length, width, base_thickness]);
// vertical spacer
translate([0, 0, base_thickness])
    cube([length, base_thickness, spacer_height]);
// horizontal spacer
translate([0, -horizontal_spacer_width, spacer_height])
    cube([length, horizontal_spacer_width, base_thickness]);
// magnet plate
translate([0, -horizontal_spacer_width , spacer_height + base_thickness])
    difference() {
        cube([base_thickness, magnet_holder_length, magnet_holder_width - base_thickness]);
        translate([magnet_hole_depth, magnet_hole_distance_to_wall, magnet_hole_distance_to_wall - base_thickness])
            cube([2 * magnet_hole_depth, magnet_length, magnet_width]);
    }
