mount_height = 200;
mount_width = 50;
mount_width = 5;
base_depth = 50;
angle = 15;
back_plate_thickness = 3;
corner_radius = 1;
mount_d1 = 3.5 + 2 * corner_radius;
mount_d2 = 3;

hole_diameter = 3;
hole_offset = 10;



$epsilon = 0.1;
$fn = 100;

p1 = [0, 0];
p1e = [- $epsilon, $epsilon];
p2 = [0, base_depth];
p3 = [- mount_height * cos(angle), - mount_height * sin(angle)];
p3e = [p3[0] - $epsilon, p3[1] + $epsilon];
p4 = [p3[0] + mount_d1 * sin(angle), p3[1] - mount_d1 * cos(angle)];
p4e = [p4[0] - $epsilon, p4[1] - $epsilon];
p5 = [p4[0] + mount_d2 * cos(angle), p4[1] + mount_d2 * sin(angle)];



module back_plate() {
    minkowski() {
        linear_extrude(back_plate_thickness) {
            polygon(points = [p1, p2, p3]);
        };
        cylinder(r = corner_radius, h = $epsilon, center = true);
    }
};

module mount() {
    minkowski() {
        linear_extrude(mount_width) {
            polygon(points = [p1, p2, p1e, p3e, p4e, p5, p4, p3]);
        };
        cylinder(r = corner_radius, h = $epsilon, center = true);
    };
};

module back_plate_hole() {
    rotate([0, 90, 0]) {
        cylinder(d = hole_diameter, h = back_plate_thickness * 3, center = true);
    };
};

module back_plate_holes() {
    translate([0, hole_offset, hole_offset + back_plate_thickness]) {
        back_plate_hole();
    };
    translate([0, base_depth - hole_offset, hole_offset + back_plate_thickness]) {
        back_plate_hole();
    };
    translate([0, hole_offset, base_depth - hole_offset]) {
        back_plate_hole();
    };
    translate([0, base_depth - hole_offset, mount_width - hole_offset]) {
        back_plate_hole();
    };
};

//difference() {
//    union() {
//        back_plate();
//        mount();
//    };
//    back_plate_holes();
//};
mount();
