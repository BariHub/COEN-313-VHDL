library ieee; use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity twos_complementer is
port (din: in std_logic_vector(7 downto 0);
	clk: in std_logic;
	reset: in std_logic;
	done_out: out std_logic;
	reg_out: out std_logic_vector(7 downto 0));
end twos_complementer;

architecture my_arch of twos_complementer is 
signal ld_done, clr_done: std_logic;
signal d, shift, load: std_logic;
signal clr, inc: std_logic;
signal counter: std_logic_vector(3 downto 0);
signal shift_reg: std_logic_vector(7 downto 0);

type state_type is 
(load_state, temp_bit, first_one, still_zero, check_count0, check_count1, invert_0, invert_1, finish, next_bit);
signal state: state_type;

begin 
done_reg: process(clk, clr_done, ld_done)
begin 
if(clk'event and clk = '1') then
	if clr_done = '1' then
		done_out <= '0';
	end if;
	if ld_done = '1' then
		done_out <= '1';
	end if;
   end if;
end process;

counter: process(clk) 
begin
if(clk'event and clk = '1') then
	if clr = '1' then
		counter <= "0000";
	end if;
	if inc = '1' then
		counter <= std_logic_vector(unsigned(counter) + 1);
	end if;
end if;
end process;

shift_reg: process (clk) 
begin
if (clk'event and clk = '1') then
	if load = '1' then
		shift_reg <= din;
	else
		if shift = '1' then
			shift_reg <= d & shift_reg(7 downto 1);
		end if;
	end if;
end if;
end process;

next_state_logic: process (reset, clk)
begin
if (reset = '1') then
	state <= load_state;
else
	if (clk'event and clk = '1') then
		case state is 
			when load_state =>
				state <= temp_bit;
			when temp_bit =>
				if shift_reg(0) = '1' then
					state <= first_one;
				else
					state <= still_zero;
				end if;
			when first_one =>
				state <= check_count1;
			when still_zero =>
				state <= check_count0;
			when check_count0 =>
				if counter = "1000" then
					state <= finish;
				else
					state <= temp_bit;
				end if;
			when check_count1 =>
				if counter = "1000" then
					state <= finish;
				else
					state <= next_bit;
				end if;
			when next_bit =>
				if counter = "1000" then
					state <= finish;
				else
					if shift_reg(0) = '0' then
						state <= invert_0;
					else
						state <= invert_1;
					end if;
				end if;
			when invert_0 =>
				if counter = "1000" then
					state <= finish;
				else
					state <= next_bit;
				end if;
			when invert_1 =>
				if counter = "1000" then
					state <= finish;
				else
					state <= next_bit;
				end if;
			when finish =>
				state <= finish;
		end case;
	end if;
end if;
end process;

output_logic: process(state)
begin
case state is
	when load_state =>
		d <= '0';
		shift <= '0';
		ld_done <= '0';
		clr_done <= '1';
		clr <= '1';
		inc <= '0';
		load <= '1';
	when temp_bit =>
		d <= '0';
		shift <= '0';
		ld_done <= '0';
		clr_done <= '0';
		clr <= '0';
		inc <= '0';
		load <= '0';
	when first_one =>
		d <= '1';
		shift <= '1';
		ld_done <= '0';
		clr_done <= '0';
		clr <= '0';
		inc <= '1';
		load <= '0';
	when still_zero =>
		d <= '0';
		shift <= '1';
		ld_done <= '0';
		clr_done <= '0';
		clr <= '0';
		inc <= '1';
		load <= '0';
	when check_count0 =>
		d <= '0';
		shift <= '0';
		ld_done <= '0';
		clr_done <= '0';
		clr <= '0';
		inc <= '1';
		load <= '0';
	when check_count1 =>
		d <= '0';
		shift <= '0';
		ld_done <= '0';
		clr_done <= '0';
		clr <= '0';
		inc <= '0';
		load <= '0';
	when next_bit =>
		d <= '0';
		shift <= '0';
		ld_done <= '0';
		clr_done <= '0';
		clr <= '0';
		inc <= '0';
		load <= '0';
	when invert_0 =>
		d <= '1';
		shift <= '1';
		ld_done <= '0';
		clr_done <= '0';
		clr <= '0';
		inc <= '1';
		load <= '0';
	when invert_1 =>
		d <= '0';
		shift <= '1';
		ld_done <= '0';
		clr_done <= '0';
		clr <= '0';
		inc <= '1';
		load <= '0';
	when finish =>
		d <= '0';
		shift <= '0';
		ld_done <= '1';
		clr_done <= '0';
		clr <= '1';
		inc <= '0';
		load <= '0';
		reg_out <= shift_reg;
end case;
end process;
end my_arch;
