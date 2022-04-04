// Setting options
(
s.boot;
s.options.sampleRate = 44100;
s.latency = 0.0256;
s.reboot;
)

//wait for the server to start properly and boot the Ottavatore
(
~pathGUI = thisProcess.nowExecutingPath.dirname ++ "/GUI_ottavatore.scd";
~pathSynths = thisProcess.nowExecutingPath.dirname ++ "/ottavatore.scd";
~pathGUI.load;
~pathSynths.load;
)