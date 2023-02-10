// Buffer Load Section
~b = Buffer.read(s, "/home/crecothl/OctaveSuperCollider/OctaveSuperColliderEasyWaveMaterial/663150__voxlab__nazi-wehrmacht-march-stomp-pulse-2-rr4.wav"); // remember to free the buffer later.

// Synth to be developed
(
SynthDef(\mySynth, {
	// out Output Chanell
	// bufnum Sound File which should been played
	// temp Basic Tempo for Sound File Playing
	// freq Fundamental Frequency for Subtraction Vocoding
	| out = 0, bufnum = 0, temp = 1, freq=440,
	// tempmodtemp Tempo of Speed Control Modification
	// tempmoddepth Amount of Control for Playback
	tempmodtemp = 1, tempmoddepth = 1,
	// ADSR Control Paramters
	// fmaTX Attack Time
	// fmdTX Decay Time
	// fmsLX Sustain Level
	// fmrT Release Time

	// ADSR Control for Substraction Vocoding Separations
	// For Basic Frequency
	fmaT1 = 0.5, fmdT1 = 1, fmsL1 = 0.3, fmrT1 = 3,
	// For 1st Overtone
	fmaT2 = 0.5, fmdT2 = 1, fmsL2 = 0.3, fmrT2 = 3,
	// For 2nd Overtone
	fmaT3 = 0.5, fmdT3 = 1, fmsL3 = 0.3, fmrT3 = 3,
	// For 3rd Overtone
	fmaT4 = 0.5, fmdT4 = 1, fmsL4 = 0.3, fmrT4 = 3,
	// For 4th Overtone
	fmaT5 = 0.5, fmdT5 = 1, fmsL5 = 0.3, fmrT5 = 3,

	// ADSR Control for Additive Adition and Amplitude Modulation
	// For Basic Frequency
	amaT1 = 0.5, amdT1 = 1, amsL1 = 0.3, amrT1 = 3,
	// For 1st Overtone
	amaT2 = 0.5, amdT2 = 1, amsL2 = 0.3, amrT2 = 3,
	// For 2nd Overtone
	amaT3 = 0.5, amdT3 = 1, amsL3 = 0.3, amrT3 = 3,
	// For 3rd Overtone
	amaT4 = 0.5, amdT4 = 1, amsL4 = 0.3, amrT4 = 3,
	// For 4th Overtone
	amaT5 = 0.5, amdT5 = 1, amsL5 = 0.3, amrT5 = 3,

	// Speration for Suvstraction Vocoding
	aa = 2|

	var sigp, sigr, // Channel for the master Signal
	// Channels for Signal from Vocoding
	sig1, sig2, sig3, sig4, sig5,
	modTempSig, // Channel for the Tempo Controll Signal

	// Enveloüe Definitions and Result Channels for the Partials
	// For Vocoding Separtions
	fmenv1, fmenvgen1, fmenv2, fmenvgen2, fmenv3, fmenvgen3, fmenv4, fmenvgen4, fmenv5, fmenvgen5,
	// For Additive Amplitude Modulation
	amenv1, amenvgen1, amenv2, amenvgen2, amenv3, amenvgen3, amenv4, amenvgen4, amenv5, amenvgen5,
	// Channels for Adition from Vocoding
	am1, am2, am3, am4, am5;
	// Sinusidual Tempo Conrroll Signal
	modTempSig = SinOsc.kr(tempmodtemp, 0, tempmoddepth, tempmoddepth)*temp;
	// Buffer Player for the Master Signal
	sigp = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum)*modTempSig, 0, 0, 1);

	// Envelope Declarations and Players for the different Overtones
	// 1.) Declaration of Envelope
	// 2.) Playing of Envelope
	// 3.) BanndPassFilter for Partial Frequency Band with Seperation by the Envelop
	// for Basic Frequency
	fmenv1 = Env.adsr(fmaT1, fmdT1, fmsL1, fmrT1);
	fmenvgen1 = EnvGen.kr(fmenv1);
	sig1 = BPF.ar(sigp, freq, (1-fmenvgen1)/aa);
	// for 1st. Overtone
	fmenv2 = Env.adsr(fmaT2, fmdT2, fmsL2, fmrT2);
	fmenvgen2 = EnvGen.kr(fmenv2);
	sig2 = BPF.ar(sigp, freq*2, (1-fmenvgen2)/aa);
	// for 2nd Overone
	fmenv3 = Env.adsr(fmaT3, fmdT3, fmsL3, fmrT3);
	fmenvgen3 = EnvGen.kr(fmenv3);
	sig3 = BPF.ar(sigp, freq*3, (1-fmenvgen3)/aa);
	// for 3rd Overtone
	fmenv4 = Env.adsr(fmaT4, fmdT4, fmsL4, fmrT4);
	fmenvgen4 = EnvGen.kr(fmenv4);
	sig4 = BPF.ar(sigp, freq*4, (1-fmenvgen4)/aa);
	// for 4th Overtone
	fmenv5 = Env.adsr(fmaT5, fmdT5, fmsL5, fmrT5);
	fmenvgen5 = EnvGen.kr(fmenv5);
	sig5 = BPF.ar(sigp, freq*5, (1-fmenvgen5)/aa);

	// Amplitude Modulation of the Partials
	// For Basic Frequency
	amenv1 = Env.adsr(amaT1, amdT1, amsL1, amrT1);
	amenvgen1 = EnvGen.kr(amenv1);
	// For 1st Overtone
	amenv2 = Env.adsr(amaT2, amdT2, amsL2, amrT2);
	amenvgen2 = EnvGen.kr(amenv2);
	// For 2nd Overtone
	amenv3 = Env.adsr(amaT3, amdT3, amsL3, amrT3);
	amenvgen3 = EnvGen.kr(amenv3);
	// For 3rd Overtone
	amenv4 = Env.adsr(amaT4, amdT4, amsL4, amrT4);
	amenvgen4 = EnvGen.kr(amenv4);
	// For 4th Overtone
	amenv5 = Env.adsr(amaT5, amdT5, amsL5, amrT5);
	amenvgen5 = EnvGen.kr(amenv5);
	// Addition of Partials as Resulted Output Signal
	sigr = ((sig1*amenvgen1) +(sig2*amenvgen2)+(sig3*amenvgen3)+(sig4*amenvgen4) + (sig5*amenvgen5));
	// Output of the Resulted Signal
	Out.ar(out, [sigr, sigr
	])
}).add;)

// Helper Function to generate new Synths from my Synth Template
(~my_routine_maker = {
	var x;
	Routine.run({
		loop({

// Synth Play Command to Controll the Synth
// For Explanation of the Parameters see SynthDef Definution of Input Signals
			x = Synth(\mySynth, [bufnum: ~b ,temp: rrand(0.2, 5), tempmodtemp: rrand(0.2, 5), tempmoddepth: rrand(0.2, 5), aT1: rrand(0.2, 5), dT1: rrand(0.2, 5), sL1: rrand(0.1, 1), rT1: rrand(0.2, 5), aT2: rrand(0.2, 5), dT2: rrand(0.2, 5), sL2: rrand(0.1, 1), rT2: rrand(0.2, 5), aT3: rrand(0.2, 5), dT3: rrand(0.2, 5), sL3: rrand(0.1, 1), rT3: rrand(0.2, 5), aT4: rrand(0.2, 5), dT4: rrand(0.2, 5), sL4: rrand(0.1, 1), rT4: rrand(0.2, 5), aT5: rrand(0.2, 5), dT5: rrand(0.2, 5), sL5: rrand(0.1, 1), rT5: rrand(0.2, 5), aa: rrand(2, 12),amaT1: rrand(0.2, 5), amdT1: rrand(0.2, 5), amsL1: rrand(0.1, 1), amrT1: rrand(0.2, 5), amaT2: rrand(0.2, 5), amdT2: rrand(0.2, 5), amsL2: rrand(0.1, 1), amrT2: rrand(0.2, 5), amaT3: rrand(0.2, 5), amdT3: rrand(0.2, 5), amsL3: rrand(0.1, 1), amrT3: rrand(0.2, 5), amaT4: rrand(0.2, 5), amdT4: rrand(0.2, 5), amsL4: rrand(0.1, 1), amrT4: rrand(0.2, 5), amaT5: rrand(0.2, 5), amdT5: rrand(0.2, 5), amsL5: rrand(0.1, 1), amrT5: rrand(0.2, 5), out: 0, freq: rrand(20, 4000) ]);
// Time Delay between the creation of different Synths
2.20.rand2.wait;
// Free the old Synth
x.free;
0.1.wait
			});

})
   };
)

1.do({ ~my_routine_maker.() });
Env.adsr(0.5, 1, 0.3, 3).plot