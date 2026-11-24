library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Registre_1bit is
    Port ( data_in : in STD_LOGIC;
           clk : in STD_LOGIC;
           ce    : in STD_LOGIC;
           rst : in STD_LOGIC;
           load: in STD_LOGIC;
           clear: in STD_LOGIC;
           data_out : out STD_LOGIC);
end Registre_1bit;

architecture Behavioral of Registre_1bit is
begin
process(clk,ce,rst)
begin
    if rst='1' then
        data_out <= '0';
    elsif(ce='1' and rising_edge(clk)) then
        if clear = '1' then
            data_out <= '0';
        elsif load='1' then
            data_out <= data_in;
        end if;
    end if;
end process;

end Behavioral;
