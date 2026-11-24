# Constraints

Place the board pin/clock constraints file (`.xdc`) here.
`scripts/create_vivado_project.tcl` adds every `.xdc` in this folder to the
project automatically.

Top-level ports of `CPU_Bootloader` that need pins:

| Port          | Dir | Typical board resource            |
|---------------|-----|-----------------------------------|
| `clk`         | in  | 100 MHz system oscillator         |
| `rst`         | in  | push-button (active high)         |
| `ce`          | in  | switch (clock enable for the CPU) |
| `scan_memory` | in  | push-button (dump RAM over UART)  |
| `rx`          | in  | USB-UART RX                       |
| `tx`          | out | USB-UART TX                       |
