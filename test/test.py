# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

#    # Generate a clock on the `clk` line
#     clock = Clock(dut.clk, 10, units="ns")  # 10ns period = 100MHz clock
#     cocotb.start_soon(clock.start())

#     # Reset the DUT (Device Under Test)
#     dut.rst_n.value = 0
#     await RisingEdge(dut.clk)
#     dut.rst_n.value = 1
#     await RisingEdge(dut.clk)
#     dut.rst_n.value = 0  # release reset
#     await RisingEdge(dut.clk)

#     # Set initial values for inputs
#     dut.ui_in.value = 0b00000000
#     dut.uio_in.value = 0b00000000

#     # Test Case 1: Basic operation check
#     await run_mac_and_lif_test(dut, ui_in=0x12, uio_in=0x34)

#     # Test Case 2: Check with different input values
#     await run_mac_and_lif_test(dut, ui_in=0x55, uio_in=0x2A)

#     # Test Case 3: Edge case with maximum input values
#     await run_mac_and_lif_test(dut, ui_in=0x7F, uio_in=0x7F)

#     # Additional tests can be added for specific behaviors as needed
#     # You could add assertions to validate expected output values in each test case


# async def run_mac_and_lif_test(dut, ui_in, uio_in):
#     """
#     Helper function to set inputs and check outputs for tt_um_systolicLif module.
#     """
#     # Set ui_in and uio_in values
#     dut.ui_in.value = ui_in
#     dut.uio_in.value = uio_in

#     # Wait a few clock cycles for outputs to settle
#     for _ in range(10):
#         await RisingEdge(dut.clk)

#     # Read and display the output values
#     uo_out = dut.uo_out.value
#     uio_out = dut.uio_out.value
#     uio_oe = dut.uio_oe.value

#     # Log the results for debugging
#     dut._log.info(f"Test with ui_in = {ui_in:#04x}, uio_in = {uio_in:#04x}")
#     dut._log.info(f"uo_out = {uo_out:#04x}, uio_out = {uio_out:#04x}, uio_oe = {uio_oe:#04x}")

#     # Optionally, add assertions to validate the outputs
#     # For example:
#     # assert uo_out == expected_value, f"Unexpected output: uo_out = {uo_out:#04x}"