library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity wheel_0 is
  Port ( 
    pos_in, char_in : in  std_logic_vector(4 downto 0);
    char_out        : out std_logic_vector(4 downto 0);
    clk             : in std_logic
  );
end wheel_0;

architecture Behavioral of wheel_0 is

signal pos : std_logic_vector(4 downto 0) := (others => '0');

begin
process (clk) begin
    if rising_edge(clk) then
            pos <= std_logic_vector( unsigned(pos_in) + unsigned(char_in));
            if unsigned(pos) > 26 then
                pos <= std_logic_vector( unsigned(pos) mod 26);
            end if;
            case pos is
                when "00000" => char_out <= "00011";
                when "00001" => char_out <= "01100";
                when "00010" => char_out <= "10011";
                when "00011" => char_out <= "10110";
                when "00100" => char_out <= "10010";
                when "00101" => char_out <= "01000";
                when "00110" => char_out <= "01011";
                when "00111" => char_out <= "10001";
                when "01000" => char_out <= "10100";
                when "01001" => char_out <= "11000";
                when "01010" => char_out <= "10000";
                when "01011" => char_out <= "01101";
                when "01100" => char_out <= "01010";
                when "01101" => char_out <= "00101";
                when "01110" => char_out <= "00100";
                when "01111" => char_out <= "01001";
                when "10000" => char_out <= "00010";
                when "10001" => char_out <= "00000";
                when "10010" => char_out <= "11001";
                when "10011" => char_out <= "00001";
                when "10100" => char_out <= "01111";
                when "10101" => char_out <= "00110";
                when "10110" => char_out <= "10111";
                when "10111" => char_out <= "01110";
                when "11000" => char_out <= "00111";
                when "11001" => char_out <= "10101";
                when others  => char_out <= (others => '0');
            end case;
    end if;
end process;

end Behavioral;
