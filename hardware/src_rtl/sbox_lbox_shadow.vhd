----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/21/2022 09:23:33 PM
-- Design Name: 
-- Module Name: sbox_lbox_shadow - Behavioral
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

entity sbox_lbox_shadow is
  Port ( 
  
    Din: in std_logic_vector(511 downto 0);
    Dout: out std_logic_vector(511 downto 0)
  );
end sbox_lbox_shadow;

architecture Behavioral of sbox_lbox_shadow is

signal sboxOut: std_logic_vector(511 downto 0);
signal lboxOut: std_logic_vector(511 downto 0);

begin

    sbox_gen: for I in 0 to 3 generate
        sbox: ENTITY work.sbox
        port map(
                index => Din(128*I+127 downto 128*I),
                output => sboxOut(128*I+127 downto 128*I)
        );
    end generate;
    
    lbox_gen: for J in 0 to 7 generate
        lbox: ENTITY work.l_box
            port map(
                    input => sboxOut(64*J+63 downto 64*J),
                    output => lboxOut(64*J+63 downto 64*J)
            );  
    end generate;
    
    Dout <= lboxOut;
end Behavioral;
