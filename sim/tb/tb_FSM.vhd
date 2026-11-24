

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity FSM_processor_tb is
end;

architecture bench of FSM_processor_tb is

  component FSM_processor
      Port ( clk : in STD_LOGIC;
             rst : in STD_LOGIC;
             Boot : in STD_LOGIC;
             carry : in STD_LOGIC;
             codeop    : in STD_LOGIC_VECTOR(1 downto 0);
             enable : out STD_LOGIC;
             WR : out STD_LOGIC);
  end component;

  signal clk: STD_LOGIC;
  signal rst: STD_LOGIC;
  signal Boot: STD_LOGIC;
  signal carry: STD_LOGIC;
  signal codeop: STD_LOGIC_VECTOR(1 downto 0);
  signal enable: STD_LOGIC;
  signal WR: STD_LOGIC;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: FSM_processor port map ( clk    => clk,
                                rst    => rst,
                                Boot   => Boot,
                                carry  => carry,
                                codeop => codeop,
                                enable => enable,
                                WR     => WR );

  stimulus: process
  begin

    rst <= '1';
    wait for 5 ns;
    rst <= '0';
    wait for 50 ns;
    
    BOOT <= '1';
    wait for 50 ns;
    Boot <= '0';
    codeop <= "00";
    carry <= '1';
    wait for 100 ns;
    Boot <= '1';
    wait for 50 ns;
    codeop <= "10";
    wait for 50 ns;
    codeop <= "11";
    wait for 150 ns;
    codeop <= "01";
    wait for 200 ns;
    
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