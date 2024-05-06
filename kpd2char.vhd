----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/06/2024 11:43:42 AM
-- Design Name: 
-- Module Name: kpd2char - Behavioral
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

entity kpd2char is
Port ( 
    sw   : in  std_logic;
    btn  : in  std_logic_vector(3 downto 0);
    char : out std_logic_vector(4 downto 0)
);
end kpd2char;

architecture Behavioral of kpd2char is

begin

if sw = '0' then
    char <= '0' + btn;
else
    char <= '1' + btn;
end if;

end Behavioral;
