----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/21/2022 04:34:24 PM
-- Design Name: 
-- Module Name: innerCalc - Behavioral
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

entity innerCalc is
  Port ( 
  Din: in std_logic_vector(127 downto 0);
  Dout:out std_logic_vector(127 downto 0);
  round: in std_logic_vector(3 downto 0)
  );
end innerCalc;

architecture Behavioral of innerCalc is

signal sBoxOut: std_logic_vector(127 downto 0);
signal lBoxOut: std_logic_vector(127 downto 0);

begin

--component declarations
    sbox: ENTITY work.sboxTop
        port map(
            Din => Din,
            Dout => sboxOut
        );
    
    lbox: ENTITY work.lboxtop
        port map(
            Din => sBoxOut,
            Dout => lBoxOut
        );

    roundd: ENTITY work.roundtop 
        port map(
            Din => lboxOut,
            round => round,
            Dout => Dout
    );


end Behavioral;
