library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity keypad is
  port(
    clk    : in std_logic;
    rst    : in std_logic;
    row    : in std_logic_vector(3 downto 0);
    col    : out std_logic_vector(3 downto 0);
    key    : out std_logic_vector(15 downto 0);
    button : in std_logic
  );
end entity;

architecture Behavioral of keypad is

  signal key_code : std_logic_vector(3 downto 0);
  signal key_data : std_logic_vector(15 downto 0);
 signal button_debounced : std_logic;

  component debounce is
    generic(
      clk_freq    : integer := 50_000_000;
      stable_time : integer := 10
    );
    port(
      clk    : in std_logic;
      rst    : in std_logic;
      button : in std_logic;
      result : out std_logic
    );
  end component;

begin

  debounce_inst : debounce
    generic map(
      clk_freq    => 50_000_000,
      stable_time => 10
    )
    port map(
      clk    => clk,
      rst    => rst,
      button => button,
      result => button_debounced
    );

  col <= "1110"; -- pull column lines high

  process(clk)
  begin
    if rising_edge(clk) then
      -- read keypad
      case row is
        when "1110" => key_code <= "0001";
        when "1101" => key_code <= "0002";
        when "1011" => key_code <= "0003";
        when "0111" => key_code <= "000A";
        when others => key_code <= "XXXX";
      end case;

      -- debounce key press
      if button_debounced = '0' and key_data(to_integer(unsigned(key_code))) = '0' then
        key_data(to_integer(unsigned(key_code))) <= '1';
      end if;

      -- debounce key release
      if button_debounced = '1' and key_data(to_integer(unsigned(key_code))) = '1' then
        key_data(to_integer(unsigned(key_code))) <= '0';
      end if;
    end if;
  end process;

  key <= key_data;


end Behavioral;