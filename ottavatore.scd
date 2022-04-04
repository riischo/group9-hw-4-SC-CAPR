(
///////////////////BUSSES//////////////////////////////
~dryBus = Bus.audio(s,1);
~hiOctBusOut = Bus.audio(s,1);
~lowOctBusOut = Bus.audio(s,1);
~dryPanBus = Bus.control(s,1);
~hiOctPanBus = Bus.control(s,1);
~lowOctPanBus = Bus.control(s,1);
~mixOutBusL = Bus.audio(s,1);
~mixOutBusR = Bus.audio(s,1);

///////////////////////GROUPS///////////////////////////////

~sourceGroup = Group.new;
~octaveGroup = Group.new(~sourceGroup, \addAfter);
~panGroup = Group.new(~octaveGroup,\addAfter);
~mixGroup = Group.new(~panGroup,\addAfter);
~masterGroup = Group.new(~mixGroup,\addAfter);

///////////////////////SynthDefs////////////////////////////

///////CLEAN Input//////////

SynthDef(\cleanInput, {
	arg output, gain = 1;
	var input;
	input = SoundIn.ar(0, gain);
	output = Out.ar(output, input);
}).add;

////////////////LOW AND HIGH OCTAVER SYNTHS/////////////////

SynthDef(\lowOctaver, {
	arg lowOn = 0, oLmul = 0.5, numLow = 1, output, input;
	var octaveLow;
	octaveLow = PitchShift.ar(
		in:In.ar(input),
		windowSize: 0.08,
		pitchRatio: 1/(2*numLow),
//		timeDispersion: 0.015,
		mul:oLmul*lowOn);
	ReplaceOut.ar(
			bus:output,
		channelsArray: octaveLow);
}).add;


////////////////LOW AND HIGH OCTAVER SYNTHS/////////////////
SynthDef(\hiOctaver, {
	arg hiOn = 0, oHmul = 0.5, numHi = 1, output, input;
	var octaveHi;
	octaveHi = PitchShift.ar(
		in:In.ar(input),
		windowSize: 0.08,
		pitchRatio: 2*numHi,
		timeDispersion: 0.015,
		mul:oHmul*hiOn);
	ReplaceOut.ar(
			bus:output,
		channelsArray: octaveHi);
}).add;

////////////////LOW AND HIGH OCTAVER SYNTHS/////////////////

SynthDef.new(\pan, {
	arg panFreq = 1, autoPan = 0, panPos = 0, output;
	var pan;
	//If autoPan activated, the pan oscillates L-R; if not it stays in PanPos
	pan = Select.kr(
		autoPan,
		[
			panPos,
			FSinOsc.kr(panFreq)

		]
	);
ReplaceOut.kr(output,pan);
}).add;

////////////MIX Synth//////////

SynthDef(\mix, {
	arg wet = 0.5;
	var dry = 1.0 - wet;
	var dryPanned, lowPanned, hiPanned;
	dryPanned = Pan2.ar(In.ar(~dryBus)*dry,In.kr(~dryPanBus));
	hiPanned = Pan2.ar(In.ar(~hiOctBusOut)*wet,In.kr(~hiOctPanBus));
	lowPanned = Pan2.ar(In.ar(~lowOctBusOut)*wet,In.kr(~lowOctPanBus));
	ReplaceOut.ar(bus:~mixOutBusL,
		channelsArray:hiPanned[0]+lowPanned[0]+dryPanned[0]);
	ReplaceOut.ar(bus:~mixOutBusR,
		channelsArray:hiPanned[1]+lowPanned[1]+dryPanned[1]);
}).add;

///////////MASTER Synth/////////////

SynthDef(\master, {
	var inputL, inputR;
	inputL = In.ar(~mixOutBusL);
	inputR = In.ar(~mixOutBusR);
	ReplaceOut.ar(0, inputL);
	ReplaceOut.ar(1, inputR)
}).add;


////////////////////////////SYNTHS INSTANCES/////////////////////////
~drySynth = Synth.new(\cleanInput,[\output, ~dryBus.index],~sourceGroup);
~hiOctSynth = Synth.new(\hiOctaver,[\input, ~dryBus.index, \output, ~hiOctBusOut.index],~octaveGroup);
~lowOctSynth = Synth.new(\lowOctaver,[\input, ~dryBus.index, \output, ~lowOctBusOut.index],~octaveGroup);
~dryPanSynth = Synth.new(\pan,[\output, ~dryPanBus.index],~panGroup);
~hiPanSynth = Synth.new(\pan,[\output, ~hiOctPanBus.index],~panGroup);
~lowPanSynth = Synth.new(\pan,[\output, ~lowOctPanBus.index],~panGroup);
~mixSynth = Synth.new(\mix,[],~mixGroup);
~masterSynth = Synth.new(\master,[],~masterGroup);

)