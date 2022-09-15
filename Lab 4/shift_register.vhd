library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity registers_min_max is
port(din: in std_logic_vector (3 downto 0);
	reset: in std_logic;
	clk: in std_logic;
	sel: in std_logic_vector (1 downto 0);
	max_out: out std_logic_vector (3 downto 0);
	min_out: out std_logic_vector (3 downto 0);
	reg_out: out std_logic_vector (3 downto 0));
end registers_min_max;

architecture my_arch of registers_min_max is

signal R0, R1, R2, R3, out_min, out_max, max_register, min_register: std_logic_vector (3 downto 0);  
signal load_max, load_min: std_logic; 

begin
data_in: process(clk, reset)
begin
	if (reset = '1') then
		R0 <= "1000";
		R1 <= "1000";
		R2 <= "1000"; 	
		R3 <= "1000";
	elsif (rising_edge(clk)) then
		R0 <= din;
		R1 <= R0;
		R2 <= R1;
		R3 <= R2; 
	end if;
end process;

find_maxmin: process(R0, R1, R2, R3)
begin
	if (R0 >= R1 and R0 >= R2 and R0 >= R3) then
		out_max <= R0;
	elsif (R1 >= R0 and R1 >= R2 and R1 >=	R3) then
		out_max <= R1;
	elsif (R2 >= R0 and R2 >= R1 and R2 >=	R3) then
		out_max <= R2;
	else
		out_max <= R3;
	end if;

	 
	if (R1 >= R0 and R2 >= R0 and R3 >= R0) then
		out_min <= R0;
	elsif (R0 >= R1 and R2 >= R1 and R3 >= R1) then
		out_min <= R1;
	elsif (R0 >= R2 and R1 >= R2 and R3 >= R2) then
		out_min <= R2;
	else
		out_min <= R3;
	end if;
end process;

load: process (clk, reset, max_register, min_register)
begin
	if (out_max >= max_register) then
		load_max <= '1'; 
	else
		load_max <= '0';
	end if;
		
	if(min_register >= out_min) then
		load_min <= '1';
	else
		load_min <= '0';
	end if;
end process;		   

maxmin_registers: process(clk, reset)
begin
	if (reset = '1') then
		max_register <= "0000";
		min_register <= "1111";
	elsif (rising_edge(clk)) then
		if (load_max = '1') then
			max_register <= out_max;
			if (load_min = '1') then
				min_register <= out_min;
			end if;
		end if;
	end if; 
end process;
max_out <= max_register;
min_out <= min_register;

mux: process(R0, R1, R2, R3, sel)
begin
case sel is
	when "00" => reg_out <= R0;
	when "01" => reg_out <= R1;
	when "10" => reg_out <= R2;
	when others => reg_out <= R3;
end case;
end process;
end my_arch;
