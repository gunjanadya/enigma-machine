library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity wheels_tb is
--  Port ( );
end wheels_tb;

architecture Behavioral of wheels_tb is

component wheel_0
  Port ( 
    pos_in, char_in : in  std_logic_vector(4 downto 0);
    char_out        : out std_logic_vector(4 downto 0);
    clk, en         : in std_logic
  );
end component;

signal clk_tb, en_tb : std_logic := '0';
signal in_tb, pos_tb, out_tb : std_logic_vector(4 downto 0) := (others => '0');

begin

dut: wheel_0
port map(
    pos_in   => pos_tb,
    char_in  => in_tb,
    char_out => out_tb,
    clk      => clk_tb, 
    en       => en_tb
);

clk_gen_prc : process begin

    clk_tb <= '0';
    wait for 4 ns;
    clk_tb <= '1';
    wait for 4 ns;

end process clk_gen_prc;

en_gen_prc : process begin

    en_tb <= '0';
    wait for 8680 ns;
    en_tb <= '1';
    wait for 8 ns;

end process en_gen_prc;

pos_gen_prc : process begin

    wait for 8688 ns;
    if unsigned(pos_tb) < 26 then
        pos_tb <= std_logic_vector( unsigned(pos_tb) + 1);
    else
        pos_tb <= (others => '0');
    end if;

end process pos_gen_prc;


end Behavioral;
