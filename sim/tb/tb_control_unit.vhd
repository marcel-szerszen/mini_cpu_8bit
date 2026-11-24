library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Control_Unit_tb is
end;

architecture bench of Control_Unit_tb is

  component Control_Unit
          GENERIC (RAM_ADR_WIDTH : INTEGER := 6);
          PORT (
              clk         : IN STD_LOGIC;
              ce          : IN STD_LOGIC;
              rst         : IN STD_LOGIC;
              carry       : IN STD_LOGIC;
              boot        : IN STD_LOGIC;
              data_in     : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
              adr         : OUT STD_LOGIC_VECTOR (RAM_ADR_WIDTH - 1 DOWNTO 0);
              clear_carry : OUT STD_LOGIC;
              enable_mem  : OUT STD_LOGIC;
              load_R1     : OUT STD_LOGIC;
              load_accu   : OUT STD_LOGIC;
              load_carry  : OUT STD_LOGIC;
              sel_UAL     : OUT STD_LOGIC_VECTOR (2 downto 0);
              w_mem       : OUT STD_LOGIC);
  end component;

  signal clk: STD_LOGIC;
  signal ce: STD_LOGIC;
  signal rst: STD_LOGIC;
  signal carry: STD_LOGIC;
  signal boot: STD_LOGIC;
  signal data_in: STD_LOGIC_VECTOR (15 DOWNTO 0);
  signal adr: STD_LOGIC_VECTOR (5 DOWNTO 0);
  signal clear_carry: STD_LOGIC;
  signal enable_mem: STD_LOGIC;
  signal load_R1: STD_LOGIC;
  signal load_accu: STD_LOGIC;
  signal load_carry: STD_LOGIC;
  signal sel_UAL: STD_LOGIC_VECTOR (2 downto 0);
  signal w_mem: STD_LOGIC;
  
  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: Control_Unit generic map ( RAM_ADR_WIDTH => 6 )
                       port map ( clk           => clk,
                                  ce            => ce,
                                  rst           => rst,
                                  carry         => carry,
                                  boot          => boot,
                                  data_in       => data_in,
                                  adr           => adr,
                                  clear_carry   => clear_carry,
                                  enable_mem    => enable_mem,
                                  load_R1       => load_R1,
                                  load_accu     => load_accu,
                                  load_carry    => load_carry,
                                  sel_UAL       => sel_UAL,
                                  w_mem         => w_mem );

  stimulus: process
  begin
    rst <= '1';
    wait for 5 ns;
    rst <= '0';
    wait for 50 ns;
    
    BOOT <= '1';
    wait for 50 ns;
    Boot <= '0';
    carry <= '1';
    wait for 100 ns;
    Boot <= '1';
    wait for 500 ns;
    
    rst <= '1';
    wait for 5 ns;
    rst <= '0';
    wait for 50 ns;
    Boot <= '0';
    wait for 200 ns;
    stop_the_clock <= true;
    wait;
  end process;
  
  
 
  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;
end;