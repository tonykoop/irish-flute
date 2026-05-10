# Irish Flute

Engineering build packet for a keyless D4 Irish flute: a six-hole wooden transverse flute with a cylindrical first-pass bore, simple embouchure, and open-pipe acoustic model.

**Readiness:** L2 design/build-packet scaffold. No prototype measurements, render pass, or source-availability check has been completed. Do not treat the hole positions as build-ready until `validation.csv` is populated.

Part of the [tonykoop/instrument-maker](https://github.com/tonykoop/instrument-maker) catalogue.

## Packet Map

| File / Folder | Purpose |
|---|---|
| `irish-flute-design-table.xlsx` | Existing parametric workbook for the family |
| `design.md` | Governing model, D4 assumptions, first-order tone-hole table |
| `bom.csv` | Materials and shop consumables for one D4 prototype |
| `sourcing.csv` | Sourceability worksheet with verification fields |
| `cut-list.csv` | Stock, bore, embouchure, and tone-hole operations |
| `validation.csv` | Dimensional and tuning checks to fill during the first build |
| `assembly-manual.md` | Shop sequence and gates |
| `drawing-brief.md` | Drawing package requirements |
| `visual-bom-brief.md` | Photo/render plan for the visual BOM |
| `risks.md` | Red-team risks with verification tests |
| `photo-shotlist.md` | Required build photos |
| `resources.md` | Provenance, model sources, and cultural notes |
| `jig-decision.md` | Fixture choices and open setup decisions |
| `drawings/irish-flute-d4-layout.svg` | L2 layout drawing starter |
| `cad/README.md` | CAD starter notes |
| `wolfram-starter.wl` | Wolfram model starter |
| `site/index.html` | Static build-log starter |

## Design Snapshot

| Parameter | D4 prototype | Status |
|---|---:|---|
| Fundamental | D4, 293.66 Hz | target |
| Bore ID | 0.750 in | assumption |
| Wall | 0.125 in | assumption |
| Effective acoustic length | 23.08 in | calculated |
| Physical bore length | 22.63 in | first-order |
| Blank length | 24.50 in | includes trim/setup allowance |
| Tone holes | 6 front holes | first-order |
| Construction | Reamed hardwood tube, hand-cut embouchure | L2 plan |

## Build Posture

This packet uses the open-open cylindrical pipe model from instrument-maker-v4.3. It intentionally excludes Tony's NAF K2 corrections because those are specific to Native American style flutes with slow-air chambers. Irish flute tuning depends strongly on embouchure cut, bore finish, hole diameter, and player technique, so the values here are starting geometry only.

## License

[CC BY 4.0](LICENSE) - see LICENSE for details.
