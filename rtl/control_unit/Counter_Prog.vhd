library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Counter_prog is
    Port ( data_in : in STD_LOGIC_VECTOR (5 downto 0);
           clk : in STD_LOGIC;
           ce    : in STD_LOGIC;
           rst : in STD_LOGIC;
           load: in STD_LOGIC;
           enable : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (5 downto 0));
end Counter_prog;

architecture Behavioral of Counter_prog is
begin 
process(clk,ce,rst)
begin
    if rst='1' then
        data_out <= (others => '0');
    elsif(ce='1' and rising_edge(clk)) then
        if enable = '1' then
            if load='1' then
                data_out <= data_in;
            end if;
        end if;
    end if;
end process;

end Behavioral;