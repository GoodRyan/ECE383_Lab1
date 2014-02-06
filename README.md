ECE383_Lab1
===========

Introduction
------------

The purpose of this lab is to write code that enables the FPGA to control a monitor’s output via a 
VGA-to-HDMI cable.

Implementation
--------------
There are two modules that generate the signals necessary to run the monitor’s display. 
These modules are h_sync and v_sync. They each include five very similar state machines 
that drive whether or not a color is displayed, or nothing is displayed at all based on timing. 
Below is a state diagram showing these states, their outputs, and how they are interconnected 
to form a Moore machine.

![alt tag](https://raw.github.com/GoodRyan/ECE383_Lab1/master/state_machine_diagram.png)
