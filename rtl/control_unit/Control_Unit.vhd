----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/20/2026 02:35:38 PM
-- Design Name: 
-- Module Name: Control_Unit - Behavioral
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

entity Control_Unit is
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
            sel_UAL     : OUT STD_LOGIC;
            w_mem       : OUT STD_LOGIC);
end Control_Unit;

architecture Behavioral of Control_Unit is

component FSM_processor is 
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           Boot : in STD_LOGIC;
           carry : in STD_LOGIC;
           codeop  : in STD_LOGIC_VECTOR(1 downto 0);
           clear_carry : out STD_LOGIC; 
           enable_mem : out STD_LOGIC; 
           load_R1 : out STD_LOGIC; 
           load_accu : out STD_LOGIC; 
           load_carry : out STD_LOGIC; 
           sel_UAL : out STD_LOGIC; 
           w_mem : out STD_LOGIC;
           clear_PC : out STD_LOGIC;
           enable_pc: out STD_LOGIC;
           load_pc: out STD_LOGIC;
           load_RI: out STD_LOGIC;
           sel_adr: out STD_LOGIC);
end component;

component Registre_16bits is
    Port ( data_in : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           ce    : in STD_LOGIC;
           rst : in STD_LOGIC;
           load: in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component Counter_prog is
    Port ( data_in : in STD_LOGIC_VECTOR (5 downto 0);
           clk : in STD_LOGIC;
           ce    : in STD_LOGIC;
           rst : in STD_LOGIC;
           load: in STD_LOGIC;
           enable : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (5 downto 0));
end component;

component mux2_6 is
    Port ( A : in STD_LOGIC_VECTOR (5 downto 0);
           B : in STD_LOGIC_VECTOR (5 downto 0);
           C : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (5 downto 0)
           );
end component;

signal add : STD_LOGIC_VECTOR( 15 downto 0);
signal add_next : STD_LOGIC_VECTOR(5 downto 0);
signal clear_PC, enable_pc, load_pc, load_RI, sel_adr : STD_LOGIC;



begin

FSM : FSM_processor
    Port map ( clk => clk,
               rst => rst,
               Boot => Boot,
               carry => carry,
               codeop => add(7 downto 6),  --changement (avant 15 downto 14)
               clear_carry => clear_carry,
               enable_mem => enable_mem,
               load_R1 => load_R1,
               load_accu => load_accu,
               load_carry => load_carry,
               sel_UAL => sel_UAL,
               w_mem => w_mem,
               clear_PC => clear_PC,
               enable_pc => enable_pc,
               load_pc => load_pc,
               load_RI => load_RI,
               sel_adr => sel_adr);
             
RI : Registre_16bits
    Port map ( data_in => data_in,
               clk => clk,
               ce  => ce,
               rst => rst,
               load => load_RI,
               data_out => add);
               
PC : Counter_Prog
    Port map(  data_in => add(5 downto 0),
               clk => clk,
               ce  => ce,
               rst => rst,
               load => load_pc,
               enable => enable_pc,
               data_out => add_next);
 
mux : mux2_6
    Port map ( A => add(5 downto 0),
               B => add_next,
               C => sel_adr,
               S => adr);
               

end Behavioral;
