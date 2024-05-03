library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;


entity DisplayController is
   port (
        clk : in std_logic;
       --controls which digit to display
       segOut : out STD_LOGIC_VECTOR (6 downto 0);
       an : out std_logic
       );
end DisplayController;

architecture Behavioral of DisplayController is

signal count   : std_logic_vector (26 downto 0) := (others => '0');
signal counter : std_logic_vector(6 downto 0) := (others => '0');

begin

process(clk) 
begin
    if rising_edge(clk) then
        if (counter = "1111110") then
            counter <= (others => '0');
        end if;
        if (unsigned(count) >= 62499999) then
            count <= std_logic_vector(unsigned(count) + 1);
        else
            counter <= std_logic_vector(unsigned(counter)+1);
            count <= (others => '0');
        end if;
    end if;
end process;
segOut <= counter;
an <= '0';
--       segOut <= "1111110" when "0000"--0
--                 "0110000" when "0001", --1
--                 "1101101" when "0010", --2
--                 "1111001" when "0011", --3
--                 "0110011" when "0100", --4
--                 "1011011" when "0101", --5
--                 "1011111" when "0110", --6
--                 "1110000" when "0111", --7
--                 "1111111" when "1000", --8
--                 "1111011" when "1001", --9
--                 "1110111" when "1010", --A
--                 "0011111" when "1011", --b
--                 "1001110" when "1100", --C
--                 "0111101" when "1101", --d
--                 "1001111" when "1110", --E
--                 "1000111" when "1111", --F
--                 "0000000" when others;

end Behavioral;
