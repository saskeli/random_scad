$fn=100;

use <threads.scad>

axle_length = 165;
thread_pitch = 1.75;
thread_length = 23;
axle_diameter = 12;
wall_thickness = 3;
plug_diameter = 20;
plug_length = 15;
countersink_length = 3.5;
hex_size = 6;
hex_depth = 7;


color([0.6,0.6,0.6])
translate([0,axle_length/2,0]) {
    difference() {
        exterior(l=axle_length,
                 tp=thread_pitch,
                 tl=thread_length,
                 d=axle_diameter, 
                 pd=plug_diameter,
                 pl=plug_length,
                 cl=countersink_length);
        id = axle_diameter - (2 * wall_thickness);
        interior(l=axle_length,
                 d=id,
                 hs=hex_size,
                 hd=hex_depth);
    }
}

module interior(l,d,hs,hd) {
    rotate([90,0,0]) {
        translate([0,0,-20]) {
            cylinder(h=l+20,d=d);
            hex(d=hs,l=hd+20);
        }
    }
}

module hex(d=6,l=30) {
    translate([0,0,l/2]) {
        intersection() {
            cube([d,d*2,l],center=true);
            rotate([0,0,60]) {
                cube([d,d*2,l],center=true);
            }
            rotate([0,0,120]) {
                cube([d,d*2,l],center=true);
            }
        }
    }
}

module exterior(l,tp,tl,d,pd,pl,cl) {
    translate([0,-l,0]) {
        rotate([-90,0,0]) {
            thread_cylinder(l,tp,tl,d);
        }
    }
    plug(pl,pd,d,cl);
}

module plug(h,d,ld,cl) {
    gr = h * (d/2)/ld + ld/2;
    rotate([90,0,0]) {
        intersection() {
            cylinder(h=h,d=d);
            cylinder(h=h,r1=gr,r2=ld/2);
        }
    }
}

module thread_cylinder(l,tp,tl,d) {
    difference() {
        cylinder(h=l,d=d-0.01);
        difference() {
            cylinder(h=tl,d=d);
            translate([0,0,-5]) {
                metric_thread(diameter=d,pitch=tp,length=tl+10,internal=true);
            }
        };
    }
}
