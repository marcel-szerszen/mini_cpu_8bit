# Test programs

Memory images used to exercise the CPU. They are loaded into RAM over UART by
the bootloader (or read directly by a simulation testbench).

## File format

* 64 lines, one per RAM address (line 1 → address 0, line 64 → address 63).
* Each line is an **unsigned decimal 16-bit word**.
* Instruction words use the course encoding: opcode in bits `15:14`, address in
  bits `5:0` (e.g. `16400 = 0x4010 = ADD 16`). See
  [../docs/instruction_set.md](../docs/instruction_set.md).

---

## `ca2.txt` — two's complement

Computes `MEM[62] ← −MEM[63]`.

| Addr | Word    | Instruction | Comment                          |
|-----:|--------:|-------------|----------------------------------|
| 0    | 61      | `NOR 61`    | ACCU ← 0 (`MEM[61] = 0xFFFF`)    |
| 1    | 16447   | `ADD 63`    | ACCU ← X                         |
| 2    | 60      | `NOR 60`    | ACCU ← NOT X (`MEM[60] = 0`)     |
| 3    | 16443   | `ADD 59`    | ACCU ← NOT X + 1 = −X            |
| 4    | 32830   | `STA 62`    | store result                     |
| 5–6  | 49158   | `JCC 6`     | halt                             |
| 59   | 1       | data        | constant 1                       |
| 60   | 0       | data        | constant 0                       |
| 61   | 65535   | data        | constant 0xFFFF                  |
| 62   | 0       | data        | **result**                       |
| 63   | 1548    | data        | X                                |

**Expected result:** `MEM[62] = 63988` (`0xF9F4` = −1548 on 16 bits).

---

## `pgcd.txt` — greatest common divisor (*PGCD*)

Subtractive Euclid's algorithm on `A = MEM[18]` and `B = MEM[19]`:
`while A ≠ B: if B ≥ A then B ← B − A else A ← A − B`.

| Addr | Word  | Instruction | Comment                                         |
|-----:|------:|-------------|-------------------------------------------------|
| 0    | 15    | `NOR 15`    | ACCU ← 0                                        |
| 1    | 18    | `NOR 18`    | ACCU ← NOT A                                    |
| 2    | 16400 | `ADD 16`    | ACCU ← −A                                       |
| 3    | 16403 | `ADD 19`    | ACCU ← B − A, C = 1 iff B ≥ A                   |
| 4    | 49161 | `JCC 9`     | B < A → go to 9                                 |
| 5    | 32787 | `STA 19`    | B ← B − A                                       |
| 6    | 16399 | `ADD 15`    | ACCU − 1, C = 0 iff B − A = 0                   |
| 7    | 49165 | `JCC 13`    | A = B → done                                    |
| 8    | 49152 | `JCC 0`     | loop (C was just cleared)                       |
| 9    | 17    | `NOR 17`    | ACCU ← NOT (B − A) = A − B − 1                  |
| 10   | 16400 | `ADD 16`    | ACCU ← A − B                                    |
| 11   | 32786 | `STA 18`    | A ← A − B                                       |
| 12   | 49152 | `JCC 0`     | loop                                            |
| 13–14| 49165 | `JCC 13`    | halt                                            |
| 15   | 65535 | data        | constant 0xFFFF                                 |
| 16   | 1     | data        | constant 1                                      |
| 17   | 0     | data        | constant 0                                      |
| 18   | 40    | data        | A                                               |
| 19   | 24    | data        | B                                               |

**Expected result:** `MEM[18] = MEM[19] = 8` (gcd(40, 24)).
