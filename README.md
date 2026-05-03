# Synchronous RAM Verification Testbench

## Overview

This project builds a synchronous 8-bit × 64K (512 Kbit) RAM that reads and writes on the positive edge of the clock, with even parity computed on every write and stored in the 9th bit of memory. The testbench is designed from the ground up using an interface with a clocking block, a program block for stimulus, and an OOP transaction class to drive, monitor, and check memory operations in a clean and scalable way.

---

## Framework & Tools

| Tool | Purpose |
|---|---|
| **Synopsys VCS** | Compile & simulate |
| **DVE / Verdi** | Waveform viewing |
| **SystemVerilog IEEE 1800-2017** | RTL + verification language |

---

## Features

- **Interface** with modport for DUT and clocking block for race-free TB stimulus
- **Concurrent checker** — asserts `read` and `write` are never high simultaneously
- **10 MHz clock** generated at the top level (100ns period)
- **OOP Transaction class** — randomized address/data, deep copy, static error counter
- **Queue-based stimulus flow** — decoupled generate → drive → monitor → check tasks
- **Program block** isolates testbench from DUT to prevent scheduling races
