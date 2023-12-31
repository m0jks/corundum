# Timing constraints for BittWare 520N-MX

set_time_format -unit ns -decimal_places 3

# Clock constraints
create_clock -name {config_clk}  -period  20.000 [ get_ports {config_clk} ]
create_clock -name {usr_refclk0} -period   3.333 [ get_ports {usr_refclk0} ]
create_clock -name {usr_refclk1} -period   3.333 [ get_ports {usr_refclk1} ]

create_clock -name {mem0_refclk} -period 3.333 [ get_ports {mem0_refclk} ]
create_clock -name {mem1_refclk} -period 3.333 [ get_ports {mem1_refclk} ]

create_clock -name {esram_0_refclk} -period 5.000 [ get_ports {esram_0_refclk} ]
create_clock -name {esram_1_refclk} -period 5.000 [ get_ports {esram_1_refclk} ]

create_clock -name {hbm_top_refclk} -period 5.000 [ get_ports {hbm_top_refclk} ]
create_clock -name {hbm_bottom_refclk} -period 5.000 [ get_ports {hbm_bottom_refclk} ]

create_clock -name {pcie_refclk} -period  10.000 [ get_ports {pcie_refclk} ]

create_clock -name {qsfp0_refclk} -period 1.551 [ get_ports {qsfp0_refclk} ]
create_clock -name {qsfp1_refclk} -period 1.551 [ get_ports {qsfp1_refclk} ]
create_clock -name {qsfp2_refclk} -period 1.551 [ get_ports {qsfp2_refclk} ]
create_clock -name {qsfp3_refclk} -period 1.551 [ get_ports {qsfp3_refclk} ]

derive_clock_uncertainty

set_clock_groups -asynchronous -group [ get_clocks {config_clk} ]
set_clock_groups -asynchronous -group [ get_clocks {usr_refclk0} ]
set_clock_groups -asynchronous -group [ get_clocks {usr_refclk1} ]

set_clock_groups -asynchronous -group [ get_clocks {mem0_refclk} ]
set_clock_groups -asynchronous -group [ get_clocks {mem1_refclk} ]

set_clock_groups -asynchronous -group [ get_clocks {esram_0_refclk} ]
set_clock_groups -asynchronous -group [ get_clocks {esram_1_refclk} ]

set_clock_groups -asynchronous -group [ get_clocks {hbm_top_refclk} ]
set_clock_groups -asynchronous -group [ get_clocks {hbm_bottom_refclk} ]

set_clock_groups -asynchronous -group [ get_clocks {pcie_refclk} ]

set_clock_groups -asynchronous -group [ get_clocks {qsfp0_refclk} ]
set_clock_groups -asynchronous -group [ get_clocks {qsfp1_refclk} ]
set_clock_groups -asynchronous -group [ get_clocks {qsfp2_refclk} ]
set_clock_groups -asynchronous -group [ get_clocks {qsfp3_refclk} ]

# JTAG constraints
create_clock -name {altera_reserved_tck} -period 62.500 {altera_reserved_tck}

set_clock_groups -asynchronous -group {altera_reserved_tck}

# IO constraints
set_false_path -to   "led_user_red[*]"
set_false_path -to   "led_user_grn[*]"
set_false_path -to   "led_qsfp[*]"

set_false_path -to   "uart_rx"
set_false_path -from "uart_tx"

set_false_path -to   "fpga_i2c_sda"
set_false_path -from "fpga_i2c_sda"
set_false_path -to   "fpga_i2c_scl"
set_false_path -from "fpga_i2c_scl"
set_false_path -to   "fpga_i2c_req_l"
set_false_path -from "fpga_i2c_mux_gnt"

set_false_path -from "fpga_gpio_1"
set_false_path -from "fpga_rst_n"

set_false_path -from "pcie_perstn"

set_false_path -from "qsfp_irq_n[*]"

set_false_path -to   "oc0_gpio[*]"
set_false_path -from "oc0_gpio[*]"
set_false_path -to   "oc0_gpio_dir[*]"
set_false_path -to   "oc0_buff_en_n[*]"

set_false_path -to   "oc1_gpio[*]"
set_false_path -from "oc1_gpio[*]"
set_false_path -to   "oc1_gpio_dir[*]"
set_false_path -to   "oc1_buff_en_n[*]"

set_false_path -from "oc2_perst_n"
set_false_path -to   "oc2_buff_in_sel"

set_false_path -from "oc3_perst_n"
set_false_path -to   "oc3_buff_in_sel"


source ../lib/eth/syn/quartus_pro/eth_mac_fifo.sdc
source ../lib/eth/lib/axis/syn/quartus_pro/sync_reset.sdc
source ../lib/eth/lib/axis/syn/quartus_pro/axis_async_fifo.sdc

# 100 MHz clock
set_clock_groups -asynchronous -group [ get_clocks "iopll_100mhz_inst|iopll_0_outclk0" ]

# clocking infrastructure
constrain_sync_reset_inst "sync_reset_100mhz_inst"
constrain_sync_reset_inst "ptp_rst_reset_sync_inst"

# PTP ref clock
set_clock_groups -asynchronous -group [ get_clocks "ref_div_inst|stratix10_clkctrl_0|clkdiv_inst|clock_div4" ]

# PHYs
proc constrain_phy { inst } {
    puts "Inserting timing constraints for PHY $inst"

    set_clock_groups -asynchronous -group [ get_clocks "${inst}|eth_xcvr_inst|tx_clkout|ch0" ]
    set_clock_groups -asynchronous -group [ get_clocks "${inst}|eth_xcvr_inst|rx_clkout|ch0" ]
    set_clock_groups -asynchronous -group [ get_clocks "${inst}|eth_xcvr_inst|profile0|tx_clkout|ch0" ]
    set_clock_groups -asynchronous -group [ get_clocks "${inst}|eth_xcvr_inst|profile0|rx_clkout|ch0" ]
    set_clock_groups -asynchronous -group [ get_clocks "${inst}|eth_xcvr_inst|profile1|tx_clkout|ch0" ]
    set_clock_groups -asynchronous -group [ get_clocks "${inst}|eth_xcvr_inst|profile1|rx_clkout|ch0" ]

    constrain_sync_reset_inst "$inst|phy_tx_rst_reset_sync_inst"
    constrain_sync_reset_inst "$inst|phy_rx_rst_reset_sync_inst"
}

proc constrain_phy_quad { inst } {
    puts "Inserting timing constraints for PHY quad $inst"

    constrain_phy "${inst}|eth_xcvr_phy_1"
    constrain_phy "${inst}|eth_xcvr_phy_2"
    constrain_phy "${inst}|eth_xcvr_phy_3"
    constrain_phy "${inst}|eth_xcvr_phy_4"
}

constrain_phy_quad "qsfp0_eth_xcvr_phy_quad"
constrain_phy_quad "qsfp1_eth_xcvr_phy_quad"
constrain_phy_quad "qsfp2_eth_xcvr_phy_quad"
constrain_phy_quad "qsfp3_eth_xcvr_phy_quad"
