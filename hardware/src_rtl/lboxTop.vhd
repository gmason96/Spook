----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/21/2022 05:03:49 PM
-- Design Name: 
-- Module Name: lboxTop - Behavioral
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

entity lboxTop is
  Port ( 
  Din: in std_logic_vector(127 downto 0);
  Dout: out std_logic_vector(127 downto 0)
  );
end lboxTop;

architecture Behavioral of lboxTop is

signal temp: std_logic_vector(127 downto 0):=Din;

begin

    lbox_calc: for I in 0 to 1 generate
            --able to add logic for if generate statement 
            --TO DO: add decryption logic for lbox and sbox top levels
            lbox: ENTITY work.l_box
            port map(
                input => temp(64*I+63 downto 64*I),
                output => temp(64*I+63 downto 64*I)
            );
        end generate;
    Dout <= temp;


end Behavioral;
