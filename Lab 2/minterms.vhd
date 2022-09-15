library ieee;
use ieee.std_logic_1164.all;

entity sum_of_minterms is
port(a,b,c: in std_logic;
	output: out std_logic);
end;

architecture min_arch of sum_of_minterms is

component and3_gate
port(in1,in2,in3: in std_logic;
	output: out std_logic);
end component;

component or3_gate
port(in1,in2,in3: in std_logic;
	output: out std_logic);
end component;

signal s1,s2,s3,nota,notb: std_logic;

for a1,a2,a3: and3_gate use entity WORK.and3_gate(and_arch);
for o1: or3_gate use entity WORK.or3_gate(or_arch);

begin

nota <= not a;
notb <= not b;
a1: and3_gate port map(in1 => nota, in2 => b, in3 => c, output => s1);
a2: and3_gate port map(in1 => nota, in2 => notb, in3 => c, output => s2);
a3: and3_gate port map(in1 => a, in2 =>	b, in3 => c, output => s3);
o1: or3_gate port map(in1 => s1, in2 => s2, in3 => s3, output => output);

end min_arch;

