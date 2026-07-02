(* instrument-maker-v4.2 Wolfram packet source *)
ClearAll["Global`*"];

packetDir = "/mnt/c/Users/Tony/Documents/GitHub/instruments/woodwind/irish-flute";
metadata = <|
  "PacketName" -> "Irish Flute - Design Document",
  "PacketPath" -> ".",
  "GeneratedOn" -> "2026-07-01",
  "Model" -> "OpenPipe",
  "HasFamilySpec" -> True,
  "HasValidation" -> True,
  "HasCncPlan" -> False
|>;

familySpecPath = FileNameJoin[{packetDir, "family-spec.csv"}];
validationPath = FileNameJoin[{packetDir, "validation.csv"}];
cncPlanPath = FileNameJoin[{packetDir, "cnc", "cnc-plan.json"}];

familySpec = If[FileExistsQ[familySpecPath],
  Import[familySpecPath, "Dataset"],
  Dataset[ImportString["[{\"member_id\": \"IFL-D4\", \"target_key\": \"D4\", \"target_hz\": \"293.66\", \"acoustic_law\": \"open_open\", \"end_condition\": \"both_ends_open\", \"bore_id_mm\": \"19.0\", \"tonehole_count\": \"6+thumb\", \"material_system\": \"wood/grenadilla/ebonite\", \"dimension_provenance\": \"measurement_required\", \"source_artifact\": \"irish-flute-design-table.xlsx\", \"notes\": \"L2 scaffold; bore ID and tonehole positions are first-order model predictions. Dimensions require design-table review and prototype measurement confirmation before fabrication authority.\"}]", "JSON"]]
];

validationData = If[FileExistsQ[validationPath],
  Import[validationPath, "Dataset"],
  Dataset[ImportString["[{\"check_id\": \"V-SCRAP-BORE\", \"category\": \"process\", \"parameter\": \"Scrap bore completed before tonewood\", \"target\": \"yes\", \"tolerance\": \"required\", \"method\": \"build log\", \"measured\": \"TBD\", \"cents_error\": \"\", \"pass_fail\": \"TBD\", \"date\": \"\", \"notes\": \"Do not bore tonewood until this passes\"}, {\"check_id\": \"V-BORE-ID\", \"category\": \"dimensional\", \"parameter\": \"Bore ID\", \"target\": \"0.750 in\", \"tolerance\": \"+/-0.005 in\", \"method\": \"bore gauge\", \"measured\": \"TBD\", \"cents_error\": \"\", \"pass_fail\": \"TBD\", \"date\": \"\", \"notes\": \"Measure entry/mid/exit\"}, {\"check_id\": \"V-BORE-WANDER\", \"category\": \"dimensional\", \"parameter\": \"Bore wander\", \"target\": \"<0.030 in\", \"tolerance\": \"maximum\", \"method\": \"calipers at exit\", \"measured\": \"TBD\", \"cents_error\": \"\", \"pass_fail\": \"TBD\", \"date\": \"\", \"notes\": \"Reject process if greater than target\"}, {\"check_id\": \"V-WALL\", \"category\": \"dimensional\", \"parameter\": \"Minimum wall thickness\", \"target\": \">=0.110 in\", \"tolerance\": \"minimum\", \"method\": \"calipers\", \"measured\": \"TBD\", \"cents_error\": \"\", \"pass_fail\": \"TBD\", \"date\": \"\", \"notes\": \"Check around embouchure and tone holes\"}, {\"check_id\": \"V-FUND\", \"category\": \"acoustic\", \"parameter\": \"All-closed fundamental\", \"target\": \"D4 293.66 Hz\", \"tolerance\": \"+/-5 cents\", \"method\": \"chromatic tuner\", \"measured\": \"TBD\", \"cents_error\": \"TBD\", \"pass_fail\": \"TBD\", \"date\": \"\", \"notes\": \"Measure before drilling tone holes\"}, {\"check_id\": \"V-H1\", \"category\": \"acoustic\", \"parameter\": \"Hole 1 E4\", \"target\": \"329.63 Hz\", \"tolerance\": \"+/-10 cents\", \"method\": \"chromatic tuner\", \"measured\": \"TBD\", \"cents_error\": \"TBD\", \"pass_fail\": \"TBD\", \"date\": \"\", \"notes\": \"Drill undersize and open gradually\"}, {\"check_id\": \"V-H2\", \"category\": \"acoustic\", \"parameter\": \"Hole 2 F#4\", \"target\": \"369.99 Hz\", \"tolerance\": \"+/-10 cents\", \"method\": \"chromatic tuner\", \"measured\": \"TBD\", \"cents_error\": \"TBD\", \"pass_fail\": \"TBD\", \"date\": \"\", \"notes\": \"\"}, {\"check_id\": \"V-H3\", \"category\": \"acoustic\", \"parameter\": \"Hole 3 G4\", \"target\": \"392.00 Hz\", \"tolerance\": \"+/-10 cents\", \"method\": \"chromatic tuner\", \"measured\": \"TBD\", \"cents_error\": \"TBD\", \"pass_fail\": \"TBD\", \"date\": \"\", \"notes\": \"\"}]", "JSON"]]
];

frequencyFromMidi[midi_, a4_: 440] := a4*2^((midi - 69)/12);
centsError[measured_, target_] := 1200*Log[2, measured/target];
openPipeLengthIn[freq_, c_: 13552, radius_: 0] := c/(2*freq) - 2*0.6*radius;
stoppedPipeLengthIn[freq_, c_: 13552, radius_: 0] := c/(4*freq) - 0.6*radius;
helmholtzFrequency[area_, volume_, leff_, c_: 13552] :=
  (c/(2*Pi))*Sqrt[area/(volume*leff)];
cantileverFrequency[k_, thickness_, length_] := k*thickness/length^2;
stringFrequency[length_, tension_, linearDensity_] :=
  1/(2*length)*Sqrt[tension/linearDensity];

modelExplorer = Switch[metadata["Model"],
  "Helmholtz",
    Manipulate[
      helmholtzFrequency[portArea, chamberVolume, effectiveLength],
      {{portArea, 0.4, "port area (in^2)"}, 0.05, 4},
      {{chamberVolume, 40, "volume (in^3)"}, 5, 400},
      {{effectiveLength, 0.6, "effective length (in)"}, 0.05, 3}
    ],
  "OpenPipe",
    Manipulate[
      openPipeLengthIn[f, 13552, radius],
      {{f, 440, "target Hz"}, 80, 1200},
      {{radius, 0.375, "bore radius (in)"}, 0, 1.5}
    ],
  "StoppedPipe",
    Manipulate[
      stoppedPipeLengthIn[f, 13552, radius],
      {{f, 220, "target Hz"}, 40, 1000},
      {{radius, 0.375, "bore radius (in)"}, 0, 1.5}
    ],
  "CantileverBeam",
    Manipulate[
      cantileverFrequency[k, thickness, length],
      {{k, 24000, "K constant"}, 1000, 80000},
      {{thickness, 0.25, "thickness (in)"}, 0.05, 1},
      {{length, 4.5, "length (in)"}, 0.5, 24}
    ],
  _,
    Manipulate[
      frequencyFromMidi[midi],
      {{midi, 69, "MIDI note"}, 24, 96, 1}
    ]
];

audioPreview[f_: 440, seconds_: 1.5] :=
  AudioNormalize[
    AudioAdd[
      AudioGenerator[{"Sin", f}, seconds],
      .35 AudioGenerator[{"Sin", 2 f}, seconds],
      .18 AudioGenerator[{"Sin", 3 f}, seconds]
    ]
  ];

validationRows = Normal[validationData];
validationPlot = Quiet@Check[
  ListPlot[
    DeleteMissing[
      ToExpression /@ Lookup[validationRows, "Cents Error", Missing[]]
    ],
    PlotTheme -> "Scientific",
    Frame -> True,
    FrameLabel -> {{"Cents error", None}, {"Measurement row", metadata["PacketName"]}}
  ],
  "No numeric validation cents-error values yet."
];

packetNotebook[] := CreateDocument[
  {
    TextCell[metadata["PacketName"], "Title"],
    TextCell["instrument-maker v4.2 computational packet", "Subtitle"],
    TextCell["Metadata", "Section"],
    ExpressionCell[metadata, "Input"],
    TextCell["Family/design data", "Section"],
    ExpressionCell[familySpec, "Input"],
    TextCell["Model explorer", "Section"],
    ExpressionCell[modelExplorer, "Input"],
    TextCell["Audio preview", "Section"],
    ExpressionCell[audioPreview[440], "Input"],
    TextCell["Validation", "Section"],
    ExpressionCell[validationPlot, "Input"]
  },
  WindowTitle -> metadata["PacketName"]
];

packetNotebook[];
