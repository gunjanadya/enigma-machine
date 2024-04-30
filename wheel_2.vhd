----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2024 04:10:44 PM
-- Design Name: 
-- Module Name: wheel_2 - Behavioral
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

entity wheel_2 is
  Port ( 
    pos_in, char_in : in  std_logic_vector(4 downto 0);
    pos_out         : out std_logic_vector(4 downto 0);
    clk, en         : in std_logic
  );
 end wheel_2;

architecture Behavioral of wheel_2 is

signal pos : std_logic_vector(4 downto 0) := (others => '0');

begin
process (clk) begin
    if rising_edge(clk) then
        if en = '1' then
            pos <= std_logic_vector( unsigned(pos_in) + unsigned(char_in));
            if unsigned(pos) > 26 then
                pos <= std_logic_vector( unsigned(pos) mod 26);
            end if;
            case pos is
                when "00000" => pos_out <= "10100";
                when "00001" => pos_out <= "10000";
                when "00010" => pos_out <= "01101";
                when "00011" => pos_out <= "10011";
                when "00100" => pos_out <= "01011";
                when "00101" => pos_out <= "10010";
                when "00110" => pos_out <= "11001";
                when "00111" => pos_out <= "00101";
                when "01000" => pos_out <= "01100";
                when "01001" => pos_out <= "10001";
                when "01010" => pos_out <= "00100";
                when "01011" => pos_out <= "00111";
                when "01100" => pos_out <= "00011";
                when "01101" => pos_out <= "01111";
                when "01110" => pos_out <= "10111";
                when "01111" => pos_out <= "01010";
                when "10000" => pos_out <= "01000";
                when "10001" => pos_out <= "00001";
                when "10010" => pos_out <= "10101";
                when "10011" => pos_out <= "11000";
                when "10100" => pos_out <= "00110";
                when "10101" => pos_out <= "01001";
                when "10110" => pos_out <= "00010";
                when "10111" => pos_out <= "10110";
                when "11000" => pos_out <= "01110";
                when "11001" => pos_out <= "00000";
                when others => pos_out <= (others => '0');
            end case;
        end if;
    end if;
end process;


end Behavioral;
