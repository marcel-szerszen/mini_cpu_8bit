----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/16/2026 09:11:39 AM
-- Design Name: 
-- Module Name: FSM_processor - Behavioral
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

entity FSM_processor is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           Boot : in STD_LOGIC;
           carry : in STD_LOGIC;
           codeop    : in STD_LOGIC_VECTOR(1 downto 0);
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
           sel_adr: out STD_LOGIC
           );
end FSM_processor;

architecture Behavioral of FSM_processor is
TYPE t_state IS (Init, Fetch_ins, Fetch_ins_dly, Decode, Fetch_op,Fetch_op_dly, Exe_Nor_Add, Exe_JCC, Store, Store_dly);
SIGNAL current_state, next_state : t_state;

begin
process(clk,rst)
begin
if rst = '1' then
    current_state <= Init;
elsif rising_edge(clk) then
    current_state <= next_state;
end if;
end process;



process(Boot,codeop,current_state)
begin
    case current_state is
    
        when Init =>
            if Boot = '0' then
                next_state <= Fetch_ins;
            else
                next_state <= current_state;
            end if;
            
        when Fetch_ins =>
            next_state <= Fetch_ins_dly;

        when Fetch_ins_dly =>
            next_state <= decode;
             
        when decode =>
            if codeop = "10" then
                next_state <= Store;
            elsif codeop = "11" then
                next_state <= Exe_JCC;
            else 
                next_state <= Fetch_op;
            end if;
            
        when Fetch_op =>
            next_state <= Fetch_op_dly;
  
        when Fetch_op_dly =>
            next_state <= Exe_Nor_Add;
                        
        when Exe_Nor_Add =>
            next_state <= Fetch_ins;
            
        when Exe_JCC =>
            next_state <= Fetch_ins;
            
        when Store =>
            next_state <= Store_dly;
            
        when Store_dly =>
            next_state <= Fetch_ins;
        when others =>
            next_state <= INIT;
end case;
end process;

process(current_state,codeop,carry)
begin
    case current_state is
        when Init =>
            clear_pc <= '1';
            enable_pc <= '0';
            load_pc <= '0';
            load_RI <= '0';
            sel_adr <= '0';
            load_R1 <= '0';
            load_accu <= '0';
            sel_UAL <= '0';
            clear_carry <= '1';
            load_carry <= '0';
            enable_mem <= '0';
            W_mem <= '0';
        when Fetch_ins =>
            clear_pc <= '0';
            enable_pc <= '0';
            load_pc <= '0';
            load_RI <= '0';
            sel_adr <= '0';
            load_R1 <= '0';
            load_accu <= '0';
            sel_UAL <= '0';
            clear_carry <= '0';
            load_carry <= '0';
            enable_mem <= '1';
            W_mem <= '0';
        when Fetch_ins_dly =>
            clear_pc <= '0';
            enable_pc <= '0';
            load_pc <= '0';
            load_RI <= '1';
            sel_adr <= '0';
            load_R1 <= '0';
            load_accu <= '0';
            sel_UAL <= '0';
            clear_carry <= '0';
            load_carry <= '0';
            enable_mem <= '1';
            W_mem <= '0';
        when Decode =>
            clear_pc <= '0';
            enable_pc <= '0';
            load_pc <= '0';
            load_RI <= '0';
            sel_adr <= '1';
            load_R1 <= '0';
            load_accu <= '0';
            sel_UAL <= '0';
            clear_carry <= '0';
            load_carry <= '0';
            enable_mem <= '0';
            W_mem <= '0';
        when fetch_op =>
            clear_pc <= '0';
            enable_pc <= '0';
            load_pc <= '0';
            load_RI <= '0';
            sel_adr <= '1';
            load_R1 <= '1';
            load_accu <= '0';
            sel_UAL <= '0';
            clear_carry <= '0';
            load_carry <= '0';
            enable_mem <= '1';
            W_mem <= '0';
        when fetch_op_dly =>
            clear_pc <= '0';
            enable_pc <= '0';
            load_pc <= '0';
            load_RI <= '0';
            sel_adr <= '1';
            load_R1 <= '1';
            load_accu <= '0';
            sel_UAL <= '0';
            clear_carry <= '0';
            load_carry <= '0';
            enable_mem <= '1';
            W_mem <= '0';
        when Exe_nor_add =>
            clear_pc <= '0';
            enable_pc <= '1';
            load_pc <= '0';
            load_RI <= '0';
            sel_adr <= '1';
            load_R1 <= '0';
            load_accu <= '1';
            sel_UAL <= codeop(0);
            clear_carry <= '0';
            load_carry <= codeop(0);
            enable_mem <= '0';
            W_mem <= '0';
        when Exe_jcc =>
            clear_pc <= '0';
            enable_pc <= carry;
            load_pc <= not(carry);
            load_RI <= '1';
            sel_adr <= '1';
            load_R1 <= '0';
            load_accu <= '0';
            sel_UAL <= '0';
            clear_carry <= carry;
            load_carry <= '0';
            enable_mem <= '0';
            W_mem <= '0';
        when Store =>
            clear_pc <= '0';
            enable_pc <= '0';
            load_pc <= '0';
            load_RI <= '0';
            sel_adr <= '1';
            load_R1 <= '0';
            load_accu <= '0';
            sel_UAL <= '0';
            clear_carry <= '0';
            load_carry <= '0';
            enable_mem <= '1';
            W_mem <= '1';
        when Store_dly =>
            clear_pc <= '0';
            enable_pc <= '1';
            load_pc <= '0';
            load_RI <= '0';
            sel_adr <= '1';
            load_R1 <= '0';
            load_accu <= '0';
            sel_UAL <= '0';
            clear_carry <= '0';
            load_carry <= '0';
            enable_mem <= '1';
            W_mem <= '0';
        when others =>
            clear_pc <= '0';
            enable_pc <= '0';
            load_pc <= '0';
            load_RI <= '0';
            sel_adr <= '0';
            load_R1 <= '0';
            load_accu <= '0';
            sel_UAL <= '0';
            clear_carry <= '0';
            load_carry <= '0';
            enable_mem <= '0';
            W_mem <= '0';
        end case; 
end process;
        



end Behavioral;

