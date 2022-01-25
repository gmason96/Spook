----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/21/2022 09:17:30 PM
-- Design Name: 
-- Module Name: shadowRound - Behavioral
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

entity shadowRound is
  Port ( 
    Din: in std_logic_vector(511 downto 0);
    Dout: out std_logic_vector(511 downto 0);
    round: in std_logic_vector(3 downto 0)
  );
end shadowRound;

architecture Behavioral of shadowRound is
signal sboxLboxOut: std_logic_vector(511 downto 0);
signal roundAddOut: std_logic_vector(511 downto 0);
signal dboxOut: std_logic_vector(511 downto 0);
signal sboxOut: std_logic_vector(511 downto 0);
signal roundp1: std_logic_vector(3 downto 0); 

begin

    roundp1 <= std_logic_vector(to_unsigned(1+to_integer(unsigned(round)),4));

    sbox_lbox: entity work.sbox_lbox_shadow
    port map(
        Din => Din,
        Dout => sboxLboxOut
    );
    
    roundCalc0: entity work.roundAdd_Shadow
    port map(
        Din => sboxLboxOut,
        Dout =>roundAddOut,
        round => round
    );
    
    sboxGen: for I in 0 to 3 generate
        sbox: entity work.sboxTop
        port map(
            Din => roundAddOut(128*I+127 downto 128*I),
            Dout => sboxOut(128*I+127 downto 128*I)
        );
    end generate;
    
    dbox: entity work.diffusion_shadow
    port map(
        input => sboxOut,
        output => dboxOut
    );
    
    roundCalc1: entity work.roundAdd_Shadow
    port map(
        Din => dboxOut,
        Dout =>Dout,
        round => roundp1
    );

end Behavioral;
