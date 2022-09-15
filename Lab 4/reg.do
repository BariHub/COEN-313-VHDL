add wave *

force reset 1
force clk 0, 1 1 -r 2
run 2

force din 0110
force sel 00
run 2
force din 0100
force sel 01
run 2
force din 0001
force sel 10
run 2
force din 0101
force sel 11
run 2

force reset 0
force clk 0, 1 1 -r 2
run 2

force din 0110
force sel 00
run 2
force din 0100
force sel 01
run 2
force din 0001
force sel 10
run 2
force din 0101
force sel 11
run 2



