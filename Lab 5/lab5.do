add wave *

force reset 1
force din 01010101
force clk 0, 1 1 -r 2
run 2

force reset 0
run 44
