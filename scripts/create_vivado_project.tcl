# -----------------------------------------------------------------------------
# Re-creates the Vivado project from the sources in this repository.
#
# Usage (from the repository root):
#     vivado -mode batch -source scripts/create_vivado_project.tcl
#   or, from the Vivado Tcl console:
#     cd <repo>; source scripts/create_vivado_project.tcl
#
# The project is generated in build/vivado/ (git-ignored), so the repository
# only tracks hand-written sources, never tool-generated files.
# -----------------------------------------------------------------------------

set repo_root [file normalize [file join [file dirname [info script]] ..]]
set proj_name mini_cpu
set proj_dir  [file join $repo_root build vivado]
set part      xc7a100tcsg324-1   ;# Artix-7 100T (Digilent Nexys 4 / Nexys A7-100T class)

create_project $proj_name $proj_dir -part $part -force
set_property target_language VHDL [current_project]

# --- Design sources ----------------------------------------------------------
set rtl_files [concat \
    [glob -directory [file join $repo_root rtl common]          *.vhd] \
    [glob -directory [file join $repo_root rtl processing_unit] *.vhd] \
    [glob -directory [file join $repo_root rtl control_unit]    *.vhd] \
    [glob -directory [file join $repo_root rtl memory]          *.vhd] \
    [glob -directory [file join $repo_root rtl bootloader]      *.vhd] \
    [glob -directory [file join $repo_root rtl top]             *.vhd] ]
add_files -fileset sources_1 $rtl_files
set_property top CPU_Bootloader [get_filesets sources_1]

# --- Constraints (optional) -------------------------------------------------
# Drop a board .xdc file into constraints/ to enable implementation/bitstream.
set xdc_files [glob -nocomplain -directory [file join $repo_root constraints] *.xdc]
if {[llength $xdc_files] > 0} {
    add_files -fileset constrs_1 $xdc_files
} else {
    puts "INFO: no .xdc found in constraints/ — synthesis only until pins are constrained."
}

# --- Simulation sources ------------------------------------------------------
add_files -fileset sim_1 [glob -directory [file join $repo_root sim tb] *.vhd]
add_files -fileset sim_1 [glob -directory [file join $repo_root programs] *.txt]

update_compile_order -fileset sources_1
puts "Project created in $proj_dir"
