# Irish Flute Risk Register

## Acoustic Risks

| ID | Risk | Severity | Mitigation | Verification |
|---|---|---|---|---|
| AC-01 | First-order hole positions do not tune on the actual flute | High | Drill undersize and tune one hole at a time | Record cents error for every hole in `validation.csv` |
| AC-02 | Embouchure geometry shifts effective length | High | Test embouchure on scrap and measure fundamental before drilling | V-FUND within tolerance or design updated |
| AC-03 | NAF K2 correction is misapplied | High | Explicitly exclude NAF corrections in `design.md` | Reviewer confirms no K2 offsets in D4 table |

## Structural Risks

| ID | Risk | Severity | Mitigation | Verification |
|---|---|---|---|---|
| ST-01 | Bore wander leaves a thin wall | High | Scrap bore validation before tonewood | V-BORE-WANDER passes |
| ST-02 | Embouchure or tone-hole tearout cracks the body | Medium | Sharp tools, backing support, seal end grain | Visual inspection after each cut |

## Ergonomic And Shop Risks

| ID | Risk | Severity | Mitigation | Verification |
|---|---|---|---|---|
| ER-01 | Hole spread is uncomfortable | Medium | Player reach test before final hole sizing | V-ERG passes |
| SH-01 | Long drill grabs or walks | High | Conservative RPM, peck clearing, secure workholding | Scrap process log accepted |
| SU-01 | Long boring bit unavailable | Medium | Verify source before cutting stock | `sourcing.csv` marked verified |

## Release Gate

This packet remains L2 until the D4 prototype is built, measured, photographed, and the validation worksheet replaces TBD values with actual measurements.
