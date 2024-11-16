# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    clock = Clock(dut.clk, 1, units="ns")
    cocotb.start_soon(clock.start())

    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut.ui_in.value = 110 
    await ClockCycles(dut.clk, 100)
    dut.ui_in.value = 70
    await ClockCycles(dut.clk, 100)
    dut.ui_in.value = 60
    await ClockCycles(dut.clk, 100)
    

    dut._log.info("finished")