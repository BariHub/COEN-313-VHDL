library ieee;
use ieee.std_logic_1164.all;

entity or3_gate is
port(in1, in2, in3: in std_logic;
	output: out std_logic);
end;

architecture or_arch of or3_gate is
begin
	output <= in1 or in2 or in3;
end;
