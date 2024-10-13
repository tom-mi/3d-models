// Rectangular bracket with two flanges and holes on each flange
module bracket (
    inner_width,
    inner_height,
    length,
    thickness = 3,
    n_holes_per_side = 2,
    hole_diameter = 3,
    flange_width = 10,
) {
    upper_hole_diameter = hole_diameter  + thickness;

    assert(inner_width > 0, "inner_width must be > 0");
    assert(inner_height > 0, "inner_height must be > 0");
    assert(thickness > 0, "thickness must be > 0");
    assert(n_holes_per_side > 0, "n_holes_per_side must be > 0");
    assert(hole_diameter > 0, "hole_diameter must be > 0");
    assert(flange_width > upper_hole_diameter, "flange_width must be > hole_diameter + thickness");
    assert(length > n_holes_per_side * flange_width, "length must be > n_holes_per_side * flange_width");

    eps = 0.01;
    module flange() {
        difference() {
            cube([flange_width, length, thickness]);
            if (n_holes_per_side == 1) {
                translate([flange_width / 2, length / 2, thickness / 2]) {
                    cylinder(d=hole_diameter, h=thickness + eps, center=true, $fn = 20);
                }
            } else {
                hole_distance = (length - flange_width) / (n_holes_per_side - 1);
                for (i = [0:n_holes_per_side - 1]) {
                    hole_position = flange_width / 2 + hole_distance * i;
                    translate([flange_width / 2, hole_position, thickness / 2]) {
                        cylinder(d1 = hole_diameter, d2 = upper_hole_diameter, h = thickness + eps, center = true, $fn = 20);
                    }
                }
            }
        }
    }

    module side() {
        cube([thickness, length, inner_height]);
    }

    module top() {
        cube([inner_width + thickness * 2, length, thickness]);
    }

    flange();
    translate([flange_width + 2 * thickness + inner_width, 0, 0]) {
        flange();
    }
    translate([flange_width, 0, 0]) {
        side();
    }
    translate([flange_width + thickness + inner_width, 0, 0]) {
        side();
    }
    translate([flange_width, 0, inner_height]) {
        top();
    }
}