# CAD / MCP Session Log — irish-flute

No external MCP or creative-tool sessions have produced artifacts in this packet as of 2026-05-29.
The SVG in `drawings/` was generated from the design-table by a prior sprint agent without an
interactive OpenSCAD MCP, Blender MCP, Illustrator MCP, or image-gen session.

When an OpenSCAD MCP, Blender MCP, or image-gen session produces or modifies a repo artifact,
add a row to the table below before committing that artifact.

| session_id | tool | input_authority | outputs | role | authority_result | review_status | notes |
|---|---|---|---|---|---|---|---|
| — | — | — | — | — | — | — | No sessions recorded. |
| fable-v5-refresh-2026-07-01 | claude-code (Fable 5) | irish-flute-design-table.xlsx, bom.csv, sourcing.csv, cut-list.csv, validation.csv | bom.csv, sourcing.csv, cut-list.csv, validation.csv | packet_refresh | fabrication | self_checked | V5 refresh pass: README status-line format fixed (bold-colon bug); tabular packet data reviewed against design-table baseline, no dimension changes made. |
| fable-v5-refresh-2026-07-01 | claude-code (Fable 5) + OpenSCAD CLI | design.md, family-spec.csv, cut-list.csv | cad/irish-flute.scad | cad_authoring | pending_measurement | self_checked | Authored new parametric master (no prior .scad existed): open-open cylindrical bore envelope (parametric L_eff/L_bore formulas per design.md) + design.md's six-hole tone-hole schedule. Embouchure/undercutting explicitly out of scope. openscad render check: pass (openscad -o STL, exit 0; L_eff=23.0743in, L_bore=22.6243in, matching design.md's 23.08/22.63). |
| fable-v5-refresh-2026-07-01 | claude-code (Fable 5) + generate_wolfram_packet.py | irish-flute-design-table.xlsx, family-spec.csv, validation.csv | wolfram/irish-flute-wolfram-model.wl | analysis_source | derived_preview | unreviewed | Generated via $SKILL/generate_wolfram_packet.py (not executed — no --execute passed); renamed from instrument-model.wl; source-only L2 evidence, distinct from existing irish-flute-starter.wl. |
