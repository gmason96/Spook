----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/21/2022 09:49:56 PM
-- Design Name: 
-- Module Name: roundAdd_Shadow - Behavioral
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

entity roundAdd_Shadow is
  Port ( 
    Din: in std_logic_vector(511 downto 0);
    Dout: out std_logic_vector(511 downto 0);
    round: in std_logic_vector(3 downto 0)
  );
end roundAdd_Shadow;

architecture Behavioral of roundAdd_Shadow is

signal roundOut: std_logic_vector(511 downto 0);

begin
    roundGen: for I in 0 to 3 generate
        roundAddition: ENTITY work.round
            generic map(
            b => I
            )
            port map(
                    index => round,
                    state => roundOut(128*I+127 downto 128*I),
                    output =>roundOut(128*I+127 downto 128*I)
            );  
    end generate;
    
    Dout <= roundOut;
end Behavioral;
