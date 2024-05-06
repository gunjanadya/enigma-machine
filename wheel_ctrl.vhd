----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2024 12:43:01 PM
-- Design Name: 
-- Module Name: wheel_ctrl - Behavioral
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

entity wheel_ctrl is
  Port ( 
      clk, en, data_in : in  std_logic;
      sw, btn          : in  std_logic_vector(2 downto 0);
      char_in          : in  std_logic_vector (4 downto 0);
      ssd_out          : out std_logic_vector(4 downto 0)
      
  );
end wheel_ctrl;

architecture Behavioral of wheel_ctrl is

signal pos0     : std_logic_vector(4 downto 0) := (others => '0');
signal pos1     : std_logic_vector(4 downto 0) := (others => '0');
signal pos2     : std_logic_vector(4 downto 0) := (others => '0');
signal char_out : std_logic_vector(4 downto 0) := (others => '1');

component wheel_top is
  Port ( 
      clk                          : in std_logic ;
      pos_0, pos_1, pos_2, char_in : in std_logic_vector(4 downto 0);
      char_out                     : out std_logic_vector(4 downto 0)
  );
end component;

begin
U1 : wheel_top
port map (
      clk,
      pos_0    => pos0, 
      pos_1    => pos1, 
      pos_2    => pos2, 
      char_in  => char_in, 
      char_out => char_out
);

clk_proc : process (clk)
begin
    if(rising_edge (clk)) then
        -- reset
        if btn(2) = '1' then
            pos0        <= (others => '0');
            pos1        <= (others => '0');
            pos2        <= (others => '0');
            char_out    <= (others => '0');
        end if;
        
        if en = '1' then
        case sw is
            when "001" =>
                ssd_out <= pos0;
                if btn(0) = '1' then 
                    if unsigned(pos0) > 0 then
                        pos0 <= std_logic_vector(unsigned(pos0) - 1);
                    else
                        pos0 <= "11001";
                    end if;
                elsif btn(1) = '1' then
                    if unsigned(pos0) < 25 then
                        pos0 <= std_logic_vector(unsigned(pos0) + 1);
                    else
                        pos0 <= (others => '0');
                    end if;
                end if;
            when "010" => 
                ssd_out <= pos1;
                if btn(0) = '1' then 
                    if unsigned(pos1) > 0 then
                        pos1 <= std_logic_vector(unsigned(pos1) - 1);
                    else
                        pos1 <= "11001";
                    end if;
                elsif btn(1) = '1' then
                    if unsigned(pos1) < 25 then
                        pos1 <= std_logic_vector(unsigned(pos1) + 1);
                    else
                        pos1 <= (others => '0');
                    end if;
                end if;
            when "100" => 
                ssd_out <= pos2;
                if btn(0) = '1' then 
                    if unsigned(pos2) > 0 then
                        pos2 <= std_logic_vector(unsigned(pos2) - 1);
                    else
                        pos0 <= "11001";
                    end if;
                elsif btn(1) = '1' then
                    if unsigned(pos2) < 25 then
                        pos2 <= std_logic_vector(unsigned(pos2) + 1);
                    else
                        pos2 <= (others => '0');
                    end if;
                end if;
            when "111" =>
            
                ssd_out <= char_out; 
                
                               
                -- on every letter input, rotate the wheels
                if data_in = '1' then
                    if unsigned(pos0) < 26 then
                        pos0 <= std_logic_vector(unsigned(pos0) + 1);
                    else
                        pos0 <= (others => '0');
                        if unsigned(pos1) < 26 then
                            pos1 <= std_logic_vector(unsigned(pos1) + 1);
                        else
                            pos1 <= (others => '0');
                            if unsigned(pos2) < 26 then
                                pos2 <= std_logic_vector(unsigned(pos2) + 1);
                            else
                                pos2 <= (others => '0');
                            end if; 
                        end if;
                    end if;            
                end if;
                
            when others => ssd_out <= (others => '1');
        end case;
        end if;
    end if;
end process clk_proc;



end Behavioral;
