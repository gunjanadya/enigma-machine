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
    clk          : in    std_logic;                     
    sw, btn      : in    std_logic_vector (3 downto 0);
    seg          : out   std_logic_vector (6 downto 0);
    an           : out   std_logic;
    kypd         : inout std_logic_vector (7 downto 0)

    );

end enigma;

architecture Behavioral of enigma is

signal kpad                     : std_logic_vector(3 downto 0) := (others => '0');
signal en_sig                   : std_logic                    := '0';
signal data_in                  : std_logic                    := '0';
signal btn_sig                  : std_logic_vector(3 downto 0) := (others => '0');
signal char_in                  : std_logic_vector(4 downto 0) := (others => '0');
signal ssd_sig                  : std_logic_vector(4 downto 0) := (others => '0');

component debouncer is
    port(
      btn  : in  std_logic;
      clk  : in  std_logic;
      dbnc : out std_logic := '0'
    );
end component;

component Decoder is
   port (
       clk              : in  STD_LOGIC;
       rst              : in  std_logic;
       Row              : in  STD_LOGIC_VECTOR (3 downto 0);
       Col              : out STD_LOGIC_VECTOR (3 downto 0);
       DecodeOut        : out STD_LOGIC_VECTOR (3 downto 0);
       is_a_key_pressed : out std_logic
       );
end component;

component kpd2char is
Port ( 
    clk  : in std_logic;
    sw   : in  std_logic;
    kpad : in  std_logic_vector (3 downto 0);
    char : out std_logic_vector (4 downto 0)
);
end component;

component wheel_ctrl is
  Port ( 
      clk, en, data_in : in  std_logic;
      sw, btn          : in  std_logic_vector(2 downto 0);
      char_in          : in  std_logic_vector (4 downto 0);
      ssd_out          : out std_logic_vector(4 downto 0)
      
  );
end component; 

component display_ctrl is
   port (
       DispVal  : in  STD_LOGIC_VECTOR (4 downto 0);
       seg      : out STD_LOGIC_VECTOR (6 downto 0)
   );
end component;

component clock_div is
    port (
      clk : in std_logic;
      div : out std_logic
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
    
enable : clock_div
Port Map(
    clk => clk,
    div => en_sig
); 

keypad : Decoder 
   port map (
       clk => clk,
       rst => btn(3),
       Row => kypd(3 downto 0), 
       Col => kypd(7 downto 4) , 
       DecodeOut => kpad,
       is_a_key_pressed => data_in
   );

input_converter : kpd2char
Port Map ( 
    clk  => clk ,
    sw   => sw(3),
    kpad => kpad,
    char => char_in
);

encryption : wheel_ctrl
  Port Map( 
      clk     => clk, 
      en      => en_sig,
      data_in => data_in,
      sw      => sw(2 downto 0), 
      btn     => btn_sig(2 downto 0),
      char_in => char_in,
      ssd_out => ssd_sig
      
  );
  
ssd : display_ctrl
   port map(
       DispVal => ssd_sig,
       seg     => seg
   );
   
an <= '0';

end Behavioral;
