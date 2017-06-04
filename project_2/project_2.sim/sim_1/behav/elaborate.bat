@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.2\\bin
call %xv_path%/xelab  -wto da901576004747d19156bdc6d8750f9a -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot tb_FL_Controller_behav xil_defaultlib.tb_FL_Controller -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
