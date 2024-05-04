----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/04/2024 12:52:28 PM
-- Design Name: 
-- Module Name: enigma_tb - Behavioral
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

entity enigma_tb is
--  Port ( );
end enigma_tb;

architecture Behavioral of enigma_tb is

signal clk_tb, ps2_clk_tb, ps2_data_tb, an_tb : std_logic                    := '0';
signal sw, btn                                : std_logic_vector(3 downto 0) := (others => '0');
signal seg                                    : std_logic_vector(6 downto 0) := (others => '0');

component enigma is
  Port ( 
    clk          : IN  STD_LOGIC;                     --system clock
    ps2_clk      : IN  STD_LOGIC;                     --clock signal from PS/2 keyboard
    ps2_data     : IN  STD_LOGIC;                     --data signal from PS/2 keyboard
    sw, btn      : in  std_logic_vector(3 downto 0);
    seg          : out STD_LOGIC_VECTOR(6 downto 0);
    an           : out std_logic
  );
end component;


begin
    -- 125 MHz Clock
    clk_gen_proc: process
    begin
    
        wait for 4 ns;
        clk_tb <= '1';
        
        wait for 4 ns;
        clk_tb <= '0';
    
    end process clk_gen_proc;
    
    -- 10 kHz Clock
    kybd_clk_gen_proc: process
    begin
    
        wait for 1 ms;
        clk_tb <= '1';
        
        wait for 1 ms;
        clk_tb <= '0';
    
    end process kybd_clk_gen_proc;

    data_gen_proc: process
    begin
    end process data_gen_proc;
    
    
end Behavioral;
