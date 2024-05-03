----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2024 02:50:09 PM
-- Design Name: 
-- Module Name: display_ctrl - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity display_ctrl is
   port (
       --output from the Decoder
       DispVal : in STD_LOGIC_VECTOR (4 downto 0);
       --controls which digit to display
       seg : out STD_LOGIC_VECTOR (6 downto 0));
end display_ctrl;

architecture Behavioral of display_ctrl is

begin

   with DispVal select
       seg    <= "1110111" when "00000", --A 
                 "0011111" when "00001", --B
                 "1001110" when "00010", --C 
                 "0111101" when "00011", --D  
                 "1001111" when "00100", --E
                 "1000111" when "00101", --F 
                 "1111011" when "00110", --G 
                 "0110111" when "00111", --H 
                 "0110000" when "01000", --I 
                 "0111100" when "01001", --J 
                 "0101111" when "01010", --K 
                 "0001110" when "01011", --L 
                 "0010101" when "01100", --M 
                 "1110110" when "01101", --N 
                 "1111110" when "01110", --0 
                 "1100111" when "01111", --P 
                 "1110011" when "10000", --Q 
                 "0000101" when "10001", --R 
                 "1011011" when "10010", --S 
                 "0001111" when "10011", --T 
                 "0111110" when "10100", --U 
                 "0100011" when "10101", --V 
                 "0011100" when "10110", --W 
                 "0111011" when "10111", --Y 
                 "1101101" when "11000", --Z
                 "0000000" when others;

end Behavioral;
