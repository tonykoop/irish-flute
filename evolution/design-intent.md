# Design Intent — irish-flute rev A

- Master CAD: `cad/irish-flute.scad` (sha256: f6063eaa2beac330208694ebef8f406d11d7c9bcca66b0f07274039c1f69dd89), driven by `design.md` governing model + `irish-flute-design-table.xlsx` (sha256: ff5f6c298f1c7fad84eeeb5f1f2fa9e5dd4fb7b002ebf7af7879a9d59cc673fc)
- Function: Keyless six-hole wooden transverse flute, D4 root, modeled as an open-open cylindrical pipe (`f = c/(2*L_eff)`). No slow-air chamber; transverse embouchure gives a different end-correction regime than NAF-style flutes (design.md explicitly excludes NAF K2 corrections).
- Environment: hand-held wind instrument; wood body, cylindrical bore, tuned by incremental hole-opening after boring.
- Target qty: 1 (D4 prototype). Deadline: TBD. Budget/unit ceiling: TBD.

## Critical dimensions (carry tolerances)

| Feature | Nominal | Tolerance | Why critical | Source |
| --- | --- | --- | --- | --- |
| Bore ID | 0.750 in | measured after boring, before final cut | intonation/wall strength | design.md Governing Model (design_table_backed) |
| L_eff (acoustic length) | 23.08 in | derived from f_root=293.66 Hz | fundamental pitch | design.md formula (design_table_backed) |
| L_bore (physical bore) | 22.63 in | +1.87 in trim/setup allowance before final cut | fundamental pitch, do not cut short | design.md Governing Model (design_table_backed) |
| Tone hole 1 (E4) | 2.58 in from foot, 0.250 in dia | drill undersize, tune by opening (risks.md AC-01) | intonation | design.md Tone-Hole First Pass table (measurement_required) |
| Tone hole 4 (A4) | 7.68 in from foot, 0.313 in dia | drill undersize, tune by opening (risks.md AC-01) | intonation | design.md Tone-Hole First Pass table (measurement_required) |
| Wall thickness | 0.125 in | verify with calipers after boring (design.md A4) | crack risk near embouchure/holes | design.md Assumptions (measurement_required) |

## Incidental (free for DFM)

- Exterior finish (Danish oil/shellac), ergonomic exterior shaping outside the bore/hole geometry, cosmetic body profile.

## Must-nots (DFM may never violate)

- Do not apply NAF K2 bore corrections — the Irish flute's transverse embouchure has a different end-correction regime (design.md Governing Model).
- Do not cut the body to final length before the embouchure is tested on scrap and fundamental is measured (risks.md AC-02; design.md A2 "measure the bored blank... before drilling holes").
- Do not drill tone holes to final diameter directly — pilot undersize, tune by opening incrementally, one hole at a time (risks.md AC-01, design.md A3).
- Do not skip the scrap-blank bore validation before boring tonewood (risks.md ST-01, bom.csv item 2 "mandatory before tonewood").
- Embouchure window/bevel and tone-hole undercutting are out of scope for cad/irish-flute.scad — hand-refine and play-test (design.md A2/A3; cad/README.md Scope Boundary).

## Material intent

- Preferred: blackwood/cherry/maple hardwood body blank (bom.csv item 1).
- Acceptable subs: poplar/pine for the mandatory scrap/practice bore blank (bom.csv item 2).
- Forbidden: none recorded beyond the practice-blank-before-tonewood sequencing above.

## Stage status

Stage 0 intake complete 2026-07-01. Gate A (Alpha shop compile) NOT yet run — no concessions logged, nothing presented as shippable. Packet remains L2 per README until the D4 prototype is built, measured, and validation.csv is populated (risks.md Release Gate).
