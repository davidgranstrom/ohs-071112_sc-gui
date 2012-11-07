
// ===========================================================================
// SimpleGui demo
// ===========================================================================

s.boot;

// ----------------------------------------
// ex1: create a gui based on SynthDef args
// ----------------------------------------
(

    SynthDef(\simplePartial, {|freq=110, amp=0.25, cfreq=2500, pan, out|
        var o = RLPF.ar(
            SinOsc.ar(freq+Rand(-0.5,0.5),SinOsc.ar(freq,0,4pi-(3pi*amp))), 
            cfreq,
            0.75
        );
        Out.ar(out, Pan2.ar(o,pan,amp));
    }, 0.1!4).add;
)

x = Synth(\simplePartial);
// SimpleGui will try and guess the appropriate ControlSpecs 
// based on the SynthDefs NamedControl arguments
SimpleGui(x, freeOnClose: true);

// ------------------------------------------------------
// ex2: create a gui based on SynthDef args and metadata
// -----------------------------------------------------
(

    // a SynthDef with metadata
    ~sdef = SynthDef(\simplePartial, {|freq=110, amp=0.25, cfreq=2500, pan, out|
        var o = RLPF.ar(
            SinOsc.ar(freq+Rand(-0.5,0.5),SinOsc.ar(freq,0,4pi-(3pi*amp))), 
            cfreq,
            0.75
        );
        Out.ar(out, Pan2.ar(o,pan,amp));
    }, 0.1!4, metadata: (
        // add our own custom spec
        freq: ControlSpec(55,555,\exp,0.01,110,"Hz"),
    )).add;
    // inspect 
    ~sdef.metadata
)

// Synth().makeGui is a convenience method for creating a SimpleGui
// notice that the metadata is used for creating our 'freq' control
x = Synth(\simplePartial).makeGui(true);

