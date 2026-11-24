----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/16/2026 09:50:00 AM
-- Design Name: 
-- Module Name: RAM_SP_64_8 - Behavioral
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

entity RAM_SP_64_8 is
    GENERIC (
        NbBits : INTEGER := 16;
        Nbadr : INTEGER := 6);
    Port ( add      : IN STD_LOGIC_VECTOR ((Nbadr - 1) DOWNTO 0);      
           data_in  : IN STD_LOGIC_VECTOR ((NbBits - 1) DOWNTO 0); 
           r_w      : IN STD_LOGIC;                                    
           enable   : IN STD_LOGIC;                                 
           clk      : IN STD_LOGIC;                                    
           data_out : OUT STD_LOGIC_VECTOR ((NbBits - 1) DOWNTO 0));
end RAM_SP_64_8;

architecture Behavioral of RAM_SP_64_8 is
TYPE ram_type IS ARRAY (0 to 63) OF UNSIGNED ((NbBits - 1) DOWNTO 0);
  SIGNAL memory : ram_type := (
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits),
   to_unsigned(0,NbBits)
   
   
   
);
  
  
BEGIN

  PROCESS (clk)
  BEGIN
    IF (clk'event AND clk = '1') THEN
        IF(r_w='1') THEN
            memory(to_integer(UNSIGNED(add))) <= unsigned(data_in);  
        ELSE
            DATA_OUT <= STD_LOGIC_VECTOR( memory(to_integer(UNSIGNED(add)))); 
        END IF;
    END IF;
 END PROCESS;
  
END Behavioral;