library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity wheel_top is
  Port ( 
      clk, en : in std_logic ;
      pos_0, pos_1, pos_2, char_in : in std_logic_vector(4 downto 0);
      char_out : out std_logic_vector(4 downto 0)
  );
end wheel_top;

architecture Behavioral of wheel_top is

signal char_1, char_2, char_3, char_4, char_5 : std_logic_vector(4 downto 0) := (others => '0');

component wheel_0
    port (
        pos_in, char_in : in  std_logic_vector(4 downto 0);
        char_out        : out std_logic_vector(4 downto 0);
        clk, en         : in std_logic
    );
end component;

component wheel_1
    port (
        pos_in, char_in : in  std_logic_vector(4 downto 0);
        char_out        : out std_logic_vector(4 downto 0);
        clk, en         : in std_logic
    );
end component;

component wheel_2
    port (
        pos_in, char_in : in  std_logic_vector(4 downto 0);
        char_out        : out std_logic_vector(4 downto 0);
        clk, en         : in std_logic
    );
end component;

begin

    U1: wheel_0
    port map(
        pos_in   => pos_0,
        char_in  => char_in,
        char_out => char_1,
        clk      => clk,
        en       => en
    );
    
    U2: wheel_1
    port map(
        pos_in   => pos_1,
        char_in  => char_1,
        char_out => char_2,
        clk      => clk,
        en       => en
    );
    
    U3: wheel_2
    port map(
        pos_in   => pos_2,
        char_in  => char_2,
        char_out => char_3,
        clk      => clk,
        en       => en
    );
    
    U4: wheel_0
    port map(
        pos_in   => pos_0,
        char_in  => char_3,
        char_out => char_4,
        clk      => clk,
        en       => en
    );
    
    U5: wheel_1
    port map(
        pos_in   => pos_1,
        char_in  => char_4,
        char_out => char_5,
        clk      => clk,
        en       => en
    );
    
    U6: wheel_2
    port map(
        pos_in   => pos_2,
        char_in  => char_5,
        char_out => char_out,
        clk      => clk,
        en       => en
    );
    
end Behavioral;
