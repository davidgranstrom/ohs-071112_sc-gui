(
    // partial contoller
    s.waitForBoot {
    
        var win, partialControls;
        var numPartials = 8;
    
        SynthDef(\simplePartial, {|freq=440, amp=0.1, pan, out|
            var o = LPF.ar(
                SinOsc.ar(freq+Rand(-0.5,0.5),SinOsc.ar(freq,0,4pi-(3pi*amp))), 
                6500
            );
            Out.ar(out, Pan2.ar(o,pan,amp));
        }, [ 0.1, 0.1, 0.1 ]).add;
    
        s.sync;
        // create some Synths, save them in an Array 
        ~synths = numPartials.collect{|i|
            Synth(\simplePartial, [\freq, 55*(i+1), \amp, 0 ])
        };
    
        // this will be our top-most layout
        partialControls = HLayout();

        ~synths.do {|syn, i|
            // add a vol and pan control for each synth instance
            partialControls.add(
                // create a slider for volume and a knob for pan
                // manage them in a VLayout
                VLayout(
                    // pan
                    Knob().action_({|kn|
                        var val = kn.value.linlin(0,1,-1,1);
                        syn.set(\pan, val);
                        "Partial #% pan: %".format((i+1), val.trunc(0.01)).postln;
                    }).centered_(true).valueAction_(0.5),
                    // vol
                    Slider().action_({|sl| 
                        var val = sl.value; // range 0 - 1
                        syn.set(\amp, val * ~synths.size.reciprocal.sqrt);
                        "Partial #% amp: %".format((i+1), val.trunc(0.01)).postln;
                    })
                )
            );
        };
        win = Window("Partial Controller").layout_(partialControls);
        win.view.resizeTo(400,270);
        win.onClose = { ~synths.do(_.free) };
        win.front;
    }
)
