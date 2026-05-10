# Irish Flute - Design Document

**Instrument:** Keyless Irish flute  
**Prototype target:** D4 six-hole wooden transverse flute  
**Family:** Open-open cylindrical pipe, transverse embouchure  
**Packet version:** instrument-maker-v4.3 root-mode L2 scaffold  
**Readiness:** Design packet only. Physical validation pending.

## Governing Model

The first-pass acoustic model treats the flute as an open-open cylindrical pipe:

```text
f = c / (2 * L_eff)
L_eff = c / (2 * f)
L_bore = L_eff - 2 * (0.6 * r)
```

At 68 F / 20 C, `c = 13552 in/s`. For D4 at 293.66 Hz:

| Quantity | Value | Notes |
|---|---:|---|
| `L_eff` | 23.08 in | acoustic length |
| Bore ID | 0.750 in | D4 prototype assumption |
| Radius | 0.375 in | derived |
| Total end correction | 0.450 in | two open ends |
| `L_bore` | 22.63 in | first-order physical bore |
| Trim/setup allowance | 1.87 in | do not cut short |
| Rough blank | 24.50 in | stock prep target |

Do not apply NAF K2 corrections. The Irish flute has no slow-air chamber, and the transverse embouchure creates a different end-correction regime.

## Tone-Hole First Pass

Distances are measured from the open foot end to the hole center. Hole diameters are intentionally conservative; final tuning is by measured pitch and incremental opening/undercutting.

| Hole | Note | Freq Hz | Distance From Foot In | Distance From Foot Mm | Starter Diameter In | Status |
|---|---:|---:|---:|---:|---:|---|
| 1 | E4 | 329.63 | 2.58 | 65.5 | 0.250 | estimate |
| 2 | F#4 | 369.99 | 4.76 | 120.9 | 0.281 | estimate |
| 3 | G4 | 392.00 | 5.77 | 146.6 | 0.281 | estimate |
| 4 | A4 | 440.00 | 7.68 | 195.1 | 0.313 | estimate |
| 5 | B4 | 493.88 | 9.38 | 238.3 | 0.313 | estimate |
| 6 | C#5 | 554.37 | 10.89 | 276.6 | 0.313 | estimate |

Formula used:

```text
distance_from_foot = L_eff * (1 - f_root / f_hole)
```

## Assumptions And Known Gaps

| ID | Assumption / Gap | Impact | Resolution |
|---|---|---|---|
| A1 | Bore is cylindrical at 0.750 in ID | Real Irish flutes often use conical/tapered behavior | Keep this as D4 prototype baseline; add tapered-body variant after measurements |
| A2 | Embouchure correction is represented by ordinary open-end correction | Fundamental may be off after cutting the embouchure | Measure the bored blank and update `validation.csv` before drilling holes |
| A3 | Hole diameters are starter values | Notes may be flat until holes are opened | Drill undersize and tune up incrementally |
| A4 | Wall thickness 0.125 in | Structural crack risk around embouchure and holes | Verify wall with calipers after boring |
| A5 | D4 is the primary build | Other keys remain workbook-only | Add family members after D4 measured data exists |

## Cross-References

- Workbook: `irish-flute-design-table.xlsx`
- Layout starter: `drawings/irish-flute-d4-layout.svg`
- Wolfram starter: `wolfram-starter.wl`
- Build sequence: `assembly-manual.md`
- Validation worksheet: `validation.csv`
