length = 40;
width = 10;
base_thickness = 1;
alignment_plate_thickness = 1;
alignment_plate_height = 2;

reed_switch_height_over_base = 20;

mount_inner_height = 4;
mount_plate_width = 10;
mount_plate_thickness = 1;
mount_contact_gap = 1;
mount_reed_casing_width = 4;
zip_tie_hole_width = 3;
zip_tie_hole_length = 4;
zip_tie_hole_offset = 4;
zip_tie_hole_width_offset1 = mount_plate_thickness;

spacer_width = 2;
spacer_height = reed_switch_height_over_base - base_thickness - mount_plate_thickness - mount_inner_height / 2;

base_magnet_length = 11;
base_magnet_width = 6;
base_magnet_hole_depth = 0.5;
base_magnet_hole_distance_to_wall = 2;


module zip_tie_hole() {
    translate([0, 0, -mount_plate_thickness / 2])
        cube([zip_tie_hole_length, zip_tie_hole_width, mount_plate_thickness * 2]);
}


// base plate
difference() {
    cube([length, width, base_thickness]);
    translate([base_magnet_hole_distance_to_wall, base_magnet_hole_distance_to_wall, base_thickness -
        base_magnet_hole_depth])
        cube([base_magnet_length, base_magnet_width, 2 * base_magnet_hole_depth]);
    translate([length - base_magnet_length - base_magnet_hole_distance_to_wall, base_magnet_hole_distance_to_wall,
            base_thickness - base_magnet_hole_depth])
        cube([base_magnet_length, base_magnet_width, 2 * base_magnet_hole_depth]);

}


// alignment plate
translate([0, -alignment_plate_thickness, -alignment_plate_height])
    cube([length, alignment_plate_thickness, alignment_plate_height + base_thickness]);
// spacer
translate([0, width - spacer_width, base_thickness])
    cube([length, spacer_width, spacer_height]);

// mount - lower plate
translate([0, width - mount_plate_width, base_thickness + spacer_height])
    difference() {
        cube([length, mount_plate_width, mount_plate_thickness]);
        // holes for zip ties
        translate([zip_tie_hole_offset, zip_tie_hole_width_offset1, 0])
            zip_tie_hole();
        translate([length - zip_tie_hole_offset - zip_tie_hole_length, zip_tie_hole_width_offset1, 0])
            zip_tie_hole();
    }
// mount - upper plate
translate([0, width - mount_plate_width, base_thickness + spacer_height + mount_plate_thickness + mount_inner_height])
difference() {
    cube([length, mount_plate_width, mount_plate_thickness]);
    // holes for zip ties
    translate([zip_tie_hole_offset, zip_tie_hole_width_offset1, 0])
        zip_tie_hole();
    translate([length - zip_tie_hole_offset - zip_tie_hole_length, zip_tie_hole_width_offset1, 0])
        zip_tie_hole();
}
translate([0, width - mount_plate_thickness, base_thickness + spacer_height + mount_plate_thickness])
    cube([length, mount_plate_thickness, mount_inner_height]);
translate([0, width - mount_plate_width, base_thickness + spacer_height + mount_plate_thickness])
    cube([length, mount_plate_thickness, mount_inner_height]);
// reed switch inner enclosure
reed_inner_wall_height = (mount_inner_height - mount_contact_gap) / 2;
translate([0, width - mount_reed_casing_width - mount_plate_thickness, base_thickness + spacer_height +
    mount_plate_thickness])
    cube([length, mount_plate_thickness, reed_inner_wall_height]);
translate([0, width - mount_reed_casing_width - mount_plate_thickness, base_thickness + spacer_height +
    mount_plate_thickness + reed_inner_wall_height + mount_contact_gap])
    cube([length, mount_plate_thickness, reed_inner_wall_height]);
