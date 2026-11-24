----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/20/2026 03:14:27 PM
-- Design Name: 
-- Module Name: mux2_6 - Behavioral
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

entity mux2_6 is
    Port ( A : in STD_LOGIC_VECTOR (5 downto 0);
           B : in STD_LOGIC_VECTOR (5 downto 0);
           C : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (5 downto 0)
           );
end mux2_6;

architecture Behavioral of mux2_6 is

begin
    S <= B when C = '1' else A;

end Behavioral;