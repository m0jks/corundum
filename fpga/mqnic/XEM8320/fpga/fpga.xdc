# XDC constraints XEM8320 10G Example Design. Dave Pegler {peglerd@gmail.com, dpegler@crfs.com}
# part: xcau25p-ffvb676-2-e

# 100MHz reference from U42 (FABRIC_REFCLK)
set_property -dict {LOC T24 IOSTANDARD LVDS} [get_ports clk_100mhz_p];
set_property -dict {LOC U24 IOSTANDARD LVDS} [get_ports clk_100mhz_n];
create_clock -period 10.000 -name clk_100mhz [get_ports clk_100mhz_p];

# D14 cannot directly drive MMCM, so need to set CLOCK_DEDICATED_ROUTE to satisfy DRC
#set_property CLOCK_DEDICATED_ROUTE ANY_CMT_COLUMN [get_nets clk_100mhz_bufg]

# -- Bank 66 and 67 -- SFP and SMA LEDs (VIO1 1v8)
set_property -dict {LOC G19 IOSTANDARD LVCMOS18} [get_ports {sfp_1_led[0]}] ;# LED 1, Bank 67, VIO1, (SYZYGY mainly port C, but also port B)
set_property -dict {LOC B16 IOSTANDARD LVCMOS18} [get_ports {sfp_1_led[1]}] ;# LED 2, Bank 67, VIO1, (SYZYGY mainly port C, but also port B)
#set_property -dict {LOC F22 IOSTANDARD LVCMOS18} [get_ports {sfp_2_led[0]}] ;# LED 3, Bank 66, VIO1, (SYZYGY mainly port A, but also port B)
#set_property -dict {LOC E22 IOSTANDARD LVCMOS18} [get_ports {sfp_2_led[1]}] ;# LED 4, Bank 67, VIO1, (SYZYGY mainly port C, but also port B)
set_property -dict {LOC M24 IOSTANDARD LVCMOS18} [get_ports   {sma_led[0]}] ;# LED 5, Bank 66, VIO1, (SYZYGY mainly port A, but also port B)
set_property -dict {LOC G22 IOSTANDARD LVCMOS18} [get_ports   {sma_led[1]}] ;# LED 6, Bank 66, VIO1, (SYZYGY mainly port A, but also port B)

#set_false_path -to [get_ports {sfp_1_led[*] sfp_2_led[*] sma_led[*]}]
set_false_path -to [get_ports {sfp_1_led[*] sma_led[*]}]
#set_output_delay 0 [get_ports {sfp_1_led[*] sfp_2_led[*] sma_led[*]}]
set_output_delay 0 [get_ports {sfp_1_led[*] sma_led[*]}]


# -- Bank 226 -- SFP+ Interfaces
#set_property -dict {LOC P7 } [get_ports sfp_mgt_refclk_p] ;# MGTREFCLK0P_226 from U39 (125MHz)
#set_property -dict {LOC P6 } [get_ports sfp_mgt_refclk_n] ;# MGTREFCLK0N_226 from U39 (125MHz)
set_property -dict {LOC  Y7 } [get_ports sfp_mgt_refclk_p] ;# MGTREFCLK1P_224 (156.25MHz) (XEM8320 Rev CXX)
set_property -dict {LOC  Y6 } [get_ports sfp_mgt_refclk_n] ;# MGTREFCLK1N_224 (156.25MHz) (XEM8320 Rev CXX)
#
set_property -dict {LOC M2 } [get_ports sfp_1_rx_p] ;# MGTYRXP0_226 GTYE4_CHANNEL_X0Y08 / GTYE4_COMMON_X0Y2
set_property -dict {LOC M1 } [get_ports sfp_1_rx_n] ;# MGTYRXN0_226 GTYE4_CHANNEL_X0Y08 / GTYE4_COMMON_X0Y2
#set_property -dict {LOC K2 } [get_ports sfp_2_rx_p] ;# MGTYRXP1_226 GTYE4_CHANNEL_X0Y09 / GTYE4_COMMON_X0Y2
#set_property -dict {LOC K1 } [get_ports sfp_2_rx_n] ;# MGTYRXN1_226 GTYE4_CHANNEL_X0Y09 / GTYE4_COMMON_X0Y2
set_property -dict {LOC N5 } [get_ports sfp_1_tx_p] ;# MGTYTXP0_226 GTYE4_CHANNEL_X0Y08 / GTYE4_COMMON_X0Y2
set_property -dict {LOC N4 } [get_ports sfp_1_tx_n] ;# MGTYTXN0_226 GTYE4_CHANNEL_X0Y08 / GTYE4_COMMON_X0Y2
#set_property -dict {LOC L5 } [get_ports sfp_2_tx_p] ;# MGTYTXP1_226 GTYE4_CHANNEL_X0Y09 / GTYE4_COMMON_X0Y2
#set_property -dict {LOC L4 } [get_ports sfp_2_tx_n] ;# MGTYTXN1_226 GTYE4_CHANNEL_X0Y09 / GTYE4_COMMON_X0Y2

# -- Bank 87 -- SFP strobes (VIO2 1v8)
set_property -dict {LOC E13 IOSTANDARD LVCMOS18 PULLUP true} [get_ports sfp_1_los]; # Bank 87, VIO2, (SYZYGY port D)
#set_property -dict {LOC A13 IOSTANDARD LVCMOS18 PULLUP true} [get_ports sfp_2_los]; # Bank 87, VIO2, (SYZYGY port D)
set_property -dict {LOC D13 IOSTANDARD LVCMOS18} [get_ports {sfp_1_rs[0]}]; # Bank 87, VIO2, (SYZYGY port D)
set_property -dict {LOC E12 IOSTANDARD LVCMOS18} [get_ports {sfp_1_rs[1]}]; # Bank 87, VIO2, (SYZYGY port D)
#set_property -dict {LOC B14 IOSTANDARD LVCMOS18} [get_ports {sfp_2_rs[0]}]; # Bank 87, VIO2, (SYZYGY port D)
#set_property -dict {LOC A12 IOSTANDARD LVCMOS18} [get_ports {sfp_2_rs[1]}]; # Bank 87, VIO2, (SYZYGY port D)
set_property -dict {LOC C13 IOSTANDARD LVCMOS18} [get_ports sfp_1_tx_disable]; # Bank 87, VIO2, (SYZYGY port D)
#set_property -dict {LOC F13 IOSTANDARD LVCMOS18} [get_ports sfp_2_tx_disable]; # Bank 87, VIO2, (SYZYGY port D)
set_property -dict {LOC D14 IOSTANDARD LVCMOS18 PULLUP true} [get_ports sfp_1_npres]; #  Bank 87, VIO2, SFP1_MOD_DEF0_VIO2)
#set_property -dict {LOC A14 IOSTANDARD LVCMOS18 PULLUP true} [get_ports sfp_2_npres]; #  Bank 87, VIO2, (SFP2_MOD_DEF0_VIO2)
set_property -dict {LOC C12 IOSTANDARD LVCMOS18 PULLUP true} [get_ports sfp_i2c_scl]; #  Bank 87, VIO2, (SFP1_MOD_DEF1_VIO2)
set_property -dict {LOC B12 IOSTANDARD LVCMOS18 PULLUP true} [get_ports sfp_1_i2c_sda]; #  Bank 87, VIO2, (SFP1_MOD_DEF2_VIO2)
#set_property -dict {LOC G12 IOSTANDARD LVCMOS18 PULLUP true} [get_ports sfp_2_i2c_scl]; #  Bank 87, VIO2, (SFP2_MOD_DEF1_VIO2)
#set_property -dict {LOC F12 IOSTANDARD LVCMOS18 PULLUP true} [get_ports sfp_2_i2c_sda]; #  Bank 87, VIO2, (SFP2_MOD_DEF2_VIO2)

# 156.25 MGT reference clock
create_clock -period 6.4 -name sfp_mgt_refclk [get_ports sfp_mgt_refclk_p]
#
#set_false_path -to [get_ports {sfp_1_tx_disable sfp_2_tx_disable sfp_1_rs sfp_2_rs}]
set_false_path -to [get_ports {sfp_1_tx_disable sfp_1_rs}]
#set_output_delay 0 [get_ports {sfp_1_tx_disable sfp_2_tx_disable sfp_1_rs sfp_2_rs}]
set_output_delay 0 [get_ports {sfp_1_tx_disable sfp_1_rs}]
#set_false_path -from [get_ports {sfp_1_npres sfp_2_npres sfp_1_los sfp_2_los}]
set_false_path -from [get_ports {sfp_1_npres sfp_1_los}]
#set_input_delay 0 [get_ports {sfp_1_npres sfp_2_npres sfp_1_los sfp_2_los}]
set_input_delay 0 [get_ports {sfp_1_npres sfp_1_los}]
#
#set_false_path -to [get_ports {sfp_1_i2c_sda sfp_2_i2c_sda sfp_1_i2c_scl sfp_2_i2c_scl}]
set_false_path -to [get_ports {sfp_1_i2c_sda sfp_1_i2c_scl}]
#set_output_delay 0 [get_ports {sfp_1_i2c_sda sfp_2_i2c_sda sfp_1_i2c_scl sfp_2_i2c_scl}]
set_output_delay 0 [get_ports {sfp_1_i2c_sda sfp_1_i2c_scl}]
#set_false_path -from [get_ports {sfp_1_i2c_sda sfp_2_i2c_sda sfp_1_i2c_scl sfp_2_i2c_scl}]
set_false_path -from [get_ports {sfp_1_i2c_sda sfp_1_i2c_scl}]
#set_input_delay 0 [get_ports {sfp_1_i2c_sda sfp_2_i2c_sda sfp_1_i2c_scl sfp_2_i2c_scl}]
set_input_delay 0 [get_ports {sfp_1_i2c_sda sfp_1_i2c_scl}]

# SZG-PCIEX4 x4 PCIe card on Port E (Bank 224)
# PCIe Lane 0
set_property -dict {LOC AF2} [get_ports {pcie_rx_p[0]}] ;# SZG_PORTE_RX0P (MGTYRXP0_224 GTYE4_CHANNEL_X0Y7 / GTYE4_COMMON_X0Y1)
set_property -dict {LOC AF1} [get_ports {pcie_rx_n[0]}] ;# SZG_PORTE_RX0N (MGTYRXN0_224 GTYE4_CHANNEL_X0Y7 / GTYE4_COMMON_X0Y1)
set_property -dict {LOC AF7} [get_ports {pcie_tx_p[0]}] ;# SZG_PORTE_TX0P (MGTYTXP0_224 GTYE4_CHANNEL_X0Y7 / GTYE4_COMMON_X0Y1)
set_property -dict {LOC AF6} [get_ports {pcie_tx_n[0]}] ;# SZG_PORTE_TX0N (MGTYTXN0_224 GTYE4_CHANNEL_X0Y7 / GTYE4_COMMON_X0Y1)
# PCIe Lane 1
set_property -dict {LOC AE4} [get_ports {pcie_rx_p[1]}] ;# SZG_PORTE_RX1P (MGTYRXP1_224 GTYE4_CHANNEL_X0Y6 / GTYE4_COMMON_X0Y1)
set_property -dict {LOC AE3} [get_ports {pcie_rx_n[1]}] ;# SZG_PORTE_RX1N (MGTYRXN1_224 GTYE4_CHANNEL_X0Y6 / GTYE4_COMMON_X0Y1)
set_property -dict {LOC AE9} [get_ports {pcie_tx_p[1]}] ;# SZG_PORTE_TX1P (MGTYTXP1_224 GTYE4_CHANNEL_X0Y6 / GTYE4_COMMON_X0Y1)
set_property -dict {LOC AE8} [get_ports {pcie_tx_n[1]}] ;# SZG_PORTE_TX1N (MGTYTXN1_224 GTYE4_CHANNEL_X0Y6 / GTYE4_COMMON_X0Y1)
# PCIe Lane 2
set_property -dict {LOC AD2} [get_ports {pcie_rx_p[2]}] ;# SZG_PORTE_RX2P (MGTYRXP2_224 GTYE4_CHANNEL_X0Y5 / GTYE4_COMMON_X0Y1)
set_property -dict {LOC AD1} [get_ports {pcie_rx_n[2]}] ;# SZG_PORTE_RX2N (MGTYRXN2_224 GTYE4_CHANNEL_X0Y5 / GTYE4_COMMON_X0Y1)
set_property -dict {LOC AD7} [get_ports {pcie_tx_p[2]}] ;# SZG_PORTE_TX2P (MGTYTXP2_224 GTYE4_CHANNEL_X0Y5 / GTYE4_COMMON_X0Y1)
set_property -dict {LOC AD6} [get_ports {pcie_tx_n[2]}] ;# SZG_PORTE_TX2N (MGTYTXN2_224 GTYE4_CHANNEL_X0Y5 / GTYE4_COMMON_X0Y1)
# PCIe Lane 3
set_property -dict {LOC AB2} [get_ports {pcie_rx_p[3]}] ;# SZG_PORTE_RX3P (MGTYRXP3_224 GTYE4_CHANNEL_X0Y4 / GTYE4_COMMON_X0Y1)
set_property -dict {LOC AB1} [get_ports {pcie_rx_n[3]}] ;# SZG_PORTE_RX3N (MGTYRXN3_224 GTYE4_CHANNEL_X0Y4 / GTYE4_COMMON_X0Y1)
set_property -dict {LOC AC5} [get_ports {pcie_tx_p[3]}] ;# SZG_PORTE_TX3P (MGTYTXP3_224 GTYE4_CHANNEL_X0Y4 / GTYE4_COMMON_X0Y1)
set_property -dict {LOC AC4} [get_ports {pcie_tx_n[3]}] ;# SZG_PORTE_TX3N (MGTYTXN3_224 GTYE4_CHANNEL_X0Y4 / GTYE4_COMMON_X0Y1)
# PCIe 100MHz reference clock
set_property -dict {LOC AB7} [get_ports pcie_refclk_p] ;# SZG_PORTE_REFCLK0P (MGTREFCLK0P_224)
set_property -dict {LOC AB6} [get_ports pcie_refclk_n] ;# SZG_PORTE_REFCLK0N (MGTREFCLK0N_224)
#
# Bank 86 (VIO3 1v8)
set_property -dict {LOC J10 IOSTANDARD LVCMOS18 PULLUP true} [get_ports pcie_reset_n]
set_false_path -from [get_ports {pcie_reset_n}]
set_input_delay 0 [get_ports {pcie_reset_n}]

# 100 MHz MGT reference clock
create_clock -period 10 -name pcie_mgt_refclk [get_ports pcie_refclk_p]


# BPI flash
#set_property -dict {LOC AF20 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_dq[0]}]
#set_property -dict {LOC AE18 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_dq[1]}]
#set_property -dict {LOC AF19 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_dq[2]}]
#set_property -dict {LOC AF17 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_dq[3]}]
#set_property -dict {LOC AB19 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_dq[4]}]
#set_property -dict {LOC AD19 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_dq[5]}]
#set_property -dict {LOC AB17 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_dq[6]}]
#set_property -dict {LOC AE17 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_dq[7]}]
#set_property -dict {LOC AD16 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_dq[8]}]
#set_property -dict {LOC AE16 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_dq[9]}]
#set_property -dict {LOC AD18 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_dq[10]}]
#set_property -dict {LOC AC21 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_dq[11]}]
#set_property -dict {LOC AE22 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_dq[12]}]
#set_property -dict {LOC AF22 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_dq[13]}]
#set_property -dict {LOC AF25 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_dq[14]}]
#set_property -dict {LOC AF24 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_dq[15]}]
#set_property -dict {LOC AE20 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_addr[0]}]
#set_property -dict {LOC AE26 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_addr[1]}]
#set_property -dict {LOC AD24 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_addr[2]}]
#set_property -dict {LOC AC23 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_addr[3]}]
#set_property -dict {LOC AE23 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_addr[4]}]
#set_property -dict {LOC AD20 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_addr[5]}]
#set_property -dict {LOC AC24 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_addr[6]}]
#set_property -dict {LOC AC22 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_addr[7]}]
#set_property -dict {LOC AD23 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_addr[8]}]
#set_property -dict {LOC AD21 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_addr[9]}]
#set_property -dict {LOC AB22 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_addr[10]}]
#set_property -dict {LOC AA22 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_addr[11]}]
#set_property -dict {LOC AE25 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_addr[12]}]
#set_property -dict {LOC AD26 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_addr[13]}]
#set_property -dict {LOC AB25 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_addr[14]}]
#set_property -dict {LOC AB26 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_addr[15]}]
#set_property -dict {LOC AD25 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_addr[16]}]
#set_property -dict {LOC AC26 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_addr[17]}]
#set_property -dict {LOC AB21 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_addr[18]}]
#set_property -dict {LOC AB24 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_addr[19]}]
#set_property -dict {LOC Y18  IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_addr[20]}]
#set_property -dict {LOC AA20 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_addr[21]}]
#set_property -dict {LOC AC19 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_addr[22]}]
#set_property -dict {LOC Y20  IOSTANDARD LVCMOS18 PULLUP true} [get_ports {flash_region}]
#set_property -dict {LOC AF18 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_ce_n}]
#set_property -dict {LOC Y21  IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_oe_n}]
#set_property -dict {LOC AB20 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_we_n}]
#set_property -dict {LOC AF23 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {flash_adv_n}]

#set_false_path -to [get_ports {flash_dq[*] flash_addr[*] flash_region flash_ce_n flash_oe_n flash_we_n flash_adv_n}]
#set_output_delay 0 [get_ports {flash_dq[*] flash_addr[*] flash_region flash_ce_n flash_oe_n flash_we_n flash_adv_n}]
#set_false_path -from [get_ports {flash_dq[*]}]
#set_input_delay 0 [get_ports {flash_dq[*]}]

# Bitstream configuration
set_property CFGBVS GND                                      [current_design]
set_property CONFIG_VOLTAGE 1.8                              [current_design]
set_property BITSTREAM.GENERAL.COMPRESS true                 [current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN Pullup               [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 31.9                [current_design]
set_property BITSTREAM.CONFIG.BPI_PAGE_SIZE 8                [current_design]
set_property BITSTREAM.CONFIG.BPI_1ST_READ_CYCLE 4           [current_design]
set_property CONFIG_MODE BPI16                               [current_design]
set_property BITSTREAM.CONFIG.OVERTEMPSHUTDOWN Enable        [current_design]
