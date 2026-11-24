----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/16/2026 11:03:29 AM
-- Design Name: 
-- Module Name: UAL - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UAL is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           R1 : in STD_LOGIC_VECTOR (15 downto 0);
           Accum : in STD_LOGIC_VECTOR (15 downto 0);
           load_accu : in STD_LOGIC;
           sel_ual : in STD_LOGIC;
           Result : out STD_LOGIC_VECTOR (15 downto 0);
           Carry : out STD_LOGIC);
end UAL;

architecture Behavioral of UAL is
signal s : unsigned(16 downto 0);

begin
process(clk)
begin
if rst = '1' then 
    s <= (others => '0');
    Carry <= '0';
elsif rising_edge(clk) then
    if load_accu = '1' then
        if sel_ual = '0' then
            Result <= R1 NOR Accum; 
        else 
            s <= unsigned("0" & R1) + unsigned("0" & Accum); 
            Result <= std_logic_vector(s(15 downto 0)); 
            carry <= s(16);
        end if;
    end if;
end if;
end process;


end Behavioral;
