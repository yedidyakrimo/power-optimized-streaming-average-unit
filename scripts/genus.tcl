set design(TOPLEVEL) "average"
set debug_file "debug.txt"
set runtype "synthesis"

# Variables
set mmmc_or_simple "simple"; # "simple" - using "read_libs"
                             # "mmmc"   - using "read_mmmc"
set phys_synth_type "lef" ;  # "none"   - don't read any physical data
                             # "lef"    - only read lef and qrctech files
                             # "floorplan"    - read in a def of the floorplan


# Load general procedures
source ../scripts/procedures.tcl -quiet
enics_start_stage "start"


# Load the specific definitions for this project
source ../inputs/$design(TOPLEVEL).defines -quiet

# Load the library paths and definitions for this technology
source ../inputs/libraries.$TECHNOLOGY.tcl -quiet
source ../inputs/libraries.$SC_TECHNOLOGY.tcl -quiet
source ../inputs/libraries.$SRAM_TECHNOLOGY.tcl -quiet
if {$design(FULLCHIP_OR_MACRO)=="FULLCHIP"} {
    source ../inputs/libraries.$IO_TECHNOLOGY.tcl -quiet
}


#############################################
#       Print values to debug file
#############################################
set df [open $debug_file a]
puts $df "\n******************************************"
puts $df "* Debug values after everything was loaded *"
puts $df "******************************************"
foreach dic {paths tech tech_files design} {
    foreach key [array names $dic] {
        puts $df "${dic}(${key}) = \t[set ${dic}([set key])]"
    }
}

close $df


##########################
# General Genus Settings
##########################
set_db source_verbose true ; # Sourcing files will be reported as verbose
set_db information_level 9 ; # The log file will report everything
suppress_messages "PHYS-90"

##########################
# Read Libraries
##########################
enics_start_stage "init_design"

if {$mmmc_or_simple=="mmmc"} {
    read_mmmc $design(mmmc_view_file)
} else {
    set_db init_lib_search_path $paths(LIB_paths) 
    suppress_messages $tech(SC_LIB_SUPPRESS_MESSAGES_GENUS)
    read_libs $tech_files(ALL_WC_LIBS)
}
# Get rid of recurring unusable library cells messages, after debugging it once...
suppress_messages "LBR-415"

############################
# Physical Synthesis Setup
############################
if {$phys_synth_type == "none"} {
   enics_message "Physical Synthesis is disabled"
   read_qrc $tech_files(QRCTECH_FILE_WC)
} else {
    suppress_messages $tech(SC_LEF_SUPPRESS_MESSAGES_GENUS)
    read_physical -lef $tech_files(ALL_LEFS)
    if {$phys_synth_type == "floorplan"} { 
        # You need to read a .def file for the floorplan to enable physical synthesis 
        read_def $design(floorplan_def)
    }
}

##########################
# Read RTL
##########################
enics_start_stage "read_rtl"

set_db init_hdl_search_path $design(hdl_search_paths)
set_db hdl_language v2001 -quiet

# Stop reporting elaboration of multi-dimensional arrays
suppress_messages "CDFG-250"
# Stop reporting implementation inference (chipWare)
suppress_messages "CWD-19 CWD-36"
# Stop reporting Replaced logic with a constant value
suppress_messages "CDFG-771"
read_hdl -language sv -f $design(read_hdl_list)

set_db [get_lib_cell {*\MXT2_X4M_A9TR/}] .avoid true

##########################
# Elaborate
##########################
enics_start_stage "elaborate"

set_db hdl_track_filename_row_col true -quiet; # helps with debug
set_db lp_insert_clock_gating true 

elaborate $design(TOPLEVEL) ;#-update

enics_start_stage "post_elaboration"

current_design $design(TOPLEVEL)
check_design -unresolved
check_design -all > $design(synthesis_reports)/post_elaboration/check_design_post_elab.rpt
if {[check_design -status]} {
    Puts "ENICSINFO: ############# There is an issue with check_design. You better look at it! ###########"
}
#save elaborated design
write_design -base_name $design(export_dir)/post_elaboartion/$design(TOPLEVEL)

# Read in a floorplan for physical synthesis
# read_def $design(floorplan_def)

##########################
# read constraints
##########################
set_db detailed_sdc_messages true ; # helps read_sdc debug
read_sdc $design(functional_sdc) -stop_on_errors 
check_timing_intent
check_timing_intent -verbose > $design(synthesis_reports)/post_elaboration/check_timing_post_elab.rpt

##########################
# Set DONT_USE Cell
##########################

enics_start_stage "set_dont_use"

set dont_use_cell "MXT2_X4M_A9TR"

# Find the cell in the library
set my_dont_use_cell [get_db lib_cells */$dont_use_cell]

if {[llength $my_dont_use_cell] > 0} {
    set_db $my_dont_use_cell .avoid true
    puts "INFO: dont_use applied to $dont_use_cell"
} else {
    puts "WARNING: Cell $dont_use_cell not found in library"
}

###################################################################################
## Define cost groups (reg2reg, in2reg, reg2out, in2out)
###################################################################################
enics_default_cost_groups
enics_report_timing $design(synthesis_reports)



################################
# clock gating settings
################################
set_db [get_db design:$design(TOPLEVEL)] .lp_clock_gating_min_flops 8
set_db [get_db design:$design(TOPLEVEL)] .lp_clock_gating_style latch 

##########################
#     Synthesize
##########################
enics_start_stage "synthesis"

# Set Synthesis Efforts
set_db syn_generic_effort high
set_db syn_map_effort low
set_db syn_opt_effort high
suppress_messages "ST-110 ST-112"

if {$phys_synth_type == "floorplan"} {
    # Synthesize to generics and place generics in floorplan
    enics_start_stage "syn_generic"
    syn_generic -physical
    # Map to technology
    enics_start_stage "technology_mapping"
    syn_map -physical
    enics_report_timing $design(synthesis_reports) 
    # Post synthesis optimization
    enics_start_stage "post_syn_opt"
    syn_opt -physical
} else {
    # Synthesize to generics (non physical-aware)
    enics_start_stage "syn_generic"
    syn_generic 
    # Map to technology (non physical-aware)
    enics_start_stage "technology_mapping"
    syn_map 
    enics_report_timing $design(synthesis_reports)
    enics_start_stage "post_syn_opt"
    if {$phys_synth_type == "lef"} {
        syn_opt ;#-physical
    } else {
        syn_opt 
    }
}



#############################
#     Post Synthesis Reports
#############################
enics_report_timing $design(synthesis_reports) 
set post_synth_reports [list \
    report_area \
    report_gates \
    report_hierarchy \
    report_clock_gating \
    report_design_rules \
    report_dp \
    report_qor \
]
foreach rpt $post_synth_reports {
    enics_message "$rpt" medium
    $rpt
    $rpt > "$design(synthesis_reports)/post_opt/${rpt}.rpt"
}
##########################
# Create Summary Report
##########################
enics_start_stage "create_summary"

# Student details
set student_name "Yedidya Krimo"
set student_id   "315212795"

# Design information
set top_module "average"
set period "2.000" 

# --- PARAMETERS FOR ID 315212795 ---
# E=1 -> COUNT: BUF
# H=9 -> AREA:  INV

# 1. COUNT Instances (BUF)
# Using =~ to match any cell starting with BUF (e.g., BUF_X3M...)
set count_instances [get_db insts -if {.base_cell.base_name =~ "BUF*"}]
set num_instances [llength $count_instances]
set count_cell_name "BUF"

# 2. Calculate AREA (INV)
# Using =~ to match any cell starting with INV
set area_instances [get_db insts -if {.base_cell.base_name =~ "INV*"}]
set total_area 0.0
foreach inst $area_instances {
    set cell_area [get_db $inst .area]
    set total_area [expr $total_area + $cell_area]
}
set area_cell_name "INV"

##########################
# Write Summary File
##########################
set summary_file [open "$design(reports_dir)/my_summary.txt" w]

# Writing in the EXACT format required by the PDF
puts $summary_file "$student_name $student_id"
puts $summary_file "TOPMODULE:"
puts $summary_file "$top_module"
puts $summary_file "Period:"
puts $summary_file "$period ns"
puts $summary_file "COUNT:"
puts $summary_file "$count_cell_name"
puts $summary_file "$num_instances"
puts $summary_file "AREA:"
puts $summary_file "$area_cell_name"
puts $summary_file "$total_area"

close $summary_file

puts "=========================================="
puts "Summary report created: $design(reports_dir)/my_summary.txt"
puts "COUNT (BUF*): $num_instances"
puts "AREA  (INV*): $total_area"
puts "=========================================="

#############################
#   Exporting the Design
#############################
enics_start_stage "export_design"
write_db $design(TOPLEVEL) -to_file "$design(export_dir)/post_synth/$design(TOPLEVEL).db" 
write_design -base_name "$design(export_dir)/post_synth/$design(TOPLEVEL)"
write_hdl > $design(postsyn_netlist)
write_sdf > "$design(export_dir)/post_synth/$design(TOPLEVEL).sdf"
write_sdc > "$design(export_dir)/post_synth/$design(TOPLEVEL).sdc"

puts "Synthesis Flow Completed Successfully."