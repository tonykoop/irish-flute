(* Irish Flute D4 - Wolfram starter, L2 scaffold *)

cSoundInches[tempF_] := 13552.0*Sqrt[(tempF + 459.67)/(68 + 459.67)];
midiToHz[m_] := 440.0*2^((m - 69)/12);
endCorrection[boreID_] := 0.6*(boreID/2);
openPipeLength[f_, boreID_, tempF_:68] :=
  cSoundInches[tempF]/(2*f) - 2*endCorrection[boreID];

rootHz = midiToHz[62]; (* D4 *)
boreID = 0.750;
lBore = openPipeLength[rootHz, boreID, 68];
holeOffsets = {2, 4, 5, 7, 9, 11};
holeFrequencies = midiToHz[62 + #] & /@ holeOffsets;
holeDistancesFromFoot =
  (cSoundInches[68]/(2*rootHz))*(1 - rootHz/#) & /@ holeFrequencies;

Dataset[
  MapThread[
    <|"offset" -> #1, "freqHz" -> #2, "distanceFromFootIn" -> #3|> &,
    {holeOffsets, holeFrequencies, holeDistancesFromFoot}
  ]
]
