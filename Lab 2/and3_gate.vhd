library ieee;
use ieee.std_logic_1164.all;

entity and3_gate is
port(in1,in2,in3: in std_logic;
	output: out std_logic);
end;

architecture and_arch of and3_gate is
begin
	output <= in1 and in2 and in3;
end;
