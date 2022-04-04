<img src="https://user-images.githubusercontent.com/51057211/161530347-4b2d75ca-afb4-47c4-8ff0-2747e66e303a.png" alt="CAPR_logo" width="200"/>

## *L'Ottavatore*
### CMLS AY 2021/2022 SC Homework #4: Octaver 
### Authors: CAPR group
* Claudio Eutizi
* Andrés Bertazzi 
* Pierluigi Tartabini 
* Riccardo Martinelli

## Brief description
The "Ottavatore" is a guitar-pedal-designed octaver, implemented using *SuperCollider 3.12.2*. 

Its main functionalities are addition and mixing of an analog input audio signal from an audio card (e.g microphone or guitar) with a synthesised signals that reproduce *upper or/and lower* octaves. Furthermore, a panning section is introduced on the right part of the pedal in order to modify the position of each voice in the stereo field.

The interface offers all required controllers for handling and modifying the parameters of the pedal:

<img src="https://user-images.githubusercontent.com/51057211/161530307-79b33a7f-5610-4a68-9090-99dc7ed39527.png" alt="Ottavatore_GUI" width="500" align = "top"/>

## Controls
From the left to the right of the GUI the controls we can find are:
### Octaver section (L'Ottavatore):
* *OCTAVE DOWN:* this column manages the lower octave synthetically introduced in the sound. The knob regulates the gain of this voice, the switch selects which octave to reproduce: the 1st or the 2nd below. The on/off button turns off/on the lower octave.
* *MIX:* A knob that regulates the dry/wet mix between the dry signal and the synthesized one.
* *OCTAVE UP:* same controls as OCTAVE DOWN, but for the upper octaves. The choice of which octave to listen to is between the 1st and the 2nd upper octave.

### Panning section (Il Pannatore):
The panning section permits to control the panning parameters for each voice that the Ottavatore outputs.
* *PAN:* a knob for modifying the position of the voice in the stereo field; this knob becomes active only when the switch of the voice is set on "manual".
* *FREQ:* this knob regulates the oscillation frequency (in Hz) of the voice from left to right when the switch is set on "AUTO" mode. It goes from a minimum of 0.05Hz to a maximum of 5Hz.
### Reset
This button resets all the knobs and all the switches to default settings, in order not to set manually all the parameters to their default state when needed. This button does not change the on/off octave buttons states.

## Boot and use the Ottavatore (IMPORTANT)
* Download all the files and folders from the repository.
* Make sure to have downloaded "Chiller" and "Harrington" fonts in order to visualize the GUI in the correct way.
* Open *index.scd* using SuperCollider.
* Interprete the two blocks in the order they are written in the file. After this, the dry signal of the source should be audible. If not there will may be visible on the SuperCollider post window some synth errors. Please repeat the interpretation procedure until it works.
* If anybody finds any bug, please let us know and we will be glad to solve it!

# ENJOY!

Thanks to Marco Di Mambro for the LOGO design.
