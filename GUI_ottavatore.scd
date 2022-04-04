
////////////////////////////////GUI////////////////////////////////////////////////

(
//VARIABLES
var kd_title, sd_label1, sd_label2,
ku_title, su_label1, su_label2,
kg_title,
kl_title, sLow_label1, sLow_label2,
kdr_title, sDry_label1, sDry_label2,
kh_title, sHigh_label1, sHigh_label2,
logo_title, logoP_title;

var kd_0, kd_05, kd_1,
ku_0, ku_05, ku_1,
kl_L, kl_R, kl_POS, kl_L_f, kl_R_f, kl_FREQ,
kdr_L, kdr_R, kdr_POS, kdr_L_f, kdr_R_f, kdr_FREQ,
kh_L, kh_R, kh_POS, kh_L_f, kh_R_f, kh_FREQ,
kg_dry, kg_wet;

var factor = 1;
var tW, tH; //fattori di traslazione
var font = "Chiller";
var font_logo = "Harrington";
var point;
var fraction;

//ARANCIONE
var back_color = Gradient(Color.new255(225, 100, 0), Color.white);

/////////////ENVIRONMENT VARIABLES/////////////////

// KNOBS OCTAVER
~knob_down;
~knob_up;
~knob_dw;

//OCTAVE CHOICE SLIDERS
~octave_low_slider;
~octave_hi_slider;

//BUTTONS
~on_off_low;
~on_off_hi;
~reset;

//KNOBs PAN
~knob_low_pan_pos;
~knob_dry_pan_pos;
~knob_high_pan_pos;
~knob_low_pan_freq;
~knob_dry_pan_freq;
~knob_high_pan_freq;

//SLIDERs PAN
~pan_low_slider;
~pan_dry_slider;
~pan_high_slider;

//WINDOW
~window;
~window = Window.new("CAPR OTTAVATORE", Rect(100,500,800*factor,500*factor));
~window.front;
~window.view.background = back_color;
~freqPanKnob = ControlSpec.new(minval:0.05,maxval: 5,warp: 'exp',step: 0.1,default: 1,units:"Hz");

//OCTAVE (LED + CAPR)

~pathImg = thisProcess.nowExecutingPath.dirname ++ "/images/LOGO capr.png";
i = Image.new(~pathImg);
i.scalesWhenResized_(true);
i.setSize(165, (165 / (i.width / i.height)).asInteger);
point = 302*factor@355*factor; //point where to draw the image
fraction = 1.0;

~window.drawFunc = {
	Pen.addOval(Rect(72.5*factor,287.5*factor,30*factor,30*factor));
	Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Gradient(back_color, Color.white), Gradient(back_color, Color.white));
	Pen.addOval(Rect(75*factor,290*factor,25*factor,25*factor));
	Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Color.new255(139, 0, 0), Color.black);
	Pen.addOval(Rect(297.5*factor,287.5*factor,30*factor,30*factor));
	Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Gradient(back_color, Color.white), Gradient(back_color, Color.white));
	Pen.addOval(Rect(300*factor,290*factor,25*factor,25*factor));
	Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Color.new255(139, 0, 0), Color.black);
	i.drawAtPoint(point, fraction:fraction);
};

~window.refresh;

//Knob LOW
tH = 17.5;
~knob_low_pan_pos = Knob.new(~window, Rect(450*factor, (40+tH)*factor, 60*factor, 85*factor));
~knob_low_pan_pos.centered_(true);
~knob_low_pan_pos.valueAction_(\pan.asSpec.unmap(0));
~knob_low_pan_pos.action_({
	arg obj;
	~lowPanSynth.set(\panPos, \pan.asSpec.map(obj.value));
});

kl_title= StaticText.new(~window,Rect(395*factor, 22*factor, 175*factor, 25*factor));
kl_title.string = "LOW";
kl_title.align = \center;
kl_title.font_(Font(font,25*factor, true));

kl_L = StaticText.new(~window,Rect(450*factor, (105+tH)*factor, 25*factor, 25*factor));
kl_L.string = "L";
kl_L.align = \center;
kl_L.font_(Font(font,12*factor));

kl_POS = StaticText.new(~window,Rect(467.5*factor, (110+tH)*factor, 25*factor, 25*factor));
kl_POS.string = "PAN";
kl_POS.stringColor = Gradient(back_color, Color.white);
kl_POS.align = \center;
kl_POS.font_(Font(font,12*factor, true));

kl_R = StaticText.new(~window,Rect(485*factor, (105+tH)*factor, 25*factor, 25*factor));
kl_R.string = "R";
kl_R.align = \center;
kl_R.font_(Font(font,12*factor));

tH = 40;
~knob_low_pan_freq = Knob.new(~window, Rect(450*factor, (135+tH)*factor, 60*factor, 85*factor));
~knob_low_pan_freq.valueAction_(~freqPanKnob.asSpec.unmap(0.5));
~knob_low_pan_freq.action_({
	arg obj;
	~lowPanSynth.set(\panFreq, ~freqPanKnob.asSpec.map(obj.value));
});
kl_L_f = StaticText.new(~window,Rect(435*factor, (200+tH)*factor, 35*factor, 25*factor));
kl_L_f.string = "0.05 Hz";
kl_L_f.align = \center;
kl_L_f.font_(Font(font,9*factor));

kl_FREQ = StaticText.new(~window,Rect(467.5*factor, (205+tH)*factor, 25*factor, 25*factor));
kl_FREQ.string = "FREQ";
kl_FREQ.align = \center;
kl_FREQ.font_(Font(font,12*factor, true));

kl_R_f = StaticText.new(~window,Rect(485*factor, (200+tH)*factor, 35*factor, 25*factor));
kl_R_f.string = "5 Hz";
kl_R_f.align = \center;
kl_R_f.font_(Font(font,9*factor));

tH = 70;
~pan_low_slider = EZSlider.new(~window, Rect(460*factor, (225+tH)*factor, 40*factor, 80*factor), controlSpec: ControlSpec.new(1, 0, \lin, 1.0, 0.0,), layout: \line2);
~pan_low_slider.setColors(sliderBackground: Gradient(Color.black, back_color), numBackground: back_color, knobColor: Color.black);
~pan_low_slider.action_({
	arg obj;
	~lowPanSynth.set(\autoPan,obj.value);
	if (~pan_low_slider.value == 0,
		{sLow_label1.stringColor = Gradient(back_color, Color.white);
			kl_POS.stringColor = Gradient(back_color, Color.white);},
		{sLow_label1.stringColor = Color.black;
			kl_POS.stringColor = Color.black;});
	if (~pan_low_slider.value == 1,
		{sLow_label2.stringColor = Gradient(back_color, Color.white);
			kl_FREQ.stringColor = Gradient(back_color, Color.white);},
		{sLow_label2.stringColor = Color.black;
			kl_FREQ.stringColor = Color.black;});
});

sLow_label1 = StaticText(~window, Rect(460*factor, (225+tH)*factor, 45*factor, 20*factor));
sLow_label1.string = "MANUAL";
sLow_label1.background = back_color;
sLow_label1.stringColor = Gradient(back_color, Color.white);
sLow_label1.align = \center;
sLow_label1.font = Font(font, 15*factor, True);

sLow_label2 = StaticText(~window, Rect(460*factor, (305+tH)*factor, 45*factor, 20*factor));
sLow_label2.string = "AUTO";
sLow_label2.background = back_color;
sLow_label2.align = \center;
sLow_label2.font = Font(font, 15*factor, True);

//Knob Dry PAN
tH = 17.5;
~knob_dry_pan_pos = Knob.new(~window, Rect(565*factor, (40+tH)*factor, 60*factor, 85*factor));
~knob_dry_pan_pos.centered_(true);
~knob_dry_pan_pos.valueAction_(\pan.asSpec.unmap(0));
~knob_dry_pan_pos.action_({
	arg obj;
	~dryPanSynth.set(\panPos, \pan.asSpec.map(obj.value));
});
kdr_title= StaticText.new(~window,Rect(510*factor, 22*factor, 175*factor, 25*factor));
kdr_title.string = "DRY";
kdr_title.align = \center;
kdr_title.font_(Font(font,25*factor, true));

kdr_L = StaticText.new(~window,Rect(565*factor, (105+tH)*factor, 25*factor, 25*factor));
kdr_L.string = "L";
kdr_L.align = \center;
kdr_L.font_(Font(font,12*factor));

kdr_POS = StaticText.new(~window,Rect(582.5*factor, (110+tH)*factor, 25*factor, 25*factor));
kdr_POS.string = "PAN";
kdr_POS.stringColor = Gradient(back_color, Color.white);
kdr_POS.align = \center;
kdr_POS.font_(Font(font,12*factor, true));

kdr_R = StaticText.new(~window,Rect(600*factor, (105+tH)*factor, 25*factor, 25*factor));
kdr_R.string = "R";
kdr_R.align = \center;
kdr_R.font_(Font(font,12*factor));

tH = 40;
~knob_dry_pan_freq = Knob.new(~window, Rect(565*factor, (135+tH)*factor, 60*factor, 85*factor));
~knob_dry_pan_freq.valueAction_(~freqPanKnob.asSpec.unmap(0.5));
~knob_dry_pan_freq.action_({
	arg obj;
	~dryPanSynth.set(\panFreq, ~freqPanKnob.asSpec.map(obj.value));
});
kdr_L_f = StaticText.new(~window,Rect(550*factor, (200+tH)*factor, 35*factor, 25*factor));
kdr_L_f.string = "0.05 Hz";
kdr_L_f.align = \center;
kdr_L_f.font_(Font(font,9*factor));

kdr_FREQ = StaticText.new(~window,Rect(582.5*factor, (205+tH)*factor, 25*factor, 25*factor));
kdr_FREQ.string = "FREQ";
kdr_FREQ.align = \center;
kdr_FREQ.font_(Font(font,12*factor, true));

kdr_R_f = StaticText.new(~window,Rect(600*factor, (200+tH)*factor, 35*factor, 25*factor));
kdr_R_f.string = "5 Hz";
kdr_R_f.align = \center;
kdr_R_f.font_(Font(font,9*factor));

tH = 70;
~pan_dry_slider = EZSlider.new(~window, Rect(575*factor, (225+tH)*factor, 40*factor, 80*factor), controlSpec: ControlSpec.new(1, 0, \lin, 1.0, 0.0,), layout: \line2, );
~pan_dry_slider.setColors(sliderBackground: Gradient(Color.black, back_color), numBackground: back_color, knobColor: Color.black);
~pan_dry_slider.action_({
	arg obj;
	~dryPanSynth.set(\autoPan,obj.value);
	~dryPanSynth.get(\autoPan, { arg value; ("autoPan is now:" + value).postln; });
	if (~pan_dry_slider.value == 0,
		{sDry_label1.stringColor = Gradient(back_color, Color.white);
			kdr_POS.stringColor = Gradient(back_color, Color.white);},
		{sDry_label1.stringColor = Color.black;
			kdr_POS.stringColor = Color.black;});
	if (~pan_dry_slider.value == 1,
		{sDry_label2.stringColor = Gradient(back_color, Color.white);
			kdr_FREQ.stringColor = Gradient(back_color, Color.white);},
		{sDry_label2.stringColor = Color.black;
			kdr_FREQ.stringColor = Color.black;});
});

sDry_label1 = StaticText(~window, Rect(575*factor, (225+tH)*factor, 45*factor, 20*factor));
sDry_label1.string = "MANUAL";
sDry_label1.background = back_color;
sDry_label1.stringColor = Gradient(back_color, Color.white);
sDry_label1.align = \center;
sDry_label1.font = Font(font, 15*factor, True);

sDry_label2 = StaticText(~window, Rect(575*factor, (305+tH)*factor, 45*factor, 20*factor));
sDry_label2.string = "AUTO";
sDry_label2.background = back_color;
sDry_label2.align = \center;
sDry_label2.font = Font(font, 15*factor, True);

//Knob High
tH = 17.5;
~knob_high_pan_pos = Knob.new(~window, Rect(680*factor, (40+tH)*factor, 60*factor, 85*factor));
~knob_high_pan_pos.centered_(true);
~knob_high_pan_pos.valueAction_(\pan.asSpec.unmap(0));
~knob_high_pan_pos.action_({
	arg obj;
	~hiPanSynth.set(\panPos, \pan.asSpec.map(obj.value));
});
kh_title= StaticText.new(~window,Rect(625*factor, 22*factor, 175*factor, 25*factor));
kh_title.string = "HIGH";
kh_title.align = \center;
kh_title.font_(Font(font,25*factor, true));

kh_L = StaticText.new(~window,Rect(680*factor, (105+tH)*factor, 25*factor, 25*factor));
kh_L.string = "L";
kh_L.align = \center;
kh_L.font_(Font(font,12*factor));

kh_POS = StaticText.new(~window,Rect(697.5*factor, (110+tH)*factor, 25*factor, 25*factor));
kh_POS.string = "PAN";
kh_POS.stringColor = Gradient(back_color, Color.white);
kh_POS.align = \center;
kh_POS.font_(Font(font,12*factor, true));

kh_R = StaticText.new(~window,Rect(715*factor, (105+tH)*factor, 25*factor, 25*factor));
kh_R.string = "R";
kh_R.align = \center;
kh_R.font_(Font(font,12*factor));

tH = 40;
~knob_high_pan_freq = Knob.new(~window, Rect(680*factor, (135+tH)*factor, 60*factor, 85*factor));
~knob_high_pan_freq.valueAction_(~freqPanKnob.asSpec.unmap(0.5));
~knob_high_pan_freq.action_({
	arg obj;
	~hiPanSynth.set(\panFreq, ~freqPanKnob.asSpec.map(obj.value));
});
kh_L_f = StaticText.new(~window,Rect(665*factor, (200+tH)*factor, 35*factor, 25*factor));
kh_L_f.string = "0.05 Hz";
kh_L_f.align = \center;
kh_L_f.font_(Font(font,9*factor));

kh_FREQ = StaticText.new(~window,Rect(697.5*factor, (205+tH)*factor, 25*factor, 25*factor));
kh_FREQ.string = "FREQ";
kh_FREQ.align = \center;
kh_FREQ.font_(Font(font,12*factor, true));

kh_R_f = StaticText.new(~window,Rect(715*factor, (200+tH)*factor, 35*factor, 25*factor));
kh_R_f.string = "5 Hz";
kh_R_f.align = \center;
kh_R_f.font_(Font(font,9*factor));

tH = 70;
~pan_high_slider = EZSlider.new(~window, Rect(690*factor, (225+tH)*factor, 40*factor, 80*factor), controlSpec: ControlSpec.new(1, 0, \lin, 1.0, 0.0,), layout: \line2);
~pan_high_slider.setColors(sliderBackground: Gradient(Color.black, back_color), numBackground: back_color, knobColor: Color.black);
~pan_high_slider.action_({
	arg obj;
	~hiPanSynth.set(\autoPan,obj.value);
	if (~pan_high_slider.value == 0,
		{sHigh_label1.stringColor = Gradient(back_color, Color.white);
			kh_POS.stringColor = Gradient(back_color, Color.white);},
		{sHigh_label1.stringColor = Color.black;
			kh_POS.stringColor = Color.black;});
	if (~pan_high_slider.value == 1,
		{sHigh_label2.stringColor = Gradient(back_color, Color.white);
			kh_FREQ.stringColor = Gradient(back_color, Color.white);},
		{sHigh_label2.stringColor = Color.black;
			kh_FREQ.stringColor = Color.black;});
});
sHigh_label1 = StaticText(~window, Rect(690*factor, (225+tH)*factor, 45*factor, 20*factor));
sHigh_label1.string = "MANUAL";
sHigh_label1.background = back_color;
sHigh_label1.stringColor = Gradient(back_color, Color.white);
sHigh_label1.align = \center;
sHigh_label1.font = Font(font, 15*factor, True);

sHigh_label2 = StaticText(~window, Rect(690*factor, (305+tH)*factor, 45*factor, 20*factor));
sHigh_label2.string = "AUTO";
sHigh_label2.background = back_color;
sHigh_label2.align = \center;
sHigh_label2.font = Font(font, 15*factor, True);


//OCTAVE DOWN (KNOB)

~knob_down = Knob.new(~window, Rect(50*factor, 60*factor, 75*factor, 100*factor));
~knob_down.valueAction_(0.5);
~knob_down.action_({
	arg obj;
	~lowOctSynth.set(\oLmul,obj.value);
});

kd_title= StaticText.new(~window,Rect(0*factor, 25*factor, 175*factor, 25*factor));
kd_title.string = "OCTAVE DOWN";
kd_title.align = \center;
kd_title.font_(Font(font,25*factor, true));

kd_0= StaticText.new(~window,Rect(50*factor, 140*factor, 25*factor, 25*factor));
kd_0.string = "0";
kd_0.align = \center;
kd_0.font_(Font(font,12*factor));

kd_05= StaticText.new(~window,Rect(0*factor, 50*factor, 175*factor, 25*factor));
kd_05.string = "0.5";
kd_05.align = \center;
kd_05.font_(Font(font,12*factor));

kd_1= StaticText.new(~window,Rect(100*factor, 140*factor, 25*factor, 25*factor));
kd_1.string = "1";
kd_1.align = \center;
kd_1.font_(Font(font,12*factor));

//OCTAVE DOWN (SLIDER)

~octave_low_slider = EZSlider.new(~window, Rect(67.5*factor, 175*factor, 40*factor, 80*factor), controlSpec: ControlSpec.new(2, 1, \lin, 1.0, 0.0,), layout: \line2);
~octave_low_slider.setColors(sliderBackground: Gradient(Color.black, back_color), numBackground: back_color, knobColor: Color.black);
~octave_low_slider.action_({
	arg obj;
	~lowOctSynth.set(\numLow,obj.value);
	if (~on_off_low.value == 1 && ~octave_low_slider.value == 1,
		{sd_label1.stringColor = Gradient(back_color, Color.white)},
		{sd_label1.stringColor = Color.black});
	if (~on_off_low.value == 1 && ~octave_low_slider.value == 2,
		{sd_label2.stringColor = Gradient(back_color, Color.white)},
		{sd_label2.stringColor = Color.black});

});

sd_label1 = StaticText(~window, Rect(67.5*factor, 175*factor, 40*factor, 20*factor));
sd_label1.string = "-1";
sd_label1.background = back_color;
sd_label1.align = \center;
sd_label1.font = Font(font, 20*factor, True);

sd_label2 = StaticText(~window, Rect(67.5*factor, 255*factor, 40*factor, 20*factor));
sd_label2.string = "-2";
sd_label2.background = back_color;
sd_label2.align = \center;
sd_label2.font = Font(font, 20*factor, True);

//OCTAVE DOWN (BUTTON)

~on_off_low = Button.new(~window, Rect(62.5*factor, 325*factor, 50*factor, 50*factor));
~on_off_low.states = [[ "OFF", Color.black, Color.white ], ["ON", Color.black, Color.white]];
~on_off_low.action_({
	arg obj;
	~lowOctSynth.set(\lowOn,obj.value);
	if (~on_off_low.value == 1,
		{kd_title.stringColor = Gradient(back_color, Color.white)},
		{kd_title.stringColor = Color.black});
	if (~on_off_low.value == 1 && ~octave_low_slider.value == 1,
		{sd_label1.stringColor = Gradient(back_color, Color.white)},
		{sd_label1.stringColor = Color.black});
	if (~on_off_low.value == 1 && ~octave_low_slider.value == 2,
		{sd_label2.stringColor = Gradient(back_color, Color.white)},
		{sd_label2.stringColor = Color.black});

	if (~on_off_low.value == 1 && ~on_off_hi.value == 1,
		{
			~window.drawFunc = {
				Pen.addOval(Rect(72.5*factor,287.5*factor,30*factor,30*factor));
				Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Gradient(back_color, Color.white), Gradient(back_color, Color.white));
				Pen.addOval(Rect(75*factor,290*factor,25*factor,25*factor));
				Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Color.red, Color.new255(255, 140, 0));

				Pen.addOval(Rect(297.5*factor,287.5*factor,30*factor,30*factor));
				Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Gradient(back_color, Color.white), Gradient(back_color, Color.white));
				Pen.addOval(Rect(300*factor,290*factor,25*factor,25*factor));
				Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Color.red, Color.new255(255, 140, 0));
				i.drawAtPoint(point, fraction:1.0);
			};
		},
		{};
		~window.refresh;
	);

	if (~on_off_low.value == 1 && ~on_off_hi.value == 0,
		{
			~window.drawFunc = {
				Pen.addOval(Rect(72.5*factor,287.5*factor,30*factor,30*factor));
				Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Gradient(back_color, Color.white), Gradient(back_color, Color.white));
				Pen.addOval(Rect(75*factor,290*factor,25*factor,25*factor));
				Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Color.red, Color.new255(255, 140, 0));

				Pen.addOval(Rect(297.5*factor,287.5*factor,30*factor,30*factor));
				Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Gradient(back_color, Color.white), Gradient(back_color, Color.white));
				Pen.addOval(Rect(300*factor,290*factor,25*factor,25*factor));
				Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Color.new255(139, 0, 0), Color.black);

				i.drawAtPoint(point, fraction:fraction);
			};
		},
		{};
		~window.refresh;
	);

	if (~on_off_low.value == 0 && ~on_off_hi.value == 1,
		{
			~window.drawFunc = {
				Pen.addOval(Rect(72.5*factor,287.5*factor,30*factor,30*factor));
				Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Gradient(back_color, Color.white), Gradient(back_color, Color.white));
				Pen.addOval(Rect(75*factor,290*factor,25*factor,25*factor));
				Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Color.new255(139, 0, 0), Color.black);

				Pen.addOval(Rect(297.5*factor,287.5*factor,30*factor,30*factor));
				Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Gradient(back_color, Color.white), Gradient(back_color, Color.white));
				Pen.addOval(Rect(300*factor,290*factor,25*factor,25*factor));
				Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Color.red, Color.new255(255, 140, 0));

				i.drawAtPoint(point, fraction:fraction);
			};
		},
		{};
		~window.refresh;
	);

	if (~on_off_low.value == 0 && ~on_off_hi.value == 0,
		{
			~window.drawFunc = {
				Pen.addOval(Rect(72.5*factor,287.5*factor,30*factor,30*factor));
				Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Gradient(back_color, Color.white), Gradient(back_color, Color.white));
				Pen.addOval(Rect(75*factor,290*factor,25*factor,25*factor));
				Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Color.new255(139, 0, 0), Color.black);

				Pen.addOval(Rect(297.5*factor,287.5*factor,30*factor,30*factor));
				Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Gradient(back_color, Color.white), Gradient(back_color, Color.white));
				Pen.addOval(Rect(300*factor,290*factor,25*factor,25*factor));
				Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Color.new255(139, 0, 0), Color.black);

				i.drawAtPoint(point, fraction:fraction);
			};
		},
		{};
		~window.refresh;
	);
});
~on_off_low.font = Font(font, 15*factor);

//OCTAVE UP (KNOB)

~knob_up = Knob.new(~window, Rect(275*factor, 60*factor, 75*factor, 100*factor));
~knob_up.valueAction_(0.5);
~knob_up.action_({
	arg obj;
	~hiOctSynth.set(\oHmul,obj.value);
});

ku_title= StaticText.new(~window,Rect(225*factor, 25*factor, 175*factor, 25*factor));
ku_title.string = "OCTAVE UP";
ku_title.align = \center;
ku_title.font_(Font(font,25*factor, true));

ku_0= StaticText.new(~window,Rect(275*factor, 140*factor, 25*factor, 25*factor));
ku_0.string = "0";
ku_0.align = \center;
ku_0.font_(Font(font,12*factor));

ku_05= StaticText.new(~window,Rect(225*factor, 50*factor, 175*factor, 25*factor));
ku_05.string = "0.5";
ku_05.align = \center;
ku_05.font_(Font(font,12*factor));

ku_1= StaticText.new(~window,Rect(325*factor, 140*factor, 25*factor, 25*factor));
ku_1.string = "1";
ku_1.align = \center;
ku_1.font_(Font(font,12*factor));

//OCTAVE UP (SLIDER)

~octave_hi_slider = EZSlider.new(~window, Rect(292.5*factor, 175*factor, 40*factor, 80*factor), controlSpec: ControlSpec.new(1, 2, \lin, 1.0, 0.0,), layout: \line2);
~octave_hi_slider.setColors(sliderBackground: Gradient(Color.black, back_color), numBackground: back_color, knobColor: Color.black);
~octave_hi_slider.action_({
	arg obj;
	~hiOctSynth.set(\numHi,obj.value);
	if (~on_off_hi.value == 1 && ~octave_hi_slider.value == 1,
		{su_label1.stringColor = Gradient(back_color, Color.white)},
		{su_label1.stringColor = Color.black});
	if (~on_off_hi.value == 1 && ~octave_hi_slider.value == 2,
		{su_label2.stringColor = Gradient(back_color, Color.white)},
		{su_label2.stringColor = Color.black});
});

su_label1 = StaticText(~window, Rect(292.5*factor, 255*factor, 40*factor, 20*factor));
su_label1.string = "+1";
su_label1.background = back_color;
su_label1.align = \center;
su_label1.font = Font(font, 20*factor, True);

su_label2 = StaticText(~window, Rect(292.5*factor, 175*factor, 40*factor, 20*factor));
su_label2.string = "+2";
su_label2.background = back_color;
su_label2.align = \center;
su_label2.font = Font(font, 20*factor, True);

//OCTAVE UP (BUTTON)

~on_off_hi = Button.new(~window, Rect(287.5*factor, 325*factor, 50*factor, 50*factor));
~on_off_hi.states = [[ "OFF", Color.black, Color.white ], ["ON", Color.black, Color.white]];
~on_off_hi.action_({
	arg obj;
	~hiOctSynth.set(\hiOn,obj.value);
	obj.value.postln;
	if (~on_off_hi.value == 1,
		{ku_title.stringColor = Gradient(back_color, Color.white)},
		{ku_title.stringColor = Color.black});
	if (~on_off_hi.value == 1 && ~octave_hi_slider.value == 1,
		{su_label1.stringColor = Gradient(back_color, Color.white)},
		{su_label1.stringColor = Color.black});
	if (~on_off_hi.value == 1 && ~octave_hi_slider.value == 2,
		{su_label2.stringColor = Gradient(back_color, Color.white)},
		{su_label2.stringColor = Color.black});

	if (~on_off_low.value == 1 && ~on_off_hi.value == 1,
		{
			~window.drawFunc = {
				Pen.addOval(Rect(72.5*factor,287.5*factor,30*factor,30*factor));
				Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Gradient(back_color, Color.white), Gradient(back_color, Color.white));
				Pen.addOval(Rect(75*factor,290*factor,25*factor,25*factor));
				Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Color.red, Color.new255(255, 140, 0));

				Pen.addOval(Rect(297.5*factor,287.5*factor,30*factor,30*factor));
				Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Gradient(back_color, Color.white), Gradient(back_color, Color.white));
				Pen.addOval(Rect(300*factor,290*factor,25*factor,25*factor));
				Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Color.red, Color.new255(255, 140, 0));

				i.drawAtPoint(point, fraction:fraction);
			};
		},
		{};
		~window.refresh;
	);

	if (~on_off_low.value == 1 && ~on_off_hi.value == 0,
		{
			~window.drawFunc = {
				Pen.addOval(Rect(72.5*factor,287.5*factor,30*factor,30*factor));
				Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Gradient(back_color, Color.white), Gradient(back_color, Color.white));
				Pen.addOval(Rect(75*factor,290*factor,25*factor,25*factor));
				Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Color.red, Color.new255(255, 140, 0));

				Pen.addOval(Rect(297.5*factor,287.5*factor,30*factor,30*factor));
				Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Gradient(back_color, Color.white), Gradient(back_color, Color.white));
				Pen.addOval(Rect(300*factor,290*factor,25*factor,25*factor));
				Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Color.new255(139, 0, 0), Color.black);

				i.drawAtPoint(point, fraction:fraction);
			};
		},
		{};
		~window.refresh;
	);

	if (~on_off_low.value == 0 && ~on_off_hi.value == 1,
		{
			~window.drawFunc = {
				Pen.addOval(Rect(72.5*factor,287.5*factor,30*factor,30*factor));
				Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Gradient(back_color, Color.white), Gradient(back_color, Color.white));
				Pen.addOval(Rect(75*factor,290*factor,25*factor,25*factor));
				Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Color.new255(139, 0, 0), Color.black);

				Pen.addOval(Rect(297.5*factor,287.5*factor,30*factor,30*factor));
				Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Gradient(back_color, Color.white), Gradient(back_color, Color.white));
				Pen.addOval(Rect(300*factor,290*factor,25*factor,25*factor));
				Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Color.red, Color.new255(255, 140, 0));

				i.drawAtPoint(point, fraction:fraction);
			};
		},
		{};
		~window.refresh;
	);

	if (~on_off_low.value == 0 && ~on_off_hi.value == 0,
		{
			~window.drawFunc = {
				Pen.addOval(Rect(72.5*factor,287.5*factor,30*factor,30*factor));
				Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Gradient(back_color, Color.white), Gradient(back_color, Color.white));
				Pen.addOval(Rect(75*factor,290*factor,25*factor,25*factor));
				Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Color.new255(139, 0, 0), Color.black);

				Pen.addOval(Rect(297.5*factor,287.5*factor,30*factor,30*factor));
				Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Gradient(back_color, Color.white), Gradient(back_color, Color.white));
				Pen.addOval(Rect(300*factor,290*factor,25*factor,25*factor));
				Pen.fillRadialGradient(~window.view.bounds.center, ~window.view.bounds.center, 0, ~window.bounds.width, Color.new255(139, 0, 0), Color.black);

				i.drawAtPoint(point, fraction:fraction);
			};
		},
		{};
		~window.refresh;
	);
});

~on_off_hi.font = Font(font, 15*factor);


// OUTPUT MIX
tH = 50;
~knob_dw = Knob.new(~window, Rect(162.5*factor, (85+tH)*factor, 75*factor, 100*factor));
~knob_dw.valueAction_(0.5);
~knob_dw.action_({
	arg obj;
	~mixSynth.set(\wet,obj.value);
});

kg_title= StaticText.new(~window,Rect(100*factor, (60+tH)*factor, 200*factor, 25*factor));
kg_title.string = "MIX";
kg_title.align = \center;
kg_title.font_(Font(font,25*factor, true));

kg_dry= StaticText.new(~window,Rect(160*factor, (165+tH)*factor, 25*factor, 25*factor));
kg_dry.string = "DRY";
kg_dry.font_(Font(font,12*factor));

kg_wet= StaticText.new(~window,Rect(220*factor, (165+tH)*factor, 25*factor, 25*factor));
kg_wet.string = "WET";
kg_wet.font_(Font(font,12*factor));


//RESET

//~reset = Button.new(~window, Rect(150*factor, 350*factor, 100*factor, 25*factor));
~reset = Button.new(~window, Rect(370*factor, 327*factor, 55*factor, 45*factor));
~reset.states = [[ "RESET", Color.white, Gradient(Color.black, back_color) ]];
~reset.action_({
	arg obj;

	//OCT and MIX RESET
	~hiOctSynth.set(\numHi,1);
	~lowOctSynth.set(\oLmul,0.5);
	~lowOctSynth.set(\numLow,1);
	~hiOctSynth.set(\oHmul,0.5);
	~mixSynth.set(\wet,0.5);
	~knob_down.valueAction_(0.5);
	~knob_up.valueAction_(0.5);
	~knob_dw.valueAction_(0.5);
	~octave_low_slider.value = 1;
	~octave_hi_slider.value = 1;

	//PAN SYNTH PARAMS RESET
	~hiPanSynth.set(\panFreq,0.1);
	~hiPanSynth.set(\autoPan,0);
	~hiPanSynth.set(\panPos,0);

	~dryPanSynth.set(\panFreq,0.1);
	~dryPanSynth.set(\autoPan,0);
	~dryPanSynth.set(\panPos,0);

	~lowPanSynth.set(\panFreq,0.1);
	~lowPanSynth.set(\autoPan,0);
	~lowPanSynth.set(\panPos,0);

	//SLIDER PAN RESET

	~pan_low_slider.value = 0;
	~pan_low_slider.value.postln;
	~pan_dry_slider.value = 0;
	~pan_dry_slider.value.postln;
	~pan_high_slider.value = 0;
	~pan_high_slider.value.postln;

	//KNOB PAN RESET

	~knob_low_pan_pos.valueAction_(0.5);
	~knob_dry_pan_pos.valueAction_(0.5);
	~knob_high_pan_pos.valueAction_(0.5);

	~knob_low_pan_freq.valueAction_(0.5);
	~knob_dry_pan_freq.valueAction_(0.5);
	~knob_high_pan_freq.valueAction_(0.5);

	if (~on_off_low.value == 1 && ~octave_low_slider.value == 1,
		{sd_label1.stringColor = Gradient(back_color, Color.white)},
		{sd_label1.stringColor = Color.black});
	if (~on_off_low.value == 1 && ~octave_low_slider.value == 2,
		{sd_label2.stringColor = Gradient(back_color, Color.white)},
		{sd_label2.stringColor = Color.black});

	if (~on_off_hi.value == 1 && ~octave_hi_slider.value == 1,
		{su_label1.stringColor = Gradient(back_color, Color.white)},
		{su_label1.stringColor = Color.black});
	if (~on_off_hi.value == 1 && ~octave_hi_slider.value == 2,
		{su_label2.stringColor = Gradient(back_color, Color.white)},
		{su_label2.stringColor = Color.black});

	if (~pan_low_slider.value == 0,
		{sLow_label1.stringColor = Gradient(back_color, Color.white);
			kl_POS.stringColor = Gradient(back_color, Color.white);},
		{sLow_label1.stringColor = Color.black;
			kl_POS.stringColor = Color.black};);
	if (~pan_low_slider.value == 1,
		{sLow_label2.stringColor = Gradient(back_color, Color.white);
			kl_FREQ.stringColor = Gradient(back_color, Color.white);},
		{sLow_label2.stringColor = Color.black;
			kl_FREQ.stringColor = Color.black};);

	if (~pan_dry_slider.value == 0,
		{sDry_label1.stringColor = Gradient(back_color, Color.white);
			kdr_POS.stringColor = Gradient(back_color, Color.white);},
		{sDry_label1.stringColor = Color.black;
			kdr_POS.stringColor = Color.black};);
	if (~pan_dry_slider.value == 1,
		{sDry_label2.stringColor = Gradient(back_color, Color.white);
			kdr_FREQ.stringColor = Gradient(back_color, Color.white);},
		{sDry_label2.stringColor = Color.black;
			kdr_FREQ.stringColor = Color.black};);

	if (~pan_high_slider.value == 0,
		{sHigh_label1.stringColor = Gradient(back_color, Color.white);
			kh_POS.stringColor = Gradient(back_color, Color.white);},
		{sHigh_label1.stringColor = Color.black;
			kh_POS.stringColor = Color.black};);
	if (~pan_high_slider.value == 1,
		{sHigh_label2.stringColor = Gradient(back_color, Color.white);
			kh_FREQ.stringColor = Gradient(back_color, Color.white);},
		{sHigh_label2.stringColor = Color.black;
			kh_FREQ.stringColor = Color.black};);
});
~reset.font = Font(font, 15*factor);

// LOGO

//logo_title= StaticText.new(~window,Rect(115*factor, 285*factor, 175*factor, 50*factor));
logo_title= StaticText.new(~window,Rect(45*factor, 410*factor, 300*factor, 50*factor));
//logo_title.string = "CAPR OTTAVATORE";
logo_title.string = "OTTAVATORE";
logo_title.align = \center;
logo_title.font_(Font(font_logo,30*factor, true));

// LOGO PAN

logoP_title= StaticText.new(~window,Rect(445*factor, 410*factor, 300*factor, 50*factor));
//logoP_title.string = "CAPR PANNATORE";
logoP_title.string = "PANNATORE";
logoP_title.align = \center;
logoP_title.font_(Font(font_logo,30*factor, true));
)