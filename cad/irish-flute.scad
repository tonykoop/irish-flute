// =============================================================
// Irish Flute — Parametric OpenSCAD Master
// =============================================================
// Source of truth: design.md (Governing Model + Tone-Hole First Pass table),
// family-spec.csv (IFL-D4 row), cut-list.csv (stock/OD).
//
// Authority status: pending_measurement — NOT fabrication authority until
// reviewed against a measured D4 prototype (validation.csv V-FUND and
// per-hole cents-error rows). See cad/mcp-session-log.md for provenance.
//
// SCOPE BOUNDARY (tuning-sensitive geometry intentionally out of scope):
//   - Embouchure window/bevel geometry is NOT modeled here. design.md A2
//     notes the embouchure correction is only an ordinary open-end
//     approximation; real embouchure cutting must be hand-refined and
//     play-tested (cad/README.md "Model Order" step 2).
//   - Tone-hole undercutting/voicing is NOT modeled; holes are drawn at
//     the design.md starter diameters only, "drill undersize and tune
//     up incrementally" (design.md A3).
//   - This is an open-open cylindrical-bore envelope + tone-hole position
//     schedule only, per the instrument-maker starter-generator boundary.
// =============================================================

$fn = 96;

// --------- INPUT PARAMETERS (edit only against design.md / family-spec.csv) ---

// Governing acoustic model (design.md "Governing Model"): open-open
// cylindrical pipe.  f = c / (2*L_eff);  L_eff = c / (2*f);
// L_bore = L_eff - 2*(0.6*r)   [two open-end corrections]
c_in_per_sec      = 13552;   // speed of sound @ 68F/20C (design.md)
f_root_hz         = 293.66;  // D4 target (design.md, family-spec.csv IFL-D4)

bore_id_in        = 0.750;   // D4 prototype bore ID (design.md; family-spec.csv bore_id_mm=19.0)
bore_r_in         = bore_id_in / 2;

body_od_in        = 1.000;   // finished OD (cut-list.csv item 1 final_od_in)
wall_in           = (body_od_in - bore_id_in) / 2;  // = 0.125 in (design.md A4)

L_eff_in          = c_in_per_sec / (2 * f_root_hz);           // acoustic length
end_corr_total_in = 2 * (0.6 * bore_r_in);                    // two open ends
L_bore_in         = L_eff_in - end_corr_total_in;             // first-order physical bore

// Tone-hole schedule — design.md "Tone-Hole First Pass" table.
// [note, freq_hz, distance_from_foot_in, starter_diameter_in]
// distance_from_foot = L_eff * (1 - f_root/f_hole); tabulated in design.md,
// reproduced here as data (not re-derived) so this file matches the
// reviewed design.md table exactly. Diameters are conservative starters —
// "drill undersize and tune up incrementally" (design.md A3).
tone_holes = [
    ["E4",  329.63,  2.58, 0.250],
    ["F#4", 369.99,  4.76, 0.281],
    ["G4",  392.00,  5.77, 0.281],
    ["A4",  440.00,  7.68, 0.313],
    ["B4",  493.88,  9.38, 0.313],
    ["C#5", 554.37, 10.89, 0.313],
];

hole_drill_len_in = wall_in * 4;  // clean through-cut allowance for the diff() cutter

// --------- MODULES ---------------------------------------------------------

// Cylindrical body: OD wall around the bore, length = L_bore_in (first-order;
// design.md notes a further 1.87 in trim/setup allowance before final cut —
// not modeled here, this is the target bore length only).
module flute_body() {
    difference() {
        cylinder(h = L_bore_in, d = body_od_in);
        translate([0, 0, -0.01])
            cylinder(h = L_bore_in + 0.02, d = bore_id_in);
    }
}

// One tone hole, drilled radially at the documented distance from the foot
// (z=0) end, on the +X side of the body.
module tone_hole(distance_from_foot_in, diameter_in) {
    translate([0, 0, distance_from_foot_in])
        rotate([0, 90, 0])
            cylinder(h = hole_drill_len_in, d = diameter_in, center = true);
}

// Top-level assembly: body with all six tone holes cut.
module irish_flute_d4() {
    difference() {
        flute_body();
        for (h = tone_holes) {
            tone_hole(h[2], h[3]);
        }
    }
}

irish_flute_d4();

echo(str("L_eff (acoustic length) = ", L_eff_in, " in"));
echo(str("L_bore (first-order physical bore) = ", L_bore_in, " in"));
echo(str("bore_id = ", bore_id_in, " in;  body_od = ", body_od_in, " in;  wall = ", wall_in, " in"));
echo(str("tone holes modeled: ", len(tone_holes)));
