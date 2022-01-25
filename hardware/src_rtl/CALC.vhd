----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/21/2022 04:32:11 PM
-- Design Name: 
-- Module Name: CALC - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CALC is
  Port ( 
      Din: in std_logic_vector(127 downto 0);
      Dout: out std_logic_vector(127 downto 0);
      round:in std_logic_vector(3 downto 0)
  );
end CALC;

architecture Behavioral of CALC is

    signal resA: std_logic_vector(127 downto 0);
    --signal roundCount: std_logic_vector(3 downto 0):="0000";
    signal nextState: std_logic_vector(127 downto 0);
    signal currState: std_logic_vector(127 downto 0);
    signal roundp1: std_logic_vector(3 downto 0);
begin

--    counter: process(clk)
--    begin
--        if rising_edge(clk) then
--            if enc = '1' then
--                --add 1 to roundCount
--                roundCount <= std_logic_vector(to_unsigned(1+to_integer(unsigned(roundCount)),4));
--             end if;
--        end if;
--    end process;
--    state_reg: process(clk)
--    begin
--        if rising_edge(clk) then
--            if enc = '1' then
--                currState <= nextState;
--                roundCount <= std_logic_vector(to_unsigned(1+to_integer(unsigned(roundCount)),4));
--            end if;
--        end if;
--    end process;
    roundp1 <= std_logic_vector(to_unsigned(1+to_integer(unsigned(round)),4));
                
    
     comp0: ENTITY work.innerCalc 
        port map(
        Din => Din,
        Dout => resA,
        round =>round
    );
    
    comp1: ENTITY work.innerCalc 
        port map(
        Din => resA,
        Dout => nextState,
        round => roundp1
    );


end Behavioral;
