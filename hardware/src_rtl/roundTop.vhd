----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/21/2022 05:13:27 PM
-- Design Name: 
-- Module Name: roundTop - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity roundTop is
  Port ( 
  Din: in std_logic_vector(127 downto 0);
  Dout: out std_logic_vector(127 downto 0);
  round: std_logic_vector(3 downto 0)
  );
end roundTop;

architecture Behavioral of roundTop is

begin
    round_calc: for I in 0 to 1 generate
        roundinstance: ENTITY work.round
        port map(
            index => round,
            state => Din,
            output => Dout
        );
    end generate;

end Behavioral;
