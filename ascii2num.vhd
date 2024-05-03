----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2024 04:07:07 PM
-- Design Name: 
-- Module Name: ascii2num - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ascii2num is
  Port ( 
      clk   : in std_logic;
      ascii : in  std_logic_vector(7 downto 0);
      num   : out std_logic_vector(4 downto 0)
  );
end ascii2num;

architecture Behavioral of ascii2num is

begin

process(clk) begin
    if rising_edge(clk) then
        case ascii is
            when "01000001" => num <= "00000";
            when "01000010" => num <= "00001";
            when "01000011" => num <= "00010";
            when "01000100" => num <= "00011";
            when "01000101" => num <= "00100";
            when "01000110" => num <= "00101";
            when "01000111" => num <= "00110";
            when "01001000" => num <= "00111";
            when "01001001" => num <= "01000";
            when "01001010" => num <= "01001";
            when "01001011" => num <= "01010";
            when "01001100" => num <= "01011";
            when "01001101" => num <= "01100";
            when "01001110" => num <= "01101";
            when "01001111" => num <= "01110";
            when "01010000" => num <= "01111";
            when "01010001" => num <= "10000";
            when "01010010" => num <= "10001";
            when "01010011" => num <= "10010";
            when "01010100" => num <= "10011";
            when "01010101" => num <= "10100";
            when "01010110" => num <= "10101";
            when "01010111" => num <= "10110";
            when "01011000" => num <= "10111";
            when "01011001" => num <= "11000";
            when "01011010" => num <= "11001";
            when others     => num <= (others => '0');
        end case;
    end if;
end process ;

end Behavioral;
