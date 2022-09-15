library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity converter is
port(sign_mag: in std_logic_vector(3 downto 0);
	twos_comp: out std_logic_vector(3 downto 0));
end;

architecture arch of converter is

begin
process(sign_mag) is
variable myvar: std_logic_vector(3 downto 0);
begin
if(sign_mag(3) = '0') then
	twos_comp <= sign_mag;
else
	myvar := not sign_mag(3 downto 0);
	myvar := myvar + "001";
	twos_comp <= sign_mag(3) & myvar(2 downto 0);
end if;
end process;
end;
