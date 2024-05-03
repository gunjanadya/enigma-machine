----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2024 04:38:13 PM
-- Design Name: 
-- Module Name: enigma - Behavioral
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
-- arithmetic functions with Signed or Unsigned architecture
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity enigma is
  Port ( 
    clk          : IN  STD_LOGIC;                     --system clock
    ps2_clk      : IN  STD_LOGIC;                     --clock signal from PS/2 keyboard
    ps2_data     : IN  STD_LOGIC;                     --data signal from PS/2 keyboard
    sw, btn      : in  std_logic_vector(3 downto 0);
    seg : out STD_LOGIC_VECTOR (6 downto 0)
  );
end enigma;

architecture Behavioral of enigma is

signal btn_sig                  : std_logic_vector(3 downto 0) := (others => '0');
signal debounce_counter_size    : INTEGER := 8;
signal clk_freq                 : INTEGER := 50_000_000;
signal data_in                  : std_logic;
signal char_in                  : std_logic_vector(4 downto 0) := (others => '0');
signal ascii_in                 : std_logic_vector(7 downto 0) := (others => '0');
signal ssd_sig                  : std_logic_vector(4 downto 0) := (others => '0');

component debouncer is
    port(
      btn  : in std_logic;
      clk  : in std_logic;
      dbnc : out std_logic := '0'
    );
end component;

component ps2_keyboard is
  GENERIC(
    clk_freq              : INTEGER := 50_000_000; --system clock frequency in Hz
    debounce_counter_size : INTEGER := 8
  );         --set such that (2^size)/clk_freq = 5us (size = 8 for 50MHz)
  PORT(
    clk          : IN  STD_LOGIC;                     --system clock
    ps2_clk      : IN  STD_LOGIC;                     --clock signal from PS/2 keyboard
    ps2_data     : IN  STD_LOGIC;                     --data signal from PS/2 keyboard
    ps2_code_new : OUT STD_LOGIC;                     --flag that new PS/2 code is available on ps2_code bus
    ps2_code     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
   ); --code received from PS/2
end component;

component ascii2num is
  Port ( 
      clk   : in std_logic;
      ascii : in  std_logic_vector(7 downto 0);
      num   : out std_logic_vector(4 downto 0)
  );
end component;

component wheel_ctrl is
  Port ( 
      clk, data_in : in  std_logic;
      sw, btn      : in  std_logic_vector(3 downto 0);
      char_in      : in  std_logic_vector (4 downto 0);
      ssd_out      : out std_logic_vector(4 downto 0)
      
  );
end component; 

component display_ctrl is
   port (
       --output from the Decoder
       DispVal : in STD_LOGIC_VECTOR (4 downto 0);
       --controls which digit to display
       seg : out STD_LOGIC_VECTOR (6 downto 0)
   );
end component;

begin

debounce_btn0: debouncer
  PORT MAP(
    clk  => clk,
    btn  => btn(0),
    dbnc => btn_sig(0)
    );
    
debounce_btn1: debouncer
  PORT MAP(
    clk  => clk,
    btn  => btn(1),
    dbnc => btn_sig(1)
    );
    
debounce_btn2: debouncer
  PORT MAP(
    clk  => clk,
    btn  => btn(2),
    dbnc => btn_sig(2)
    );
    
keyboard : ps2_keyboard
  GENERIC MAP(
    clk_freq => clk_freq, --system clock frequency in Hz
    debounce_counter_size => debounce_counter_size --set such that (2^size)/clk_freq = 5us (size = 8 for 50MHz)
  )
  PORT MAP(
    clk => clk,
    ps2_clk => ps2_clk,
    ps2_data => data_in,
    ps2_code => ascii_in
   ); --code received from PS/2
   
input_converter : ascii2num 
  Port Map ( 
      clk,
      ascii => ascii_in,
      num   => char_in
  );

encryption : wheel_ctrl
  Port Map( 
      clk, 
      data_in,
      sw, 
      btn => btn_sig,
      char_in => char_in,
      ssd_out => ssd_sig
      
  );
  
ssd : display_ctrl
   port map(
       DispVal => ssd_sig,
       seg     => seg
   );
end Behavioral;
