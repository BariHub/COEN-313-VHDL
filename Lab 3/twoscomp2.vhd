library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity converter2 is
port(sign_mag: in std_logic_vector(3 downto 0);
	twos_comp: out std_logic_vector(3 downto 0));
end;

architecture arch of converter2 is
signal s1: std_logic_vector(3 downto 0);

begin
process(sign_mag) is
begin
if(sign_mag(3) = '0') then
	s1 <= sign_mag;
else
	s1 <= sign_mag(3) & (not sign_mag(2 downto 0) + "001");
end if;
end process;
	twos_comp <= s1;
end;
