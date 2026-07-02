# Irish Flute CAD Starter

`irish-flute.scad` is a parametric OpenSCAD master (V5 refresh, 2026-07-01):
open-open cylindrical bore envelope (formulas from design.md's governing
model) plus the six tone holes from design.md's Tone-Hole First Pass table.
It is `pending_measurement` authority — not fabrication-ready until reviewed
against a measured D4 prototype.

## Parameters (see cad/irish-flute.scad header)

- `bore_id_in = 0.750 in`
- `body_od_in = 1.000 in`
- `L_bore_in` — computed from `c_in_per_sec` and `f_root_hz` (design.md
  governing model), not a baked value.
- `tone_holes` — distance-from-foot + starter diameter per hole, from
  design.md's table.

## Scope Boundary (still not modeled — build these by hand)

1. Embouchure cut feature with editable bevel — tuning-sensitive, out of
   scope for this starter (design.md A2).
2. Tone-hole undercutting/voicing — holes are drawn at starter diameters
   only; tune by opening incrementally (design.md A3).
3. Optional ergonomic exterior shaping.

Rebuild the model from the measured D4 prototype (not just the first-order
table) once `validation.csv` has real fundamental and per-hole pitch data.
