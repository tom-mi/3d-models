tablet_width = 160;
tablet_thickness = 9;
tablet_holder_height = 110;

eps = 0.01;

wall_thickness = 1;
base_wall_thickness = 5;
front_overlap = 3;

hole_diameter = 5;
hole_head_diameter = 10;
hole_head_height = 3;

$fn = 32;

module outer() {
    cube([tablet_width + 2 * wall_thickness,
                tablet_thickness + wall_thickness + base_wall_thickness,
            tablet_holder_height
        ]);
}

module tablet() {
    cube([tablet_width, tablet_thickness, tablet_holder_height + eps]);
}
module opening_front() {
    translate([front_overlap + wall_thickness, -eps, front_overlap]) {
        cube([tablet_width - 2 * front_overlap, wall_thickness + 2 * eps, tablet_holder_height - front_overlap + eps]);
    }
}

module screw_hole(x, y) {
    translate([x, 0, y])
    rotate([-90, 0, 0])
    union() {
        translate([0, 0, wall_thickness + tablet_thickness + base_wall_thickness / 2]) {
            cylinder(h = base_wall_thickness + 2 * eps, d = hole_diameter, center = true);
        }
        translate([0, 0, tablet_thickness + wall_thickness + hole_head_height / 2 - eps]) {
            cylinder(h = hole_head_height + eps, d = hole_head_diameter, center = true);
        }
    }
}

module screw_holes() {
    screw_hole(tablet_width * 0.25, tablet_holder_height * 0.5);
    screw_hole(tablet_width * 0.75, tablet_holder_height * 0.5);
}

difference() {
    outer();
    {
        translate([wall_thickness, wall_thickness, wall_thickness]) {
            tablet();
        }
        opening_front();
        screw_holes();
    }
};