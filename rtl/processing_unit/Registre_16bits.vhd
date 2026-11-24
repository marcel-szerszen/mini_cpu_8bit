library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Registre_16bits is
    Port ( data_in : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           ce  : in STD_LOGIC;
           rst : in STD_LOGIC;
           load: in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (15 downto 0));
end Registre_16bits;

architecture Behavioral of Registre_16bits is
begin 
process(clk,ce,rst)
begin
    if rst='1' then
        data_out <= (others => '0');
    elsif(ce='1' and rising_edge(clk)) then
        if load='1' then
            data_out <= data_in;
        end if;
    end if;
end process;

end Behavioral;