// Setting options
(
s.boot;
s.options.sampleRate = 44100;
s.latency = 0.0256;
s.reboot;
)

//wait for the server to start properly and boot the Ottavatore
(
~pathGUI = File.getcwd ++ "\\GUI_ottavatore.scd";
~pathSynths = File.getcwd ++ "\\ottavatore.scd";
~pathSynths.load;
~pathGUI.load;
)