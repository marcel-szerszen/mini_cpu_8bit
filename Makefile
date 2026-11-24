# -----------------------------------------------------------------------------
# Mini-CPU — open-source checks with GHDL
#
#   make check   Analyse every RTL file and elaborate the top level (CPU_Bootloader)
#   make clean   Remove the GHDL work directory
#
# The full Vivado flow (synthesis / implementation) is driven by
# scripts/create_vivado_project.tcl — see README.md.
# -----------------------------------------------------------------------------

GHDL       ?= ghdl
GHDLFLAGS  ?= --std=08 -fsynopsys --workdir=$(WORKDIR)
WORKDIR    := build/ghdl
TOP        := CPU_Bootloader

# Analysis order: leaf cells first, top level last
RTL_SRCS := \
	rtl/common/mux2_1.vhd \
	rtl/processing_unit/Registre_1bit.vhd \
	rtl/processing_unit/Registre_16bits.vhd \
	rtl/processing_unit/UAL.vhd \
	rtl/processing_unit/Processing_unit.vhd \
	rtl/control_unit/Counter_Prog.vhd \
	rtl/control_unit/mux2_6.vhd \
	rtl/control_unit/FSM_processor.vhd \
	rtl/control_unit/Control_Unit.vhd \
	rtl/memory/RAM_SP_64_8.vhd \
	rtl/bootloader/uart_recv.vhd \
	rtl/bootloader/UART_fifoed_send_V1.vhd \
	rtl/bootloader/byte_2_word.vhd \
	rtl/bootloader/word_2_byte.vhd \
	rtl/bootloader/boot_loader.vhd \
	rtl/top/CPU_Bootloader.vhd

.PHONY: check clean

check: | $(WORKDIR)
	$(GHDL) -a $(GHDLFLAGS) $(RTL_SRCS)
	$(GHDL) -e $(GHDLFLAGS) $(TOP)
	@echo "OK: all sources analysed and $(TOP) elaborated."

$(WORKDIR):
	mkdir -p $@

clean:
	rm -rf build $(TOP) *.o *.cf
