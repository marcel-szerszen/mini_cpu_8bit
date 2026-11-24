library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_Std.all;


entity Processing_unit is
    Port (  data_in : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            clk : IN STD_LOGIC;
            ce  : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            load_R1 : IN STD_LOGIC;
            load_accu : IN STD_LOGIC;
            load_carry : IN STD_LOGIC;
            init_carry : IN STD_LOGIC;
            sel_UAL : IN STD_LOGIC;
            data_out : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
            carry : OUT STD_LOGIC
           );
end Processing_unit;



architecture Behavioral of Processing_unit is

COMPONENT UAL IS
        Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           R1 : in STD_LOGIC_VECTOR (15 downto 0);
           Accum : in STD_LOGIC_VECTOR (15 downto 0);
           sel_ual : in STD_LOGIC;
           load_accu : in STD_lOGIC;
           Result : out STD_LOGIC_VECTOR (15 downto 0);
           Carry : out STD_LOGIC);
    END COMPONENT;
    
    COMPONENT Registre_16bits IS
        Port ( data_in : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           ce    : in STD_LOGIC;
           rst : in STD_LOGIC;
           load: in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (15 downto 0));
    END COMPONENT;
    
    COMPONENT Registre_1bit IS
        Port ( data_in : in STD_LOGIC;
           clk : in STD_LOGIC;
           ce    : in STD_LOGIC;
           rst : in STD_LOGIC;
           load: in STD_LOGIC;
           clear: in std_logic;
           data_out : out STD_LOGIC);
    END COMPONENT;

signal s_datain : STD_LOGIC_VECTOR (15 downto 0);
signal s_accu : STD_LOGIC_VECTOR (15 downto 0) :=(others => '0');
signal e_dataout : STD_LOGIC_VECTOR(15 downto 0) :=(others => '0');
signal s_carry : std_logic;

begin
data_out <= e_dataout;

c_UAL : UAL
    PORT MAP(
        clk => clk,
        rst => rst,
        R1 => s_datain,
        accum => e_dataout,
        sel_ual => sel_ual,
        load_accu => load_accu,
        result => s_accu,
        carry => s_carry
        );
        
c_R1 : Registre_16bits
    PORT MAP(
        clk => clk,
        rst => rst,
        ce => ce,
        data_in => data_in,
        load => load_R1,
        data_out => s_datain
        );
 
c_ACCU : Registre_16bits
    PORT MAP(
        clk => clk,
        rst => rst,
        ce => ce,
        data_in => s_accu,
        load => load_accu,
        data_out => e_dataout
        );
        
c_CARRY : Registre_1bit
    PORT MAP(
        clk => clk,
        rst => rst,
        ce => ce,
        data_in => s_carry,
        load => load_carry,
        clear => init_carry,
        data_out => carry
        );

end Behavioral;