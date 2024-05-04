----------------------------------------------------------------------------------
-- Company: Rutgers
-- Engineer: Gunjan Adya
-- 
-- Create Date: 02/08/2024 07:42:09 PM
-- Design Name: 
-- Module Name: clock_div - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_div is
    port (
      clk : in std_logic;
      div : out std_logic
    );
end clock_div;

architecture Behavioral of clock_div is

  signal count   : std_logic_vector (26 downto 0) := (others => '0');
  signal nbl     : std_logic := '0';

begin
process(clk) 
begin
    if rising_edge(clk) then
    
        if (unsigned(count) < 62499999) then
            count <= std_logic_vector(unsigned(count) + 1);
            nbl <= '0';            
        else
            nbl <= '1'; 
            count <= (others => '0');

        end if;
    end if;
end process;
div <= nbl;

end Behavioral;
