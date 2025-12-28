`timescale 1ns/1ps

// Wrapper to provide a timescale for the provided divider implementation
// This file textually includes the original div.sv (which must not be modified).
// The include path is relative to this wrapper file (same directory), so
// include the sibling div.sv directly.
`include "../src/rtl/div.sv"
