#import "../../colors.typ": lightblue, lighterblue, mainblue
#import "../../utils/code.typ": code, code_cpp, code_py
#import "../../utils/analysis.typ": analyse_function_table, analyse_attribute_table

// Give this chapter a label so other chapters can reference it.
= Chapter Title <chap:chapter1>

// Write your introduction paragraph here.
// Explain what this chapter covers and why it matters.

== Background

// Provide theoretical background for your topic.
// Cite your sources using @yourkey — defined in references.bib.

== Implementation

// Describe your implementation. Use subsections as needed.

=== Code Example

// Use code_cpp() for C++, code_py() for Python, code() for other languages.
#code_cpp(caption: [Example: reading a sensor value],
"int readSensor(int pin) {
    int value = analogRead(pin);
    return map(value, 0, 1023, 0, 100);
}")

=== Figure Example

#figure(
  image("../../img/placeholder.png", width: 60%),
  caption: [Replace this with your actual figure],
) <fig:example>

// Reference a figure: see @fig:example.

=== Table Example

#figure(
  table(
    columns: (auto, 1fr),
    inset: 6pt,
    stroke: 0.4pt + gray,
    fill: (x, y) => if y == 0 { mainblue } else if calc.odd(y) { lighterblue } else { lightblue },
    table.header([*Parameter*], [*Value*]),
    [Supply voltage], [3.3 V],
    [Operating frequency], [400 kHz],
    [Resolution], [16 bit],
  ),
  caption: [Example parameters],
) <tab:example>

=== Function and Attribute Reference

// Use analyse_function_table() to document the public API of a module or class.
#figure(
  analyse_function_table(
    [int],  [readSensor(int pin)],  [Reads the analogue value on the given pin and maps it to 0–100.],
    [void], [initSensor()],        [Initialises the sensor hardware and sets the default sampling rate.],
    [bool], [isSensorReady()],     [Returns true once the sensor has completed its warm-up phase.],
  ),
  caption: [Sensor module — function reference],
) <tab:func-ref>

// Use analyse_attribute_table() to document struct fields or class members.
#figure(
  analyse_attribute_table(
    [int],  [pin],        [GPIO pin number connected to the sensor.],
    [int],  [sampleRate], [Sampling rate in Hz (default: 10).],
    [bool], [ready],      [True once the sensor has completed initialisation.],
  ),
  caption: [Sensor module — attribute reference],
) <tab:attr-ref>

== Results

// Describe what you measured, tested, or verified.
// Reference your figures and tables: @fig:example, @tab:example.
