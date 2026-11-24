# Instruction Set Architecture

The Mini-CPU is an **accumulator machine**: every arithmetic/logic instruction
reads one operand from memory, combines it with the accumulator `ACCU`, and
writes the result back into `ACCU`. There are no general-purpose registers.

## Instruction format

Each instruction is 8 bits wide: a 2-bit opcode followed by a 6-bit field that
holds a memory address (64 addressable words).

```
  7   6   5   4   3   2   1   0
+-------+-----------------------+
| opcode|        address        |
+-------+-----------------------+
```

> **Implementation note:** memory words are 16 bits wide (see
> [architecture.md](architecture.md#memory)). An instruction occupies the low
> byte of a word in the RTL (`IR(7:6)` = opcode, `IR(5:0)` = address). The
> sample programs in [`programs/`](../programs) use the
> course's encoding instead, with the opcode in bits `15:14`. See
> [Known limitations](architecture.md#status-and-known-limitations).

## Instructions

| Opcode | Mnemonic  | Operation                                    | Flags        | Cycles |
|:------:|-----------|----------------------------------------------|--------------|:------:|
| `00`   | `NOR adr` | `ACCU ← ACCU NOR MEM[adr]`                   | —            | 6      |
| `01`   | `ADD adr` | `ACCU ← ACCU + MEM[adr]`                     | `C ← carry`  | 6      |
| `10`   | `STA adr` | `MEM[adr] ← ACCU`                            | —            | 5      |
| `11`   | `JCC adr` | if `C = 0`: `PC ← adr`, else `C ← 0` and fall through | `C ← 0` | 4      |

The cycle counts follow directly from the control FSM (see
[architecture.md](architecture.md#control-fsm)): every memory access takes two
states because the RAM has a one-cycle synchronous read latency.

## Why only four instructions are enough

`NOR` is *functionally complete*, and together with `ADD` it can build every
other operation:

| Wanted operation      | Sequence (constants stored in memory)                 |
|-----------------------|-------------------------------------------------------|
| `ACCU ← 0`            | `NOR all_ones`                                        |
| `ACCU ← MEM[x]`       | `NOR all_ones` ; `ADD x`                              |
| `ACCU ← NOT ACCU`     | `NOR zero`                                            |
| `ACCU ← −ACCU`        | `NOR zero` ; `ADD one` (two's complement)             |
| `ACCU ← ACCU − 1`     | `ADD all_ones`                                        |
| `ACCU ← a AND b`      | `NOT a NOR NOT b` (De Morgan)                         |
| Unconditional jump    | `JCC adr` right after an instruction that cleared `C` |
| Halt                  | `JCC self` (repeated twice, so it also catches `C = 1`) |

The [`programs/`](../programs) folder shows these idioms in two complete
programs (two's complement and GCD).
