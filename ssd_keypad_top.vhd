library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;



entity ssd_keypad_top is
   port (
       sys_clk      : in    STD_LOGIC;
       decode_out   : in    STD_LOGIC_VECTOR (3 downto 0);
       an           : out   STD_LOGIC;                      -- Controls which position of the seven segment display to display
       seg          : out   STD_LOGIC_VECTOR (6 downto 0);  -- controls segments of pmod to display
       sw           : in    STD_LOGIC_VECTOR (3 downto 0);   -- switches on board
       led          : out   STD_LOGIC_VECTOR (3 downto 0);
       kypd         : inout std_logic_vector (7 downto 0)
   );
end ssd_keypad_top;

architecture Behavioral of ssd_keypad_top is

   constant clk_freq : INTEGER := 125_000_000;
   constant stable_time : INTEGER := 10;
   
   constant count_width : INTEGER := 20; --1MHz switching between digits on 7segdis

   component debounce
       generic (
           clk_freq : INTEGER := clk_freq;
           stable_time : INTEGER := stable_time
       );
       port (
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           button : in STD_LOGIC;
           result : out STD_LOGIC);
   end component;
   
   
      component single_pulse_detector
       generic (detect_type : STD_LOGIC_VECTOR(1 downto 0) := "00");
       port (
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           input_signal : in STD_LOGIC;
           output_pulse : out STD_LOGIC);
   end component;

   component DisplayController is
       port (
           --output from the Decoder
           DispVal : in STD_LOGIC_VECTOR (3 downto 0);
           --controls which digit to display
           segOut : out STD_LOGIC_VECTOR (6 downto 0));
   end component;
 
   component clk_wiz_0 is
       port (
           sys_clk: in std_logic;
           clk : out std_logic);
   end component;  
   
   component Decoder is 
       port (
              clk : in STD_LOGIC;
              rst: in std_logic;
              Row : in STD_LOGIC_VECTOR (3 downto 0);
              Col : out STD_LOGIC_VECTOR (3 downto 0);
              DecodeOut : out STD_LOGIC_VECTOR (3 downto 0);
              is_a_key_pressed: out std_logic);
   end component;
   
   signal count : unsigned(count_width-1 downto 0) := (others => '0');
   
   signal rst : STD_LOGIC;
   signal keypad_debounce : std_logic_vector(3 downto 0);
   signal keypad_pulse : std_logic_vector(3 downto 0);
   signal disp_sel : STD_LOGIC;
   signal kypd_w : std_logic_vector(7 downto 0);
   signal is_a_key_pressed : std_logic;
   signal dcd_reg : std_logic_vector(3 downto 0);
   signal dcd_reg1 : std_logic_vector(3 downto 0);
   signal dcd_reg2 : std_logic_vector(3 downto 0);
   signal seg1 : std_logic_vector(6 downto 0);
   signal seg2 : std_logic_vector(6 downto 0);
   signal clk : std_logic;
begin

   rst <= decode_out(0);
   an <= count(count_width-1);
   led <= dcd_reg1;
   seg <= seg2 when (count(count_width-1) = '1') else seg1;
   
   sclk : clk_wiz_0 port map (clk => clk, sys_clk => sys_clk);
   db0  : debounce generic map (clk_freq => clk_freq, stable_time => stable_time) port map(clk => clk, rst => rst, button => decode_out(0), result => keypad_debounce(0));
   db1  : debounce generic map (clk_freq => clk_freq, stable_time => stable_time) port map(clk => clk, rst => rst, button => decode_out(1), result => keypad_debounce(1));
   db2  : debounce generic map (clk_freq => clk_freq, stable_time => stable_time) port map(clk => clk, rst => rst, button => decode_out(2), result => keypad_debounce(2));
   db3  : debounce generic map (clk_freq => clk_freq, stable_time => stable_time) port map(clk => clk, rst => rst, button => decode_out(3), result => keypad_debounce(3));
   pd0  : single_pulse_detector port map(clk => clk, rst => rst, input_signal => keypad_debounce(0), output_pulse => keypad_pulse(0));
   pd1  : single_pulse_detector port map(clk => clk, rst => rst, input_signal => keypad_debounce(1), output_pulse => keypad_pulse(1));
   pd2  : single_pulse_detector port map(clk => clk, rst => rst, input_signal => keypad_debounce(2), output_pulse => keypad_pulse(2));
   pd3  : single_pulse_detector port map(clk => clk, rst => rst, input_signal => keypad_debounce(3), output_pulse => keypad_pulse(3));
   ssd1 : DisplayController port map(DispVal => dcd_reg1, segOut => seg1);
   ssd2 : DisplayController port map(DispVal => dcd_reg2, segOut => seg2);
   
   dcd1 : Decoder 
   port map (
       clk => clk, 
       rst => rst, 
       Row => kypd(3 downto 0), 
       Col => kypd(7 downto 4) , 
       DecodeOut => dcd_reg, 
       is_a_key_pressed => is_a_key_pressed
   );
   

process (rst, keypad_pulse)
   begin
       if rst = '1' then
           disp_sel <= '0';

       elsif (keypad_pulse /= decode_out) then
           disp_sel <= not disp_sel;
       else
           if disp_sel = '1' then
                dcd_reg1 <= dcd_reg;
           else
                dcd_reg2 <= dcd_reg;
           end if;
       end if;
end process;

process (clk, rst)
 begin
 if rising_edge(clk) then
    if rst = '1' then
        count <= (others => '0');
    else
        count <= count + 1;
    end if;
 end if;
end process;


end Behavioral;