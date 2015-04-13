# MINIMIG-DE1
# top makefile
# 2012, rok.krajnc@gmail.com


### board ###
BOARD?=de0_nano


### paths ###
REL_DIR=rel
CTRL_FW_DIR=fw/ctrl
CTRL_BOOT_DIR=fw/ctrl_boot
FPGA_DIR=fpga/$(BOARD)


### files ###
CTRL_FW=$(CTRL_FW_DIR)/bin/de1_boot.bin
FPGA=$(FPGA_DIR)/out/minimig_de1.sof $(FPGA_DIR)/out/minimig_de1.pof


### build rules ###
BUILD_OPT=clean all

# all
all:
	@echo Building all ...
	@mkdir -p $(REL_DIR)
	@make ctrl_fw
	@make ctrl_boot
	@make fpga


ctrl_fw: Makefile 
	@echo Building ctrl firmware in $(CTRL_FW_DIR) ...
	@$(MAKE) -C $(CTRL_FW_DIR) $(BUILD_OPT)
	@cp $(CTRL_FW) $(REL_DIR)/

ctrl_boot: Makefile 
	@echo Building ctrl boot firmware in $(CTRL_BOOT_DIR) ...
	@$(MAKE) -C $(CTRL_BOOT_DIR) $(BUILD_OPT)

fpga: Makefile 
	@echo Building FPGA in $(FPGA_DIR) ...
	@$(MAKE) -C $(FPGA_DIR) $(BUILD_OPT)
	@cp $(FPGA) $(REL_DIR)/


# clean
clean:
	@echo Clearing release dir ...
#	@rm -rf $(REL_DIR)
	@$(MAKE) -C $(CTRL_FW_DIR) clean
	@$(MAKE) -C $(CTRL_BOOT_DIR) clean
	@$(MAKE) -C $(FPGA_DIR) clean

