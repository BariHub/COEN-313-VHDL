library ieee;
use ieee.std_logic_1164.all;

entity sum_of_minterms_re is
port(a,b,c: in std_logic;
	output: out std_logic);
end;

architecture min_arch of sum_of_minterms_re is
begin

	output <= (not a and not b and c) or (not a and b and c) or (a and b and c);

end;

