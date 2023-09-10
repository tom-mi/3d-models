mount_height = 220;
mount_width = 50;
base_depth = 80;
angle = 30;
back_plate_thickness = 1;
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
p6 = [-base_depth * 0.2 * sin(angle), base_depth * 0.2 * cos(angle)];



module back_plate() {
    minkowski() {
        linear_extrude(back_plate_thickness) {
            polygon(points = [p1, p2, p6, p3]);
        };
        cylinder(r = corner_radius, h = $epsilon, center = true);
    }
};
module front_plate() {
  translate([0, 0, mount_width]) {
      back_plate();
  };
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
    translate([0, hole_offset, mount_width - hole_offset]) {
        back_plate_hole();
    };
    translate([0, base_depth - hole_offset, mount_width - hole_offset]) {
        back_plate_hole();
    };
};

difference() {
    union() {
        back_plate();
        front_plate();
        mount();
    };
    back_plate_holes();
};

